import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../common_widgets/internet_loss.dart';
import '../localizations.dart';
import '../network/network_calls.dart';
import 'routingConstant.dart';
import 'utility.dart';

class NotificationEmpty extends StatefulWidget {
  @override
  _NotificationEmptyState createState() => _NotificationEmptyState();
}

class _NotificationEmptyState extends State<NotificationEmpty>
    with AutomaticKeepAliveClientMixin {
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List? detail = [];
  bool _isLoading = true;
  late bool _internet;
  late bool _auth;

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
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(
      onSuccess: (msg) async {
        _internet = msg;
        _auth = (await checkAuthorizaton())!;
        if (mounted) {
          msg
              ? _auth
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
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      displacement: 200,
      onRefresh: () async {
        _networkCalls.checkInternetConnectivity(
          onSuccess: (msg) async {
            _internet = msg;
            _auth = (await checkAuthorizaton())!;
            if (mounted) {
              msg
                  ? _auth
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
        backgroundColor: const Color(0XFFD6D6D6),
        body: Column(
          children: [
            buildAppBar(
                language: AppLocalizations.of(context)!.locale,
                title: AppLocalizations.of(context)!.notificationC,
                height: sizeHeight,
                width: sizeWidth),
            _isLoading
                ? Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                          child: _shimmerCard(),
                        ),
                        itemCount: 5,
                      ),
                    ),
                  )
                : _internet
                    ? detail!.isEmpty
                        ? Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics()),
                              child: SizedBox(
                                height: sizeHeight * .6,
                                width: sizeWidth,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30),
                                      child: Container(
                                        color: Colors.white,
                                        height: sizeHeight * .5,
                                        width: sizeWidth,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
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
                                    flaxibleGap(4),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Expanded(
                            child: SizedBox(
                                height: sizeHeight * .65,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  itemCount: detail![0]["currentNotification"]
                                          .length +
                                      detail![0]["previousNotfication"].length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, blockIdx) {
                                    int current = detail![0]
                                            ["currentNotification"]
                                        .length;
                                    int previous = detail![0]
                                            ["previousNotfication"]
                                        .length;
                                    return GestureDetector(
                                      onTap: () {
                                        // if (detail[0]["currentNotification"]
                                        //     .isEmpty) {
                                        //   if (detail[0]["previousNotfication"]
                                        //               [blockIdx]
                                        //           ["notificationFor"] ==
                                        //       "team") {
                                        //     if (detail[0]["previousNotfication"]
                                        //         [blockIdx]["is_clickable"]) {
                                        //       navigateToTeam();
                                        //     } else {
                                        //       showMessage(
                                        //           AppLocalizations.of(context)
                                        //               .youarelongermemberteam,
                                        //           scaffoldkey);
                                        //     }
                                        //   } else if (detail[0][
                                        //                       "previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "created" &&
                                        //       detail[0]["previousNotfication"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(1);
                                        //   } else if (detail[0][
                                        //                       "previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "verified" &&
                                        //       detail[0]["previousNotfication"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(0);
                                        //   } else if (detail[0][
                                        //                       "previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["previousNotfication"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "rejected" &&
                                        //       detail[0]["previousNotfication"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(1);
                                        //   }
                                        // } else if (detail[0]
                                        //         ["previousNotfication"]
                                        //     .isEmpty) {
                                        //   if (detail[0]["currentNotification"]
                                        //               [blockIdx]
                                        //           ["notificationFor"] ==
                                        //       "team") {
                                        //     if (detail[0]["currentNotification"]
                                        //         [blockIdx]["is_clickable"]) {
                                        //       navigateToTeam();
                                        //     } else {
                                        //       showMessage(
                                        //           AppLocalizations.of(context)
                                        //               .youarelongermemberteam,
                                        //           scaffoldkey);
                                        //     }
                                        //   } else if (detail[0][
                                        //                       "currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "created" &&
                                        //       detail[0]["currentNotification"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(1);
                                        //   } else if (detail[0][
                                        //                       "currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "verified" &&
                                        //       detail[0]["currentNotification"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(0);
                                        //   } else if (detail[0][
                                        //                       "currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationFor"] ==
                                        //           "pitch" &&
                                        //       detail[0]["currentNotification"]
                                        //                   [blockIdx]
                                        //               ["notificationType"] ==
                                        //           "rejected" &&
                                        //       detail[0]["currentNotification"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //     navigateToInreview(1);
                                        //   }
                                        // } else {
                                        //   if (blockIdx < current) {
                                        //     if (detail[0]["currentNotification"]
                                        //                 [blockIdx]
                                        //             ["notificationFor"] ==
                                        //         "team") {
                                        //       if (detail[0]
                                        //               ["currentNotification"]
                                        //           [blockIdx]["is_clickable"]) {
                                        //         navigateToTeam();
                                        //       } else {
                                        //         showMessage(
                                        //             AppLocalizations.of(context)
                                        //                 .youarelongermemberteam,
                                        //             scaffoldkey);
                                        //       }
                                        //     } else if (detail[0][
                                        //                         "currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationType"] ==
                                        //             "created" &&
                                        //         detail[0]["currentNotification"]
                                        //                 [blockIdx]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(1);
                                        //     } else if (detail[0][
                                        //                         "currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationType"] ==
                                        //             "verified" &&
                                        //         detail[0]["currentNotification"]
                                        //                 [blockIdx]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(0);
                                        //     } else if (detail[0][
                                        //                         "currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["currentNotification"]
                                        //                     [blockIdx]
                                        //                 ["notificationType"] ==
                                        //             "rejected" &&
                                        //         detail[0]["currentNotification"]
                                        //                 [blockIdx]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(1);
                                        //     }
                                        //   } else {
                                        //     if (detail[0]["previousNotfication"]
                                        //                 [blockIdx - current]
                                        //             ["notificationFor"] ==
                                        //         "team") {
                                        //       if (detail[0][
                                        //                   "previousNotfication"]
                                        //               [blockIdx - current]
                                        //           ["is_clickable"]) {
                                        //         navigateToTeam();
                                        //       } else {
                                        //         showMessage(
                                        //             AppLocalizations.of(context)
                                        //                 .youarelongermemberteam,
                                        //             scaffoldkey);
                                        //       }
                                        //     } else if (detail[0][
                                        //                         "previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationType"] ==
                                        //             "created" &&
                                        //         detail[0]["previousNotfication"]
                                        //                 [blockIdx - current]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(1);
                                        //     } else if (detail[0][
                                        //                         "previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationType"] ==
                                        //             "verified" &&
                                        //         detail[0]["previousNotfication"]
                                        //                 [blockIdx - current]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(0);
                                        //     } else if (detail[0][
                                        //                         "previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationFor"] ==
                                        //             "pitch" &&
                                        //         detail[0]["previousNotfication"]
                                        //                     [blockIdx - current]
                                        //                 ["notificationType"] ==
                                        //             "rejected" &&
                                        //         detail[0]["previousNotfication"]
                                        //                 [blockIdx - current]
                                        //             ["is_clickable"]) {
                                        //       navigateToInreview(1);
                                        //     }
                                        //   }
                                        // }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            blockIdx == 0 && current != 0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, bottom: 5),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .newC,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF032040),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  )
                                                : Container(),
                                            current == 0 || blockIdx >= current
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0) //
                                                                  ),
                                                        ),
                                                        height:
                                                            sizeHeight * .12,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sizeHeight *
                                                                          .01),
                                                              child: ClipRRect(
                                                                  //clipBehavior: Clip.hardEdge,
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          50.0),
                                                                  child: detail![0]["currentNotification"][blockIdx]["image"][0]["filePath"] ==
                                                                          null
                                                                      ? Image
                                                                          .asset(
                                                                          "assets/images/profile.png",
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          height:
                                                                              sizeHeight * .06,
                                                                          width:
                                                                              sizeHeight * .06,
                                                                        )
                                                                      : cachedNetworkImage(
                                                                          height: sizeHeight *
                                                                              .06,
                                                                          width: sizeHeight *
                                                                              .06,
                                                                          cuisineImageUrl:
                                                                              detail![0]["currentNotification"][blockIdx]["image"][0]["filePath"])),
                                                            ),
                                                            Container(
                                                              height:
                                                                  sizeHeight *
                                                                      .06,
                                                              width: 1,
                                                              color: const Color(
                                                                  0XFFD8D8D8),
                                                            ),
                                                            Expanded(
                                                              child: SizedBox(
                                                                  width:
                                                                      sizeWidth *
                                                                          .4,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                            width: sizeWidth *
                                                                                .7,
                                                                            child:
                                                                                Text(
                                                                              detail![0]["currentNotification"][blockIdx]["notificationMessage"] == null ? "" : detail![0]["currentNotification"][blockIdx]["notificationMessage"]["message"] ?? "",
                                                                              style: const TextStyle(color: Color(0XFF424242), fontSize: 14),
                                                                              maxLines: 2,
                                                                            )),
                                                                        Text(
                                                                            detail![0]["currentNotification"][blockIdx]["createdDatetime"] == null
                                                                                ? ""
                                                                                : "${detail![0]["currentNotification"][blockIdx]["createdDatetime"]}",
                                                                            style:
                                                                                const TextStyle(color: Color(0XFFADADAD), fontSize: 12))
                                                                      ],
                                                                    ),
                                                                  )),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                            blockIdx == current && previous != 0
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20, bottom: 5),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .previous,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF032040),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  )
                                                : Container(),
                                            previous == 0 || blockIdx < current
                                                ? Container()
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 1),
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0) //
                                                                ),
                                                      ),
                                                      height: sizeHeight * .12,
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    sizeHeight *
                                                                        .01),
                                                            child: ClipRRect(
                                                                //clipBehavior: Clip.hardEdge,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50.0),
                                                                child: detail![0]["previousNotfication"][blockIdx -
                                                                                current]["image"]
                                                                            [
                                                                            "filePath"] ==
                                                                        null
                                                                    ? Image
                                                                        .asset(
                                                                        "assets/images/profile.png",
                                                                        fit: BoxFit
                                                                            .fill,
                                                                        height: sizeHeight *
                                                                            .06,
                                                                        width: sizeHeight *
                                                                            .06,
                                                                      )
                                                                    : cachedNetworkImage(
                                                                        height: sizeHeight *
                                                                            .06,
                                                                        width: sizeHeight *
                                                                            .06,
                                                                        cuisineImageUrl:
                                                                            detail![0]["previousNotfication"][blockIdx -
                                                                                current]["image"]["filePath"],
                                                                      )),
                                                          ),
                                                          Container(
                                                            height: sizeHeight *
                                                                .06,
                                                            width: 1,
                                                            color: const Color(
                                                                0XFFD8D8D8),
                                                          ),
                                                          Expanded(
                                                            child: SizedBox(
                                                              width: sizeWidth *
                                                                  .4,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SizedBox(
                                                                        width: sizeWidth *
                                                                            .7,
                                                                        child:
                                                                            Text(
                                                                          detail![0]["previousNotfication"][blockIdx - current]["notificationMessage"] == null
                                                                              ? ""
                                                                              : detail![0]["previousNotfication"][blockIdx - current]["notificationMessage"]["message"] ?? "",
                                                                          style: const TextStyle(
                                                                              color: Color(0XFF424242),
                                                                              fontSize: 14),
                                                                          maxLines:
                                                                              2,
                                                                        )),
                                                                    Text(
                                                                        detail![0]["previousNotfication"][blockIdx - current]["createdDatetime"] ==
                                                                                null
                                                                            ? ""
                                                                            : "${detail![0]["previousNotfication"][blockIdx - current]["createdDatetime"]}",
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0XFFADADAD),
                                                                            fontSize: 12))
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )),
                          )
                    : Expanded(
                        child: SizedBox(
                          height: sizeHeight * .5,
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
                      ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // image: Image.network(profileDetail.profile_pic),
                ),
              ),
            ),
            flaxibleGap(2),
            Container(
              height: 40,
              width: 1,
              color: const Color(0XFFD8D8D8),
            ),
            flaxibleGap(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }

  void navigateToTeam() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.team, (Route<dynamic> route) => false);
  }

  void navigateToInreview(int index) {
    Navigator.pushNamed(context, RouteNames.myPitches, arguments: index);
  }
}
