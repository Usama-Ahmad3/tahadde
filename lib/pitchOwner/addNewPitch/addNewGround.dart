
import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

FlutterGooglePlacesSdk _places = FlutterGooglePlacesSdk(kGoogleApiKey);

class AddNewGroundFirst extends StatefulWidget {
  const AddNewGroundFirst({super.key});

  @override
  _AddNewGroundFirstState createState() => _AddNewGroundFirstState();
}

class _AddNewGroundFirstState extends State<AddNewGroundFirst> {
  final _nameController = TextEditingController(text: '');
  final _description = TextEditingController(text: '');
  final _descriptionArabic = TextEditingController(text: "");
  final _nameControllerArabic = TextEditingController(text: '');
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final focuss = FocusNode();
  final focusss = FocusNode();
  // GoogleTranslator translator = GoogleTranslator();
  late GoogleMapController _mapController;
  bool _isAddressLoading = true;
  late String locationName;
  bool map = false;
  bool _isLoading = false;
  late String country;
  bool _internet = true;
  bool isImageLoade = false;
  late File image;
  var pitchId;
  late Position position;
  late double pitchLat;
  late double pitchLong;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool indoor = false;
  bool outdoor = false;
  bool both = false;
  late String pitchName;
  late String pitchDescription;
  late String arabicPitchDescription;
  late String pitchNameArabic;
  late String gamePlay;
  late String _facility;
  final _formKey = GlobalKey<FormState>();
  late int count;
  List<int> indexList = [];
  List<Marker> allMarkers = [];
  addMarker() {
    allMarkers.clear();
    allMarkers.add(Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {
        debugPrint('marker');
      },
      // position: LatLng(position.latitude, position.longitude),
    ));
  }

  // void trans(String text, String language, TextEditingController controler) {
  //   if (text == "") {
  //     setState(() {
  //       controler.text = "";
  //     });
  //   } else {
  //     translator.translate(text, to: language).then((value) {
  //       setState(() {
  //         controler.text = value.toString();
  //       });
  //     });
  //   }
  // }

  defaultLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      position = value;
      pitchLong = position.longitude;
      pitchLat = position.latitude;
      Map latLong = {
        "latitude": pitchLat.toString(),
        "longitude": pitchLong.toString(),
      };
      _networkCalls.getAddress(
          LatLong: latLong,
          onSuccess: (msg) {
            if (mounted) {
              setState(() {
                country = msg[1];
                locationName = msg[0];
                _isAddressLoading = false;
              });
            }
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          });
    });
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        _openGallery(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .galleryPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisGalleryPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting),
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
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          openAppSettings();
                                        }),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      msg
          ? _permission()
          : setState(() {
              _isLoading = false;
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

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            body: SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 60.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: sizeHeight * .6,
                                      color: Colors.white,
                                      padding:
                                          const EdgeInsets.only(left: 16, right: 16),
                                    ),
                                    Container(
                                      height: sizeHeight * .15,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : _internet
            ? map
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
                              // GoogleMap(
                              //   onMapCreated: (controller) {
                              //     _mapController = controller;
                              //   },
                              //   onTap: (latLng) {
                              //     print(
                              //         '${latLng.latitude}, ${latLng.longitude}');
                              //     pitchLong = latLng.longitude;
                              //     pitchLat = latLng.latitude;
                              //     setState(() {
                              //       allMarkers.add(Marker(
                              //         markerId: const MarkerId('myMarker'),
                              //         draggable: false,
                              //         onTap: () {
                              //           debugPrint('marker');
                              //         },
                              //         // position: LatLng(pitchLat, pitchLong),
                              //       ));
                              //     });
                              //     Map latlong = {
                              //       "latitude": pitchLat.toString(),
                              //       "longitude": pitchLong.toString(),
                              //     };
                              //     _networkCalls.getAddress(
                              //         LatLong: latlong,
                              //         onSuccess: (msg) {
                              //           setState(() {
                              //             country = msg[1];
                              //             locationName = msg[0];
                              //           });
                              //         },
                              //         onFailure: (msg) {
                              //           showMessage(msg, homeScaffoldKey);
                              //         },
                              //         tokenExpire: () {
                              //           if (mounted) on401(context);
                              //         });
                              //     //getUserLocation();
                              //   },
                              //   compassEnabled: true,
                              //   mapType: MapType.normal,
                              //   // initialCameraPosition: CameraPosition(
                              //   //     target: LatLng(
                              //   //         position.latitude, position.longitude),
                              //   //     zoom: 15.0),
                              //   markers: Set.from(allMarkers),
                              //   //markers: _markers.values.toSet(),
                              // ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 30),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          map = false;
                                          _isAddressLoading = false;
                                        });
                                      },
                                      child: Image.asset(
                                        "images/arrowMap.png",
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
                                Container(
                                  child: Text(locationName),
                                ),
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
                                          _isAddressLoading = false;
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
                                          Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                          )
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
                      appBar: AppBar(
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Color(0XFFFFFFFF),
                          ),
                        ),
                        automaticallyImplyLeading: false,
                        title: Text(
                          AppLocalizations.of(context)!.addNewPitch,
                          style: const TextStyle(fontSize: 18),
                        ),
                        backgroundColor: const Color(0XFF032040),
                      ),
                      bottomNavigationBar: pitchId != null &&
                              indexList.isNotEmpty &&
                              gamePlay != ""
                          ? Material(
                              color: const Color(0XFF25A163),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _facility = "";
                                    for (int i = 0; i < indexList.length; i++) {
                                      _facility =
                                          "$_facility${facilitySlug[i]},";
                                    }
                                    _facility = _facility.substring(
                                        0, facility.length - 1);
                                    _facility = _facility.substring(0);
                                    Map detail = {
                                      "longitude": pitchLat,
                                      "latitude": pitchLong,
                                      "pitchName": pitchName,
                                      "pitchLocation": locationName,
                                      "pitchDescription": pitchDescription,
                                      "gameplaySlug": gamePlay,
                                      "facilitiesSlug": _facility,
                                      "pitchimageId": pitchId,
                                      "country": country
                                    };
                                    if (arabicPitchDescription != "") {
                                      detail["pitchDescriptionarabic"] =
                                          arabicPitchDescription;
                                    }
                                    if (pitchNameArabic != "") {
                                      detail["pitchNamearabic"] =
                                          pitchNameArabic;
                                    }
                                    navigateToDocuments(detail);
                                  }
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
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    _showChoiceDialog(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: isImageLoade
                                        ? Container(
                                            color: const Color(0XFF032040),
                                            height: sizeHeight * .2,
                                            width: sizeWidth,
                                            child: Lottie.asset(
                                              'lottiefiles/profile.json',
                                            ),
                                          )
                                        : Container(
                                            width: sizeWidth,
                                            color: const Color(0XFFEAEAEA),
                                            height: sizeHeight * .153,
                                            child: image == null
                                                ? Column(
                                                    children: <Widget>[
                                                      flaxibleGap(1),
                                                      const Icon(
                                                        Icons.add,
                                                        color:
                                                            Color(0XFFB3B3B3),
                                                        size: 40,
                                                      ),
                                                      flaxibleGap(1),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .addPitchImage,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFFB3B3B3),
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins")),
                                                      flaxibleGap(1),
                                                    ],
                                                  )
                                                : _decideImageview(),
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: textField(
                                      name: AppLocalizations.of(context)!
                                          .pitchNameEnglish,
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .pleaseenterPitchName;
                                        }
                                        return '';
                                      },
                                      // onchange: (value) {
                                      //   trans(
                                      //       value, "ar", _nameControllerArabic);
                                      // },
                                      text: false,
                                      text1: false,
                                      submit: (value) => FocusScope.of(context)
                                          .requestFocus(focusss),
                                      onSaved: (value) => pitchName = value!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: textField(
                                      name: AppLocalizations.of(context)!
                                          .pitchnameinArabic,
                                      controller: _nameControllerArabic,
                                      // onchange: (value){
                                      //   trans(value,"en", _nameController);
                                      // },
                                      node: focusss,
                                      submit: (value) => FocusScope.of(context)
                                          .requestFocus(focuss),
                                      text: false,
                                      text1: false,
                                      onSaved: (value) =>
                                          pitchNameArabic = value!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20),
                                  child: locationName != null
                                      ? Container(
                                          alignment:
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      "en"
                                                  ? Alignment.centerLeft
                                                  : Alignment.centerRight,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .pitchLocation,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Color(0XFFADADAD),
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                                _isAddressLoading
                                    ? GestureDetector(
                                        onTap: () {
                                          _permission();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 40,
                                          ),
                                          child: Container(
                                            color: const Color(0XFF032040),
                                            height: sizeHeight * .1,
                                            width: sizeWidth,
                                            child: Lottie.asset(
                                                'lottiefiles/profile.json',
                                                fit: BoxFit.fill),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _isAddressLoading = true;
                                              FocusScope.of(context).unfocus();
                                              location();
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: sizeWidth * .7,
                                                child: Text(
                                                  locationName ?? AppLocalizations.of(context)!.pitchLocation,
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: locationName == null
                                                        ? const Color(0XFFADADAD)
                                                        : const Color(0XFF032040),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        locationName == null
                                                            ? FontWeight.w500
                                                            : FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                ),
                                              ),
                                              flaxibleGap(1),
                                              const Icon(
                                                Icons.location_on,
                                                color: Color(0XFF25A163),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 40, right: 40),
                                  child: Container(
                                    height: 1,
                                    color: const Color(0XFFADADAD),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, top: 20, right: 40, bottom: 10),
                                  child: Container(
                                    alignment:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .descriptionEnglish,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFFADADAD),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Container(
                                    height: sizeHeight * .15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFFA3A3A3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: TextFormField(
                                        controller: _description,
                                        // onChanged: (value) {
                                        //   trans(
                                        //       value, "ar", _descriptionArabic);
                                        // },
                                        textInputAction: TextInputAction.done,
                                        focusNode: focuss,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterDescription;
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          pitchDescription = value!;
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        maxLength: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, top: 20, right: 40, bottom: 10),
                                  child: Container(
                                    alignment:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .descriptioninArabic,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Color(0XFFADADAD),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 40),
                                  child: Container(
                                    height: sizeHeight * .15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFFA3A3A3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: TextFormField(
                                        controller: _descriptionArabic,
                                        // onChanged: (value){
                                        //   trans(value,"en", _description);
                                        // },
                                        textInputAction: TextInputAction.done,
                                        onSaved: (value) {
                                          arabicPitchDescription = value!;
                                        },
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(0),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 3,
                                        maxLength: 50,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 10),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        child: indoor
                                            ? SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/Rectangle.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/uncheck.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                        onTap: () {
                                          setState(() {
                                            indoor = !indoor;
                                            outdoor = false;
                                            both = false;
                                            if (indoor) {
                                              gamePlay = "indoor";
                                            } else {
                                              gamePlay = "";
                                            }
                                          });
                                        },
                                      ),
                                      flaxibleGap(1),
                                      Text(
                                        AppLocalizations.of(context)!.indoor,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFFADADAD),
                                        ),
                                      ),
                                      flaxibleGap(3),
                                      GestureDetector(
                                        child: outdoor
                                            ? SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/Rectangle.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/uncheck.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                        onTap: () {
                                          setState(() {
                                            outdoor = !outdoor;
                                            indoor = false;
                                            both = false;
                                            if (outdoor) {
                                              gamePlay = "outdoor";
                                            } else {
                                              gamePlay = "";
                                            }
                                          });
                                        },
                                      ),
                                      flaxibleGap(1),
                                      Text(
                                        AppLocalizations.of(context)!.outdoor,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFFADADAD),
                                        ),
                                      ),
                                      flaxibleGap(3),
                                      GestureDetector(
                                        child: both
                                            ? SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/Rectangle.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              )
                                            : SizedBox(
                                                height: sizeHeight * .03,
                                                width: sizeWidth * .055,
                                                child: Image.asset(
                                                  "images/uncheck.png",
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                        onTap: () {
                                          setState(() {
                                            both = !both;
                                            indoor = false;
                                            outdoor = false;
                                            if (both) {
                                              gamePlay = "both";
                                            } else {
                                              gamePlay = "";
                                            }
                                          });
                                        },
                                      ),
                                      flaxibleGap(1),
                                      Text(
                                        AppLocalizations.of(context)!.both,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFFADADAD),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 40,
                                  ),
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .chooseFacilitiesProvided,
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        // color: Color(0XFF25A163),
                                        color: Color(0XFFADADAD),
                                        fontSize: 15,
                                        fontFamily: 'Poppins',
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 40, bottom: 10),
                                  child: SizedBox(
                                    height: sizeHeight * .13,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: facility.length,
                                        itemBuilder: (BuildContext context,
                                            int blockIdx) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (indexList
                                                      .contains(blockIdx)) {
                                                    indexList.remove(blockIdx);
                                                  } else {
                                                    indexList.add(blockIdx);
                                                  }
                                                  //count=blockIdx;
                                                });
                                              },
                                              child: indexList
                                                      .contains(blockIdx)
                                                  ? Container(
                                                      width: sizeWidth * .28,
                                                      height: sizeWidth * .07,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0XFFA3A3A3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: const Color(0XFF25A163)
                                                            .withOpacity(.3),
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          flaxibleGap(2),
                                                          Image.asset(
                                                            facilityImageS[
                                                                blockIdx],
                                                            width:
                                                                sizeWidth * .1,
                                                            height:
                                                                sizeWidth * .1,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          flaxibleGap(1),
                                                          Text(
                                                              facility[
                                                                  blockIdx],
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF424242),
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none)),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: sizeWidth * .28,
                                                      height: sizeWidth * .07,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: const Color(
                                                                0XFFA3A3A3)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          flaxibleGap(2),
                                                          Image.asset(
                                                            facilityImage[
                                                                blockIdx],
                                                            width:
                                                                sizeWidth * .1,
                                                            height:
                                                                sizeWidth * .1,
                                                            fit: BoxFit.fill,
                                                          ),
                                                          flaxibleGap(1),
                                                          Text(
                                                              facility[
                                                                  blockIdx],
                                                              style: const TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF424242),
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none)),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      _permission();
                    }
                  });
                },
              );
  }

  void navigateToDocuments(Map detail) {
    Navigator.pushNamed(context, RouteNames.addNewGroundSecond, arguments: detail);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      isImageLoade = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            pitchId = msg;
            isImageLoade = false;
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      isImageLoade = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            pitchId = msg;
            print(msg);
            isImageLoade = false;
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

  Widget _decideImageview() {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  }

  // Future<void> _handlePressButton() async {
  //   // show input autocomplete with selected mode
  //   // then get the Prediction selected
  //   Prediction p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: kGoogleApiKey,
  //     onError: onError,
  //     mode: Mode.fullscreen,
  //     logo: const Text(""),
  //     language: "en",
  //     components: [Component(Component.country, "are")],
  //   );
  //
  //   displayPrediction(p, homeScaffoldKey.currentState);
  // }

  // void onError(PlacesAutocompleteResponse response) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(response.errorMessage)),
  //   );
  // }

//   Future<Null> displayPrediction(p, ScaffoldState scaffold) async {
//     if (p != null) {
//       // get detail (lat/lng)
//       var detail =
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
//               _isAddressLoading = true;
//             });
//           },
//           onFailure: (msg) {
//             showMessage(msg, homeScaffoldKey);
//           },
//           tokenExpire: () {
//             if (mounted) on401(context);
//           });
//       // defaultGetUserLocation(pitchLat, pitchLong, true);
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
