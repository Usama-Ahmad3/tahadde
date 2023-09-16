import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import '../../loginSignupPitchOwner/select_sport.dart';

class EditPitchDetail extends StatefulWidget {
  final detail;
  EditPitchDetail({this.detail});
  @override
  _EditPitchDetailState createState() => _EditPitchDetailState();
}

class _EditPitchDetailState extends State<EditPitchDetail> {
  final _nameController = TextEditingController(text: '');
  final _descriptionArabic = TextEditingController(text: "");
  final _nameControllerArabic = TextEditingController(text: '');
  final _description = TextEditingController(text: '');
  final _codeControllerArabic = TextEditingController(text: '');
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String gamePlay = "";
  bool loading = false;
  bool internet = true;
  bool indoor = false;
  bool outdoor = false;

  final NetworkCalls _networkCalls = NetworkCalls();
  final focuss = FocusNode();
  final focusss = FocusNode();
  final codeFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  late PitchDetailModel detailSportsModel;
  List<String> indexList = [];
  editVenue(Map detail) async {
    await _networkCalls.editVenue(
      id: widget.detail["id"].toString(),
      venueDetail: detail,
      venueType: widget.detail["venueType"],
      onSuccess: (event) {
        if (mounted) {
          Map detail = {
            "id": widget.detail["id"],
            "name": _nameController.text
          };
          navigateToEditVenues(detail);
        }
      },
      onFailure: (msg) {
        if (mounted)
          // ignore: curly_braces_in_flow_control_structures
          showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameController.text = widget.detail["detail"].venueDetails.nameEnglish;
    _nameControllerArabic.text =
        widget.detail["detail"].venueDetails.nameArabic;
    _description.text = widget.detail["detail"].venueDetails.descriptionEnglish;
    _descriptionArabic.text =
        widget.detail["detail"].venueDetails.descriptionArabic;
    _codeControllerArabic.text = widget.detail["detail"].code;
    gamePlay = widget.detail["detail"].venueDetails.gamePlay.slug;
    if (gamePlay == "both") {
      indoor = true;
      outdoor = true;
    } else if (gamePlay == "indoor") {
      indoor = true;
    } else {
      outdoor = true;
    }
    widget.detail["detail"].venueDetails.facility
        .forEach((element) => indexList.add(element.slug));
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: appBar(
            title: AppLocalizations.of(context)!.pitchDetails,
            language: AppLocalizations.of(context)!.locale,
            onTap: () {
              Navigator.of(context).pop();
            }),
        bottomNavigationBar: indexList.isNotEmpty
            ? Material(
                color: const Color(0XFF25A163),
                child: InkWell(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      String _facility = "";
                      for (int i = 0; i < indexList.length; i++) {
                        print(indexList);
                        _facility = "$_facility${indexList[i]},";
                      }
                      _facility = _facility.substring(0, _facility.length - 1);
                      _facility = _facility.substring(0);
                      detailSportsModel.facility = _facility;
                      String gamePlayApi;
                      if (indoor && outdoor) {
                        gamePlayApi = "both";
                      } else if (indoor) {
                        gamePlayApi = "indoor";
                      } else {
                        gamePlayApi = "outdoor";
                      }
                      detailSportsModel.gamePlay = gamePlayApi;
                      Map detailApi = {
                        "nameEnglish": detailSportsModel.pitchName,
                        "nameArabic": detailSportsModel.pitchNameAr,
                        "descriptionArabic": detailSportsModel.descriptionAr,
                        "location":
                            widget.detail["detail"].venueDetails.location,
                        "descriptionEnglish": detailSportsModel.description,
                        "code": detailSportsModel.code,
                        "gameplay_slug": detailSportsModel.gamePlay,
                        "facilities_slug_list": detailSportsModel.facility,
                      };
                      editVenue(detailApi);
                    }
                  },
                  splashColor: Colors.black,
                  child: Container(
                      height: sizeHeight * .104,
                      alignment: Alignment.center,
                      child: loading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.continueW,
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
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
          child: Container(
            width: sizeWidth,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFF25A163),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                      flaxibleGap(
                        1,
                      ),
                      Container(
                        height: sizeHeight * .005,
                        width: sizeWidth * .19,
                        color: const Color(0XFFCBCBCB),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: textField(
                        name: "Venue Name",
                        controller: _nameController,
                        // onchange: (value) {
                        //   trans(value, "ar", _nameControllerArabic);
                        // },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .pleaseenterPitchName;
                          }
                          return '';
                        },
                        text: false,
                        text1: false,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(focusss),
                        onSaved: (value) => detailSportsModel =
                            PitchDetailModel(pitchName: value)),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40, left: 40, top: 10),
                    child: textField(
                        name: "Venue Name ( Arabic )",
                        controller: _nameControllerArabic,
                        text: false,
                        text1: false,
                        node: focusss,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(codeFocus),
                        onSaved: (value) =>
                            detailSportsModel.pitchNameAr = value),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(right: 40, left: 40, top: 10),
                    child: textField(
                        name: "Code",
                        controller: _codeControllerArabic,
                        text: false,
                        text1: false,
                        node: codeFocus,
                        submit: (value) =>
                            FocusScope.of(context).requestFocus(focuss),
                        onSaved: (value) => detailSportsModel.code = value),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 40, top: 20, right: 40, bottom: 10),
                    child: Container(
                      alignment: AppLocalizations.of(context)!.locale == "en"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: const Text(
                        "Description",
                        style: TextStyle(
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
                          border: Border.all(color: const Color(0XFFA3A3A3))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          controller: _description,
                          // onChanged: (value) {
                          //   trans(value, "ar", _descriptionArabic);
                          // },
                          focusNode: focuss,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .pleaseenterDescription;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            detailSportsModel.description = value;
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
                      alignment: AppLocalizations.of(context)!.locale == "en"
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: const Text(
                        "Description ( Arabic )",
                        style: TextStyle(
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
                          border: Border.all(color: const Color(0XFFA3A3A3))),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                          controller: _descriptionArabic,
                          onSaved: (value) {
                            detailSportsModel.descriptionAr = value;
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
                        flaxibleGap(
                          3,
                        ),
                        GestureDetector(
                          child: indoor
                              ? Container(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/Rectangle.png",
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/uncheck.png",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                          onTap: () {
                            setState(() {
                              FocusScope.of(context).requestFocus(FocusNode());
                              indoor = !indoor;
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
                                  color: appThemeColor,
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
                              ? Container(
                                  height: sizeHeight * .03,
                                  width: sizeWidth * .055,
                                  child: Image.asset(
                                    "assets/images/Rectangle.png",
                                    fit: BoxFit.fill,
                                  ),
                                )
                              : Container(
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
                                  color: appThemeColor,
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
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context)!.chooseFacilitiesProvided,
                        style: const TextStyle(
                          decoration: TextDecoration.none,
                          // color: Color(0XFF25A163),
                          color: Color(0XFFADADAD),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 10),
                    child: Container(
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
                                    if (indexList
                                        .contains(facilitySlug[blockIdx])) {
                                      indexList.remove(facilitySlug[blockIdx]);
                                    } else {
                                      indexList.add(facilitySlug[blockIdx]);
                                    }
                                  });
                                },
                                child: indexList
                                        .contains(facilitySlug[blockIdx])
                                    ? Container(
                                        width: sizeWidth * .28,
                                        height: sizeWidth * .07,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFA3A3A3)),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: const Color(0XFF25A163)
                                              .withOpacity(.3),
                                        ),
                                        child: Column(
                                          children: <Widget>[
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
                                          children: <Widget>[
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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
