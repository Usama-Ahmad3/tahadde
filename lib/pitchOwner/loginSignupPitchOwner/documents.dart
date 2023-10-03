import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../newStructure/view/owner/home_screens/home_page/select_sport0.dart';

class Documents extends StatefulWidget {
  SportsModel detail;
  Documents({super.key, required this.detail});
  @override
  State<Documents> createState() => _DocumentsState();
}

class _DocumentsState extends State<Documents> {
  final DateFormat formatter = DateFormat('dd MMM yyyy', 'en_US');
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  final _nameController = TextEditingController(text: '');
  final _licenceController = TextEditingController(text: "");
  var _expiryDate;
  var _apiExpiryDate;
  GoogleMapController? _mapController;
  String locationName = '';
  String? country;
  int checkIndex = -1;
  bool isAddressLoading = true;
  bool map = false;
  bool loading = true;
  bool internet = true;
  bool _isImageLoading = false;
  File? image;
  var pitch_Id;
  Position? position;
  double? pitchLat;
  double? pitchLong;
  final NetworkCalls _networkCalls = NetworkCalls();
  final _formKey = GlobalKey<FormState>();
  List<Marker> allMarkers = [];
  List<DocumentResponse> doc = [];
  addMarker() {
    allMarkers.clear();
    allMarkers.add(Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {
        debugPrint('marker');
      },
      position: LatLng(position!.latitude, position!.longitude),
    ));
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture,
                style: const TextStyle(color: Colors.black)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary,
                        style: const TextStyle(color: Colors.black)),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        _openGallery(context);
                      } else if (status.isDenied) {
                        _openGallery(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .galleryPermission,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  content: Text(
                                      AppLocalizations.of(context)!
                                          .thisGalleryPicturesUploadImage,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: const TextStyle(
                                              color: Colors.black)),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto),
                    onTap: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        _openCamera(context);
                      } else if (status.isDenied) {
                        _openCamera(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .cameraPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  editVenue(Map detail) async {
    await _networkCalls.editVenue(
      id: widget.detail.id.toString(),
      venueDetail: detail,
      venueType: widget.detail.venueType!,
      onSuccess: (event) {
        if (mounted) backToEdit();
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  defaultLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      position = value;
      pitchLong = position!.longitude;
      pitchLat = position!.latitude;
      Map latlong = {
        "latitude": pitchLat.toString(),
        "longitude": pitchLong.toString(),
      };
      _networkCalls.getAddress(
          LatLong: latlong,
          onSuccess: (msg) {
            setState(() {
              country = msg[1];
              locationName = msg[0];
              isAddressLoading = false;
            });
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          });
    });
  }

  Future<void> _getLocationPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      print('Temporary');
      await Geolocator.openLocationSettings();
    } else if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      await Geolocator.requestPermission();
      print('Permanent');
    } else {
      location();
    }
  }

  location() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      setState(() {
        position = value;
        map = true;
        addMarker();
      });
    });
  }

  _permission() async {
    var status = await Permission.location.status;
    if (status.isGranted) {
      defaultLocation();
    } else if (status.isDenied) {
      defaultLocation();
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
                title: Text(AppLocalizations.of(context)!.locationPermission),
                content: Text(AppLocalizations.of(context)!
                    .thislocationPicturesUploadImage),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(AppLocalizations.of(context)!.deny),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoDialogAction(
                      child: Text(AppLocalizations.of(context)!.setting),
                      onPressed: () {
                        Navigator.of(context).pop();
                        openAppSettings();
                      }),
                ],
              ));
    }
  }

  Future<DateTime?> slecteDtateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
        locale: Locale(AppLocalizations.of(context)!.locale),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0XFF032040)),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

  @override
  void initState() {
    super.initState();
    _permission();
    _getLocationPermission();
    loadDocument();
  }

  loadDocument() {
    _networkCalls.availableDoc(
        onSuccess: (detail) {
          detail.forEach((element) {
            doc.add(DocumentResponse(
              id: element["document"]["id"],
              expiryDate: element["documents_expiry_date"],
              docImage: element["document"]["filePath"],
              docName: element["document_name"],
              licenceNumber: element["document_code"],
            ));
          });
          setState(() {
            loading = false;
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return loading
        ? Scaffold(
            appBar: appBar(
                title: AppLocalizations.of(context)!.documents,
                language: AppLocalizations.of(context)!.locale,
                onTap: () {
                  Navigator.of(context).pop();
                }),
            body: const Center(
              child: CircularProgressIndicator(
                color: appThemeColor,
              ),
            ),
          )
        : map
            ? Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: AppBar(
                      backgroundColor: const Color(0XFF032040),
                    )),
                body: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Stack(
                        children: [
                          GoogleMap(
                            onMapCreated: (controller) {
                              _mapController = controller;
                            },
                            onTap: (latLng) {
                              print('${latLng.latitude}, ${latLng.longitude}');
                              pitchLong = latLng.longitude;
                              pitchLat = latLng.latitude;
                              setState(() {
                                allMarkers.add(Marker(
                                  markerId: const MarkerId('myMarker'),
                                  draggable: false,
                                  onTap: () {
                                    debugPrint('marker');
                                  },
                                  position: LatLng(pitchLat!, pitchLong!),
                                ));
                              });
                              Map latlong = {
                                "latitude": pitchLat.toString(),
                                "longitude": pitchLong.toString(),
                              };
                              _networkCalls.getAddress(
                                  LatLong: latlong,
                                  onSuccess: (msg) {
                                    setState(() {
                                      country = msg[1];
                                      locationName = msg[0];
                                      // isAddressLoading=false;
                                    });
                                  },
                                  onFailure: (msg) {
                                    showMessage(msg);
                                  },
                                  tokenExpire: () {
                                    if (mounted) on401(context);
                                  });
                              // getUserLocation(pitchLat,pitchLong);
                            },
                            compassEnabled: true,
                            mapType: MapType.normal,
                            initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    position!.latitude, position!.longitude),
                                zoom: 15.0),
                            markers: Set.from(allMarkers),
                            //markers: _markers.values.toSet(),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 30),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      map = false;
                                      isAddressLoading = false;
                                    });
                                  },
                                  child: Image.asset(
                                    "assets/images/arrowMap.png",
                                    height: 50,
                                  ),
                                ),
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      width: sizeWidth,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40),
                            topLeft: Radius.circular(40)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            fixedGap(height: 10.0),
                            Container(
                              height: 8,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.grey.shade300,
                                //color: Color(color),
                              ),
                            ),
                            fixedGap(height: 10.0),
                            Text(locationName),
                            flaxibleGap(1),
                            Material(
                              child: Ink(
                                width: sizeWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0XFF25A163),
                                  //color: Color(color),
                                ),
                                child: InkWell(
                                  splashColor: Colors.black,
                                  child: button(
                                      name: AppLocalizations.of(context)!
                                          .confirm),
                                  onTap: () {
                                    setState(() {
                                      isAddressLoading = false;
                                      map = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            flaxibleGap(1),
                            GestureDetector(
                              onTap: () {
                                // _handlePressButton();
                              },
                              child: Container(
                                height: 40,
                                width: sizeWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.grey.shade300,
                                  //color: Color(color),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Search Pitch",
                                        style: TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                            color: Colors.grey),
                                      ),
                                      Spacer(),
                                      Icon(Icons.search, color: Colors.grey)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            flaxibleGap(1),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            : GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  appBar: appBar(
                      title: AppLocalizations.of(context)!.documents,
                      language: AppLocalizations.of(context)!.locale,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  bottomNavigationBar: pitch_Id != null &&
                          pitchLong != null &&
                          _expiryDate != null &&
                          _nameController.text != "" &&
                          !widget.detail.isEdit!
                      ? Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              // if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (widget.detail.isEdit!) {
                                Map detail = {
                                  "location": locationName,
                                  "documentId": pitch_Id,
                                  "document_name":
                                      widget.detail.documentModel!.documentName,
                                  "documents_expiry_date": _apiExpiryDate,
                                  "document_code": widget
                                      .detail.documentModel!.licenceNumber,
                                  "country": country,
                                  "pitchLatitude": pitchLat,
                                  "pitchLongitude": pitchLong,
                                };
                                editVenue(detail);
                              } else {
                                widget.detail.documentModel!.lat = pitchLat;
                                widget.detail.documentModel!.long = pitchLong;
                                widget.detail.documentModel!.address =
                                    locationName;
                                widget.detail.documentModel!.documentImageId =
                                    pitch_Id;
                                widget.detail.documentModel!.expiryDate =
                                    _apiExpiryDate;
                                widget.detail.documentModel!.country = country;
                                navigateToDocuments(widget.detail);
                              }
                              // }
                            },
                            splashColor: Colors.black,
                            child: Container(
                                height: sizeHeight * .104,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.continueW,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                          ),
                        )
                      : Container(
                          height: sizeHeight * .104,
                          color: const Color(0XFFBCBCBC),
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.continueW,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                  body: SingleChildScrollView(
                    child: SizedBox(
                      width: sizeWidth,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07,
                                  vertical: sizeHeight * .02),
                              child: _isImageLoading
                                  ? Container(
                                      color: const Color(0XFF032040),
                                      height: sizeHeight * .2,
                                      width: sizeWidth,
                                      child: Lottie.asset(
                                        'assets/lottiefiles/profile.json',
                                      ),
                                    )
                                  : Container(
                                      color: const Color(0XFF032040),
                                      height: sizeHeight * .3,
                                      width: sizeWidth,
                                      child: image == null
                                          ? doc.isNotEmpty
                                              ? ListView.builder(
                                                  itemCount: doc.length + 1,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: index == 0
                                                          ? widget.detail
                                                                  .isEdit!
                                                              ? const SizedBox
                                                                  .shrink()
                                                              : GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      checkIndex =
                                                                          -1;
                                                                      _nameController
                                                                          .text = "";
                                                                      _licenceController
                                                                          .text = "";
                                                                      _expiryDate =
                                                                          null;
                                                                      _apiExpiryDate =
                                                                          null;
                                                                      _showChoiceDialog(
                                                                          context);
                                                                    });
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        sizeHeight *
                                                                            .3,
                                                                    color: Colors
                                                                        .white,
                                                                    width: 150,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          50.0),
                                                                      child: Image
                                                                          .asset(
                                                                        "assets/images/add_doc.png",
                                                                        height:
                                                                            50,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                          : GestureDetector(
                                                              onTap: () {
                                                                if (checkIndex ==
                                                                    index) {
                                                                  setState(() {
                                                                    checkIndex =
                                                                        -1;
                                                                    _nameController
                                                                        .text = "";
                                                                    _licenceController
                                                                        .text = "";
                                                                    _expiryDate =
                                                                        null;
                                                                    _apiExpiryDate =
                                                                        null;
                                                                    pitch_Id =
                                                                        null;
                                                                  });
                                                                } else {
                                                                  setState(() {
                                                                    checkIndex =
                                                                        index;

                                                                    _nameController
                                                                            .text =
                                                                        doc[checkIndex - 1].docName ??
                                                                            "";
                                                                    _licenceController
                                                                        .text = doc[
                                                                            checkIndex -
                                                                                1]
                                                                        .licenceNumber!;
                                                                    if (doc[checkIndex -
                                                                                1]
                                                                            .expiryDate !=
                                                                        null) {
                                                                      _expiryDate =
                                                                          formatter
                                                                              .format(DateTime.parse(doc[checkIndex - 1].expiryDate!));
                                                                      _apiExpiryDate =
                                                                          apiFormatter
                                                                              .format(DateTime.parse(doc[checkIndex - 1].expiryDate!));
                                                                      pitch_Id =
                                                                          doc[checkIndex - 1]
                                                                              .id;
                                                                    } else {
                                                                      _expiryDate =
                                                                          null;
                                                                      _apiExpiryDate =
                                                                          null;
                                                                      pitch_Id =
                                                                          null;
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                              child: Stack(
                                                                children: [
                                                                  cachedNetworkImage(
                                                                      height:
                                                                          sizeHeight *
                                                                              .3,
                                                                      width:
                                                                          150,
                                                                      cuisineImageUrl:
                                                                          doc[index - 1]
                                                                              .docImage,
                                                                      imageFit:
                                                                          BoxFit
                                                                              .fill),
                                                                  checkIndex ==
                                                                          index
                                                                      ? Container(
                                                                          height:
                                                                              sizeHeight * .3,
                                                                          width:
                                                                              150,
                                                                          color: Colors
                                                                              .white
                                                                              .withOpacity(.2),
                                                                        )
                                                                      : const SizedBox
                                                                          .shrink(),
                                                                  checkIndex ==
                                                                          index
                                                                      ? SizedBox(
                                                                          height:
                                                                              sizeHeight * .3,
                                                                          width:
                                                                              150,
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(50.0),
                                                                            child:
                                                                                Image.asset(
                                                                              "assets/images/check.png",
                                                                              height: 50,
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : const SizedBox
                                                                          .shrink(),
                                                                ],
                                                              ),
                                                            ),
                                                    );
                                                  })
                                              : GestureDetector(
                                                  onTap: () {
                                                    _showChoiceDialog(context);
                                                  },
                                                  child: Column(
                                                    children: <Widget>[
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      const Icon(
                                                        Icons.add_circle,
                                                        color: Colors.white,
                                                        size: 50,
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .uploadDocument,
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins")),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          AppLocalizations.of(context)!
                                                              .weNeedAccount,
                                                          style: TextStyle(
                                                              color:
                                                                  const Color(
                                                                          0XFF9B9B9B)
                                                                      .withOpacity(
                                                                          .5),
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins")),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                          : GestureDetector(
                                              onTap: () {
                                                _showChoiceDialog(context);
                                              },
                                              child: _decideImageview()),
                                    ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07),
                              child: textField(
                                  name: AppLocalizations.of(context)!
                                      .documentName,
                                  controller: _nameController,
                                  onchange: (value) {},
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterPitchName;
                                    }
                                    return null;
                                  },
                                  text: false,
                                  text1: false,
                                  // submit: (value) => FocusScope.of(context)
                                  //     .requestFocus(focusss),
                                  onSaved: (value) {
                                    widget.detail.documentModel =
                                        DocumentModel(documentName: value!);
                                  }),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07),
                              child: textField(
                                  name:
                                      AppLocalizations.of(context)!.licenceName,
                                  controller: _licenceController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterPitchName;
                                    }
                                    return null;
                                  },
                                  text: false,
                                  text1: false,
                                  // submit: (value) => FocusScope.of(context)
                                  //     .requestFocus(focusss),
                                  onSaved: (value) => widget.detail
                                      .documentModel!.licenceNumber = value!),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07),
                              child: Text(
                                AppLocalizations.of(context)!.expiryDate,
                                style: const TextStyle(
                                    color: Color(0XFFADADAD),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .07,
                              ),
                              child: GestureDetector(
                                onTap: () async {
                                  final selectDate =
                                      await slecteDtateTime(context);
                                  if (selectDate != null) {
                                    setState(() {
                                      _expiryDate = formatter
                                          .format((selectDate))
                                          .toString();
                                      _apiExpiryDate = apiFormatter
                                          .format((selectDate))
                                          .toString();
                                    });
                                  }
                                },
                                child: Text(
                                  _expiryDate ?? "Expiry Document Date",
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      decoration: TextDecoration.none,
                                      color: Color(0XFF032040),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                ),
                              ),
                            ),
                            !widget.detail.isEdit!
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeWidth * .07),
                                    child: Container(
                                      height: 1,
                                      width: sizeWidth,
                                      color: Colors.grey,
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .07,
                              ),
                              child: !widget.detail.isEdit!
                                  ? Container(
                                      alignment: AppLocalizations.of(context)!
                                                  .locale ==
                                              "en"
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .pitchLocation,
                                        style: const TextStyle(
                                            color: Color(0XFFADADAD),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Container(),
                            ),
                            widget.detail.isEdit!
                                ? const SizedBox.shrink()
                                : isAddressLoading
                                    ? GestureDetector(
                                        onTap: () {
                                          _permission();
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .07,
                                              vertical: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              shimmer(width: sizeWidth),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              shimmer(width: sizeWidth * .7),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Ink(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .07),
                                        child: InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            setState(() {
                                              isAddressLoading = true;
                                              FocusScope.of(context).unfocus();
                                              _getLocationPermission();
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: sizeWidth * .7,
                                                child: Text(
                                                  locationName,
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: locationName == null
                                                        ? const Color(
                                                            0XFFADADAD)
                                                        : const Color(
                                                            0XFF032040),
                                                    fontSize: 12,
                                                    fontWeight:
                                                        locationName == null
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              Image.asset(
                                                "assets/images/locationPitch.png",
                                                height: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07),
                              child: Container(
                                height: 1,
                                width: sizeWidth,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }

  void navigateToDocuments(SportsModel detail) {
    Navigator.pushNamed(context, RouteNames.pitchDetail, arguments: detail);
  }

  void backToEdit() {
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _isImageLoading = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            pitch_Id = msg;
            print(msg);

            _isImageLoading = false;
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      _isImageLoading = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            pitch_Id = msg;
            print(msg);
            _isImageLoading = false;
          });
        },
        onFailure: (msg) {
          //showMessage(msg, scaffoldkey);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  Widget _decideImageview() {
    return Image.file(
      image!,
      fit: BoxFit.cover,
    );
  }

//   Future<void> _handlePressButton() async {
//     // show input autocomplete with selected mode
//     // then get the Prediction selected
//     Prediction p = await PlacesAutocomplete.show(
//       context: context,
//       apiKey: kGoogleApiKey,
//       onError: onError,
//       mode: Mode.fullscreen,
//       language: "en",
//       logo: const Text(""),
//       components: [Component(Component.country, "are")],
//     );
//
//     displayPrediction(p, homeScaffoldKey.currentState);
//   }
//
//   void onError(PlacesAutocompleteResponse response) {
//     homeScaffoldKey.currentState.showSnackBar(
//       SnackBar(content: Text(response.errorMessage)),
//     );
//   }
//
//   Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
//     if (p != null) {
//       // get detail (lat/lng)
//       PlacesDetailsResponse detail =
//           await _places.getDetailsByPlaceId(p.placeId);
//       pitchLat = detail.result.geometry.location.lat;
//       pitchLong = detail.result.geometry.location.lng;
//       _mapController
//           .animateCamera(CameraUpdate.newLatLng(LatLng(pitchLat, pitchLong)));
//       Map latlong = {
//         "latitude": pitchLat.toString(),
//         "longitude": pitchLong.toString(),
//       };
//       _networkCalls.getAddress(
//           LatLong: latlong,
//           onSuccess: (msg) {
//             setState(() {
//               country = msg[1];
//               locationName = msg[0];
//               isAddressLoading = true;
//             });
//           },
//           onFailure: (msg) {
//             showMessage(msg, homeScaffoldKey);
//           },
//           tokenExpire: () {
//             if (mounted) on401(context);
//           });
//       //defaultGetUserLocation(pitchLat, pitchLong,true);
//       setState(() {
//         allMarkers.add(Marker(
//           draggable: true,
//           markerId: const MarkerId('myMarker'),
//           onTap: () {
//             debugPrint('marker');
//           },
//           position: LatLng(pitchLat, pitchLong),
//         ));
//       });
// //      scaffold.showSnackBar(
// //        SnackBar(content: Text("${p.description} - $lat/$lng")),
// //      );
//     }
//   }
}

class DocumentResponse {
  int? id;
  String? expiryDate;
  String? docImage;
  String? docName;
  String? licenceNumber;
  DocumentResponse(
      {this.id,
      this.expiryDate,
      this.docImage,
      this.licenceNumber,
      this.docName});
}
