import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/document_screen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/listWidgetSettings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../constant.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/specific_pitch_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../../pitchOwner/loginSignupPitchOwner/select_sport.dart';

class EditVenuesScreen extends StatefulWidget {
  final Map detail;
  const EditVenuesScreen({super.key, required this.detail});
  @override
  State<EditVenuesScreen> createState() => _EditVenuesScreenState();
}

class _EditVenuesScreenState extends State<EditVenuesScreen> {
  late bool _internet;
  bool _isLoading = true;
  String date = "name";

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
            title: Text(
              AppLocalizations.of(context)!.uploadprofilepicture,
              style: const TextStyle(color: Colors.black),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
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
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary,
                        style: const TextStyle(color: Colors.black)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto,
                        style: const TextStyle(color: Colors.black)),
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
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
          preferredSize: Size(width, height * 0.105),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.pitchBookings,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leadingWidth: width * 0.18,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    padding: EdgeInsets.all(height * 0.008),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.close,
                        color: Colors.white,
                      ),
                    )),
              ),
            ),
          )),
      body: _isLoading
          ? Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.white
                      : const Color(0xff686868),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Center(
                child: CircularProgressIndicator(
                  color: appThemeColor,
                ),
              ),
            )
          : _internet
              ? Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.033),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : const Color(0xff686868),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      fixedGap(height: 10.0),
                      SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount:
                                specificPitchScreen.images!.files!.length + 1,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              return index == 0
                                  ? GestureDetector(
                                      onTap: () {
                                        _showChoiceDialog(context);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: CircleAvatar(
                                          backgroundColor:
                                              const Color(0XFFD4D4D4),
                                          radius: height * 0.053,
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                flaxibleGap(1),
                                                Image.asset(
                                                  "assets/images/add_vanue.png",
                                                  height: height * 0.03,
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .addPitchImage,
                                                    textAlign: TextAlign.center,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFFB3B3B3),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Poppins")),
                                                flaxibleGap(
                                                  1,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Stack(
                                        alignment: Alignment.topRight,
                                        children: [
                                          Container(
                                            height: height * 0.11,
                                            width: width * 0.25,
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              child: cachedNetworkImage(
                                                  imageFit: BoxFit.fill,
                                                  cuisineImageUrl:
                                                      specificPitchScreen
                                                          .images!
                                                          .files![index - 1]!
                                                          .filePath),
                                            ),
                                          ),
                                          // _decideImageview(index-1),
                                          specificPitchScreen
                                                      .images!.files!.length >
                                                  1
                                              ? Positioned(
                                                  top: 0,
                                                  right: 2,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        specificPitchScreen
                                                            .images!.files!
                                                            .removeAt(
                                                                index - 1);
                                                        List<int> imageList =
                                                            [];
                                                        for (var element
                                                            in specificPitchScreen
                                                                .images!
                                                                .files!) {
                                                          imageList.add(
                                                              element!.id!);
                                                        }
                                                        Map<String, dynamic>
                                                            detail = {
                                                          "pitchimageId":
                                                              imageList,
                                                        };
                                                        editVenue(detail);
                                                      });
                                                    },
                                                    child: CircleAvatar(
                                                      radius: height * 0.012,
                                                      backgroundImage:
                                                          const AssetImage(
                                                        "assets/images/delete_image.png",
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    );
                            }),
                          )),
                      fixedGap(height: 10.0),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      ...List.generate(
                        4,
                        (index) => ListWidgetSettings(
                            callback: index == 0
                                ? () {
                                    navigateToDocuments(SportsModel(
                                        isEdit: true,
                                        id: widget.detail["id"],
                                        venueType: venueType));
                                  }
                                : index == 1
                                    ? () {
                                        navigateToPitchDetail(
                                            specificPitchScreen);
                                      }
                                    : index == 2
                                        ? () {
                                            Map detail = {
                                              "id": specificPitchScreen.id
                                                  .toString(),
                                              "subPitchId": specificPitchScreen
                                                  .venueDetails!
                                                  .pitchType![0]!
                                                  .id
                                                  .toString(),
                                              "back": true
                                            };
                                            navigateToSlotScreen(detail);
                                          }
                                        : () {
                                            navigateToEditSession();
                                          },
                            title: title[index],
                            icon: icon[index]),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Row(
                      //     children: [
                      //       card(
                      //           image: "assets/images/document_image.png",
                      //           text: AppLocalizations.of(context)!.documents,
                      //           onTap: () {
                      //             navigateToDocuments(SportsModel(
                      //                 isEdit: true,
                      //                 id: widget.detail["id"],
                      //                 venueType: venueType));
                      //           }),
                      //       flaxibleGap(
                      //         1,
                      //       ),
                      //       card(
                      //           image: "assets/images/venue_detail_image.png",
                      //           text:
                      //               AppLocalizations.of(context)!.pitchDetails,
                      //           onTap: () {
                      //             navigateToPitchDetail(specificPitchScreen);
                      //           }),
                      //     ],
                      //   ),
                      // ),
                      // fixedGap(height: 10.0),
                      // Padding(
                      //   padding: const EdgeInsets.all(5.0),
                      //   child: Row(
                      //     children: [
                      //       card(
                      //           image: "assets/images/price_image.png",
                      //           text: AppLocalizations.of(context)!.slotPrice,
                      //           onTap: () {
                      //             Map detail = {
                      //               "id": specificPitchScreen.id.toString(),
                      //               "subPitchId": specificPitchScreen
                      //                   .venueDetails!.pitchType![0]!.id
                      //                   .toString(),
                      //               "back": true
                      //             };
                      //             navigateToSlotScreen(detail);
                      //           }),
                      //       flaxibleGap(
                      //         1,
                      //       ),
                      //       card(
                      //           image: "assets/images/session_image.png",
                      //           text: AppLocalizations.of(context)!.sessions,
                      //           onTap: () {
                      //             navigateToEditSession();
                      //           }),
                      //     ],
                      //   ),
                      // )
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
        for (var element in specificPitchScreen.images!.files!) {
          pitchImageId.add(element!.id);
        }
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

    // ignore: use_build_context_synchronously
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
        for (var element in specificPitchScreen.images!.files!) {
          pitchImageId.add(element!.id);
        }
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

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  List title = [
    AppLocalizations().documents,
    AppLocalizations().pitchDetails,
    AppLocalizations().slotPrice,
    AppLocalizations().sessions
  ];
  List icon = [
    Icons.file_copy_outlined,
    Icons.info_outline,
    Icons.monitor_heart_outlined,
    Icons.assessment_outlined
  ];

  void navigateToDocuments(SportsModel detail) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => DocumentScreen(detail: detail)));
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
