import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/teamModelClass.dart';
import '../../../network/network_calls.dart';

class EnterDetailJoinTeam extends StatefulWidget {
  TeamModelClass? teamDeatail;
  EnterDetailJoinTeam({super.key, this.teamDeatail});
  @override
  _EnterDetailJoinTeamState createState() => _EnterDetailJoinTeamState();
}

class _EnterDetailJoinTeamState extends State<EnterDetailJoinTeam> {
  String? _player;
  final _formKey = GlobalKey<FormState>();
  String? _curentlySelectedItem;
  final GlobalKey _textKey = GlobalKey();
  bool monVal = false;
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final List<String> _dropdownMonth = [
    "football",
  ];
  bool loading = true;
  Map? profileDetail;
  bool? internet;
  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
          loading = false;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return loading
        ? Scaffold(
            key: scaffoldkey,
            backgroundColor: const Color(0XFFF0F0F0),
            bottomNavigationBar: Container(
                height: sizeHeight * .09,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.requestjointeam,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                )),
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
            body: SingleChildScrollView(
              child: SizedBox(
                height: sizeHeight * .78,
                width: sizeWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .05,
                          top: sizeHeight * .04,
                          bottom: sizeHeight * .03,
                          right: sizeWidth * .05),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: sizeHeight * .1,
                              width: sizeWidth * .2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0XFF032040),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 5,
                              width: sizeWidth * .5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .05, right: sizeWidth * .05),
                      child: Container(
                        height: sizeHeight * .5,
                        color: const Color(0XFFFFFFFF),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(
                                    width: sizeWidth * .35,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          enabled: true,
                                          child: Container(
                                            height: 5,
                                            width: sizeWidth,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0) //

                                                  ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Shimmer.fromColors(
                                          baseColor: Colors.grey.shade300,
                                          highlightColor: Colors.grey.shade100,
                                          enabled: true,
                                          child: Container(
                                            height: 5,
                                            width: sizeWidth,
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0) //

                                                  ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeWidth * .02,
                                        vertical: sizeHeight * .01),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: Container(
                                        height: sizeHeight * .1,
                                        width: sizeHeight * .1,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0XFF4F5C6A),
                                          // image: Image.network(profileDetail.profile_pic),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 20,
                                  width: sizeWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //

                                            ),
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 20,
                                  width: sizeWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //

                                            ),
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 20,
                                  width: sizeWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //

                                            ),
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 20,
                                  width: sizeWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //

                                            ),
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 20,
                                  width: sizeWidth,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //

                                            ),
                                  ),
                                ),
                              ),
                              flaxibleGap(
                                4,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    flaxibleGap(
                      1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Checkbox(
                          activeColor: const Color(0XFF25A163),
                          value: monVal,
                          onChanged: (v) {},
                        ),
                        SizedBox(
                          width: sizeWidth * .76,
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: AppLocalizations.of(context)!.iAgree,
                                  style: const TextStyle(
                                      color: Color(0XFFADADAD), fontSize: 12),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.term,
                                  style: const TextStyle(
                                    color: Color(0XFF25A163),
                                    fontSize: 12,
                                  ),
                                ),
                                TextSpan(
                                  text: AppLocalizations.of(context)!.oftheTeam,
                                  style: const TextStyle(
                                      color: Color(0XFFADADAD), fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : internet!
            ? Scaffold(
                key: scaffoldkey,
                backgroundColor: const Color(0XFFF0F0F0),
                bottomNavigationBar: monVal && _player != null
                    ? Material(
                        color: const Color(0XFF25A163),
                        child: InkWell(
                          onTap: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              internet = msg;
                              if (msg == true) {
                                Map detail = {
                                  "captainId": widget.teamDeatail!.captain!.id,
                                  "playergamePlayed": _player
                                };
                                _networkCalls.playerInvitationSend(
                                  detail: detail,
                                  onSuccess: (msg) {
                                    navigateToHome();
                                  },
                                  onFailure: (msg) {
                                    showMessage(msg);
                                  },
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
                          },
                          splashColor: Colors.black,
                          child: Container(
                              height: sizeHeight * .09,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.requestjointeam,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              )),
                        ),
                      )
                    : Container(
                        height: sizeHeight * .09,
                        color: Colors.grey,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.requestjointeam,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        )),
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
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: sizeHeight * .78,
                    width: sizeWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05,
                              top: sizeHeight * .04,
                              bottom: sizeHeight * .03,
                              right: sizeWidth * .05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                  height: sizeHeight * .1,
                                  width: sizeWidth * .2,
                                  child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
                                      child: cachedNetworkImage(
                                          cuisineImageUrl: widget
                                              .teamDeatail?.teamLogo?.filePath,
                                          placeholder: 'images/profile.png'))),
                              Padding(
                                padding: AppLocalizations.of(context)!.locale ==
                                        "en"
                                    ? EdgeInsets.only(left: sizeWidth * .05)
                                    : EdgeInsets.only(right: sizeWidth * .05),
                                child: SizedBox(
                                  height: sizeHeight * .1,
                                  child: Text(
                                    widget.teamDeatail!.teamName.toString(),
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                      decoration: TextDecoration.none,
                                      color: Color(0XFF032040),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: Container(
                            height: sizeHeight * .5,
                            color: const Color(0XFFFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .05,
                                  right: sizeWidth * .05),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SizedBox(
                                          width: sizeWidth * .35,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .newPlayer,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 12,
                                                    color: Color(0XFF898989),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(
                                                "${profileDetail!['first_name']} ${profileDetail!['last_name']}",
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0XFF032040),
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                        flaxibleGap(
                                          1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .02,
                                              vertical: sizeHeight * .01),
                                          child: Container(
                                              height: sizeHeight * .1,
                                              width: sizeHeight * .1,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0XFF4F5C6A),
                                                // image: Image.network(profileDetail.profile_pic),
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        sizeHeight * .1),
                                                child: profileDetail![
                                                            'profile_pic'] !=
                                                        null
                                                    ? cachedNetworkImage(
                                                        cuisineImageUrl:
                                                            profileDetail![
                                                                    'profile_pic']
                                                                ['filePath'],
                                                      )
                                                    : Image.asset(
                                                        "images/profile.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                              )),
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(
                                      1,
                                    ),
                                    Container(
                                        height: 1,
                                        width: sizeWidth,
                                        color: const Color(0XFFADADAD)),
                                    Flexible(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Text(
                                      profileDetail!['email'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0XFF032040)),
                                    ),
                                    Container(
                                        height: 1,
                                        width: sizeWidth,
                                        color: const Color(0XFFADADAD)),
                                    flaxibleGap(
                                      1,
                                    ),
                                    profileDetail!['contact_number'] != null
                                        ? Text(
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? "${profileDetail!['countryCode'] ?? ""}" "${profileDetail!['contact_number'] ?? ""}"
                                                : "${profileDetail!['countryCode'].substring(1) ?? ""}${profileDetail!['contact_number'] ?? ""}${profileDetail!['countryCode'].substring(0, 1) ?? ""}",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0XFF032040)),
                                          )
                                        : Container(),
                                    profileDetail!['contact_number'] != null
                                        ? Container(
                                            height: 1,
                                            width: sizeWidth,
                                            color: const Color(0XFFADADAD))
                                        : Container(),
                                    profileDetail!['contact_number'] != null
                                        ? Flexible(
                                            flex: 1,
                                            child: Container(),
                                          )
                                        : Container(),
                                    profileDetail!['dob'] != null
                                        ? Text(
                                            profileDetail!['dob'],
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0XFF032040)),
                                          )
                                        : Container(),
                                    profileDetail!['dob'] != null
                                        ? Container(
                                            height: 1,
                                            width: sizeWidth,
                                            color: const Color(0XFFADADAD))
                                        : Container(),
                                    profileDetail!['dob'] != null
                                        ? flaxibleGap(
                                            1,
                                          )
                                        : Container(),
                                    profileDetail!['playerPosition']["name"] !=
                                            null
                                        ? Text(
                                            profileDetail!['playerPosition']
                                                    ["name"] ??
                                                "Player Position",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Color(0XFF032040)),
                                          )
                                        : Container(),
                                    profileDetail!['playerPosition']["name"] !=
                                            null
                                        ? Container(
                                            height: 1,
                                            width: sizeWidth,
                                            color: const Color(0XFFADADAD))
                                        : Container(),
                                    SizedBox(
                                      height: sizeHeight * .07,
                                      child: Center(
                                        child: DropdownButton<String>(
                                          underline: Container(
                                            height: 1,
                                            color: const Color(0XFF9F9F9F),
                                          ),
                                          iconEnabledColor:
                                              const Color(0XFF9B9B9B),
                                          focusColor: const Color(0XFF9B9B9B),
                                          isExpanded: true,
                                          value: _curentlySelectedItem,
                                          hint: Text(
                                            AppLocalizations.of(context)!
                                                .gamePlayed,
                                            style: const TextStyle(
                                                color: Color(0XFFADADAD),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          items: _dropdownMonth
                                              .map((value) => DropdownMenuItem(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF032040),
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (String? value) {
                                            setState(() {
                                              _curentlySelectedItem = value;
                                              _player = value;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    flaxibleGap(
                                      4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                              activeColor: const Color(0XFF25A163),
                              value: monVal,
                              onChanged: (bool? value) {
                                setState(() {
                                  monVal = value!;
                                });
                              },
                            ),
                            SizedBox(
                              width: sizeWidth * .76,
                              child: RichText(
                                key: _textKey,
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          AppLocalizations.of(context)!.iAgree,
                                      style: const TextStyle(
                                          color: Color(0XFFADADAD),
                                          fontSize: 12),
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!.term,
                                      style: const TextStyle(
                                        color: Color(0XFF25A163),
                                        fontSize: 12,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () async {
                                          privacyPolicy(
                                              "terms_and_conditions_url");
                                        },
                                    ),
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .oftheTeam,
                                      style: const TextStyle(
                                          color: Color(0XFFADADAD),
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      loadProfile();
                    } else {
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                },
              );
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }
}
