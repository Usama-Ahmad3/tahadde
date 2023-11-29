import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../../constant.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../player/HomeScreen/widgets/buttonWidget.dart';
import '../../../../player/HomeScreen/widgets/textFormField.dart';

class EditAcademyDetailScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var detail;
  EditAcademyDetailScreen({super.key, required this.detail});
  @override
  State<EditAcademyDetailScreen> createState() =>
      _EditAcademyDetailScreenState();
}

class _EditAcademyDetailScreenState extends State<EditAcademyDetailScreen> {
  final _nameController = TextEditingController(text: '');
  final _descriptionArabic = TextEditingController(text: "");
  final _nameControllerArabic = TextEditingController(text: '');
  final _description = TextEditingController(text: '');
  final _codeControllerArabic = TextEditingController(text: '');
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String gamePlay = "";
  bool loading = false;
  List facilitySlugD = [];
  bool internet = true;
  bool indoor = false;
  bool outdoor = false;

  final NetworkCalls _networkCalls = NetworkCalls();
  final arabicFocus = FocusNode();
  final descriptionFocus = FocusNode();
  final descriptionAFocus = FocusNode();
  final codeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  PitchDetailModel? detailSportsModel;
  List<String> indexList = [];
  // editVenue(Map detail) async {
  //   await _networkCalls.editVenue(
  //     id: widget.detail["id"].toString(),
  //     venueDetail: detail,
  //     venueType: widget.detail["venueType"],
  //     onSuccess: (event) {
  //       if (mounted) {
  //         Map detail = {
  //           "id": widget.detail["id"],
  //           "name": _nameController.text
  //         };
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => EditVenuesScreen(detail: detail),
  //             ));
  //         // navigateToEditVenues(detail);
  //       }
  //     },
  //     onFailure: (msg) {
  //       if (mounted)
  //         // ignore: curly_braces_in_flow_control_structures
  //         showMessage(msg);
  //     },
  //     tokenExpire: () {
  //       if (mounted) on401(context);
  //     },
  //   );
  // }
  editAcademy(Map detail) async {
    await _networkCalls.editAcademy(
      id: widget.detail.academyId.toString(),
      academyDetail: detail,
      onSuccess: (event) {
        if (mounted) {
          showMessage('success');
        }
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.detail.academyNameEnglish.toString();
    _nameControllerArabic.text = widget.detail.academyNameArabic.toString();
    _description.text = widget.detail.descriptionEnglish.toString();
    _descriptionArabic.text = widget.detail.descriptionArabic.toString();
    gamePlay = widget.detail.gameplaySlug.toString();
    if (gamePlay == "both") {
      indoor = true;
      outdoor = true;
    } else if (gamePlay == "indoor") {
      indoor = true;
    } else {
      outdoor = true;
    }
    List facilitySlugD =
        widget.detail.facilitySlug!.split(',').map((e) => e.trim()).toList();
    facilitySlugD.forEach((element) => indexList.add(element));
    print(facility);
    print(facilitySlugD);
    // widget.detail["detail"].venueDetails.facility
    //     .forEach((element) => indexList.add(element.slug));
  }

  @override
  void dispose() {
    _nameControllerArabic.dispose();
    _nameController.dispose();
    _description.dispose();
    _descriptionArabic.dispose();
    _codeControllerArabic.dispose();
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
              AppLocalizations.of(context)!.academyDetail,
              true,
              AppColors.appThemeColor,
              AppColors.appThemeColor,
              const Color(0XFFCBCBCB),
              const Color(0XFFCBCBCB)),
          body: Container(
            color: Colors.black,
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
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: sizeWidth * 0.025),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: sizeHeight * 0.02,
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
                            onChanged: (value) {
                              detailSportsModel =
                                  PitchDetailModel(pitchName: value);
                              return '';
                            },
                            onValidate: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenterPitchName;
                              }
                              return null;
                            },
                            onSubmitted: (value) {
                              FocusScope.of(context).requestFocus(arabicFocus);
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
                            hintText: AppLocalizations.of(context)!.venueNameA,
                            focus: arabicFocus,
                            onSubmitted: (value) {
                              FocusScope.of(context).requestFocus(codeFocus);
                              return null;
                            },
                            onChanged: (value) {
                              detailSportsModel!.pitchNameAr = value;
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
                              detailSportsModel?.description = value ?? '';
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
                              detailSportsModel!.descriptionAr = value;
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
                            children: [
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: AppColors.appThemeColor,
                                            fontWeight: FontWeight.w600)
                                    : Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: const Color(0XFFADADAD),
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
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: AppColors.appThemeColor,
                                            fontWeight: FontWeight.w600)
                                    : Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                          color: const Color(0XFFADADAD),
                                        ),
                              ),
                              flaxibleGap(
                                3,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!
                              .chooseFacilitiesProvided,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
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
                              itemBuilder:
                                  (BuildContext context, int blockIdx) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (indexList
                                            .contains(facility[blockIdx])) {
                                          indexList.remove(facility[blockIdx]);
                                        } else {
                                          indexList.add(facility[blockIdx]);
                                        }
                                      });
                                    },
                                    child: indexList
                                            .contains(facility[blockIdx])
                                        ? Container(
                                            width: sizeWidth * .28,
                                            height: sizeWidth * .07,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0XFFA3A3A3)),
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
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? null
                                                      : AppColors.white,
                                                  width: sizeWidth * .1,
                                                  height: sizeWidth * .1,
                                                  fit: BoxFit.fill,
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                AppLocalizations.of(context)!.locale == "en"
                                                    ? Text(facility[blockIdx],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: MyAppState.mode == ThemeMode.light
                                                                    ? const Color(
                                                                        0XFF424242)
                                                                    : AppColors
                                                                        .white,
                                                                decoration:
                                                                    TextDecoration
                                                                        .none))
                                                    : Text(facilityAr[blockIdx],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: MyAppState.mode ==
                                                                        ThemeMode.light
                                                                    ? const Color(0XFF424242)
                                                                    : AppColors.white,
                                                                decoration: TextDecoration.none)),
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
                                                  color:
                                                      const Color(0XFFA3A3A3)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.white,
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
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: const Color(
                                                                    0XFF424242),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none))
                                                    : Text(facilityAr[blockIdx],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: const Color(
                                                                    0XFF424242),
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
                        indexList.isNotEmpty
                            ? ButtonWidget(
                                onTaped: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    String facility = "";
                                    for (int i = 0; i < indexList.length; i++) {
                                      print(indexList);
                                      facility = "$facility${indexList[i]},";
                                    }
                                    facility = facility.substring(
                                        0, facility.length - 1);
                                    facility = facility.substring(0);
                                    detailSportsModel?.facility = facility;
                                    String gamePlayApi;
                                    if (indoor && outdoor) {
                                      gamePlayApi = "both";
                                    } else if (indoor) {
                                      gamePlayApi = "indoor";
                                    } else {
                                      gamePlayApi = "outdoor";
                                    }
                                    Map academyDetail = {
                                      "academydetail": {
                                        "Academy_NameEnglish":
                                            _nameController.text,
                                        "Academy_NameArabic":
                                            _nameControllerArabic.text,
                                        "descriptionEnglish": _description.text,
                                        "descriptionArabic":
                                            _descriptionArabic.text,
                                        "facilitySlug": facility,
                                        "gameplaySlug": gamePlayApi,
                                      },
                                    };
                                    // showMessage("Can't do it right now!");
                                    editAcademy(academyDetail);
                                    Navigator.pop(context);
                                    // print(academyDetail);
                                    // detailSportsModel?.gamePlay = gamePlayApi;
                                    // Map detailApi = {
                                    //   "nameEnglish":
                                    //       detailSportsModel?.pitchName,
                                    //   "nameArabic":
                                    //       detailSportsModel?.pitchNameAr,
                                    //   "descriptionArabic":
                                    //       detailSportsModel?.descriptionAr,
                                    //   "location": widget.detail["detail"]
                                    //       .venueDetails.location,
                                    //   "descriptionEnglish":
                                    //       detailSportsModel?.description,
                                    //   "code": detailSportsModel?.code,
                                    //   "gameplay_slug":
                                    //       detailSportsModel?.gamePlay,
                                    //   "facilities_slug_list":
                                    //       detailSportsModel?.facility,
                                    // };
                                    // print(detailApi);
                                    // editVenue(detailApi);
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
                                title: Text(
                                    AppLocalizations.of(context)!.continu,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                                isLoading: loading,
                                onTaped: () {},
                              ),
                        SizedBox(
                          height: sizeHeight * 0.01,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  void navigateToEditVenues(Map detail) {
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, RouteNames.editVenues,
        arguments: detail);
  }

  void onError(response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }
}
