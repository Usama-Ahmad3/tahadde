import 'dart:io';
import 'dart:ui';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/teamModelClass.dart';
import '../../network/network_calls.dart';
import '../loginSignup/signup.dart';

class EnterDetail extends StatefulWidget {
  dynamic leagueData;
  EnterDetail({super.key, this.leagueData});
  @override
  _EnterDetail createState() => _EnterDetail();
}

class _EnterDetail extends State<EnterDetail> {
  late bool _internet;
  late File image;
  var logoId;
  late String subRole;
  final GlobalKey _textKey = GlobalKey();
  final focus = FocusNode();
  final focuss = FocusNode();
  bool monVal = false;
  late String email;
  String contryCode = "+971";
  final _emailController = TextEditingController(text: '');
  final _numberController = TextEditingController(text: '');
  final _teamController = TextEditingController();
  late String number;
  late TeamModelClass teamInfoData;
  bool _isLoading = true;
  final _formKey = GlobalKey<FormState>();
  bool addTeam = false;
  bool addTeamExternal = false;
  bool addTeamInternal = false;
  late int teamIdInternal;
  String teamName = "";
  late String teamNameExternal;
  late int teamIdExternal;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late Map profileDetail;
  final NetworkCalls _networkCalls = NetworkCalls();

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

  privacyPolicy(String text) async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  teamInfo() {
    _networkCalls.teamInfo(
      teamType: "?team_type=internal",
      onSuccess: (msg) {
        setState(() {
          _isLoading = false;
          addTeam = true;
          addTeamInternal = true;
          teamInfoData = msg;
        });
      },
      onFailure: (msg) {
        showMessage(msg);
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
            title: Text(AppLocalizations.of(context)!.chooseteamlogo),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto),
                    onTap: () {
                      _openCamera(context);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  loadProfile() async {
    _networkCalls.role(onSuccess: (msg) {
      setState(() {
        subRole = msg["sub-role"];
        _networkCalls.getProfile(
          onSuccess: (msg) {
            setState(() {
              profileDetail = msg;
              _numberController.text = msg['contact_number'] ?? '';
              _emailController.text = msg['email'] ?? '';
              _isLoading = false;
            });
          },
          onFailure: (msg) {},
          tokenExpire: () {
            if (mounted) on401(context);
          },
        );
      });
    }, onFailure: (msg) {
      _networkCalls.getProfile(
        onSuccess: (msg) {
          setState(() {
            profileDetail = msg;
            _numberController.text = msg['contact_number'] ?? '';
            _emailController.text = msg['email'] ?? '';
            _isLoading = false;
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      focus.addListener(() {
        bool hasFocus = focus.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return Material(
        child: _isLoading
            ? Scaffold(
                key: scaffoldkey,
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
                    AppLocalizations.of(context)!.enterYourDetails,
                    style: TextStyle(
                        fontSize: appHeaderFont,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                body: Container(
                  height: sizeheight,
                  width: sizewidth,
                  color: const Color(0XFFF0F0F0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: sizeheight * .7,
                        width: sizewidth,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: sizewidth * .05, right: sizewidth * .05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              flaxibleGap(
                                4,
                              ),
                              Container(
                                height: sizeheight * .15,
                                color: const Color(0XFFFFFFFF),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        3,
                                      ),
                                      Text(
                                        widget.leagueData["detail"].name ?? '',
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                          widget.leagueData["detail"].pitchType
                                              .name,
                                          style: const TextStyle(
                                              color: Color(0XFF25A163))),
                                      flaxibleGap(
                                        2,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                              widget.leagueData["country"] ??
                                                  "",
                                              style: const TextStyle(
                                                  color: Color(0XFF424242))),
                                          Text(
                                              '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.grandTotal.round()}',
                                              style: const TextStyle(
                                                  color: Color(0XFF898989)))
                                        ],
                                      ),
                                      flaxibleGap(
                                        5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                4,
                              ),
                              Container(
                                color: Colors.white,
                                height: sizeheight * .2,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      flaxibleGap(
                                        1,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .chooseYourTeam,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Color(0XFF424242),
                                            fontWeight: FontWeight.w600),
                                      ),
                                      flaxibleGap(
                                        2,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: sizeheight * .11,
                                          width: sizewidth,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                7,
                              ),
                              Container(
                                height: sizeheight * .16,
                                color: const Color(0XFFFFFFFF),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        4,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .paymentSummary,
                                        style:
                                            const TextStyle(color: Color(0XFF424242)),
                                      ),
                                      flaxibleGap(
                                        2,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!
                                                .subTotal,
                                            style: const TextStyle(
                                                color: Color(0XFF7A7A7A)),
                                          ),
                                          flaxibleGap(
                                            18,
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.subTotal.round()}',
                                            style: const TextStyle(
                                                color: Color(0XFF7A7A7A)),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!.tex,
                                            style: const TextStyle(
                                                color: Color(0XFF7A7A7A)),
                                          ),
                                          Flexible(
                                            flex: 18,
                                            child: Container(),
                                          ),
                                          widget.leagueData["detail"]
                                                      .paymentSummary.tax !=
                                                  null
                                              ? Text(
                                                  "${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.tax.round()}",
                                                  style: const TextStyle(
                                                      color: Color(0XFF7A7A7A)),
                                                )
                                              : Text(
                                                  "${AppLocalizations.of(context)!.currency} 00",
                                                  style: const TextStyle(
                                                      color: Color(0XFF7A7A7A)),
                                                ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: 1,
                                        color: const Color(0XFFD6D6D6),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!
                                                .grandTotal,
                                            style: const TextStyle(
                                                color: Color(0XFF424242),
                                                fontWeight: FontWeight.bold),
                                          ),
                                          flaxibleGap(
                                            18,
                                          ),
                                          Text(
                                            '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.grandTotal.round()} ',
                                            style: const TextStyle(
                                                color: Color(0XFF424242)),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                      flaxibleGap(
                                        3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Checkbox(
                                    value: monVal,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        monVal = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: sizewidth * .76,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .iAgree,
                                            style: const TextStyle(
                                                color: Color(0XFFADADAD),
                                                fontSize: 15),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${AppLocalizations.of(context)!.term} ",
                                            style: const TextStyle(
                                              color: Color(0XFF25A163),
                                              fontSize: 15,
                                              // decoration: TextDecoration.underline
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .ofCompany,
                                            style: const TextStyle(
                                                color: Color(0XFFADADAD),
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              flaxibleGap(1),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Cancellations made within 24 hours will not receive a refund.",
                                  style: TextStyle(
                                      color: Color(0XFFADADAD), fontSize: 11),
                                ),
                              ),
                              flaxibleGap(3)
                            ],
                          ),
                        ),
                      ),
                      flaxibleGap(
                        1,
                      ),
                    ],
                  ),
                ),
              )
            : _internet
                ? Scaffold(
                    key: scaffoldkey,
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
                        AppLocalizations.of(context)!.enterYourDetails,
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
                      backgroundColor: const Color(0XFF032040),
                    ),
                    body: Stack(
                      children: [
                        Container(
                          height: sizeheight,
                          width: sizewidth,
                          color: const Color(0XFFF0F0F0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: sizeheight * .7,
                                width: sizewidth,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        4,
                                      ),
                                      Container(
                                        height: sizeheight * .15,
                                        color: const Color(0XFFFFFFFF),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: sizewidth * .05,
                                              right: sizewidth * .05),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                flex: 3,
                                                child: Container(),
                                              ),
                                              Text(
                                                widget.leagueData["detail"]
                                                        .name ??
                                                    '',
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                  widget.leagueData["detail"]
                                                      .pitchType.name,
                                                  style: const TextStyle(
                                                      color:
                                                          Color(0XFF25A163))),
                                              Flexible(
                                                flex: 2,
                                                child: Container(),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      widget.leagueData[
                                                              "country"] ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0XFF424242))),
                                                  Text(
                                                      '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.grandTotal.round()}',
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0XFF898989)))
                                                ],
                                              ),
                                              flaxibleGap(
                                                5,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        4,
                                      ),
                                      teamIdInternal == null &&
                                              teamIdExternal == null
                                          ? Container(
                                              color: Colors.white,
                                              height: sizeheight * .2,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        sizewidth * .05),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    flaxibleGap(
                                                      1,
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .chooseYourTeam,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color:
                                                              Color(0XFF424242),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    flaxibleGap(
                                                      2,
                                                    ),
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            if (subRole ==
                                                                "member") {
                                                              showMessage(
                                                                  "Only the captain can sign up the team");
                                                            } else {
                                                              _networkCalls
                                                                  .checkInternetConnectivity(
                                                                      onSuccess:
                                                                          (msg) {
                                                                if (msg) {
                                                                  if (mounted) {
                                                                    setState(
                                                                        () {
                                                                      _isLoading =
                                                                          true;
                                                                      teamInfo();
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (mounted) {
                                                                    showMessage(
                                                                        AppLocalizations.of(context)!
                                                                            .noInternetConnection);
                                                                  }
                                                                }
                                                              });
                                                            }
                                                          },
                                                          child: Container(
                                                            height: sizeheight *
                                                                .11,
                                                            width:
                                                                sizewidth * .35,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: const Color(
                                                                      0XFF25A163)
                                                                  .withOpacity(
                                                                      .2),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .withTahaddi,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Color(
                                                                      0XFF424242)),
                                                            ),
                                                          ),
                                                        ),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              addTeam = true;
                                                              addTeamExternal =
                                                                  true;
                                                            });
                                                          },
                                                          child: Container(
                                                            alignment: Alignment
                                                                .center,
                                                            height: sizeheight *
                                                                .11,
                                                            width:
                                                                sizewidth * .35,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              color: const Color(
                                                                      0XFF25A163)
                                                                  .withOpacity(
                                                                      .2),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .withoutTahaddi,
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF424242),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    flaxibleGap(
                                                      3,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : teamIdInternal != null
                                              ? Container(
                                                  color: const Color(0XFF032040),
                                                  height: sizeheight * .15,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeheight *
                                                                    .02),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .enteringwithtahadditeam,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              sizeheight * .1,
                                                          width: sizewidth,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                  height:
                                                                      sizeheight *
                                                                          .08,
                                                                  width:
                                                                      sizeheight *
                                                                          .08,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0XFF4F5C6A),
                                                                    // image: Image.network(profileDetail.profile_pic),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            100.0),
                                                                    child: teamInfoData.captain!.profile_pic !=
                                                                            null
                                                                        ? Image
                                                                            .network(
                                                                            teamInfoData.captain!.profile_pic!.filePath.toString(),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            "images/profile.png",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  )),
                                                              flaxibleGap(
                                                                3,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  flaxibleGap(
                                                                    4,
                                                                  ),
                                                                  Text(
                                                                    "${teamInfoData.captain!.first_name} ${teamInfoData.captain!.last_name}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                  Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .captain,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            10,
                                                                        color: Color(
                                                                            0XFF25A163)),
                                                                  ),
                                                                  flaxibleGap(
                                                                    1,
                                                                  ),
                                                                  Text(
                                                                    teamInfoData
                                                                        .teamName.toString(),
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  flaxibleGap(
                                                                    3,
                                                                  ),
                                                                ],
                                                              ),
                                                              flaxibleGap(
                                                                4,
                                                              ),
                                                              Container(
                                                                  height:
                                                                      sizeheight *
                                                                          .08,
                                                                  width:
                                                                      sizeheight *
                                                                          .08,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Color(
                                                                        0XFF4F5C6A),
                                                                    // image: Image.network(profileDetail.profile_pic),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        const BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    child: teamInfoData.teamLogo!.filePath !=
                                                                            null
                                                                        ? Image
                                                                            .network(
                                                                            teamInfoData.teamLogo!.filePath!.toString(),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )
                                                                        : Image
                                                                            .asset(
                                                                            "images/profile.png",
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  color: Colors.white,
                                                  height: sizeheight * .2,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        color:
                                                            const Color(0XFF032040),
                                                        height:
                                                            sizeheight * .15,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      sizeheight *
                                                                          .02),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .enteringwithtahadditeam,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    sizeheight *
                                                                        .1,
                                                                width:
                                                                    sizewidth,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        height: sizeheight *
                                                                            .08,
                                                                        width: sizeheight *
                                                                            .08,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Color(0XFF4F5C6A),
                                                                          // image: Image.network(profileDetail.profile_pic),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100.0),
                                                                          child: teamInfoData.captain!.profile_pic != null
                                                                              ? Image.network(
                                                                                  teamInfoData.captain!.profile_pic!.filePath.toString(),
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/profile.png",
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        )),
                                                                    Flexible(
                                                                      flex: 3,
                                                                      child:
                                                                          Container(),
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        flaxibleGap(
                                                                          4,
                                                                        ),
                                                                        Text(
                                                                          "${teamInfoData.captain!.first_name} ${teamInfoData.captain!.last_name}",
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .captain,
                                                                          style: const TextStyle(
                                                                              fontSize: 10,
                                                                              color: Color(0XFF25A163)),
                                                                        ),
                                                                        flaxibleGap(
                                                                          1,
                                                                        ),
                                                                        Text(
                                                                          teamInfoData
                                                                              .teamName.toString(),
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        flaxibleGap(
                                                                          3,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    flaxibleGap(
                                                                      4,
                                                                    ),
                                                                    Container(
                                                                        height: sizeheight *
                                                                            .08,
                                                                        width: sizeheight *
                                                                            .08,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Color(0XFF4F5C6A),
                                                                          // image: Image.network(profileDetail.profile_pic),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(10)),
                                                                          child: teamInfoData.teamLogo!.filePath != null
                                                                              ? Image.network(
                                                                                  teamInfoData.teamLogo!.filePath.toString(),
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/profile.png",
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizewidth *
                                                                        .05),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                                "${AppLocalizations.of(context)!.team} : "),
                                                            Text(
                                                              teamNameExternal,
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF032040)),
                                                            ),
                                                            flaxibleGap(
                                                              1,
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  addTeam =
                                                                      true;
                                                                  addTeamExternal =
                                                                      true;
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.edit,
                                                                color: Color(
                                                                    0XFF9B9B9B),
                                                                size: 20,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                      flaxibleGap(
                                        7,
                                      ),
                                      Container(
                                        height: sizeheight * .16,
                                        color: const Color(0XFFFFFFFF),
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: sizewidth * .05,
                                              right: sizewidth * .05),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              flaxibleGap(
                                                4,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .paymentSummary,
                                                style: const TextStyle(
                                                    color: Color(0XFF424242)),
                                              ),
                                              flaxibleGap(
                                                2,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)!
                                                        .subTotal,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF7A7A7A)),
                                                  ),
                                                  flaxibleGap(
                                                    18,
                                                  ),
                                                  Text(
                                                    '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.subTotal.round()}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF7A7A7A)),
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)!
                                                        .tex,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF7A7A7A)),
                                                  ),
                                                  flaxibleGap(
                                                    18,
                                                  ),
                                                  widget
                                                              .leagueData[
                                                                  "detail"]
                                                              .paymentSummary
                                                              .tax !=
                                                          null
                                                      ? Text(
                                                          "${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.tax.round()}",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF7A7A7A)),
                                                        )
                                                      : Text(
                                                          "${AppLocalizations.of(context)!.currency} 00",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF7A7A7A)),
                                                        ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              Container(
                                                height: 1,
                                                color: const Color(0XFFD6D6D6),
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    AppLocalizations.of(context)!
                                                        .grandTotal,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF424242),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  flaxibleGap(
                                                    18,
                                                  ),
                                                  Text(
                                                    '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.grandTotal.round()} ',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF424242)),
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                              flaxibleGap(
                                                3,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        3,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Checkbox(
                                            value: monVal,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                monVal = value!;
                                              });
                                            },
                                          ),
                                          SizedBox(
                                            width: sizewidth * .76,
                                            child: RichText(
                                              key: _textKey,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .iAgree,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFFADADAD),
                                                        fontSize: 15),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        " ${AppLocalizations.of(context)!.term} ",
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            privacyPolicy(
                                                                "terms_and_conditions_url");
                                                          },
                                                    style: const TextStyle(
                                                      color: Color(0XFF25A163),
                                                      fontSize: 15,
                                                      // decoration: TextDecoration.underline
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: AppLocalizations.of(
                                                            context)!
                                                        .ofCompany,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFFADADAD),
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      flaxibleGap(1),
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        child: Text(
                                          "Cancellations made within 24 hours will not receive a refund.",
                                          style: TextStyle(
                                              color: Color(0XFFADADAD),
                                              fontSize: 11),
                                        ),
                                      ),
                                      flaxibleGap(3)
                                    ],
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              monVal &&
                                      (teamIdExternal != null ||
                                          teamIdInternal != null)
                                  ? Container(
                                      height: sizeheight * .09,
                                      color: const Color(0XFF25A163),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            '${AppLocalizations.of(context)!.currency} ${widget.leagueData["detail"].paymentSummary.grandTotal.round()}',
                                            style: const TextStyle(
                                                color: Color(0XFFFFFFFF),
                                                fontSize: 18),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              navigateToDetail();
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0XFFFFFFFF),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(5.0),
                                                  topRight:
                                                      Radius.circular(5.0),
                                                  bottomLeft:
                                                      Radius.circular(5.0),
                                                  bottomRight:
                                                      Radius.circular(5.0),
                                                ),
                                              ),
                                              height: sizeheight * .04,
                                              width: sizewidth * .25,
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .proceed,
                                                style: TextStyle(
                                                  color: const Color(0XFF25A163),
                                                  fontSize: AppLocalizations.of(
                                                                  context)!
                                                              .locale ==
                                                          "en"
                                                      ? 18
                                                      : 22,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      height: 0,
                                    ),
                            ],
                          ),
                        ),
                        addTeam
                            ? BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(0),
                                ),
                              )
                            : Container(),
                        addTeamExternal
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizewidth * .05),
                                  child: Form(
                                    key: _formKey,
                                    child: Container(
                                      height: sizeheight * .6,
                                      width: sizewidth,
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
                                                horizontal: sizewidth * .05),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                    AppLocalizations.of(context)!
                                                        .selectonefieldtoenterwithotheryourtahadditeam,
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color:
                                                            Color(0XFFADADAD),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins")),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                SizedBox(
                                                    height: sizeheight * .03,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            addTeam = false;
                                                            addTeamExternal =
                                                                false;
                                                          });
                                                        },
                                                        child: Image.asset(
                                                          "images/deletImage.png",
                                                          height:
                                                              sizeheight * .03,
                                                        )))
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                          SizedBox(
                                            height: sizeheight * .15,
                                            child: Row(
                                              children: <Widget>[
                                                flaxibleGap(
                                                  1,
                                                ),
                                                Container(
                                                  height: sizeheight * .08,
                                                  width: sizeheight * .08,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Color(0XFF4F5C6A),
//                                    image: DecorationImage(
//                                      image: ExactAssetImage('images/4.jpg'),
//                                      fit: BoxFit.cover,
//                                    )
                                                  ),
                                                  child: profileDetail[
                                                              'profile_pic'] !=
                                                          null
                                                      ? ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100.0),
                                                          child: Image.network(
                                                            profileDetail[
                                                                    'profile_pic']
                                                                ['filePath'],
                                                            fit: BoxFit.fill,
                                                          ))
                                                      : Image.asset(
                                                          "images/profile.png",
                                                          fit: BoxFit.fill),
                                                  //child: Image.asset('images/4.jpg'),
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    flaxibleGap(
                                                      2,
                                                    ),
                                                    Text(
                                                      "${profileDetail["first_name"]} ${profileDetail["last_name"]}",
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Color(
                                                              0xff0320040)),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .captainC,
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          color: Color(
                                                              0XFF25A163)),
                                                    ),
                                                    flaxibleGap(
                                                      2,
                                                    ),
                                                  ],
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    _showChoiceDialog(context);
                                                  },
                                                  child: Container(
                                                    //alignment: Alignment.center,
                                                    height: sizeheight * .08,
                                                    width: sizeheight * .08,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0XFF032040)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: const Color(0XFF032040),
                                                    ),
                                                    child: image == null
                                                        ? const Icon(
                                                            Icons.camera,
                                                            color: Color(
                                                                0XFF25A163),
                                                          )
                                                        : ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            child: Image.file(
                                                              image,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                          Material(
                                            color: Colors.white,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizewidth * .05),
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: _teamController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .pleaseenterTeamName;
                                                      }
                                                      return null;
                                                    },
                                                    onFieldSubmitted: (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(focuss);
                                                    },
                                                    keyboardType:
                                                        TextInputType.text,
                                                    onSaved: (value) {
                                                      teamNameExternal = value!;
                                                    },
                                                    autofocus: false,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFF032040),
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets.all(0),
                                                      labelText: AppLocalizations
                                                              .of(context)!
                                                          .teamName, //\uD83D\uDD12
                                                      labelStyle: const TextStyle(
                                                          color:
                                                              Color(0XFFADADAD),
                                                          fontSize: 12),
                                                      enabledBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0XFF9F9F9F)),
                                                      ),
                                                      focusedBorder:
                                                          const UnderlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0XFF9F9F9F)),
                                                      ),
                                                    ),
                                                  ),
                                                  textField(
                                                    name: AppLocalizations.of(
                                                            context)!
                                                        .email,
                                                    controller:
                                                        _emailController,
                                                    node: focuss,
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .pleaseenterEmail;
                                                      }
                                                      return '';
                                                    },
                                                    text: false,
                                                    text1: false,
                                                    submit: (value) {
                                                      FocusScope.of(context)
                                                          .requestFocus(focus);
                                                    },
                                                    onSaved: (value) {
                                                      email = value!;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: sizeheight * .075,
                                                    width: sizewidth,
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          height:
                                                              sizeheight * .15,
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child:
                                                              CountryCodePicker(
                                                            onChanged: (value) {
                                                              setState(() {
                                                                contryCode = value
                                                                    .toString();
                                                                // print(country+"ratnesh");
                                                              });
                                                            },
                                                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                            initialSelection:
                                                                '+971',
                                                            favorite: const [
                                                              '+971',
                                                              'ITU',
                                                              '+91',
                                                              'IN'
                                                            ],
                                                            // optional. Shows only country name and flag
                                                            showCountryOnly:
                                                                false,
                                                            // optional. Shows only country name and flag when popup is closed.
                                                            showOnlyCountryWhenClosed:
                                                                false,
                                                            // optional. aligns the flag and the Text left
                                                            alignLeft: false,
                                                          ),
                                                        ),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              sizewidth * .55,
                                                          height:
                                                              sizeheight * .15,
                                                          child: textField(
                                                            node: focus,
                                                            validator: (value) {
                                                              if (value!
                                                                  .isEmpty) {
                                                                return AppLocalizations.of(
                                                                        context)!
                                                                    .pleaseenterPhoneNumber;
                                                              }
                                                              return '';
                                                            },
                                                            controller:
                                                                _numberController,
                                                            text: false,
                                                            text1: false,
                                                            keybordType: true,
                                                            name: AppLocalizations
                                                                    .of(context)!
                                                                .phone,
                                                            hint: AppLocalizations
                                                                    .of(context)!
                                                                .phone,
                                                            onSaved: (value) {
                                                              number = value!;
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          flaxibleGap(
                                            3,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                _formKey.currentState!.save();

                                                Map detail = {
                                                  "teamName": teamNameExternal,
                                                  "contactNumber": number,
                                                  "email": email,
                                                  "countryCode": contryCode,
                                                };
                                                if (logoId != null) {
                                                  detail["teamlogoId"] = logoId;
                                                }
                                                _networkCalls
                                                    .checkInternetConnectivity(
                                                        onSuccess: (msg) {
                                                  _internet = msg;
                                                  if (_internet) {
                                                    setState(() {
                                                      _isLoading = true;
                                                    });
                                                    _networkCalls.creatTeam(
                                                      teamType:
                                                          "?team_type=external",
                                                      detail: detail,
                                                      onSuccess: (msg) {
                                                        if (mounted) {
                                                          setState(() {
                                                            teamInfoData = msg;
                                                            teamIdExternal =
                                                                teamInfoData.id!.toInt();
                                                            addTeamExternal =
                                                                false;
                                                            _isLoading = false;
                                                            addTeam = false;
                                                          });
                                                        }
                                                      },
                                                      onFailure: (msg) {
                                                        if (mounted) {
                                                          showMessage(
                                                              msg);
                                                        }
                                                        setState(() {
                                                          addTeamExternal =
                                                              false;
                                                          _isLoading = false;
                                                          addTeam = false;
                                                        });
                                                      },
                                                      tokenExpire: () {
                                                        if (mounted) {
                                                          on401(context);
                                                        }
                                                      },
                                                    );
                                                  } else {
                                                    if (mounted) {
                                                      showMessage(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .noInternetConnection);
                                                    }
                                                  }
                                                });
                                              }
                                            },
                                            child: Container(
                                                color: const Color(0XFF25A163),
                                                height: sizeheight * .08,
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        addTeamInternal
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizewidth * .05),
                                  child: Form(
                                    key: _formKey,
                                    child: Container(
                                      height: sizeheight * .4,
                                      width: sizewidth,
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
                                                horizontal: sizewidth * .03),
                                            child: Row(
                                              children: <Widget>[
                                                Text(
                                                    AppLocalizations.of(context)!
                                                        .selectonefieldtoenterwithotherteam,
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color:
                                                            Color(0XFFADADAD),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins")),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                SizedBox(
                                                  height: sizeheight * .03,
                                                  child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          addTeam = false;
                                                          addTeamInternal =
                                                              false;
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "images/deletImage.png",
                                                        height:
                                                            sizeheight * .03,
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                          teamInfoData == null
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: sizewidth * .04,
                                                      right: sizewidth * .04),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      navigateToTeam();
                                                    },
                                                    child: Stack(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      children: <Widget>[
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            image: DecorationImage(
                                                                image: ExactAssetImage(
                                                                    'images/languageAdd.png'),
                                                                fit: BoxFit
                                                                    .fill),
                                                            // border: Border.all(color: Colors.black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        10.0) //                 <--- border radius here
                                                                    ),
                                                          ),
                                                          height:
                                                              sizeheight * .15,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .createTeam,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF032040),
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                      left: sizewidth * .04,
                                                      right: sizewidth * .04),
                                                  child: Container(
                                                    decoration: const BoxDecoration(
                                                      color: Color(0XFF032040),
                                                      // border: Border.all(color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10.0) //                 <--- border radius here
                                                              ),
                                                    ),
                                                    height: sizeheight * .15,
                                                    child: Row(
                                                      children: <Widget>[
                                                        flaxibleGap(
                                                          2,
                                                        ),
                                                        Container(
                                                            height: sizeheight *
                                                                .08,
                                                            width: sizeheight *
                                                                .08,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0XFF4F5C6A),
                                                              // image: Image.network(profileDetail.profile_pic),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100.0),
                                                              child: teamInfoData
                                                                          .captain!
                                                                          .profile_pic !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      teamInfoData
                                                                          .captain!
                                                                          .profile_pic!
                                                                          .filePath.toString(),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.asset(
                                                                      "images/profile.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            )),
                                                        flaxibleGap(
                                                          3,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            flaxibleGap(
                                                              4,
                                                            ),
                                                            Text(
                                                              "${teamInfoData.captain!.first_name} ${teamInfoData.captain!.last_name}",
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .captain,
                                                              style: const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Color(
                                                                      0XFF25A163)),
                                                            ),
                                                            flaxibleGap(
                                                              1,
                                                            ),
                                                            Text(
                                                              teamInfoData
                                                                  .teamName.toString(),
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            flaxibleGap(
                                                              3,
                                                            ),
                                                          ],
                                                        ),
                                                        flaxibleGap(
                                                          4,
                                                        ),
                                                        Container(
                                                            height: sizeheight *
                                                                .08,
                                                            width: sizeheight *
                                                                .08,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0XFF4F5C6A),
                                                              // image: Image.network(profileDetail.profile_pic),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                              child: teamInfoData
                                                                          .teamLogo!
                                                                          .filePath !=
                                                                      null
                                                                  ? Image
                                                                      .network(
                                                                      teamInfoData
                                                                          .teamLogo!
                                                                          .filePath.toString(),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )
                                                                  : Image.asset(
                                                                      "images/profile.png",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                            )),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                          flaxibleGap(
                                            1,
                                          ),
                                          teamInfoData == null
                                              ? Container()
                                              : GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      addTeam = false;
                                                      addTeamInternal = false;
                                                      teamIdInternal =
                                                          teamInfoData.id!.toInt();
                                                    });
                                                  },
                                                  child: Container(
                                                      color: const Color(0XFF25A163),
                                                      height: sizeheight * .08,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .save,
                                                        style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Poppins",
                                                        ),
                                                      )),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  )
                : InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        _internet = msg;
                        if (msg == true) {
                          loadProfile();
                        }
                      });
                    },
                  ));
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        _isLoading = true;
        image = File(picture.path);

        var detail = {"profile_image": image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              logoId = msg;
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
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        _isLoading = true;
        image = File(picture.path);
        print('hello');
        print(picture);

        var detail = {"profile_image": image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              logoId = msg;

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
      }
    });
    Navigator.of(context).pop();
  }

  void navigateToDetail() {
    var deatil = {
      "price": widget.leagueData["detail"].paymentSummary.grandTotal.round(),
      "name": widget.leagueData["detail"].name,
      "email": widget.leagueData["detail"].organisedBy,
      "startingDate": widget.leagueData["detail"].pitchType.name,
      "pitchtype": "noPitch",
      "apidetail": "noapi",
      "teamId": teamIdInternal ?? teamIdExternal,
      "tanjectionDetail": widget.leagueData["id"],
      "detail": widget.leagueData["detail"].paymentSummary
    };
    Navigator.pushNamed(context, RouteNames.payment, arguments: deatil);
  }

  void navigateToTeam() {
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.team, (r) => false);
  }
}
