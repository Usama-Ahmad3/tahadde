import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/priceScreen3.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart' hide Marker;
import 'package:permission_handler/permission_handler.dart';

import '../../../../../constant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../../../player/HomeScreen/widgets/buttonWidget.dart';

class PitchDetailScreen extends StatefulWidget {
  final SportsModel detail;
  const PitchDetailScreen({super.key, required this.detail});
  @override
  State<PitchDetailScreen> createState() => _PitchDetailScreenState();
}

class _PitchDetailScreenState extends State<PitchDetailScreen> {
  final _nameController = TextEditingController(text: '');
  final _descriptionArabic = TextEditingController(text: "");
  final _nameControllerArabic = TextEditingController(text: '');
  final _description = TextEditingController(text: '');
  final _codeController = TextEditingController(text: '');
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String gamePlay = "";
  late String _facility;
  bool loading = false;
  bool internet = true;
  bool indoor = false;
  bool outdoor = false;
  final bool _isImageLoading = false;
  List<File> image = <File>[];
  late List<dynamic> pitch_Id;
  final NetworkCalls _networkCalls = NetworkCalls();
  final arabicFocus = FocusNode();
  final codeFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final descriptionAFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  List<int> indexList = [];
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  GestureDetector(
                    child: Text(
                      AppLocalizations.of(context)!.choosefromlibrary,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.normal),
                    ),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        // ignore: use_build_context_synchronously
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
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal)),
                                  content: Text(
                                      AppLocalizations.of(context)!
                                          .thisGalleryPicturesUploadImage,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal)),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.normal)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.normal)),
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
                    child: Text(AppLocalizations.of(context)!.takephoto,
                        style: TextStyle(
                            color: AppColors.black,
                            fontWeight: FontWeight.normal)),
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
                                  title: Text(
                                      AppLocalizations.of(context)!
                                          .cameraPermission,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal)),
                                  content: Text(
                                      AppLocalizations.of(context)!
                                          .thisPicturesUploadImage,
                                      style: TextStyle(
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal)),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.normal)),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting,
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontWeight: FontWeight.normal)),
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
  void dispose() {
    _nameController.dispose();
    _descriptionArabic.dispose();
    _description.dispose();
    _nameControllerArabic.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    var size = MediaQuery.of(context).size;
    return GestureDetector(
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
          child: Container(
            color: AppColors.black,
            child: Container(
              width: sizeWidth,
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.033),
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: sizeHeight * 0.01),
                        child: _isImageLoading
                            ? Container(
                                color: AppColors.themeColor,
                                height: sizeHeight * .2,
                                width: sizeWidth,
                                child: Lottie.asset(
                                  'assets/lottiefiles/profile.json',
                                ),
                              )
                            : SizedBox(
                                width: sizeWidth,
                                height: sizeHeight * .12,
                                child: image.isEmpty
                                    ? GridView.count(
                                        crossAxisCount: 1,
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(4, (index) {
                                          return GestureDetector(
                                            onTap: () {
                                              index == 0
                                                  ? _showChoiceDialog(context)
                                                  : null;
                                            },
                                            child: _addVenue(),
                                          );
                                        }))
                                    : GridView.count(
                                        crossAxisCount: 1,
                                        scrollDirection: Axis.horizontal,
                                        children: List.generate(
                                            image.length + 1, (index) {
                                          if (index == 0) {
                                            return GestureDetector(
                                              onTap: () {
                                                _showChoiceDialog(context);
                                              },
                                              child: _addVenue(),
                                            );
                                          } else if (image.length >= index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  _decideImageview(index - 1),
                                                  _deleteVenue(index),
                                                ],
                                              ),
                                            );
                                          }

                                          return _addVenue();
                                        })),
                              ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.academyName,
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
                          hintText: AppLocalizations.of(context)!.academyName,
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(arabicFocus);
                            return null;
                          },
                          onChanged: (value) {
                            widget.detail.pitchDetailModel =
                                PitchDetailModel(pitchName: value!);
                            return '';
                          },
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterPitchName;
                            }
                            return null;
                          },
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          enableBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          focusBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12))),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.academyNameA,
                        style: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.themeColor
                                : AppColors.white),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      TextFieldWidget(
                          controller: _nameControllerArabic,
                          hintText: AppLocalizations.of(context)!.academyNameA,
                          focus: arabicFocus,
                          onSubmitted: (value) {
                            FocusScope.of(context).requestFocus(codeFocus);
                            return null;
                          },
                          onChanged: (value) {
                            widget.detail.pitchDetailModel!.pitchNameAr = value;
                            return '';
                          },
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterPitchName;
                            }
                            return null;
                          },
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          enableBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          focusBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12))),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      // Text(
                      //   AppLocalizations.of(context)!.code,
                      //   style: TextStyle(
                      //       color: MyAppState.mode == ThemeMode.light
                      //           ? const Color(0XFF032040)
                      //           : Colors.white),
                      // ),
                      // SizedBox(
                      //   height: sizeHeight * 0.01,
                      // ),
                      // textFieldWidget(
                      //     controller: _codeController,
                      //     hintText: AppLocalizations.of(context)!.code,
                      //     focus: codeFocus,
                      //     onSubmitted: (value) {
                      //       FocusScope.of(context)
                      //           .requestFocus(descriptionFocus);
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //       widget.detail.pitchDetailModel!.code = value!;
                      //       return '';
                      //     },
                      //     border: OutlineInputBorder(
                      //         borderSide: const BorderSide(color: Colors.grey),
                      //         borderRadius: BorderRadius.circular(12)),
                      //     enableBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(color: Colors.grey),
                      //         borderRadius: BorderRadius.circular(12)),
                      //     focusBorder: OutlineInputBorder(
                      //         borderSide: const BorderSide(color: Colors.grey),
                      //         borderRadius: BorderRadius.circular(12))),
                      // SizedBox(
                      //   height: sizeHeight * 0.02,
                      // ),
                      Text(
                        AppLocalizations.of(context)!.description,
                        style: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.themeColor
                                : AppColors.white),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      textFieldWidgetMulti(
                          controller: _description,
                          hintText: '',
                          focus: descriptionFocus,
                          onSubmitted: (value) {
                            FocusScope.of(context)
                                .requestFocus(descriptionAFocus);
                            return null;
                          },
                          maxLines: 3,
                          onChanged: (value) {
                            widget.detail.pitchDetailModel!.description =
                                value!;
                            return '';
                          },
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterDescription;
                            }
                            return null;
                          },
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          enableBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          focusBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12))),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      Text(
                        AppLocalizations.of(context)!.descriptionA,
                        style: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.themeColor
                                : AppColors.white),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      textFieldWidgetMulti(
                          controller: _descriptionArabic,
                          hintText: '',
                          focus: descriptionAFocus,
                          maxLines: 3,
                          onChanged: (value) {
                            widget.detail.pitchDetailModel!.descriptionAr =
                                value!;
                            return '';
                          },
                          onValidate: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterDescription;
                            }
                            return null;
                          },
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          enableBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          focusBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.grey),
                              borderRadius: BorderRadius.circular(12))),
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Row(
                          children: <Widget>[
                            flaxibleGap(
                              3,
                            ),
                            GestureDetector(
                              child: indoor
                                  ? SizedBox(
                                      height: sizeHeight * .03,
                                      width: sizeWidth * .055,
                                      child: Container(
                                        width: sizeWidth * 0.11,
                                        height: sizeHeight * 0.04,
                                        decoration: BoxDecoration(
                                            color: AppColors.appThemeColor,
                                            borderRadius: BorderRadius.circular(
                                                sizeHeight * 0.005)),
                                        child: Icon(
                                          FontAwesomeIcons.check,
                                          color: AppColors.white,
                                        ),
                                      ))
                                  : SizedBox(
                                      height: sizeHeight * .03,
                                      width: sizeWidth * .055,
                                      child: Image.asset(
                                        "assets/images/uncheck.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  indoor = !indoor;
                                  if (indoor && outdoor) {
                                    gamePlay = "both";
                                  } else {
                                    if (indoor) {
                                      gamePlay = "indoor";
                                    } else {
                                      gamePlay = "";
                                    }
                                  }
                                });
                              },
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                              AppLocalizations.of(context)!.indoor,
                              style: indoor
                                  ? const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.appThemeColor,
                                      fontWeight: FontWeight.w600)
                                  : const TextStyle(
                                      fontSize: 12,
                                      color: Color(0XFFADADAD),
                                    ),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            GestureDetector(
                              child: outdoor
                                  ? SizedBox(
                                      height: sizeHeight * .03,
                                      width: sizeWidth * .055,
                                      child: Container(
                                        width: sizeWidth * 0.11,
                                        height: sizeHeight * 0.04,
                                        decoration: BoxDecoration(
                                            color: AppColors.appThemeColor,
                                            borderRadius: BorderRadius.circular(
                                                sizeHeight * 0.005)),
                                        child: Icon(
                                          FontAwesomeIcons.check,
                                          color: AppColors.white,
                                        ),
                                      ))
                                  : SizedBox(
                                      height: sizeHeight * .03,
                                      width: sizeWidth * .055,
                                      child: Image.asset(
                                        "assets/images/uncheck.png",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                              onTap: () {
                                setState(() {
                                  outdoor = !outdoor;
                                  if (indoor && outdoor) {
                                    gamePlay = "both";
                                  } else {
                                    if (outdoor) {
                                      gamePlay = "outdoor";
                                    } else {
                                      gamePlay = "";
                                    }
                                  }
                                });
                              },
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                              AppLocalizations.of(context)!.outdoor,
                              style: outdoor
                                  ? const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.appThemeColor,
                                      fontWeight: FontWeight.w600)
                                  : const TextStyle(
                                      fontSize: 12,
                                      color: Color(0XFFADADAD),
                                    ),
                            ),
                            flaxibleGap(
                              3,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!.chooseFacilitiesProvided,
                        style: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.themeColor
                                : AppColors.white),
                      ),
                      SizedBox(
                        height: sizeHeight * 0.01,
                      ),
                      SizedBox(
                        height: sizeHeight * .13,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: facility.length,
                            itemBuilder: (BuildContext context, int blockIdx) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (indexList.contains(blockIdx)) {
                                        indexList.remove(blockIdx);
                                      } else {
                                        indexList.add(blockIdx);
                                      }
                                    });
                                  },
                                  child: indexList.contains(blockIdx)
                                      ? Container(
                                          width: sizeWidth * .28,
                                          height: sizeWidth * .07,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0XFFA3A3A3)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: AppColors.appThemeColor
                                                .withOpacity(0.7),
                                          ),
                                          child: Column(
                                            children: [
                                              flaxibleGap(
                                                2,
                                              ),
                                              Image.asset(
                                                facilityImageS[blockIdx],
                                                width: sizeWidth * .1,
                                                height: sizeWidth * .1,
                                                fit: BoxFit.fill,
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      "en"
                                                  ? Text(facility[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none))
                                                  : Text(facilityAr[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                              flaxibleGap(
                                                1,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: sizeWidth * .28,
                                          height: sizeWidth * .07,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0XFFA3A3A3)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              flaxibleGap(
                                                2,
                                              ),
                                              Image.asset(
                                                facilityImage[blockIdx],
                                                width: sizeWidth * .1,
                                                height: sizeWidth * .1,
                                                fit: BoxFit.fill,
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      "en"
                                                  ? Text(facility[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none))
                                                  : Text(facilityAr[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
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
                      SizedBox(
                        height: sizeHeight * 0.02,
                      ),
                      image.isNotEmpty && indexList.isNotEmpty
                          ? ButtonWidget(
                              title:
                                  Text(AppLocalizations.of(context)!.continu),
                              isLoading: loading,
                              onTaped: () async {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
                                  _facility = "";
                                  widget.detail.pitchDetailModel!.code =
                                      Random().nextInt(100).toString();
                                  for (int i = 0; i < indexList.length; i++) {
                                    _facility = "$_facility${facilitySlug[i]},";
                                  }
                                  _facility = _facility.substring(
                                      0, _facility.length - 1);
                                  _facility = _facility.substring(0);
                                  widget.detail.pitchDetailModel!.facility =
                                      _facility;
                                  widget.detail.pitchDetailModel!.gamePlay =
                                      gamePlay;
                                  setState(() {
                                    loading = true;
                                  });
                                  var detail = {
                                    "profile_image": image,
                                    "type": "bookpitch"
                                  };
                                  await _networkCalls.helperMultiImage(
                                    pitchImage: detail,
                                    onSuccess: (msg) {
                                      widget.detail.pitchDetailModel!
                                          .pitchImageId = msg;
                                      setState(() {
                                        loading = false;
                                      });

                                      navigateToPriceScreen(widget.detail);
                                      // print(widget
                                      //     .detail.documentModel!.expiryDate);
                                      // print(widget.detail.documentModel!.lat);
                                    },
                                    onFailure: (msg) {
                                      showMessage(msg);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    tokenExpire: () {
                                      if (mounted) on401(context);
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                  );
                                }
                              },
                            )
                          : ButtonWidget(
                              color: const Color(0XFFBCBCBC),
                              title:
                                  Text(AppLocalizations.of(context)!.continu),
                              isLoading: loading,
                              onTaped: () {},
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

  void navigateToPriceScreen(SportsModel detail) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => PriceScreenView(detail: detail)));
    // Navigator.pushNamed(context, RouteNames.priceScreen, arguments: detail);
  }

  _openGallery(BuildContext context) async {
    Navigator.of(context).pop();
    var picture = await ImagePicker().pickMultiImage();
    setState(() {
      for (int i = 0; i < picture.length; i++) {
        File imageIndex = File(picture[i].path);
        image.add(imageIndex);
      }
    });
  }

  _openCamera(BuildContext context) async {
    Navigator.of(context).pop();
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      image.add(File(picture!.path));
    });
  }

  Widget _decideImageview(int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        image[index],
        fit: BoxFit.cover,
      ),
    );
  }

  _addVenue() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
            color: const Color(0XFFD4D4D4),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            flaxibleGap(
              1,
            ),
            Image.asset(
              "assets/images/add_vanue.png",
              height: 25,
            ),
            flaxibleGap(
              1,
            ),
            Text(AppLocalizations.of(context)!.addPitchImage,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: MyAppState.mode == ThemeMode.light
                        ? const Color(0XFFB3B3B3)
                        : Colors.black38,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins")),
            flaxibleGap(
              1,
            ),
          ],
        ),
      ),
    );
  }

  _deleteVenue(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          image.removeAt(index - 1);
        });
      },
      child: Align(
          alignment: Alignment.topRight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              "assets/images/delete_image.png",
              height: 25,
            ),
          )),
    );
  }

  void onError(response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
}
