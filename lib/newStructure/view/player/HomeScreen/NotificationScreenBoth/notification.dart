import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../../../../utils/utils.dart';
import 'notificationShimmer.dart';

class NotificationScreen extends StatefulWidget {
  bool player;
  NotificationScreen({super.key, this.player = true});

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
      onSuccess: (msg) async {
        if (mounted) {
          detail = await msg;
          _isLoading = false;
          setState(() {});
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
                  ? await loadNotification()
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                        ? await loadNotification()
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
          appBar: appBarWidget(
            sizeWidth: width,
            sizeHeight: height,
            context: context,
            title: AppLocalizations.of(context)!.notification,
            back: true,
          ),
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
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          detail!.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: height * 0.2,
                                    ),
                                    SizedBox(
                                      height: width * .4,
                                      width: height * .4,
                                      child: Lottie.asset(
                                        'assets/lottiefiles/notification.json',
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .notificationDec,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: const Color(0XFFB7B7B7),
                                              fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )
                              : Container(
                                  height: widget.player ? 700 * fem : 650 * fem,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30 * fem),
                                        topLeft: Radius.circular(30 * fem)),
                                    // ignore: prefer_const_constructors
                                    color: mode == ThemeMode.light
                                        ? const Color(0xfff2f2f2)
                                        : AppColors.darkTheme,
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
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.062),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .newC,
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3333333333 *
                                                          ffem /
                                                          fem,
                                                      color: mode ==
                                                              ThemeMode.light
                                                          ? AppColors.darkTheme
                                                          : const Color(
                                                              0xffffffff),
                                                    ),
                                              ),
                                            ),
                                          ),
                                          ...List.generate(
                                              detail![0]["currentNotification"]
                                                          .length +
                                                      detail![0][
                                                              "previousNotfication"]
                                                          .length ??
                                                  0, (index) {
                                            int current = detail![0]
                                                    ["currentNotification"]
                                                .length;
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
                                                            horizontal: 8 * fem,
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
                                                              : AppColors.grey),
                                                      color: mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0xffffffff)
                                                          : AppColors
                                                              .containerColorW12,
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
                                                              child:
                                                                  // detail![0]["previousNotfication"]
                                                                  //                 [index == 0 ? 0 : index - current][
                                                                  //             'notificationFor'] ==
                                                                  //         'team'
                                                                  // ? detail![0]["previousNotfication"][index == 0 ? 0 : index - current]["image"]["filePath"] == null
                                                                  // ?
                                                                  Image.asset(
                                                                "assets/images/profile.png",
                                                                fit:
                                                                    BoxFit.fill,
                                                                height:
                                                                    .06 * fem,
                                                                width:
                                                                    .05 * fem,
                                                              )),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      26 * fem),
                                                          constraints:
                                                              BoxConstraints(
                                                            maxWidth: 185 * fem,
                                                          ),
                                                          child: RichText(
                                                            text: TextSpan(
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
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
                                                                  text: detail![0]["previousNotfication"][index < 0 || index == 0 ? 0 : index - current]
                                                                              [
                                                                              "notificationMessage"] ==
                                                                          null
                                                                      ? ""
                                                                      : detail![0]
                                                                              [
                                                                              "previousNotfication"][index < 0 ||
                                                                                  index == 0
                                                                              ? 0
                                                                              : index - current]["notificationMessage"]["message"] ??
                                                                          "",
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .titleSmall!
                                                                      .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        height: 1.3846153846 *
                                                                            ffem /
                                                                            fem,
                                                                        color: mode ==
                                                                                ThemeMode.light
                                                                            ? const Color(0xff050505)
                                                                            : const Color(0xffffffff),
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          detail![0]["previousNotfication"][index < 0 || index == 0
                                                                          ? 0
                                                                          : index - current]
                                                                      [
                                                                      "createdDatetime"] ==
                                                                  null
                                                              ? ""

                                                              ///6
                                                              : detail![0]
                                                                      ["previousNotfication"][index < 0 ||
                                                                          index ==
                                                                              0
                                                                      ? 0
                                                                      : index -
                                                                          current]["createdDatetime"]
                                                                  .toString()
                                                                  .substring(0, 10),
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
                                                            vertical: 12 * fem,
                                                          ),
                                                          child: Align(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: Text(
                                                              'Earlier',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height:
                                                                        1.3333333333 *
                                                                            ffem /
                                                                            fem,
                                                                    color: MyAppState.mode ==
                                                                            ThemeMode
                                                                                .light
                                                                        ? AppColors
                                                                            .darkTheme
                                                                        : AppColors
                                                                            .white,
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
                                )
                        ],
                      ),
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
