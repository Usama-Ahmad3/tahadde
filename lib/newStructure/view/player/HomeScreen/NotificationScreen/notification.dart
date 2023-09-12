import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/NotificationScreen/notificationShimmer.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../utils.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  List? detail = [];
  bool _isLoading = true;
  bool? _internet;
  bool? _auth;

  loadNotification() async {
    await _networkCalls.notificationGet(
      onSuccess: (msg) {
        if (mounted) {
          setState(() {
            detail = msg;
            _isLoading = false;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(
      onSuccess: (msg) async {
        _internet = msg;
        _auth = (await checkAuthorizaton());
        if (mounted) {
          msg
              ? _auth!
                  ? loadNotification()
                  : {
                      if (mounted)
                        setState(() {
                          _isLoading = false;
                        })
                    }
              : {
                  if (mounted)
                    setState(() {
                      _isLoading = false;
                    })
                };
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mode = MyAppState.mode;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RefreshIndicator(
        displacement: 200,
        onRefresh: () async {
          _networkCalls.checkInternetConnectivity(
            onSuccess: (msg) async {
              _internet = msg;
              _auth = (await checkAuthorizaton());
              if (mounted) {
                msg
                    ? _auth!
                        ? loadNotification()
                        : {
                            if (mounted)
                              setState(() {
                                _isLoading = false;
                              })
                          }
                    : {
                        if (mounted)
                          setState(() {
                            _isLoading = false;
                          })
                      };
              }
            },
          );
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: _isLoading
              ? Padding(
                  padding: EdgeInsets.only(top: 120.0 * fem),
                  child: ListView.builder(
                    itemBuilder: (_, __) => Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                      child: NotificationShimmer.shimmerCard(),
                    ),
                    itemCount: 5,
                  ),
                )
              : _internet!
                  ? Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 55),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 83.5 * fem, 0 * fem),
                                    width: 40 * fem,
                                    height: 40 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/icon-7AR.png',
                                      width: 40 * fem,
                                      height: 40 * fem,
                                    ),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.notificationC,
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.4705882353 * ffem / fem,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        detail!.isEmpty
                            ? Positioned(
                                top: 200 * fem,
                                left: 0,
                                right: 0,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 18.0),
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(
                                        parent:
                                            AlwaysScrollableScrollPhysics()),
                                    child: Container(
                                      height: 400 * fem,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          flaxibleGap(3),
                                          SizedBox(
                                            height: 100,
                                            child: Lottie.asset(
                                              'assets/lottiefiles/notification.json',
                                            ),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .notificationDec,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0XFFB7B7B7),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          flaxibleGap(5),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 680 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30 * fem),
                                        topLeft: Radius.circular(30 * fem)),
                                    // ignore: prefer_const_constructors
                                    color: mode == ThemeMode.light
                                        ? const Color(0xfff2f2f2)
                                        : const Color(0xff686868),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 8.0 * fem),
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(
                                          parent:
                                              AlwaysScrollableScrollPhysics()),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 12 * fem,
                                                horizontal: 24 * fem),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .newC,
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: mode == ThemeMode.light
                                                      ? const Color(0xff686868)
                                                      : const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                          ),
                                          ...List.generate(
                                              detail![0]["currentNotification"]
                                                      .length +
                                                  detail![0][
                                                          "previousNotfication"]
                                                      .length, (index) {
                                            int current = detail![0]
                                                    ["currentNotification"]
                                                .length;
                                            // int previous = detail![0]
                                            //         ["previousNotfication"]
                                            //     .length;
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 18.0,
                                                      vertical: 5),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                15 * fem,
                                                            vertical: 12 * fem),
                                                    width: double.infinity,
                                                    height: 62 * fem,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0xffffffff)
                                                              : Colors.grey),
                                                      color: mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0xffffffff)
                                                          : const Color(
                                                              0xff686868),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15 * fem),
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // iconpL1 (I303:11933;303:11890)
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      8 * fem),
                                                          width: 32 * fem,
                                                          height: 32 * fem,
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50.0),
                                                              child: detail![0][
                                                                              "previousNotfication"]
                                                                          [
                                                                          index -
                                                                              current]["image"]["filePath"] ==
                                                                      null
                                                                  ? Image.asset(
                                                                      "assets/images/profile.png",
                                                                      fit: BoxFit
                                                                          .fill,
                                                                      height:
                                                                          .06 *
                                                                              fem,
                                                                      width: .06 *
                                                                          fem,
                                                                    )
                                                                  : cachedNetworkImage(
                                                                      height:
                                                                          .06 *
                                                                              fem,
                                                                      width: .06 *
                                                                          fem,
                                                                      cuisineImageUrl: detail![0]
                                                                              [
                                                                              "previousNotfication"]
                                                                          [
                                                                          index -
                                                                              current]["image"]["filePath"],
                                                                    )),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      26 * fem),
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 175 * fem,
                                                          ),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    15 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height:
                                                                    1.3333333333 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                              children: [
                                                                TextSpan(
                                                                  text: detail![0]["previousNotfication"][index - current]
                                                                              [
                                                                              "notificationMessage"] ==
                                                                          null
                                                                      ? ""
                                                                      : detail![0]["previousNotfication"][index - current]["notificationMessage"]
                                                                              [
                                                                              "message"] ??
                                                                          "",
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        13 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    height:
                                                                        1.3846153846 *
                                                                            ffem /
                                                                            fem,
                                                                    color: mode ==
                                                                            ThemeMode
                                                                                .light
                                                                        ? const Color(
                                                                            0xff050505)
                                                                        : const Color(
                                                                            0xffffffff),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          detail![0]["previousNotfication"]
                                                                          [
                                                                          index -
                                                                              current]
                                                                      [
                                                                      "createdDatetime"] ==
                                                                  null
                                                              ? ""
                                                              : detail![0]["previousNotfication"]
                                                                          [
                                                                          index -
                                                                              current]
                                                                      [
                                                                      "createdDatetime"]
                                                                  .toString()
                                                                  .substring(
                                                                      0, 10),
                                                          textAlign:
                                                              TextAlign.right,
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 11 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            height:
                                                                1.3636363636 *
                                                                    ffem /
                                                                    fem,
                                                            color: mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? const Color(
                                                                    0xff050505)
                                                                : const Color(
                                                                    0xffffffff),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: index == 3
                                                        ? 16 * fem
                                                        : 0 * fem,
                                                  ),
                                                  index == 3
                                                      ? Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      12 * fem,
                                                                  horizontal:
                                                                      24 * fem),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Earlier',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    15 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                height:
                                                                    1.3333333333 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff686868),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: InternetLoss(
                              onChange: () {
                                _networkCalls.checkInternetConnectivity(
                                  onSuccess: (msg) {
                                    _internet = msg;
                                    if (msg == true) loadNotification();
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
        ));
  }
}
