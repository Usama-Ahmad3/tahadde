import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/bookPitchModelClass.dart';
import '../../../network/network_calls.dart';
import '../../../player/loginSignup/signup.dart';

// GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class RejectPitch extends StatefulWidget {
  Map pitchDetail;

  RejectPitch({super.key, required this.pitchDetail});

  @override
  _RejectPitchState createState() => _RejectPitchState();
}

class _RejectPitchState extends State<RejectPitch> {
  bool addPitch = false;
  late String gamePlay;
  late bool doc;
  final _formKey = GlobalKey<FormState>();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController _mapController;
  late File image;
  late File docImage;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late BookPitchDetail pitchDetail;
  var pitch_Id;
  var doc_Id;
  List<Marker> allMarkers = [];
  late String _curentlySelectedItem1;
  final focus = FocusNode();
  final focuss = FocusNode();
  late String locationName;
  final _nameController = TextEditingController(text: '');
  final _descriptionController = TextEditingController(text: '');
  bool map = false;
  late String pitchName;
  late String pitchTypeSlug;
  late String pitchDescription;
  late Position position;
  late String country;
  late bool _internet;
  late int gamePlayId;
  late double pitchLat;
  late double pitchLong;
  late int count;
  late String pitchType;
  bool isAddressLoading = false;
  var price;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  List<int> indexList = [];
  final _pitchType = [
    "5x5",
    "7x7",
    "11x11",
  ];

