import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/main_home/view_all.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../player/HomeScreen/Home/shimmerWidgets.dart';
import '../../../../utils.dart';

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
    return RefreshIndicator(
      displacement: 200,
      onRefresh: () async {
        _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
          _internet = msg;
          if (_internet == true) {
            _isLoading = false;
            loadMyPitch();
          }
          setState(() {
            _isLoading = false;
          });
        });
      },
      child: _internet
          ? Scaffold(
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
              ),
              body: _isLoading
                  ? ShimmerWidgets().buildShimmer(fem, context, _pitchDetail)
                  : ListView(
                      children: [
                        SizedBox(
                          height: sizeHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeHeight * 0.03),
                          child: SizedBox(
                            height: sizeHeight * 0.19,
                            width: double.infinity,
                            child: const Placeholder(),
                          ),
                        ),
                        SizedBox(
                          height: sizeHeight * 0.01,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: sizeHeight * 0.63,
                          margin: EdgeInsets.only(top: sizeHeight * 0.02),
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * 0.07,
                              vertical: sizeHeight * 0.03),
                          decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? const Color(0xffffffff)
                                : const Color(0xff5A5C60),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ...List.generate(
                                        _pitchDetail.length,
                                        // _pitchDetail.length,
                                        (index) => index == 0
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    right: sizeWidth * 0.022),
                                                child: InkWell(
                                                  onTap: () {
                                                    navigateToSports();
                                                  },
                                                  child: Container(
                                                    width: sizeWidth * 0.85,
                                                    height: sizeHeight * 0.22,
                                                    decoration: BoxDecoration(
                                                      image: const DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: AssetImage(
                                                              "assets/images/addnew.png")),
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.grey.shade200
                                                          : Colors.white12,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        SizedBox(
                                                          height:
                                                              sizeHeight * 0.02,
                                                        ),
                                                        Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .academy,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    sizeHeight *
                                                                        0.023,
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? const Color(
                                                                        0xff686868)
                                                                    : Colors
                                                                        .white70)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        sizeWidth * 0.01),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.grey.shade200
                                                        : const Color(
                                                            0xff373737),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: sizeWidth * 0.85,
                                                        height:
                                                            sizeHeight * 0.196,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    15),
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                          ),
                                                          child:
                                                              cachedNetworkImage(
                                                            cuisineImageUrl:
                                                                _pitchDetail[
                                                                        index]
                                                                    .pitchImage,
                                                            imageFit:
                                                                BoxFit.fill,
                                                            errorFit: BoxFit
                                                                .fitHeight,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        _pitchDetail[index]
                                                            .venueName
                                                            .toString(),
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: MyAppState
                                                                      .mode ==
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
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.01,
                                ),
                                InkWell(
                                  onTap: () {
                                    navigateToVenuesViewMore(_pitchDetail);
                                  },
                                  child: Text(
                                    AppLocalizations.of(context)!.viewAll,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 16,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0xff686868)
                                          : Colors.white70,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: sizeHeight * 0.02,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(right: sizeWidth * 0.022),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (MyAppState.mode ==
                                            ThemeMode.light) {
                                          MyAppState.mode = ThemeMode.dark;
                                        } else {
                                          MyAppState.mode = ThemeMode.light;
                                        }
                                      });
                                    },
                                    child: Container(
                                      width: sizeWidth * 0.85,
                                      height: sizeHeight * 0.22,
                                      decoration: BoxDecoration(
                                        image: const DecorationImage(
                                            fit: BoxFit.fill,
                                            image: AssetImage(
                                                "assets/images/addnew.png")),
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.white12,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .innovative,
                                              style: TextStyle(
                                                  fontSize: sizeHeight * 0.023,
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0xff686868)
                                                      : Colors.white70)),
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
                              ],
                            ),
                          ),
                        ),
                      ],
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
            ),
    );
  }

  void navigateToVenuesViewMore(event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ViewMoreVenueScreen(venues: event)));
    // Navigator.pushNamed(context, RouteNames.viewMoreVenue, arguments: event);
  }

  void navigateToSports() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SelectSportScreen(isBack: true)));
    // Navigator.pushNamed(context, RouteNames.selectSport, arguments: true);
  }
}
