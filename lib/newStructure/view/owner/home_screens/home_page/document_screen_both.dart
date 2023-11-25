import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../../../player/HomeScreen/widgets/app_bar.dart';

// ignore: must_be_immutable
class DocumentScreen extends StatefulWidget {
  SportsModel detail;
  int? specificAcademyId;
  DocumentScreen({super.key, required this.detail, this.specificAcademyId});
  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  final DateFormat formatter = DateFormat('dd MMM yyyy', 'en_US');
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  var _nameController = TextEditingController(text: '');
  var _licenceController = TextEditingController(text: "");
  var _expiryDate = TextEditingController();
  var locationController = TextEditingController();
  var _apiExpiryDate;
  GoogleMapController? mapController;
  String? country;
  int checkIndex = -1;
  bool isAddressLoading = true;
  bool map = false;
  bool loading = true;
  bool internet = true;
  bool _isImageLoading = false;
  File? image;
  File? documentFilePath;
  bool pdfClicked = false;
  var pitch_Id;
  Position? position;
  double? pitchLat;
  double? pitchLong;
  String documentImage = '';
  final NetworkCalls _networkCalls = NetworkCalls();
  final _formKey = GlobalKey<FormState>();
  List<Marker> allMarkers = [];
  List<DocumentResponse> doc = [];
  SpecificAcademy _specificAcademy = SpecificAcademy();
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

