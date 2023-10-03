import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../common_widgets/internet_loss.dart';
import '../common_widgets/localeHelper.dart';
import '../localizations.dart';
import '../network/network_calls.dart';
import 'routingConstant.dart';
import 'utility.dart';

class More extends StatefulWidget {
  const More({super.key});

  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  bool isSwitched = true;
  late bool _auth;
  String msg =
      'hello,this is my App:https://tahadde.page.link?link=https://www.google.com/&apn=com.root.tahadde';

  // String base64Image =
  //     "https://tahadde.page.link?link=https://www.google.com/&apn=com.root.tahadde";
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late bool _internet;
  bool _isLoading = true;
  late Map profileDetail;
  late SharedPreferences pref;

  privacyPolicy() async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg["privacy_policy_url"]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  loadProfile() async {
    _auth = (await checkAuthorizaton())!;
    if (_auth) {
      setState(() {
        _isLoading = false;
        AppLocalizations.of(context)!.locale == "en"
            ? isSwitched = true
            : isSwitched = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        AppLocalizations.of(context)!.locale == "en"
            ? isSwitched = true
            : isSwitched = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (_internet == true) {
        loadProfile();
      }
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    _networkCalls.saveLanguage(AppLocalizations.of(context)!.locale);
    return Scaffold(
      body: Column(
        children: [
          buildAppBar(
              language: AppLocalizations.of(context)!.locale,
              title: AppLocalizations.of(context)!.setting,
              height: sizeHeight,
              width: sizeWidth),
          _isLoading
              ? _buildLoadingShimmer(sizeWidth)
              : _internet
                  ? Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .5,
                        width: MediaQuery.of(context).size.width,
                        color: const Color(0XFFD6D6D6),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            _auth
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      color: const Color(0XFFFFFFFF),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                      child: Column(
                                        children: <Widget>[
                                          flaxibleGap(1),
                                          // Padding(
                                          //   padding: EdgeInsets.symmetric(
                                          //     horizontal: 10,
                                          //   ),
                                          //   child: Row(
                                          //     children: <Widget>[
                                          //       Image.asset(
                                          //         'images/rate.png',
                                          //         height: 22,
                                          //         width: 60,
                                          //       ),
                                          //       Container(
                                          //         width: 5,
                                          //       ),
                                          //       Text(
                                          //         AppLocalizations.of(context)
                                          //             .rateApp,
                                          //         style: TextStyle(
                                          //             fontFamily: 'Poppins',
                                          //             fontSize: 14,
                                          //             color: Color(0XFF4A4A4A),
                                          //             fontWeight: FontWeight.w600),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          // flaxibleGap(2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                _settingModalBottomSheet(
                                                    context, sizeHeight);
                                                // navigateToContectUs();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/call.png',
                                                    height: 22,
                                                    width: 60,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .contectUs,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          flaxibleGap(2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                privacyPolicy();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/setting.png',
                                                    height: 22,
                                                    width: 60,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .ourPolicy,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          flaxibleGap(1),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/earth.png',
                                                  height: 22,
                                                  width: 60,
                                                ),
                                                Container(
                                                  width: 5,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .language,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Color(0XFF4A4A4A),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                flaxibleGap(6),
                                                isSwitched
                                                    ? const Text('Ar',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFFB7B7B7)))
                                                    : const Text('Ar',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF032040))),
                                                Switch(
                                                  value: isSwitched,
                                                  onChanged: (value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        isSwitched = value;
                                                        isSwitched
                                                            ? helper
                                                                .onLocaleChanged(
                                                                    const Locale(
                                                                        "en"))
                                                            : helper
                                                                .onLocaleChanged(
                                                                    const Locale(
                                                                        "ar"));
                                                      });
                                                    }
                                                  },
                                                  activeColor:
                                                      const Color(0xFF032040),
                                                  inactiveThumbColor:
                                                      const Color(0xFF032040),
                                                ),
                                                isSwitched
                                                    ? const Text(
                                                        'En',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF032040)),
                                                      )
                                                    : const Text('En',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFFB7B7B7))),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(15),
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 30.0),
                                    child: Container(
                                      color: const Color(0XFFFFFFFF),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .5,
                                      child: Column(
                                        children: <Widget>[
                                          flaxibleGap(3),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/login.png',
                                                  height: 22,
                                                  width: 60,
                                                ),
                                                Container(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    navigateToDetail();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .login,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/signup.png',
                                                  height: 22,
                                                  width: 60,
                                                ),
                                                Container(
                                                  width: 5,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    navigateToDetail1();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .signUp,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          // flaxibleGap(2),
                                          // Padding(
                                          //   padding:
                                          //       EdgeInsets.symmetric(horizontal: 10),
                                          //   child: Row(
                                          //     children: <Widget>[
                                          //       Image.asset(
                                          //         'images/rate.png',
                                          //         height: 22,
                                          //         width: 60,
                                          //       ),
                                          //       Container(
                                          //         width: 5,
                                          //       ),
                                          //       Text(
                                          //         AppLocalizations.of(context)
                                          //             .rateApp,
                                          //         style: TextStyle(
                                          //             fontFamily: 'Poppins',
                                          //             fontSize: 14,
                                          //             color: Color(0XFF4A4A4A),
                                          //             fontWeight: FontWeight.w600),
                                          //       )
                                          //     ],
                                          //   ),
                                          // ),
                                          flaxibleGap(2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                _settingModalBottomSheet(
                                                    context, sizeHeight);
                                                //  navigateToContectUs();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/call.png',
                                                    height: 22,
                                                    width: 60,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .contectUs,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          flaxibleGap(2),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                privacyPolicy();
                                              },
                                              child: Row(
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/setting.png',
                                                    height: 22,
                                                    width: 60,
                                                  ),
                                                  Container(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .ourPolicy,
                                                    style: const TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0XFF4A4A4A),
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          flaxibleGap(1),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Image.asset(
                                                  'assets/images/earth.png',
                                                  height: 22,
                                                  width: 60,
                                                ),
                                                Container(
                                                  width: 5,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .language,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 14,
                                                      color: Color(0XFF4A4A4A),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                flaxibleGap(6),
                                                isSwitched
                                                    ? const Text('Ar',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFFB7B7B7)))
                                                    : const Text('Ar',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF032040))),
                                                Switch(
                                                  value: isSwitched,
                                                  onChanged: (value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        isSwitched = value;
                                                        isSwitched
                                                            ? helper
                                                                .onLocaleChanged(
                                                                    const Locale(
                                                                        "en"))
                                                            : helper
                                                                .onLocaleChanged(
                                                                    const Locale(
                                                                        "ar"));
                                                      });
                                                    }
                                                  },
                                                  activeColor:
                                                      const Color(0xFF032040),
                                                  inactiveThumbColor:
                                                      const Color(0xFF032040),
                                                ),
                                                isSwitched
                                                    ? const Text(
                                                        'En',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF032040)),
                                                      )
                                                    : const Text('En',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0XFFB7B7B7))),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(10),
                                        ],
                                      ),
                                    ),
                                  ),
                            flaxibleGap(4),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: sizeHeight * .5,
                        child: InternetLoss(
                          onChange: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              _internet = msg;
                              if (_internet == true) {
                                loadProfile();
                              }
                            });
                          },
                        ),
                      ),
                    ),
        ],
      ),
    );
  }

  Widget _buildLoadingShimmer(sizeWidth) {
    return Expanded(
      child: SizedBox(
        width: sizeWidth,
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
                child: ListView.builder(
                  itemBuilder: (_, __) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 150.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 100.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 100.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 4.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 160.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 20.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetail() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  void _settingModalBottomSheet(context, sizeHeight) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        builder: (BuildContext bc) {
          return SizedBox(
            height: sizeHeight * .35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  flaxibleGap(
                    1,
                  ),
                  Text(
                    AppLocalizations.of(context)!.contectUs,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final link = WhatsAppUnilink(
                        text: msg,
                      );
                      await launch("$link");
                      //FlutterShareMe().shareToWhatsApp(base64Image: base64Image, msg: msg);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/whatApp.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.whatsapp,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchInBrowser("http://instagram.com/tahadde");
                      //InstagramShare.share('/', 'image');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/instagram.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.instagram,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch("mailto:info@tahadde.com");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/mailshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.email,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      makePhoneCall("tel:");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/callshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.callus,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.chooseAccount);
  }
}
