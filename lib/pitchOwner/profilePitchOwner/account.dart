import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../common_widgets/localeHelper.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with AutomaticKeepAliveClientMixin {
  bool pitchOwner = false;
  bool isSwitched = true;
  bool player = false;
  late bool internet;
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  late Map profileDetail;
  bool isStateLoading = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          AppLocalizations.of(context)!.locale == "en"
              ? isSwitched = true
              : isSwitched = false;
          profileDetail = msg;
          isStateLoading = false;
        });
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  onWillLogout(String description, bool isLogout) {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(description),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      if (isLogout) {
                        _networkCalls.logout(
                          onSuccess: (msg) {
                            _networkCalls.clearToken(key: 'token');
                            _networkCalls.clearToken(key: 'role');
                            _networkCalls.clearToken(key: "auth");
                            navigateToHome();
                          },
                          onFailure: (msg) {
                            if (mounted) showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      } else {
                        _networkCalls.deleteAccount(
                          onSuccess: (msg) {
                            _networkCalls.clearToken(key: 'token');
                            _networkCalls.clearToken(key: 'role');
                            _networkCalls.clearToken(key: "auth");
                            navigateToHome();
                          },
                          onFailure: (msg) {
                            showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      }
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
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    _networkCalls.saveLanguage(AppLocalizations.of(context)!.locale);
    return isStateLoading
        ? SafeArea(
            child: Scaffold(
              backgroundColor: const Color(0XFFE0E0E0),
              body: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      buildAppBar(
                          language: AppLocalizations.of(context)!.locale,
                          title: AppLocalizations.of(context)!.account,
                          height: sizeHeight,
                          width: sizeWidth),
                      Container(
                        height: 120,
                      ),
                      Expanded(
                        child: Container(
                          height: sizeHeight * .5,
                          width: sizeWidth,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                            ),
                            //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .1, right: sizeWidth * .1),
                            child: Column(
                              children: <Widget>[
                                Flexible(
                                  flex: 6,
                                  child: Container(),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .02),
                                        child: SvgPicture.asset(
                                          "assets/images/bankCard.svg",
                                          height: 25,
                                        )),
                                    Text(
                                      AppLocalizations.of(context)!.bankDetails,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF595959),
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Container(
                                  height: 1,
                                  color: const Color(0XFFE0E0E0),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .02),
                                        child: Image.asset(
                                          "assets/images/mypitches.png",
                                          height: 25,
                                        )),
                                    Material(
                                      color: Colors.white,
                                      child: Text(
                                        AppLocalizations.of(context)!.myPitches,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF595959),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: 1,
                                  color: const Color(0XFFE0E0E0),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .02),
                                        child: Image.asset(
                                          "assets/images/passwordReset.png",
                                          height: 25,
                                        )),
                                    Material(
                                      color: Colors.white,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .changepasswordC,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF595959),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: 1,
                                  color: const Color(0XFFE0E0E0),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .02),
                                      child: Image.asset(
                                        'assets/images/earth.png',
                                        height: 25,
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.language,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF595959),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    flaxibleGap(
                                      6,
                                    ),
                                    isSwitched
                                        ? const Text('Ar',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFFB7B7B7)))
                                        : const Text('Ar',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF032040))),
                                    Switch(
                                      value: isSwitched,
                                      activeColor: const Color(0xFF032040),
                                      inactiveThumbColor:
                                          const Color(0xFF032040),
                                      onChanged: (msg) {},
                                    ),
                                    isSwitched
                                        ? const Text(
                                            'En',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF032040)),
                                          )
                                        : const Text('En',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFFB7B7B7))),
                                    flaxibleGap(
                                      1,
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  6,
                                ),
                                Row(
                                  children: <Widget>[
                                    Flexible(
                                      flex: 2,
                                      child: Container(),
                                    ),
                                    SvgPicture.asset(
                                        "assets/images/logout.svg"),
                                    flaxibleGap(
                                      1,
                                    ),
                                    Material(
                                      color: Colors.white,
                                      child: Text(
                                        AppLocalizations.of(context)!.logout,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFFD0021B),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    flaxibleGap(
                                      21,
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 140, horizontal: sizeWidth * .05),
                    child: Container(
                      height: sizeHeight * .15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0XFF032040),
                      ),
                      child: Row(
                        children: <Widget>[
                          flaxibleGap(
                            2,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: sizeHeight * .09,
                              width: sizeHeight * .09,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFF4F5C6A),
                              ),
                              //child: Image.asset('images/4.jpg'),
                            ),
                          ),
                          flaxibleGap(
                            3,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              flaxibleGap(
                                2,
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  width: sizeWidth * .5,
                                  height: 5,
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
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.call,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: sizeWidth * .01,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      width: sizeWidth * .3,
                                      height: 5,
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
                              flaxibleGap(
                                1,
                              ),
                              Row(
                                children: <Widget>[
                                  const Icon(
                                    Icons.mail,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    width: sizeWidth * .01,
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      width: sizeWidth * .3,
                                      height: 5,
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
                              // flaxibleGap(
                              //   1,
                              // ),
                              // Row(
                              //   children: <Widget>[
                              //     Image.asset(
                              //       "images/gender.png",
                              //       fit: BoxFit.cover,
                              //       height: 15,
                              //       color: Colors.white,
                              //     ),
                              //     Container(
                              //       width: sizeWidth * .01,
                              //     ),
                              //     Shimmer.fromColors(
                              //       baseColor: Colors.grey[300],
                              //       highlightColor: Colors.grey[100],
                              //       enabled: true,
                              //       child: Container(
                              //         width: sizeWidth * .2,
                              //         height: 5,
                              //         decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.all(
                              //               Radius.circular(5.0) //
                              //
                              //               ),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              flaxibleGap(
                                2,
                              ),
                            ],
                          ),
                          Flexible(
                            flex: 10,
                            child: Container(),
                          ),
                          GestureDetector(
                            onTap: () {
                              navigateToEditprofile();
                            },
                            child: Icon(
                              Icons.edit,
                              size: 20,
                              color: const Color(0XFFBCBCBC).withOpacity(.3),
                            ),
                          ),
                          flaxibleGap(
                            4,
                          ),
                        ],
                      ),
                    ),
                  ),
                  //            Padding(
                ],
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ),
          )
        : internet
            ? SafeArea(
                child: Scaffold(
                  backgroundColor: const Color(0XFFE0E0E0),
                  body: Stack(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          buildAppBar(
                              language: AppLocalizations.of(context)!.locale,
                              title: AppLocalizations.of(context)!.account,
                              height: sizeHeight,
                              width: sizeWidth),
                          Container(
                            height: 100,
                          ),
                          Expanded(
                            child: Container(
                              height: sizeHeight * .5,
                              width: sizeWidth,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                                //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: sizeWidth * .1,
                                    right: sizeWidth * .1),
                                child: Column(
                                  children: <Widget>[
                                    flaxibleGap(6),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizeWidth * .02),
                                            child: SvgPicture.asset(
                                              "assets/images/bankCard.svg",
                                              height: 25,
                                            )),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bankDetails,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0XFF595959),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(1),
                                    Container(
                                      height: 1,
                                      color: const Color(0XFFE0E0E0),
                                    ),
                                    flaxibleGap(1),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizeWidth * .02),
                                            child: Image.asset(
                                              "assets/images/mypitches.png",
                                              height: 25,
                                            )),
                                        Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              navigateToMyPitches();
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .myPitches,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF595959),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(
                                      1,
                                    ),
                                    Container(
                                      height: 1,
                                      color: const Color(0XFFE0E0E0),
                                    ),
                                    flaxibleGap(
                                      1,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizeWidth * .02),
                                            child: Image.asset(
                                              "assets/images/passwordReset.png",
                                              height: 25,
                                            )),
                                        Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              navigateToChangePassword();
                                            },
                                            splashColor: Colors.black,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .changepasswordC,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFF595959),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(
                                      1,
                                    ),
                                    Container(
                                      height: 1,
                                      color: const Color(0XFFE0E0E0),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .02),
                                          child: Image.asset(
                                            'assets/images/earth.png',
                                            height: 25,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .language,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Color(0XFF595959),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        flaxibleGap(
                                          6,
                                        ),
                                        isSwitched
                                            ? const Text('Ar',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFFB7B7B7)))
                                            : const Text('Ar',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF032040))),
                                        Switch(
                                          value: isSwitched,
                                          onChanged: (value) {
                                            isSwitched = value;
                                            isSwitched
                                                ? helper.onLocaleChanged(
                                                    const Locale("en"))
                                                : helper.onLocaleChanged(
                                                    const Locale("ar"));
                                            _networkCalls.saveLanguage(
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? "ar"
                                                    : "en");
                                            loadProfile();
                                          },
                                          activeColor: const Color(0xFF032040),
                                          inactiveThumbColor:
                                              const Color(0xFF032040),
                                        ),
                                        isSwitched
                                            ? const Text(
                                                'En',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFF032040)),
                                              )
                                            : const Text('En',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0XFFB7B7B7))),
                                        flaxibleGap(
                                          1,
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(
                                      6,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        flaxibleGap(
                                          2,
                                        ),
                                        SvgPicture.asset(
                                            "assets/images/logout.svg"),
                                        flaxibleGap(
                                          1,
                                        ),
                                        Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              onWillLogout(
                                                  AppLocalizations.of(context)!
                                                      .youGoingLogout,
                                                  true);
                                            },
                                            splashColor: Colors.grey,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .logout,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFFD0021B),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        flaxibleGap(
                                          21,
                                        ),
                                        Material(
                                          color: Colors.white,
                                          child: InkWell(
                                            onTap: () {
                                              onWillLogout(
                                                  AppLocalizations.of(context)!
                                                      .youGoingDeleteAccount,
                                                  false);
                                            },
                                            splashColor: Colors.grey,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .deleteAccount,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0XFFD0021B),
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    flaxibleGap(
                                      4,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 180, horizontal: sizeWidth * .05),
                        child: Container(
                          height: sizeHeight * .15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0XFF032040),
                          ),
                          child: Row(
                            children: <Widget>[
                              flaxibleGap(
                                2,
                              ),
                              Container(
                                  height: sizeHeight * .09,
                                  width: sizeHeight * .09,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color(0XFF4F5C6A),
                                  ),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(sizeHeight * .09),
                                    child: profileDetail['profile_pic'] != null
                                        ? cachedNetworkImage(
                                            cuisineImageUrl:
                                                profileDetail['profile_pic']
                                                    ['filePath'],
                                            placeholder:
                                                "assets/images/profile.png")
                                        : Image.asset(
                                            "assets/images/profile.png",
                                            fit: BoxFit.fill,
                                          ),
                                  )
                                  //child: Image.asset('images/4.jpg'),
                                  ),
                              flaxibleGap(
                                3,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  flaxibleGap(
                                    2,
                                  ),
                                  SizedBox(
                                    width: sizeWidth * .5,
                                    child: Text(
                                      '${profileDetail['first_name']} ${profileDetail['last_name']}',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        height: 1,
                                        fontSize: 18,
                                        color: Color(0XFF25A163),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.call,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: sizeWidth * .01,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? "${profileDetail['countryCode'] ?? ""}" +
                                                "${profileDetail['contact_number'] ?? ""}"
                                            : "${profileDetail['countryCode'].substring(1) ?? ""}${profileDetail['contact_number'] ?? ""}${profileDetail['countryCode'].substring(0, 1) ?? ""}",
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      const Icon(
                                        Icons.mail,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: sizeWidth * .01,
                                      ),
                                      Text(
                                        profileDetail['email'],
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: <Widget>[
                                  //     Image.asset(
                                  //       "images/gender.png",
                                  //       fit: BoxFit.cover,
                                  //       height: 15,
                                  //       color: Colors.white,
                                  //     ),
                                  //     Container(
                                  //       width: sizeWidth * .01,
                                  //     ),
                                  //     Text(
                                  //       profileDetail['gender'] ??
                                  //           'Not Available',
                                  //       style: TextStyle(
                                  //           fontSize: 13, color: Colors.white),
                                  //     ),
                                  //   ],
                                  // ),
                                  flaxibleGap(
                                    2,
                                  ),
                                ],
                              ),
                              flaxibleGap(
                                10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigateToEditprofile();
                                },
                                child: Icon(
                                  Icons.edit,
                                  size: 20,
                                  color:
                                      const Color(0XFFBCBCBC).withOpacity(.3),
                                ),
                              ),
                              flaxibleGap(
                                4,
                              ),
                            ],
                          ),
                        ),
                      ),
                      //            Padding(
                    ],
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                ),
              )
            : Column(
                children: [
                  buildAppBar(
                      language: AppLocalizations.of(context)!.locale,
                      title: AppLocalizations.of(context)!.account,
                      height: sizeHeight,
                      width: sizeWidth),
                  Expanded(
                    child: InternetLoss(
                      onChange: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          internet = msg;
                          if (msg == true) {
                            loadProfile();
                          } else {
                            setState(() {
                              isStateLoading = false;
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              );
  }

  void navigateToEditprofile() {
    Navigator.pushNamed(context, RouteNames.editProfilePitchOwner);
  }

  void navigateToMyPitches() {
    Navigator.pushNamed(context, RouteNames.myVenues);
  }

  void navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.playerHome, (Route<dynamic> route) => false);
  }

  void navigateToChangePassword() {
    Navigator.pushNamed(context, RouteNames.resetPassword);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
