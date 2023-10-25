import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/carousel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../player/HomeScreen/Home/shimmerWidgets.dart';
import '../../../../../utils/utils.dart';

class PitchOwnerMainHome extends StatefulWidget {
  const PitchOwnerMainHome({super.key});

  @override
  State<PitchOwnerMainHome> createState() => _PitchOwnerMainHomeState();
}

class _PitchOwnerMainHomeState extends State<PitchOwnerMainHome> {
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  List<MyVenueModelClass> _pitchDetail = [];
  bool _internet = true;
  int initial = 0;
  int clicked = 1;

  loadMyPitch() async {
    await _networkCalls.myVenues(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _pitchDetail = event;
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
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (_internet == true) {
        _isLoading = false;
        loadMyPitch();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return _internet
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: const Color(0xff050505),
              appBar: AppBar(
                elevation: 2,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    SizedBox(
                        height: 40 * fem,
                        width: 40 * fem,
                        child: Image.asset(
                          'assets/images/T.png',
                          color: Colors.greenAccent,
                        )),
                    SizedBox(
                      width: sizeWidth * 0.001,
                    ),
                    Text(
                      AppLocalizations.of(context)!.tahaddi,
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.25 * ffem / fem,
                        letterSpacing: -0.2 * fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
                // bottom: TabBar(
                //   indicatorSize: TabBarIndicatorSize.tab,
                //   unselectedLabelColor: AppColors.grey,
                //   dividerColor: AppColors.red,
                //   isScrollable: true,
                //   physics: AlwaysScrollableScrollPhysics(),
                //   // indicator: BoxDecoration(
                //   //   color: Color(0xff1d7e55),
                //   //   borderRadius: BorderRadius.circular(8),
                //   // ),
                //   padding:
                //       EdgeInsets.symmetric(vertical: sizeHeight * 0.003),
                //   tabs: [
                //     Center(
                //         child: Padding(
                //       padding: EdgeInsets.all(sizeHeight * 0.012),
                //       child: Text(
                //         AppLocalizations.of(context)!.academyOnly,
                //       ),
                //     )),
                //     Center(
                //         child: Padding(
                //       padding: EdgeInsets.all(sizeHeight * 0.012),
                //       child: Text(
                //         AppLocalizations.of(context)!.innovative,
                //       ),
                //     )),
                //   ],
                // ),
              ),
              floatingActionButton: SpeedDial(
                elevation: 3,
                label: Text(
                  'Add',
                  // AppLocalizations.of(context)!.add,
                  style: TextStyle(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.black,
                      fontSize: 11),
                ),
                animationCurve: Curves.easeInOutCirc,
                backgroundColor: MyAppState.mode == ThemeMode.light
                    ? AppColors.darkTheme
                    : Colors.tealAccent.shade100,
                onPress: () {
                  navigateToSports();
                },
                child: Icon(
                  Icons.add,
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.black,
                  size: sizeHeight * 0.03,
                ),
              ),
              body: _isLoading
                  ? ShimmerWidgets().buildShimmer(fem, context, _pitchDetail)
                  : LayoutBuilder(
                      builder: (context, constraints) => ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: constraints.maxHeight),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: sizeHeight * 0.21,
                                width: sizeWidth,
                                child: Carousel(image: const [
                                  'https://tse1.mm.bing.net/th?id=OIP.PVOhIhZ2cfFJVWI3U9WG6AHaE7&pid=Api&P=0&h=220',
                                  'https://tse1.mm.bing.net/th?id=OIP.PVOhIhZ2cfFJVWI3U9WG6AHaE7&pid=Api&P=0&h=220',
                                ]),
                              ),
                              SizedBox(
                                height: sizeHeight * 0.01,
                              ),
                              Material(
                                  color: AppColors.transparent,
                                  child: Container(
                                    height: sizeHeight * 0.07,
                                    color: AppColors.black,
                                    constraints: BoxConstraints(
                                        maxHeight: sizeHeight * 0.06),
                                    child: TabBar(
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      unselectedLabelColor: AppColors.grey,
                                      dividerColor: AppColors.red,
                                      isScrollable: true,
                                      physics: AlwaysScrollableScrollPhysics(),
                                      // indicator: BoxDecoration(
                                      //   color: Color(0xff1d7e55),
                                      //   borderRadius: BorderRadius.circular(8),
                                      // ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: sizeHeight * 0.003),
                                      tabs: [
                                        Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeHeight * 0.01),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .academyOnly,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        )),
                                        Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(
                                              sizeHeight * 0.012),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .innovative,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: constraints.maxHeight * 0.75),
                                child: TabBarView(children: [
                                  RefreshIndicator(
                                    displacement: 200,
                                    onRefresh: () async {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                          }
                                          loadMyPitch();
                                        } else {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                        color: AppColors.black,
                                        child: Container(
                                          height: sizeHeight * 0.7,
                                          width: sizeWidth,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * 0.039),
                                          decoration: BoxDecoration(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.white
                                                  : AppColors.darkTheme,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: sizeHeight * 0.01,
                                                  horizontal:
                                                      sizeWidth * 0.014),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 12 * fem,
                                                        top: 12 * fem),
                                                    width: double.infinity,
                                                    child: InkWell(
                                                      onTap: () {
                                                        var details = {
                                                          "bool": false
                                                        };
                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .academy,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? const Color(
                                                                        0xff050505)
                                                                    : const Color(
                                                                        0xffffffff)),
                                                      ),
                                                    ),
                                                  ),
                                                  ...List.generate(
                                                    _pitchDetail.length > 2
                                                        ? 3
                                                        : _pitchDetail.length,
                                                    (index) => Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  sizeHeight *
                                                                      0.01),
                                                      child: Container(
                                                        width: sizeWidth * 0.9,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .grey200
                                                              : AppColors
                                                                  .containerColorW12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child:
                                                                  DefaultTextStyle(
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: MyAppState.mode ==
                                                                            ThemeMode
                                                                                .light
                                                                        ? AppColors
                                                                            .black
                                                                        : AppColors
                                                                            .white),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal: sizeWidth *
                                                                              0.02,
                                                                          vertical:
                                                                              sizeHeight * 0.005),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            '${AppLocalizations.of(context)!.status}:',
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                                                                          ),
                                                                          Text(
                                                                            _pitchDetail[index].isVerified!
                                                                                ? AppLocalizations.of(context)!.verified
                                                                                : _pitchDetail[index].isDecline!
                                                                                    ? AppLocalizations.of(context)!.rejected
                                                                                    : AppLocalizations.of(context)!.inReview,
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.redAccent),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              12),
                                                                      child:
                                                                          cachedNetworkImage(
                                                                        height: sizeHeight *
                                                                            0.193,
                                                                        imageFit:
                                                                            BoxFit.fill,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        cuisineImageUrl:
                                                                            _pitchDetail[index].pitchImage.toString() ??
                                                                                "",
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: sizeHeight *
                                                                          0.005,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        cachedNetworkImage(
                                                                          height:
                                                                              sizeHeight * 0.02,
                                                                          imageFit:
                                                                              BoxFit.fill,
                                                                          width:
                                                                              sizeWidth * 0.05,
                                                                          cuisineImageUrl:
                                                                              _pitchDetail[index].sportImage.toString() ?? "",
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              sizeWidth * 0.01,
                                                                        ),
                                                                        Text(
                                                                          _pitchDetail[index]
                                                                              .venueName
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .copyWith(color: AppColors.black),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          bottom: sizeHeight *
                                                                              0.008,
                                                                          left: sizeWidth *
                                                                              0.007),
                                                                      child:
                                                                          Text(
                                                                        _pitchDetail[index]
                                                                            .location!,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .titleSmall!
                                                                            .copyWith(color: AppColors.black),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.01,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    0.01),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.bottomLeft,
                                                      child: InkWell(
                                                        onTap: () {
                                                          navigateToVenuesViewMore(
                                                              _pitchDetail);
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .viewAll,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    color: AppColors
                                                                        .green,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.04,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                  RefreshIndicator(
                                    displacement: 200,
                                    onRefresh: () async {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                          }
                                          loadMyPitch();
                                        } else {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: AppColors.black,
                                      child: Container(
                                          height: sizeHeight,
                                          width: sizeWidth,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * 0.039),
                                          decoration: BoxDecoration(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.white
                                                  : AppColors.darkTheme,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: sizeHeight * 0.01,
                                                horizontal: sizeWidth * 0.014),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 12 * fem,
                                                        top: 12 * fem),
                                                    width: double.infinity,
                                                    child: InkWell(
                                                      onTap: () {
                                                        var details = {
                                                          "bool": false
                                                        };
                                                      },
                                                      child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .innovative,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? const Color(
                                                                          0xff050505)
                                                                      : const Color(
                                                                          0xffffffff))),
                                                    ),
                                                  ),
                                                  ...List.generate(
                                                    _pitchDetail.length > 2
                                                        ? 1
                                                        : _pitchDetail.length,
                                                    (index) => InkWell(
                                                      onTap: () {
                                                        navigateToSports();
                                                      },
                                                      child: Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    sizeHeight *
                                                                        0.01),
                                                        child: Container(
                                                          width:
                                                              sizeWidth * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .grey200
                                                                : AppColors
                                                                    .containerColorW12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                child:
                                                                    DefaultTextStyle(
                                                                  style: Theme.of(
                                                                          context)
                                                                      .textTheme
                                                                      .bodyMedium!
                                                                      .copyWith(
                                                                          color: MyAppState.mode == ThemeMode.light
                                                                              ? AppColors.black
                                                                              : AppColors.white),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: sizeWidth *
                                                                                0.02,
                                                                            vertical:
                                                                                sizeHeight * 0.005),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text('${AppLocalizations.of(context)!.status}:'),
                                                                            Text(
                                                                              _pitchDetail[index].isVerified! ? AppLocalizations.of(context)!.verified : AppLocalizations.of(context)!.inReview,
                                                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.redAccent),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        child:
                                                                            cachedNetworkImage(
                                                                          height:
                                                                              sizeHeight * 0.193,
                                                                          imageFit:
                                                                              BoxFit.fill,
                                                                          width: MediaQuery.of(context)
                                                                              .size
                                                                              .width,
                                                                          cuisineImageUrl:
                                                                              _pitchDetail[index].pitchImage.toString() ?? "",
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: sizeHeight *
                                                                            0.005,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          cachedNetworkImage(
                                                                            height:
                                                                                sizeHeight * 0.02,
                                                                            imageFit:
                                                                                BoxFit.fill,
                                                                            width:
                                                                                sizeWidth * 0.05,
                                                                            cuisineImageUrl:
                                                                                _pitchDetail[index].sportImage.toString() ?? "",
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                sizeWidth * 0.01,
                                                                          ),
                                                                          Text(_pitchDetail[index]
                                                                              .venueName
                                                                              .toString()),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            bottom: sizeHeight *
                                                                                0.008,
                                                                            left:
                                                                                sizeWidth * 0.007),
                                                                        child: Text(
                                                                            _pitchDetail[index]
                                                                                .location!,
                                                                            style:
                                                                                Theme.of(context).textTheme.titleSmall),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              // ...List.generate(
              //   widget.bookPitchData.length,
              //       (index) => InkWell(
              //     onTap: () {
              //       dynamic detail = {
              //         "pitchId": widget.bookPitchData[index]["id"] ?? 0,
              //         "subPitchId":
              //         widget.bookPitchData[index]["pitchType"][0] ?? 0
              //       };
              //       navigateToGroundDetail(detail);
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.only(bottom: 16 * fem),
              //       child: Container(
              //         padding: EdgeInsets.only(bottom: 16 * fem),
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           color: mode == ThemeMode.light
              //               ? const Color(0xffffffff)
              //               : const Color(0xff373737),
              //           borderRadius: BorderRadius.circular(15 * fem),
              //           boxShadow: [
              //             BoxShadow(
              //               color: const Color(0x0f050818),
              //               offset: Offset(10 * fem, 40 * fem),
              //               blurRadius: 30 * fem,
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               margin: EdgeInsets.only(bottom: 12 * fem),
              //               width: 327 * fem,
              //               height: 145 * fem,
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(15 * fem),
              //                   topRight: Radius.circular(15 * fem),
              //                 ),
              //                 child: cachedNetworkImage(
              //                   cuisineImageUrl: widget
              //                       .bookPitchData[index]["bookpitchfiles"]
              //                   ["files"]
              //                       .isNotEmpty
              //                       ? widget.bookPitchData[index]
              //                   ["bookpitchfiles"]["files"][0]["filePath"]
              //                       : Container(),
              //                   height: 150,
              //                   width: fem,
              //                   imageFit: BoxFit.fitWidth,
              //                   errorFit: BoxFit.fitHeight,
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding:
              //               EdgeInsets.only(left: 4.0 * fem, bottom: 2 * fem),
              //               child: Text(
              //                 widget.bookPitchData[index]["name"],
              //                 style: SafeGoogleFont(
              //                   'Inter',
              //                   fontSize: 20 * ffem,
              //                   fontWeight: FontWeight.w600,
              //                   height: 1.25 * ffem / fem,
              //                   letterSpacing: -0.2 * fem,
              //                   color: mode == ThemeMode.light
              //                       ? const Color(0xff050505)
              //                       : const Color(0xffffffff),
              //                 ),
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.only(
              //                       right: 10 * fem, left: 4 * fem),
              //                   width: 24 * fem,
              //                   height: 24 * fem,
              //                   child: Image.asset(
              //                     'assets/light-design/images/icon-bus.png',
              //                     width: 24 * fem,
              //                     height: 24 * fem,
              //                   ),
              //                 ),
              //                 Text(
              //                   AppLocalizations.of(context)!.showDirections,
              //                   style: SafeGoogleFont(
              //                     'Inter',
              //                     fontSize: 13 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3846153846 * ffem / fem,
              //                     color: const Color(0xff686868),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ),
          )
        : Column(
            children: [
              Expanded(
                child: InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (_internet == true) {
                        _isLoading = false;
                        // loadLeagueData();
                        loadMyPitch();
                        // loadTournamentData();
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  },
                ),
              ),
            ],
          );
  }

  void navigateToVenuesViewMore(event) {
    Navigator.pushNamed(context, RouteNames.viewMoreVenue, arguments: event);
  }

  void navigateToSports() {
    Navigator.pushNamed(context, RouteNames.selectSport, arguments: true);
  }
}
