import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/createSession4.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/document_screen_both.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/slot_chart_screen5.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
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
import '../../../../../app_colors/app_colors.dart';

class EditAcademyScreen extends StatefulWidget {
  final Map detail;
  const EditAcademyScreen({super.key, required this.detail});
  @override
  State<EditAcademyScreen> createState() => _EditAcademyScreenState();
}

class _EditAcademyScreenState extends State<EditAcademyScreen> {
  bool _internet = true;
  bool _isLoading = false;
  String date = "name";

  late SpecificModelClass specificPitchScreen;
  SpecificAcademy? specificAcademy;
  String venueType = '';
  final NetworkCalls _networkCalls = NetworkCalls();
  List<File> image = <File>[];
  List academyImages = [];

  loadSpecific() async {
    print('kks');
    await _networkCalls.specificAcademy(
      id: widget.detail["id"].toString(),
      onSuccess: (event) async {
        specificAcademy = event;
        if (mounted) {
          setState(() {
            _isLoading = false;
            academyImages = specificAcademy!.academyImage!;
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
    print('reaches');
    await _networkCalls.editAcademy(
      id: widget.detail["id"].toString(),
      academyDetail: detail,
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            showMessage('Success');
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
            backgroundColor: AppColors.white,
            elevation: 2,
            shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
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
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary,
                        style: TextStyle(color: AppColors.black)),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto,
                        style: TextStyle(color: AppColors.black)),
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
      backgroundColor: AppColors.black,
      appBar: appBarWidget(
        width,
        height,
        context,
        AppLocalizations.of(context)!.editAcademy,
        true,
      ),
      body: _isLoading
          ? Container(
              height: height,
              width: width,
              padding: const EdgeInsets.all(20),
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
            )
          : _internet
              ? Container(
                  height: height,
                  width: width,
                  padding: EdgeInsets.symmetric(horizontal: width * 0.033),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      fixedGap(height: 10.0),
                      SizedBox(
                          height: 100,
                          child: ListView.builder(
                            itemCount: specificAcademy != null
                                ? specificAcademy!.academyImage!.length + 1
                                : 1,
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
                                                    AppLocalizations
                                                            .of(context)!
                                                        .addPitchImage,
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            color: const Color(
                                                                0XFFB3B3B3),
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
                                            decoration: BoxDecoration(
                                                color: AppColors.white,
                                                shape: BoxShape.circle),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                child: cachedNetworkImage(
                                                  imageFit: BoxFit.fill,
                                                  cuisineImageUrl:
                                                      specificAcademy!
                                                                  .academyImage![
                                                              index - 1] ??
                                                          '',
                                                )
                                                // specificAcademy!
                                                //     .images![index - 1]),
                                                ),
                                          ),
                                          // _decideImageview(index-1),
                                          specificAcademy!
                                                      .academyImage!.length >
                                                  1
                                              ? Positioned(
                                                  top: 0,
                                                  right: 2,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      specificAcademy!
                                                          .academyImage!
                                                          .removeAt(index - 1);
                                                      Map detail = {
                                                        "academy_image":
                                                            specificAcademy!
                                                                .academyImage
                                                      };
                                                      print("delete$detail");
                                                      editAcademy(detail);
                                                      setState(() {});
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
                                              : SizedBox.shrink(),
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
                        (index) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.025,
                              vertical: height * 0.001),
                          child: ListWidgetSettings(
                              callback: index == 0
                                  ? () {
                                      navigateToDocuments(
                                          detail: SportsModel(
                                              isEdit: true,
                                              id: widget.detail["id"],
                                              venueType: venueType),
                                          specificAcademyId: specificAcademy
                                              ?.academyId!
                                              .toInt());
                                    }
                                  : index == 1
                                      ? () {
                                          navigateToPitchDetail(
                                              specificAcademy!);
                                        }
                                      : index == 2
                                          ? () {
                                              Map detail = {
                                                "id": widget.detail["id"]
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
    File? imageIndex;
    for (int i = 0; i < picture.length; i++) {
      imageIndex = File(picture[i].path);
      image.add(imageIndex);
    }
    var detail = {"profile_image": image, "type": "bookpitch"};
    await _networkCalls.helperMultiImageDocument(
      pitchImage: imageIndex,
      onSuccess: (msg) {
        academyImages.add(msg);
        // List<dynamic> pitchImageId = msg;
        // for (var element in specificPitchScreen.images!.files!) {
        //   pitchImageId.add(element!.id);
        // }
        // Map<String, dynamic> detail = {
        //   "pitchimageId": pitchImageId,
        // };
        Map academyDetail = {
          "academydetail": {"academy_image": academyImages},
        };
        print(academyDetail);
        editAcademy(academyDetail);
        setState(() {});
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
    await _networkCalls.helperMultiImageDocument(
      pitchImage: image,
      onSuccess: (msg) {
        academyImages.add(msg);
        // List<dynamic> pitchImageId = msg;
        // for (var element in specificPitchScreen.images!.files!) {
        //   pitchImageId.add(element!.id);
        // }
        // Map<String, dynamic> detail = {
        //   "pitchimageId": pitchImageId,
        // };
        Map academyDetail = {
          "academydetail": {"academy_image": academyImages},
        };
        print(academyDetail);
        editAcademy(academyDetail);
        setState(() {});
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
    AppLocalizations().bookingDetails,
    AppLocalizations().slotPrice,
    AppLocalizations().sessions
  ];
  List icon = [
    Icons.file_copy_outlined,
    Icons.info_outline,
    Icons.monitor_heart_outlined,
    Icons.assessment_outlined
  ];

  void navigateToDocuments(
      {required SportsModel detail, int? specificAcademyId}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DocumentScreen(
                  detail: detail,
                  specificAcademyId: specificAcademyId,
                )));
  }

  void navigateToPitchDetail(SpecificAcademy detail) {
    Navigator.pushNamed(context, RouteNames.editAcademyDetail,
        arguments: detail);
  }

  void navigateToSlotScreen(Map detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SlotChartScreen(
                  academyDetail: detail,
                  backTag: true,
                )));
    // Navigator.pushNamed(context, RouteNames.slotChart, arguments: detail);
  }

  void navigateToEditSession() {
    Map detail = {
      "id": widget.detail["id"].toString(),
    };
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CreateSessionScreen(
                  academyData: detail,
                  createdTag: true,
                )));
    // Navigator.pushNamed(context, RouteNames.editSession, arguments: detail);
  }
}