  Future<void> _pickDocument() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowCompression: true,
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        pdfClicked = true;
        checkIndex = -1;
        documentFilePath = File(result.files.single.path.toString());
        print(documentFilePath);
        setState(() {
          var detail = {"profile_image": documentFilePath, "type": "bookpitch"};
          _networkCalls.helperMultiImageDocument(
            pitchImage: documentFilePath,
            onSuccess: (msg) {
              setState(() {
                pitch_Id = msg;
                documentImage = msg;
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
    } catch (e) {
      showMessage(e.toString());
    }
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: AppColors.white,
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.uploadPDF,
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.normal)),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        _pickDocument();
                      } else if (status.isDenied) {
                        _pickDocument();
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .galleryPermission,
                                      style: TextStyle(color: AppColors.black)),
                                  content: Text(
                                      AppLocalizations.of(context)!
                                          .thisGalleryPicturesUploadImage,
                                      style: TextStyle(color: AppColors.black)),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: TextStyle(
                                              color: AppColors.black)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: TextStyle(
                                              color: AppColors.black)),
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
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary,
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.normal)),
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
                                      style: TextStyle(color: AppColors.black)),
                                  content: Text(
                                      AppLocalizations.of(context)!
                                          .thisGalleryPicturesUploadImage,
                                      style: TextStyle(color: AppColors.black)),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: TextStyle(
                                              color: AppColors.black)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: TextStyle(
                                              color: AppColors.black)),
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
                    child: Text(
                      AppLocalizations.of(context)!.takephoto,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal),
                    ),
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
                                  actions: [
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

  loadSpecific() async {
    print('kks');
    await _networkCalls.specificAcademy(
      id: widget.specificAcademyId.toString(),
      onSuccess: (event) {
        _specificAcademy = event;
        if (mounted) {
          setState(() {
            // if (specificPitchScreen.isDeclined!) {
            //   venueType = "declined";
            // } else if (specificPitchScreen.isVerified!) {
            //   venueType = "verified";
            // } else {
            //   venueType = "inreview";
            // }
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          showMessage(msg);
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  editAcademy(Map detail) async {
    await _networkCalls.editAcademy(
      id: widget.specificAcademyId.toString(),
      academyDetail: detail,
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
    print(await _networkCalls.getKey('token'));
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      position = value;
      print('ok jxddddddddddddddddddddddddddddddddd');
      pitchLong = position!.longitude;
      pitchLat = position!.latitude;
      Map latlong = {
        "latitude": pitchLat.toString(),
        "longitude": pitchLong.toString(),
        "language": 'en'
      };
      print(latlong);
      _networkCalls.getAddress(
          LatLong: latlong,
          onSuccess: (msg) {
            setState(() {
              country = msg[1];
              locationController.text = msg[0].toString().substring(9);
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
      defaultLocation();
    }
  }

  location() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      setState(() {
        position = value;
        map = widget.detail.isEdit! ? false : true;
        addMarker();
      });
    });
  }

  _permission() async {
    print('permissionnnnnn');
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
                actions: [
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
              colorScheme:
                  const ColorScheme.light(primary: AppColors.appThemeColor),
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
    widget.specificAcademyId != null ? loadSpecific() : null;
    widget.specificAcademyId != null ? loadDocument() : null;
    widget.specificAcademyId != null ? null : loading = false;
  }

  loadDocument() {
    Future.delayed(const Duration(seconds: 1), () {
      print(_specificAcademy.documents![0].documentName);
      _nameController.text =
          _specificAcademy.documents![0].documentName.toString() ?? '';
      _licenceController.text =
          _specificAcademy.documents![0].licenseNumber.toString() ?? '';
      _expiryDate.text =
          _specificAcademy.documents![0].expiryDate.toString() ?? '';
      image = File(_specificAcademy.documents![0].file.toString()) ?? File('');
      checkIndex = 1;
      setState(() {
        loading = false;
      });
    });
    // _networkCalls.availableDoc(
    //     onSuccess: (detail) {
    //       detail.forEach((element) {
    //         doc.add(DocumentResponse(
    //           id: element["id"],
    //           expiryDate: element["Expiry_Date"],
    //           docImage: element["file"],
    //           docName: element["Document_Name"],
    //           licenceNumber: element["License_Number"],
    //         ));
    //       });
    //       setState(() {
    //         loading = false;
    //       });
    //     },
    //     onFailure: (msg) {},
    //     tokenExpire: () {
    //       if (mounted) on401(context);
    //     });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return loading
        ? Scaffold(
            backgroundColor: AppColors.black,
            appBar: appBarWidget(
              sizeWidth,
              sizeHeight,
              context,
              AppLocalizations.of(context)!.document,
              true,
            ),
            body: Container(
              height: sizeHeight,
              width: sizeWidth,
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.033),
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appThemeColor,
                ),
              ),
            ),
          )
        : map
            ? Scaffold(
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: AppBar(
                      backgroundColor: AppColors.themeColor,
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
                              mapController = controller;
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
                                      locationController.text =
                                          msg[0].toString().substring(9);
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
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
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
                            Text(
                              locationController.text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.black),
                            ),
                            flaxibleGap(1),
                            Material(
                              child: Ink(
                                width: sizeWidth,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: AppColors.appThemeColor,
                                  //color: Color(color),
                                ),
                                child: InkWell(
                                  splashColor: AppColors.black,
                                  child: button(
                                    name: AppLocalizations.of(context)!.confirm,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      isAddressLoading = false;
                                      map = false;
                                    });
                                  },
                                ),
                              ),
                            ),
                            // flaxibleGap(1),
                            // GestureDetector(
                            //   onTap: () {
                            //     _handlePressButton();
                            //   },
                            //   child: Container(
                            //     height: 40,
                            //     width: sizeWidth,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(4),
                            //       color: Colors.grey.shade300,
                            //       //color: Color(color),
                            //     ),
                            //     child: const Padding(
                            //       padding: EdgeInsets.all(8.0),
                            //       child: Row(
                            //         children: [
                            //           Text(
                            //             "Search Pitch",
                            //             style: TextStyle(
                            //                 fontFamily: "Poppins",
                            //                 fontWeight: FontWeight.w500,
                            //                 fontSize: 15,
                            //                 color: Colors.grey),
                            //           ),
                            //           Spacer(),
                            //           Icon(Icons.search, color: Colors.grey)
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
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
                  backgroundColor: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  appBar: appBarForCreatingAcademy(
                    size,
                    context,
                    AppLocalizations.of(context)!.document,
                    true,
                    const Color(0XFFCBCBCB),
                    const Color(0XFFCBCBCB),
                  ),
                  body: SingleChildScrollView(
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Container(
                      color: AppColors.black,
                      child: Container(
                        width: sizeWidth,
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * 0.059),
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Form(
                          key: _formKey,
                          child: DefaultTextStyle(
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: sizeHeight * 0.008,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeWidth * .009,
                                      vertical: sizeHeight * .02),
                                  child: _isImageLoading
                                      ? Container(
                                          height: sizeHeight * .2,
                                          width: sizeWidth,
                                          decoration: BoxDecoration(
                                              color: AppColors.themeColor,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Lottie.asset(
                                            'assets/lottiefiles/profile.json',
                                          ),
                                        )
                                      : SizedBox(
                                          height: sizeHeight * .2,
                                          width: sizeWidth,
                                          child: image != null ||
                                                  documentFilePath != null
                                              ?
                                              // doc.isNotEmpty
                                              //         ? ListView.builder(
                                              //             itemCount: doc.length + 1,
                                              //             scrollDirection:
                                              //                 Axis.horizontal,
                                              //             itemBuilder:
                                              //                 (context, index) {
                                              //               return Padding(
                                              //                 padding:
                                              //                     const EdgeInsets
                                              //                         .all(5.0),
                                              //                 child: index == 0
                                              //                     ? widget.detail
                                              //                             .isEdit!
                                              //                         ? const SizedBox
                                              //                             .shrink()
                                              //                         : GestureDetector(
                                              //                             onTap: () {
                                              //                               setState(
                                              //                                   () {
                                              //                                 checkIndex =
                                              //                                     -1;
                                              //                                 _nameController.text =
                                              //                                     "";
                                              //                                 _licenceController.text =
                                              //                                     "";
                                              //                                 _expiryDate.text =
                                              //                                     '';
                                              //                                 _apiExpiryDate =
                                              //                                     null;
                                              //                                 _showChoiceDialog(
                                              //                                     context);
                                              //                               });
                                              //                             },
                                              //                             child:
                                              //                                 Container(
                                              //                               height:
                                              //                                   sizeHeight *
                                              //                                       .3,
                                              //                               width:
                                              //                                   150,
                                              //                               decoration: BoxDecoration(
                                              //                                   color: MyAppState.mode == ThemeMode.light
                                              //                                       ? Colors.grey.shade200
                                              //                                       : Colors.white,
                                              //                                   borderRadius: BorderRadius.circular(10)),
                                              //                               child:
                                              //                                   Padding(
                                              //                                 padding: const EdgeInsets
                                              //                                     .all(
                                              //                                     50.0),
                                              //                                 child: Image
                                              //                                     .asset(
                                              //                                   "assets/images/add_doc.png",
                                              //                                   height:
                                              //                                       50,
                                              //                                 ),
                                              //                               ),
                                              //                             ),
                                              //                           )
                                              //                     : GestureDetector(
                                              //                         onTap: () {
                                              //                           if (checkIndex ==
                                              //                               index) {
                                              //                             setState(
                                              //                                 () {
                                              //                               checkIndex =
                                              //                                   -1;
                                              //                               _nameController
                                              //                                   .text = "";
                                              //                               _licenceController
                                              //                                   .text = "";
                                              //                               _expiryDate
                                              //                                   .text = '';
                                              //                               _apiExpiryDate =
                                              //                                   null;
                                              //                               pitch_Id =
                                              //                                   null;
                                              //                             });
                                              //                           } else {
                                              //                             setState(
                                              //                                 () {
                                              //                               checkIndex =
                                              //                                   index;
                                              //                               _nameController
                                              //                                       .text =
                                              //                                   doc[checkIndex - 1].docName ??
                                              //                                       "";
                                              //                               _licenceController
                                              //                                   .text = doc[checkIndex -
                                              //                                       1]
                                              //                                   .licenceNumber!;
                                              //                               if (doc[checkIndex - 1]
                                              //                                       .expiryDate !=
                                              //                                   null) {
                                              //                                 _expiryDate
                                              //                                     .text = formatter.format(DateTime.parse(doc[checkIndex -
                                              //                                         1]
                                              //                                     .expiryDate!));
                                              //                                 _apiExpiryDate =
                                              //                                     apiFormatter.format(DateTime.parse(doc[checkIndex - 1].expiryDate!));
                                              //                                 pitch_Id =
                                              //                                     doc[checkIndex - 1].id;
                                              //                               } else {
                                              //                                 _expiryDate.text =
                                              //                                     '';
                                              //                                 _apiExpiryDate =
                                              //                                     null;
                                              //                                 pitch_Id =
                                              //                                     null;
                                              //                               }
                                              //                             });
                                              //                           }
                                              //                         },
                                              //                         child: Stack(
                                              //                           children: [
                                              //                             ClipRRect(
                                              //                               borderRadius:
                                              //                                   BorderRadius.circular(
                                              //                                       10),
                                              //                               child: cachedNetworkImage(
                                              //                                   height: sizeHeight *
                                              //                                       .2,
                                              //                                   width: sizeWidth *
                                              //                                       0.45,
                                              //                                   cuisineImageUrl: doc[index - 1]
                                              //                                       .docImage,
                                              //                                   imageFit:
                                              //                                       BoxFit.fill),
                                              //                             ),
                                              //                             checkIndex ==
                                              //                                     index
                                              //                                 ? Container(
                                              //                                     height:
                                              //                                         sizeHeight * .2,
                                              //                                     width:
                                              //                                         sizeWidth * 0.45,
                                              //                                     decoration:
                                              //                                         BoxDecoration(color: Colors.white.withOpacity(.2), borderRadius: BorderRadius.circular(10)),
                                              //                                   )
                                              //                                 : const SizedBox
                                              //                                     .shrink(),
                                              //                             checkIndex ==
                                              //                                     index
                                              //                                 ? SizedBox(
                                              //                                     height:
                                              //                                         sizeHeight * .2,
                                              //                                     width:
                                              //                                         sizeWidth * 0.45,
                                              //                                     child:
                                              //                                         Padding(
                                              //                                       padding: const EdgeInsets.all(50.0),
                                              //                                       child: Image.asset(
                                              //                                         "assets/images/check.png",
                                              //                                         height: 50,
                                              //                                       ),
                                              //                                     ),
                                              //                                   )
                                              //                                 : const SizedBox
                                              //                                     .shrink(),
                                              //                           ],
                                              //                         ),
                                              //                       ),
                                              //               );
                                              //             }) :
                                              GestureDetector(
                                                  onTap: () {
                                                    _showChoiceDialog(context);
                                                  },
                                                  child: checkIndex == 1
                                                      ? cachedNetworkImage(
                                                          height:
                                                              sizeHeight * .2,
                                                          width: sizeWidth,
                                                          cuisineImageUrl:
                                                              image!.path)
                                                      : pdfClicked
                                                          ? _decidePdfView()
                                                          : _decideImageview())
                                              : GestureDetector(
                                                  onTap: () {
                                                    _showChoiceDialog(context);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Icon(
                                                        Icons.add_circle,
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? const Color(
                                                                0XFF9B9B9B)
                                                            : AppColors.white,
                                                        size: 50,
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .uploadDocument,
                                                          style: Theme
                                                                  .of(context)
                                                              .textTheme
                                                              .bodyMedium!
                                                              .copyWith(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? const Color(
                                                                          0XFF9B9B9B)
                                                                      : AppColors
                                                                          .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Poppins")),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .weNeedAccount,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleSmall!
                                                              .copyWith(
                                                                  color: const Color(
                                                                          0XFF9B9B9B)
                                                                      .withOpacity(
                                                                          .5),
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
                                                )),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.documentName,
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.themeColor
                                          : AppColors.white),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                ),
                                TextFieldWidget(
                                    controller: _nameController,
                                    hintText: AppLocalizations.of(context)!
                                        .documentName,
                                    enable:
                                        widget.detail.isEdit! ? false : true,
                                    onChanged: (value) {
                                      widget.detail.documentModel =
                                          DocumentModel(documentName: value!);
                                      return '';
                                    },
                                    onValidate: (value) {
                                      if (value.toString().isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseentername;
                                      }
                                      return null;
                                    },
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enableBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                SizedBox(
                                  height: sizeHeight * 0.02,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.licenceName,
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.themeColor
                                          : AppColors.white),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                ),
                                TextFieldWidget(
                                    controller: _licenceController,
                                    hintText: AppLocalizations.of(context)!
                                        .licenceName,
                                    type: TextInputType.number,
                                    onChanged: (value) {
                                      widget.detail.documentModel!
                                          .licenceNumber = value;
                                      return '';
                                    },
                                    enable:
                                        widget.detail.isEdit! ? false : true,
                                    onValidate: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseenterPitchName;
                                      }
                                      return null;
                                    },
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enableBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                SizedBox(
                                  height: sizeHeight * 0.02,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.expiryDate,
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.themeColor
                                          : AppColors.white),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                ),
                                InkWell(
                                  onTap: () async {
                                    var selectDate;
                                    selectDate =
                                        widget.specificAcademyId != null
                                            ? null
                                            : await slecteDtateTime(context);
                                    if (selectDate != null) {
                                      setState(() {
                                        _expiryDate.text = formatter
                                            .format((selectDate))
                                            .toString();
                                        _apiExpiryDate = apiFormatter
                                            .format((selectDate))
                                            .toString();
                                      });
                                    }
                                  },
                                  child: TextFieldWidget(
                                    controller: _expiryDate,
                                    hintText: 'Expiry Document Date',
                                    enable: false,
                                    onValidate: (value) {
                                      if (value.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .expriyDate;
                                      }
                                      return null;
                                    },
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    enableBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: AppColors.grey),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.02,
                                ),
                                locationController.text.isNotEmpty &&
                                        widget.specificAcademyId == null
                                    ? Text(
                                        AppLocalizations.of(context)!
                                            .academyLocation,
                                        style: TextStyle(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.themeColor
                                                : AppColors.white),
                                      )
                                    : const SizedBox.shrink(),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                ),
                                widget.specificAcademyId != null
                                    ? const SizedBox.shrink()
                                    : isAddressLoading
                                        ? GestureDetector(
                                            onTap: () {
                                              _permission();
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                shimmer(width: sizeWidth),
                                                SizedBox(
                                                  height: sizeHeight * 0.013,
                                                ),
                                                shimmer(width: sizeWidth * .8),
                                                SizedBox(
                                                  height: sizeHeight * 0.013,
                                                ),
                                                shimmer(width: sizeWidth),
                                              ],
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              isAddressLoading = true;
                                              FocusScope.of(context).unfocus();
                                              _getLocationPermission();
                                            },
                                            child: TextFieldWidget(
                                              controller: locationController,
                                              hintText: locationController.text,
                                              suffixIcon:
                                                  Icons.location_searching,
                                              suffixIconColor:
                                                  MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? AppColors.black
                                                      : AppColors.white,
                                              enable: false,
                                              onValidate: (value) {
                                                if (value.isEmpty) {
                                                  return AppLocalizations.of(
                                                          context)!
                                                      .expriyDate;
                                                }
                                                return null;
                                              },
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              enableBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              focusBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                            ),
                                          ),
                                SizedBox(
                                  height: sizeHeight * 0.02,
                                ),
                                locationController.text != '' &&
                                        _expiryDate.text != '' &&
                                        _nameController.text != ""
                                    ? ButtonWidget(
                                        onTaped: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            _formKey.currentState!.save();
                                            if (widget.specificAcademyId !=
                                                null) {
                                              print('Document $documentImage');
                                              print('Image $image');
                                              showMessage(
                                                  "You can't update your document");
                                              Navigator.pop(context);
                                              // List<Sessions> mondaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'monday')
                                              //         .toList();
                                              // List<Sessions> tuesdaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'tuesday')
                                              //         .toList();
                                              // List<Sessions> wednesdaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'wednesday')
                                              //         .toList();
                                              // List<Sessions> thursdaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'thursday')
                                              //         .toList();
                                              // List<Sessions> fridaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'friday')
                                              //         .toList();
                                              // List<Sessions> saturdaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'saturday')
                                              //         .toList();
                                              // List<Sessions> sundaySessions =
                                              //     _specificAcademy.sessions!
                                              //         .where((session) =>
                                              //             session.weekday ==
                                              //             'sunday')
                                              //         .toList();
                                              // for (int i = 0;
                                              //     i < mondaySessions.length;
                                              //     i++) {
                                              //   print(mondaySessions[i].name);
                                              // }
                                              // Map detailS = {
                                              //   "weekday":
                                              //       mondaySessions[0].weekday,
                                              //   "sessions": mondaySessions
                                              // };
                                              // print(detailS);
                                              // _specificAcademy.documents![0]
                                              //     .file = documentImage;
                                              // _specificAcademy.documents![0]
                                              //         .expiryDate =
                                              //     _expiryDate.text;
                                              // Map documentDetail =
                                              //     ModelToMapEditAcademy
                                              //         .editAcademy(
                                              //             _specificAcademy);
                                              // print(documentDetail);
                                              // editAcademy(documentDetail);
                                            } else {
                                              widget.detail.documentModel?.lat =
                                                  pitchLat;
                                              widget.detail.documentModel
                                                  ?.long = pitchLong;
                                              widget.detail.documentModel !=
                                                      null
                                                  ? widget.detail.documentModel!
                                                          .address =
                                                      locationController.text
                                                  : widget.detail.documentModel
                                                          ?.address =
                                                      locationController.text;
                                              // widget.detail.documentModel !=
                                              //         null
                                              //     ? widget.detail.documentModel!
                                              //             .documentImageId =
                                              //         pitch_Id
                                              //     : widget.detail.documentModel
                                              //             ?.documentImageId =
                                              //         pitch_Id;
                                              widget.detail.documentModel !=
                                                      null
                                                  ? widget.detail.documentModel!
                                                          .expiryDate =
                                                      _apiExpiryDate
                                                  : widget.detail.documentModel
                                                          ?.expiryDate =
                                                      _apiExpiryDate;
                                              widget.detail.documentModel !=
                                                      null
                                                  ? widget.detail.documentModel!
                                                      .country = country
                                                  : widget.detail.documentModel
                                                      ?.country = country;
                                              widget.detail.documentModel!
                                                      .documentImage =
                                                  documentImage;
                                              print(widget.detail.documentModel!
                                                  .documentImage);
                                              navigateToDocuments(
                                                  widget.detail);
                                            }
                                          }
                                        },
                                        title: Text(
                                          AppLocalizations.of(context)!.continu,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        isLoading: loading)
                                    : ButtonWidget(
                                        color: const Color(0XFFBCBCBC),
                                        onTaped: () {},
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .continu),
                                        isLoading: false),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
  }

  void navigateToDocuments(SportsModel detail) {
    print("Details$detail");
    Navigator.pushNamed(context, RouteNames.pitchDetail, arguments: detail);
  }

  void backToEdit() {
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      print('ddj');
      _isImageLoading = true;
      image = File(picture!.path);
      checkIndex = -1;
      print('Image$image');
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperMultiImageDocument(
        pitchImage: image,
        onSuccess: (msg) {
          _isImageLoading = false;
          setState(() {
            pitch_Id = msg;
            documentImage = msg;
            print(msg);
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
      checkIndex = -1;
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperMultiImageDocument(
        pitchImage: image,
        onSuccess: (msg) {
          setState(() {
            pitch_Id = msg;
            documentImage = msg;
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

  Widget _decidePdfView() {
    return PDFView(
      filePath: documentFilePath!.path,
      enableSwipe: true,
    );
  }

  Widget _decideImageview() {
    return Image.file(
      image!,
      fit: BoxFit.cover,
    );
  }
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

List<Map<String, dynamic>> sessions = [
  {
    "session_id": 500,
    "Holiday": false,
    "Name": "xcc",
    "Name_Arabic": "cccvht",
    "Slot_duration": 30,
    "Extra_slot": 10,
    "Start_time": "13:00:00",
    "End_time": "13:00:00",
    "Weekday": "monday",
  },
  {
    "session_id": 501,
    "Holiday": false,
    "Name": "xcc",
    "Name_Arabic": "cccvht",
    "Slot_duration": 30,
    "Extra_slot": 10,
    "Start_time": "13:00:00",
    "End_time": "13:00:00",
    "Weekday": "wednesday",
  },
  // Add more sessions here
];

// Filter sessions with "Weekday" equal to "Monday"
