import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/specific_pitch_model_class.dart';
import '../../../network/network_calls.dart';
import '../../loginSignupPitchOwner/select_sport.dart';

class EditVenues extends StatefulWidget {
  final Map detail;
  EditVenues({required this.detail});
  @override
  _EditVenuesState createState() => _EditVenuesState();
}

class _EditVenuesState extends State<EditVenues> {
  late bool _internet;
  bool _isLoading = true;
  String date = "name";

  final scaffoldkey = GlobalKey<ScaffoldState>();
  late SpecificModelClass specificPitchScreen;
  late String venueType;
  final NetworkCalls _networkCalls = NetworkCalls();
  List<File> image = <File>[];

  loadSpecific() async {
    await _networkCalls.specificVenue(
      id: widget.detail["id"].toString(),
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            specificPitchScreen = event;
            if (specificPitchScreen.isDeclined!) {
              venueType = "declined";
            } else if (specificPitchScreen.isVerified!) {
              venueType = "verified";
            } else {
              venueType = "inreview";
            }
            _isLoading = false;
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

  editVenue(Map detail) async {
    await _networkCalls.editVenue(
      id: widget.detail["id"].toString(),
      venueDetail: detail,
      venueType: venueType,
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            specificPitchScreen = event;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = true;
          });
        }
        loadSpecific();
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
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

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadSpecific();
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
    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        flexibleSpace: Image(
          image: AppLocalizations.of(context)!.locale == "en"
              ? const AssetImage("assets/images/header.png")
              : const AssetImage("assets/images/arabicHeader.png"),
          fit: BoxFit.cover,
        ),
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
          widget.detail["name"],
          style: TextStyle(
              fontSize: 16,
              color: const Color(0XFFFFFFFF),
              fontFamily: AppLocalizations.of(context)!.locale == "en"
                  ? "Poppins"
                  : "VIP",
              fontWeight: FontWeight.w600),
        ),
      ),
      // bottomNavigationBar: GestureDetector(
      //   onTap: () {},
      //   child: Container(
      //       height: sizeHeight * .09,
      //       color: Color(0XFFE73D3B),
      //       alignment: Alignment.center,
      //       child: Text(
      //         "Closed for Maintenance",
      //         style: TextStyle(
      //             fontFamily: "Poppins",
      //             fontWeight: FontWeight.w500,
      //             fontSize: 20,
      //             color: Colors.white),
      //       )),
      // ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: appThemeColor,
              ),
            )
          : _internet
              ? Container(
                  height: sizeHeight,
                  width: sizeWidth,
                  padding: const EdgeInsets.all(20),
                  color: const Color(0XFFE5E5E5),
                  child: Column(
                    children: [
                      fixedGap(height: 10.0),
                      SizedBox(
                        height: specificPitchScreen.images!.files!.length <= 2
                            ? 100
                            : 200,
                        child: specificPitchScreen.images!.files!.length <= 2
                            ? ListView.builder(
                                itemCount:
                                    specificPitchScreen.images!.files!.length +
                                        1,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return index == 0
                                      ? GestureDetector(
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              color: const Color(0XFFD4D4D4),
                                              width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  Image.asset(
                                                    "assets/images/add_vanue.png",
                                                    height: 20,
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .addPitchImage,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFFB3B3B3),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "Poppins")),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              // _decideImageview(index-1),
                                              cachedNetworkImage(
                                                  width: 100,
                                                  height: 100,
                                                  cuisineImageUrl:
                                                      specificPitchScreen
                                                          .images!
                                                          .files![index - 1]!
                                                          .filePath),
                                              specificPitchScreen.images!.files!
                                                          .length >
                                                      1
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          specificPitchScreen
                                                              .images!.files!
                                                              .removeAt(
                                                                  index - 1);
                                                          List<int> imageList =
                                                              [];
                                                          specificPitchScreen
                                                              .images!.files!
                                                              .forEach(
                                                                  (element) {
                                                            imageList.add(
                                                                element!.id!);
                                                          });
                                                          Map<String, dynamic>
                                                              detail = {
                                                            "pitchimageId":
                                                                imageList,
                                                          };
                                                          editVenue(detail);
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "assets/images/delete_image.png",
                                                        height: 25,
                                                      ),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                        );
                                }),
                              )
                            : GridView.count(
                                crossAxisCount: 2,
                                scrollDirection: Axis.horizontal,
                                children: List.generate(
                                    specificPitchScreen.images!.files!.length +
                                        1, (index) {
                                  return index == 0
                                      ? GestureDetector(
                                          onTap: () {
                                            _showChoiceDialog(context);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Container(
                                              color: const Color(0XFFD4D4D4),
                                              width: 100,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  Image.asset(
                                                    "assets/images/add_vanue.png",
                                                    height: 20,
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .addPitchImage,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFFB3B3B3),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "Poppins")),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Stack(
                                            alignment: Alignment.topRight,
                                            children: [
                                              // _decideImageview(index-1),
                                              cachedNetworkImage(
                                                  width: 100,
                                                  height: 100,
                                                  cuisineImageUrl:
                                                      specificPitchScreen
                                                          .images!
                                                          .files![index - 1]!
                                                          .filePath),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    specificPitchScreen
                                                        .images!.files!
                                                        .removeAt(index - 1);
                                                    List<int> imageList = [];
                                                    specificPitchScreen
                                                        .images!.files!
                                                        .forEach((element) {
                                                      imageList
                                                          .add(element!.id!);
                                                    });
                                                    Map<String, dynamic>
                                                        detail = {
                                                      "pitchimageId": imageList,
                                                    };
                                                    editVenue(detail);
                                                  });
                                                },
                                                child: Image.asset(
                                                  "assets/images/delete_image.png",
                                                  height: 25,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                })),
                      ),
                      fixedGap(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            card(
                                image: "assets/images/document_image.png",
                                text: AppLocalizations.of(context)!.documents,
                                onTap: () {
                                  navigateToDocuments(SportsModel(
                                      isEdit: true,
                                      id: widget.detail["id"],
                                      venueType: venueType));
                                }),
                            flaxibleGap(
                              1,
                            ),
                            card(
                                image: "assets/images/venue_detail_image.png",
                                text:
                                    AppLocalizations.of(context)!.pitchDetails,
                                onTap: () {
                                  navigateToPitchDetail(specificPitchScreen);
                                }),
                          ],
                        ),
                      ),
                      fixedGap(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            card(
                                image: "assets/images/price_image.png",
                                text: AppLocalizations.of(context)!.slotPrice,
                                onTap: () {
                                  Map detail = {
                                    "id": specificPitchScreen.id.toString(),
                                    "subPitchId": specificPitchScreen
                                        .venueDetails!.pitchType![0]!.id
                                        .toString(),
                                    "back": true
                                  };
                                  navigateToSlotScreen(detail);
                                }),
                            flaxibleGap(
                              1,
                            ),
                            card(
                                image: "assets/images/session_image.png",
                                text: AppLocalizations.of(context)!.sessions,
                                onTap: () {
                                  navigateToEditSession();
                                }),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              : InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (msg == true) {
                        loadSpecific();
                      }
                    });
                  },
                ),
    );
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickMultiImage();
    for (int i = 0; i < picture.length; i++) {
      File imageIndex = File(picture[i].path);
      image.add(imageIndex);
    }
    var detail = {"profile_image": image, "type": "bookpitch"};
    await _networkCalls.helperMultiImage(
      pitchImage: detail,
      onSuccess: (msg) {
        List<dynamic> pitchImageId = msg;
        specificPitchScreen.images!.files!.forEach((element) {
          pitchImageId.add(element!.id);
        });
        Map<String, dynamic> detail = {
          "pitchimageId": pitchImageId,
        };
        editVenue(detail);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );

    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    image.add(File(picture!.path));
    var detail = {"profile_image": image, "type": "bookpitch"};
    await _networkCalls.helperMultiImage(
      pitchImage: detail,
      onSuccess: (msg) {
        List<dynamic> pitchImageId = msg;
        specificPitchScreen.images!.files!.forEach((element) {
          pitchImageId.add(element!.id);
        });
        Map<String, dynamic> detail = {
          "pitchimageId": pitchImageId,
        };
        editVenue(detail);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );

    Navigator.of(context).pop();
  }

  Widget card(
      {required String image, required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.center,
        height: 150,
        width: 150,
        color: appThemeColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 60,
              width: 60,
            ),
            Text(
              text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }

  void navigateToDocuments(SportsModel detail) {
    Navigator.pushNamed(context, RouteNames.documents, arguments: detail);
  }

  void navigateToPitchDetail(var detail) {
    Map pitchDetail = {
      "id": widget.detail["id"],
      "venueType": venueType,
      "detail": detail
    };
    Navigator.pushNamed(context, RouteNames.editPitchDetail,
        arguments: pitchDetail);
  }

  void navigateToSlotScreen(Map detail) {
    Navigator.pushNamed(context, RouteNames.slotChart, arguments: detail);
  }

  void navigateToEditSession() {
    Map detail = {
      "id": specificPitchScreen.id.toString(),
      "subPitchId":
          specificPitchScreen.venueDetails!.pitchType![0]!.id.toString(),
    };
    Navigator.pushNamed(context, RouteNames.editSession, arguments: detail);
  }
}