  final _pitchTypeSlug = [
    "5-aside",
    "7-aside",
    "11-aside",
  ];
  final List<String> _dropdownMonth = [
    "Indoor",
    "Outdoor",
    "Both",
  ];
  final List<String> _dropdownMonthAr = [
    "ملعب داخلي",
    "ملعب خارجي",
    "على حد سواء",
  ];
  late OverlayEntry? overlayEntry;

  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: const DoneButton(),
      );
    });
    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  addMarker() {
    allMarkers.clear();
    allMarkers.add(Marker(
      markerId: const MarkerId('myMarker'),
      draggable: false,
      onTap: () {
        debugPrint('marker');
      },
      position: LatLng(position.latitude, position.longitude),
    ));
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
                    child:
                        Text(AppLocalizations.of(context)!.choosefromlibrary),
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
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
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

  loadVerifiedPitch() async {
    await _networkCalls.verifiedPitchInfoDetail(
        detail: widget.pitchDetail,
        onSuccess: (event) {
          setState(() {
            pitchDetail = event;
            if (pitchDetail.facilities!.isNotEmpty) {
              for (int i = 0; i < pitchDetail.facilities!.length; i++) {
                indexList.add(pitchDetail.facilities![i]!.id!.toInt());
              }
            }
            _descriptionController.text = pitchDetail.description.toString();
            _nameController.text = pitchDetail.name.toString();
            _curentlySelectedItem1 = pitchDetail.gamePlay!.name.toString();
            gamePlayId = pitchDetail.gamePlay!.id!.toInt();
            country = pitchDetail.country.toString();
            locationName = pitchDetail.location.toString();
            _isLoading = false;
          });
        },
        onFailure: (msg) {
          setState(() {
            _isLoading = false;
          });
        },
        tokenExpire: () {});
  }

  location() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      setState(() {
        map = true;
        position = value;
        addMarker();
        Map latlong = {
          "latitude": position.latitude.toString(),
          "longitude": position.longitude.toString(),
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
        //defaultGetUserLocation(position.latitude,position.longitude,false);
      });
    });
  }

  onWillPop(String id) {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(
              AppLocalizations.of(context)!.areYouSureYouWant,
              style: const TextStyle(
                  color: Color(0XFF032040),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0XFFA3A3A3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("  ${AppLocalizations.of(context)!.no}  ",
                          style: const TextStyle(color: Color(0XFF696969))),
                    )),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0XFF25A163),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("  ${AppLocalizations.of(context)!.yes}  ",
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      setState(() {
                        _isLoading = true;
                        Navigator.of(context).pop(false);
                        _networkCalls.deleteSubPitch(
                          id: widget.pitchDetail["id"],
                          pitchTypeId: id,
                          onSuccess: (msg) {
                            loadVerifiedPitch();
                          },
                          onFailure: (n) {},
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      });
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                      }
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focuss.addListener(() {
        bool hasFocus = focuss.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
      focus.addListener(() {
        bool hasFocus = focus.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    _networkCalls.checkInternetConnectivity(onSuccess: (internet) {
      _internet = internet;
      if (internet) {
        loadVerifiedPitch();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: appThemeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0XFF25A163),
              ),
            ),
          )
        : _internet
            ? map
                ? Scaffold(
                    appBar: AppBar(
                      actions: [
                        GestureDetector(
                          onTap: () {
                            // _handlePressButton();
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Icon(
                              Icons.search,
                              color: Color(0XFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            map = false;
                            isAddressLoading = false;
                          });
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0XFFFFFFFF),
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      backgroundColor: const Color(0XFF032040),
                      title: Text(
                        AppLocalizations.of(context)!.pitchLocation,
                        style: TextStyle(
                            fontSize: appHeaderFont,
                            color: const Color(0XFFFFFFFF),
                            fontFamily:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? "Poppins"
                                    : "VIP",
                            fontWeight:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                      ),
                    ),
                    bottomSheet: BottomSheet(
                      onClosing: () {},
                      builder: (context) => Container(
                        height: 150,
                        width: sizeWidth,
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            flaxibleGap(
                              1,
                            ),
                            Material(
                              child: Ink(
                                width: sizeWidth * .7,
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
                            flaxibleGap(
                              1,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(locationName),
                            ),
                            flaxibleGap(
                              1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
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
                                position: LatLng(pitchLat, pitchLong),
                              ));
                            });
                            Map latlong = {
                              "latitude": pitchLat.toString(),
                              "longitude": pitchLong.toString(),
                            };
                            _networkCalls.getAddress(
                                LatLong: latlong,
                                onSuccess: (msg) {
                                  if (mounted) {
                                    setState(() {
                                      country = msg[1];
                                      locationName = msg[0];
                                      //isAddressLoading=false;
                                    });
                                  }
                                },
                                onFailure: (msg) {
                                  showMessage(msg);
                                },
                                tokenExpire: () {
                                  if (mounted) on401(context);
                                });
                            // getUserLocation();
                          },

                          compassEnabled: true,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target:
                                  LatLng(position.latitude, position.longitude),
                              zoom: 15.0),
                          markers: Set.from(allMarkers),
                          //markers: _markers.values.toSet(),
                        ),
                      ),
                    ),
                  )
                : Stack(
                    children: <Widget>[
                      Scaffold(
                          key: _scaffoldKey,
                          bottomNavigationBar: GestureDetector(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                _networkCalls.checkInternetConnectivity(
                                    onSuccess: (msg) {
                                  if (msg) {
                                    Map url = {
                                      'id': pitchDetail.id.toString(),
                                      "pitch": "inreview",
                                      "language":
                                          AppLocalizations.of(context)!.locale
                                    };
                                    Map body = {
                                      "name": pitchName,
                                      "description": pitchDescription,
                                      "gameplayId": gamePlayId,
                                      "country": country,
                                      "location": locationName
                                    };
                                    if (indexList.isNotEmpty) {
                                      body["facilitiesId"] = indexList;
                                    }
                                    if (pitch_Id != null) {
                                      body["imageId"] = pitch_Id;
                                    }
                                    if (doc_Id != null) {
                                      body["documentId"] = doc_Id;
                                    }

                                    _networkCalls.editPitch(
                                      body: body,
                                      urlDetail: url,
                                      onSuccess: (msg) {
                                        navigateToOwnerHome();
                                      },
                                      onFailure: (e) {},
                                      tokenExpire: () {
                                        if (mounted) on401(context);
                                      },
                                    );
                                  } else {
                                    if (mounted) {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });
                              }
                            },
                            child: Container(
                                height: sizeHeight * .09,
                                color: const Color(0XFF25A163),
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.save,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                          ),
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
                            backgroundColor: const Color(0XFF032040),
                            automaticallyImplyLeading: false,
                            title: Text(
                              AppLocalizations.of(context)!.rejectedPitch,
                              style: TextStyle(
                                  fontSize: appHeaderFont,
                                  color: const Color(0XFFFFFFFF),
                                  fontFamily:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? "Poppins"
                                          : "VIP",
                                  fontWeight:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                            ),
                          ),
                          body: Form(
                            key: _formKey,
                            child: ListView(
                              children: <Widget>[
                                Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    image == null
                                        ? cachedNetworkImage(
                                            height: 150,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            cuisineImageUrl: pitchDetail
                                                    .bookpitchfiles!
                                                    .files![0]!
                                                    .filePath ??
                                                '',
                                          )
                                        : Image.file(
                                            image,
                                            fit: BoxFit.cover,
                                            height: 150,
                                            width: sizeWidth,
                                          ),
                                    image == null
                                        ? BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 0.0, sigmaY: 0.0),
                                            child: Container(
                                              color:
                                                  Colors.white.withOpacity(.5),
                                              height: 150,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                          )
                                        : Container(),
                                    GestureDetector(
                                      onTap: () {
                                        doc = false;
                                        _showChoiceDialog(context);
                                      },
                                      child: Container(
                                        color: const Color(0XFFF1F1F1),
                                        height: 40,
                                        child: Row(
                                          children: <Widget>[
                                            flaxibleGap(
                                              3,
                                            ),
                                            const Icon(
                                              Icons.camera,
                                              color: Color(0XFF25A163),
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .changeImage,
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF032040),
                                                )),
                                            flaxibleGap(
                                              20,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20),
                                  child: textField(
                                      name: AppLocalizations.of(context)!
                                          .pitchName,
                                      controller: _nameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return AppLocalizations.of(context)!
                                              .pleaseenterPitchName;
                                        }
                                        return '';
                                      },
                                      text: false,
                                      text1: false,
                                      submit: (value) => FocusScope.of(context)
                                          .requestFocus(focus),
                                      onSaved: (value) => pitchName = value!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40, top: 20),
                                  child: locationName != null
                                      ? Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .pitchLocation,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              // color: Color(0XFF25A163),
                                              color: Color(0XFFADADAD),
                                              fontSize: 12,

                                              fontFamily: 'Poppins',
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ),
                                isAddressLoading
                                    ? Padding(
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
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 5),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isAddressLoading = true;
                                              location();
                                            });
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: sizeWidth * .75,
                                                child: Text(
                                                  locationName,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    // color: Color(0XFF25A163),
                                                    color:
                                                        const Color(0XFF032040),
                                                    fontSize: 15,
                                                    fontWeight:
                                                        locationName == null
                                                            ? FontWeight.w600
                                                            : FontWeight.w600,
                                                    fontFamily: 'Poppins',
                                                  ),
                                                  maxLines: 5,
                                                ),
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              Image.asset(
                                                  "images/locationPitch.png"),
                                            ],
                                          ),
                                        ),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 40, right: 40),
                                  child: Container(
                                    height: 1,
                                    color: const Color(0XFFADADAD),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    top: 20,
                                    right: 40,
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)!
                                            .description,
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          // color: Color(0XFF25A163),
                                          color: Color(0XFFADADAD),
                                          fontSize: 15,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 40,
                                    right: 40,
                                  ),
                                  child: Container(
                                    height: sizeHeight * .15,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFFA3A3A3))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: TextFormField(
                                        controller: _descriptionController,
                                        focusNode: focus,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterDescription;
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w600),
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
                                AppLocalizations.of(context)!.locale == "en"
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 20),
                                        child: SizedBox(
                                          height: sizeHeight * .07,
                                          child: Center(
                                            child: DropdownButton<String>(
                                              underline: Container(
                                                height: 1,
                                                color: const Color(0XFF9F9F9F),
                                              ),
                                              iconEnabledColor:
                                                  const Color(0XFF9B9B9B),
                                              focusColor:
                                                  const Color(0XFF9B9B9B),
                                              isExpanded: true,
                                              value: _curentlySelectedItem1,
                                              hint: Text(
                                                AppLocalizations.of(context)!
                                                    .chooseyoursport,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0XFFADADAD),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              items: _dropdownMonth
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0XFF032040),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _curentlySelectedItem1 =
                                                      value!;
                                                  gamePlay = value;
                                                  gamePlayId = value == "Indoor"
                                                      ? 9
                                                      : value == "both"
                                                          ? 14
                                                          : 8;
                                                  debugPrint(
                                                      'User Selected $value');
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 40, right: 40, bottom: 20),
                                        child: SizedBox(
                                          height: sizeHeight * .07,
                                          child: Center(
                                            child: DropdownButton<String>(
                                              underline: Container(
                                                height: 1,
                                                color: const Color(0XFF9F9F9F),
                                              ),
                                              iconEnabledColor:
                                                  const Color(0XFF9B9B9B),
                                              focusColor:
                                                  const Color(0XFF9B9B9B),
                                              isExpanded: true,
                                              value: _curentlySelectedItem1,
                                              hint: Text(
                                                AppLocalizations.of(context)!
                                                    .chooseyoursport,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color(0XFFADADAD),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              items: _dropdownMonthAr
                                                  .map((value) =>
                                                      DropdownMenuItem(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0XFF032040),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (String? value) {
                                                setState(() {
                                                  _curentlySelectedItem1 =
                                                      value!;
                                                  gamePlay = value;
                                                  gamePlayId = value ==
                                                          "ملعب داخلي"
                                                      ? 9
                                                      : value == "على حد سواء"
                                                          ? 14
                                                          : 8;
                                                  debugPrint(
                                                      'User Selected $value');
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                Container(
                                  color: const Color(0XFFF2F2F2),
                                  height: sizeHeight * .4,
                                  width: sizeWidth,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05,
                                              vertical: sizeHeight * .02),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .myPitches,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF9B9B9B),
                                                decoration:
                                                    TextDecoration.none),
                                          )),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .07,
                                            vertical: sizeHeight * .01),
                                        child: Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              child: Container(
                                                height: sizeHeight * .05,
                                                width: sizeHeight * .05,
                                                decoration: BoxDecoration(
                                                  color: const Color(0XFF25A163)
                                                      .withOpacity(.3),
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Image.asset(
                                                  'images/addnew.png',
                                                ),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  addPitch = true;
                                                  count = 0;
                                                  pitchType = '';
                                                });
                                              },
                                            ),
                                            Container(
                                              width: sizeWidth * .03,
                                            ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .addPitch,
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins")),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizeHeight * .25,
                                        child: ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                pitchDetail.pitchType!.length,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    left: sizeWidth * .05,
                                                    right: sizeWidth * .05,
                                                    top: sizeHeight * .01),
                                                child: Container(
                                                  height: sizeHeight * .08,
                                                  width: sizeWidth * .8,
                                                  decoration:
                                                      const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                            Radius.circular(
                                                                5.0),
                                                            //
                                                          ),
                                                          color: Colors.white),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizeWidth *
                                                                        .04),
                                                        child: Text(
                                                            "${pitchDetail.pitchType![index]!.area}",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF032040),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 18)),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizeWidth *
                                                                        .02),
                                                        child: Container(
                                                          height:
                                                              sizeHeight * .05,
                                                          width: 2,
                                                          color: const Color(
                                                              0XFF979797),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizeWidth *
                                                                        .02),
                                                        child: Container(
                                                          width: sizeWidth * .3,
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                              "${pitchDetail.pitchType![index]!.name}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF979797),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      14)),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizeWidth *
                                                                        .05),
                                                        child: Text(
                                                            "${AppLocalizations.of(context)!.currency} ${pitchDetail.pitchType![index]!.paymentSummary!.grandTotal.round()}",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF25A163),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 12)),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          onWillPop(pitchDetail
                                                              .pitchType![
                                                                  index]!
                                                              .id
                                                              .toString());
                                                        },
                                                        child: Image.asset(
                                                          'images/delete.png',
                                                          height: 15,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 10, top: 10),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: sizeHeight * .27,
                                      color: const Color(0XFFF2F2F2),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20, right: 20, bottom: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 20),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .chooseFacilitiesProvided,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    color: Color(0XFF9B9B9B),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20, bottom: 10),
                                              child: SizedBox(
                                                height: sizeHeight * .13,
                                                child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: facility.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int blockIdx) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              if (indexList.contains(
                                                                  facilityId[
                                                                      blockIdx])) {
                                                                indexList.remove(
                                                                    facilityId[
                                                                        blockIdx]);
                                                              } else {
                                                                indexList.add(
                                                                    facilityId[
                                                                        blockIdx]);
                                                              }
                                                              //count=blockIdx;
                                                            });
                                                          },
                                                          child: indexList.contains(
                                                                  facilityId[
                                                                      blockIdx])
                                                              ? Container(
                                                                  width:
                                                                      sizeWidth *
                                                                          .28,
                                                                  height:
                                                                      sizeWidth *
                                                                          .07,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0XFFA3A3A3)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: const Color(
                                                                            0XFF25A163)
                                                                        .withOpacity(
                                                                            .3),
                                                                  ),
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      flaxibleGap(
                                                                        2,
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        facilityImageS[
                                                                            blockIdx],
                                                                        width: sizeWidth *
                                                                            .1,
                                                                        height:
                                                                            sizeWidth *
                                                                                .1,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                      flaxibleGap(
                                                                        1,
                                                                      ),
                                                                      AppLocalizations.of(context)!.locale ==
                                                                              "en"
                                                                          ? Text(
                                                                              facility[blockIdx],
                                                                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF424242), decoration: TextDecoration.none))
                                                                          : Text(facilityAr[blockIdx], style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF424242), decoration: TextDecoration.none)),
                                                                      flaxibleGap(
                                                                        1,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width:
                                                                      sizeWidth *
                                                                          .28,
                                                                  height:
                                                                      sizeWidth *
                                                                          .07,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border: Border.all(
                                                                        color: const Color(
                                                                            0XFFA3A3A3)),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      flaxibleGap(
                                                                        2,
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        facilityImage[
                                                                            blockIdx],
                                                                        width: sizeWidth *
                                                                            .1,
                                                                        height:
                                                                            sizeWidth *
                                                                                .1,
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                      flaxibleGap(
                                                                        1,
                                                                      ),
                                                                      AppLocalizations.of(context)!.locale ==
                                                                              "en"
                                                                          ? Text(
                                                                              facility[blockIdx],
                                                                              style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF424242), decoration: TextDecoration.none))
                                                                          : Text(facilityAr[blockIdx], style: const TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Color(0XFF424242), decoration: TextDecoration.none)),
                                                                      flaxibleGap(
                                                                        1,
                                                                      ),
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
                                      )),
                                ),
                                Container(
                                  color: Colors.white,
                                  height: sizeHeight * .3,
                                  width: sizeWidth,
                                  alignment: Alignment.center,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: <Widget>[
                                      docImage == null
                                          ? Padding(
                                              padding: EdgeInsets.only(
                                                left: sizeWidth * .05,
                                                right: sizeWidth * .05,
                                              ),
                                              child: cachedNetworkImage(
                                                height: sizeHeight * .25,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                cuisineImageUrl: pitchDetail
                                                        .bookpitchfiles!
                                                        .document!
                                                        .filePath ??
                                                    '',
                                              ))
                                          : Image.file(
                                              docImage,
                                              fit: BoxFit.cover,
                                              height: 150,
                                              width: sizeWidth,
                                            ),
                                      docImage == null
                                          ? BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 0.0, sigmaY: 0.0),
                                              child: Container(
                                                color: Colors.white
                                                    .withOpacity(.7),
                                                height: sizeHeight * .3,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                              ),
                                            )
                                          : Container(),
                                      GestureDetector(
                                        onTap: () {
                                          doc = true;
                                          _showChoiceDialog(context);
                                        },
                                        child: Container(
                                          color: const Color(0XFFF1F1F1),
                                          height: 40,
                                          child: Row(
                                            children: <Widget>[
                                              flaxibleGap(
                                                3,
                                              ),
                                              const Icon(
                                                Icons.edit,
                                                color: Color(0XFF25A163),
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .addanotherdocument,
                                                  style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFF032040),
                                                  )),
                                              flaxibleGap(
                                                20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                      addPitch
                          ? BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                color: Colors.black.withOpacity(0),
                              ),
                            )
                          : Container(),
                      addPitch
                          ? Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: Container(
                                  height: sizeHeight * .5,
                                  width: sizeWidth,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .addnewpitchdetails,
                                                style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Color(0XFFADADAD),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins")),
                                            flaxibleGap(
                                              1,
                                            ),
                                            SizedBox(
                                              height: sizeHeight * .03,
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  setState(() {
                                                    addPitch = false;
                                                  });
                                                },
                                                backgroundColor:
                                                    const Color(0XFFD8D8D8),
                                                splashColor: Colors.black,
                                                child: Icon(
                                                  Icons.clear,
                                                  color:
                                                      const Color(0XFF4A4A4A),
                                                  size: sizeHeight * .02,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseentername;
                                              }
                                              return null;
                                            },
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(focuss);
                                            },
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) {
                                              pitchName = value!;
                                            },
                                            autofocus: false,
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .name,
                                              //\uD83D\uDD12
                                              labelStyle: const TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .selectPitchType,
                                            style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Color(0XFFADADAD),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins")),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05,
                                            vertical: sizeHeight * .005),
                                        child: SizedBox(
                                          height: sizeHeight * .11,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _pitchType.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int blockIdx) {
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (count == blockIdx) {
                                                          count = 0;
                                                          pitchType = "";
                                                        } else {
                                                          count = blockIdx;
                                                          pitchType =
                                                              _pitchType[
                                                                  blockIdx];
                                                          pitchTypeSlug =
                                                              _pitchTypeSlug[
                                                                  blockIdx];
                                                        }
                                                      });
                                                    },
                                                    child: count == blockIdx
                                                        ? Container(
                                                            height: sizeHeight *
                                                                .11,
                                                            width: sizeHeight *
                                                                .13,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0XFF032040),
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFF979797)),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10.0) //                 <--- border radius here
                                                                      ),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              _pitchType[
                                                                  blockIdx],
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Color(
                                                                      0XFF25A163),
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: sizeHeight *
                                                                .11,
                                                            width: sizeHeight *
                                                                .13,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                      0XFF25A163)
                                                                  .withOpacity(
                                                                      .25),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10.0) //                 <--- border radius here
                                                                      ),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              _pitchType[
                                                                  blockIdx],
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Color(
                                                                      0XFF646464),
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05,
                                              vertical: sizeHeight * .005),
                                          child: TextFormField(
                                            focusNode: focuss,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterprice;
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            textInputAction:
                                                TextInputAction.done,
                                            onSaved: (value) {
                                              price = value;
                                            },
                                            autofocus: false,
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  const EdgeInsets.all(0),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .price,
                                              //\uD83D\uDD12
                                              labelStyle: const TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12),
                                              suffixText:
                                                  AppLocalizations.of(context)!
                                                      .currency,
                                              suffixStyle: const TextStyle(
                                                  color: Color(0XFF858585),
                                                  fontSize: 12),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        3,
                                      ),
                                      pitchType != null
                                          ? GestureDetector(
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  setState(() {
                                                    addPitch = false;
                                                    _isLoading = true;
                                                    Map detai = {
                                                      "subpitchtypeName":
                                                          pitchName,
                                                      "payment": price,
                                                      "pitchtypeSlug":
                                                          pitchTypeSlug,
                                                      "area": pitchType
                                                    };
                                                    _networkCalls
                                                        .createSubPitch(
                                                      bodydata: detai,
                                                      id: widget
                                                          .pitchDetail["id"],
                                                      onSuccess: (msg) {
                                                        loadVerifiedPitch();
                                                      },
                                                      onFailure: (n) {},
                                                      tokenExpire: () {
                                                        if (mounted) {
                                                          on401(context);
                                                        }
                                                      },
                                                    );
                                                  });
                                                }
                                              },
                                              child: Container(
                                                  color:
                                                      const Color(0XFF25A163),
                                                  height: sizeHeight * .08,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .save,
                                                    style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  )),
                                            )
                                          : Container(
                                              color: const Color(0XFFBCBCBC),
                                              height: sizeHeight * .08,
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .save,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                ),
                                              )),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadVerifiedPitch();
                    }
                  });
                },
              );
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _isLoading = true;
      doc ? docImage = File(picture!.path) : image = File(picture!.path);
      var detail = {
        "profile_image": doc ? docImage : image,
        "type": "bookpitch"
      };
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            doc ? doc_Id = msg : pitch_Id = msg;
            print(msg);
            _isLoading = false;
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _isLoading = true;
      doc ? docImage = File(picture!.path) : image = File(picture!.path);
      var detail = {
        "profile_image": doc ? docImage : image,
        "type": "bookpitch"
      };
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(
            () {
              doc ? doc_Id = msg : pitch_Id = msg;
              _isLoading = false;
            },
          );
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  void navigateToOwnerHome() {
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, RouteNames.myPitches, arguments: 1);
  }

  // Future<void> _handlePressButton() async {
  //   // show input autocomplete with selected mode
  //   // then get the Prediction selected
  //   Prediction p = await PlacesAutocomplete.show(
  //     context: context,
  //     apiKey: kGoogleApiKey,
  //     onError: onError,
  //     mode: Mode.overlay,
  //     language: "en",
  //     components: [Component(Component.country, "are")],
  //   );
  //
  //   displayPrediction(p, homeScaffoldKey.currentState);
  // }

  void onError(response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

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
