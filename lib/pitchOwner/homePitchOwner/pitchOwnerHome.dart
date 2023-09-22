import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/home.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/leagueModelClass.dart';
import '../../modelClass/my_venue_list_model_class.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';

class PitchOwnerHome extends StatefulWidget {
  @override
  _PitchOwnerHomeState createState() => _PitchOwnerHomeState();
}

class _PitchOwnerHomeState extends State<PitchOwnerHome>
    with AutomaticKeepAliveClientMixin {
  final NetworkCalls _networkCalls = NetworkCalls();
  final List<League> _leagueData = [];
  final List<Turnament> _tournamentData = [];
  bool _isLoading = true;
  List<MyVenueModelClass> _pitchDetail = [];
  late bool _internet;
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
  // loadLeagueData() async {
  //   await _networkCalls.leagueOwner(
  //     filter: true,
  //     onSuccess: (tournamentInfo) {
  //       if (mounted)
  //         setState(() {
  //           _leagueData = tournamentInfo;
  //         });
  //     },
  //     onFailure: (msg) {
  //       if (mounted)
  //         setState(() {
  //           _isLoading = false;
  //         });
  //     },
  //     tokenExpire: () {
  //       if (mounted) on401(context);
  //     },
  //   );
  // }

  // loadTournamentData() async {
  //   await _networkCalls.tournamentOwner(
  //     filter: true,
  //     onSuccess: (tournamentInfo) {
  //       if (mounted)
  //         setState(() {
  //           _tournamentData = tournamentInfo;
  //         });
  //     },
  //     onFailure: (msg) {
  //       if (mounted)
  //         setState(() {
  //           _isLoading = false;
  //         });
  //     },
  //     tokenExpire: () {
  //       if (mounted) on401(context);
  //     },
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(DateTime.now());
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (_internet == true) {
        _isLoading = false;
        // loadLeagueData();
        // loadTournamentData();
        loadMyPitch();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: const Text(
              "Coming Soon",
              style: TextStyle(color: Colors.black),
            ),
            // AppLocalizations.of(context).toReserve),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              // TextButton(
              //   child: Text(AppLocalizations.of(context).login),
              //   onPressed: () {
              //     navigateToDetail1();
              //   },
              // )
            ],
          );
        });
    //Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return RefreshIndicator(
      displacement: 200,
      onRefresh: () async {
        _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
          _internet = msg;
          if (_internet == true) {
            _isLoading = false;
            // loadLeagueData();
            // loadTournamentData();
            loadMyPitch();
          }
          setState(() {
            _isLoading = false;
          });
        });
      },
      child: _isLoading
          ? _buildShimmer(sizeHeight, sizeWidth)
          : _internet
              ? SafeArea(
                  child: Scaffold(
                    body: SizedBox(
                      height: sizeHeight,
                      width: sizeWidth,
                      child: ListView(
                        children: <Widget>[
                          buildAppBar(
                              language: AppLocalizations.of(context)!.locale,
                              title: AppLocalizations.of(context)!.tahaddi,
                              height: sizeHeight,
                              width: sizeWidth),
                          Container(
                            height: sizeHeight * .05,
                          ),
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .04),
                              child: buildViewMore(
                                  onTapGesture: _leagueData.isNotEmpty,
                                  language:
                                      AppLocalizations.of(context)!.locale,
                                  title: AppLocalizations.of(context)!.league,
                                  viewMore:
                                      AppLocalizations.of(context)!.viewMore,
                                  titleColor: const Color(0XFF032040),
                                  viewMoreColor: const Color(0XFF032040),
                                  width: sizeWidth,
                                  onTap: () {
                                    navigateToViewMore("League");
                                  },
                                  pathColor: Colors.transparent)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .04,
                                right: sizeWidth * .04,
                                top: sizeHeight * .01),
                            child: GestureDetector(
                                onTap: () {
                                  onWillPop();
                                  //  navigateTocreateEvevt("League");
                                },
                                child: _buildCreateEvent(
                                    title: AppLocalizations.of(context)!
                                        .createYourLeagueHere,
                                    height: sizeHeight)),
                          ),
                          _leagueData.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: sizeWidth * .03,
                                      right: sizeWidth * .03,
                                      top: sizeHeight * .01),
                                  child: SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _leagueData.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Map detail = {
                                              "event": "League",
                                              "id": _leagueData[index].id
                                            };
                                            navigateToEventDetail(detail);
                                          },
                                          child: Stack(
                                            alignment:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? Alignment.bottomLeft
                                                    : Alignment.bottomRight,
                                            children: <Widget>[
                                              _leagueData[index].leaguefiles !=
                                                      null
                                                  ? LeagueListItem(
                                                      file: _leagueData[index]
                                                          .leaguefiles!
                                                          .files!
                                                          .filePath
                                                          .toString(),
                                                    )
                                                  : Padding(
                                                      padding: AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .locale ==
                                                              "en"
                                                          ? EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .02)
                                                          : EdgeInsets.only(
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .02),
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            // border: Border.all(color: Colors.black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        5.0) //                 <--- border radius here
                                                                    ),
                                                          ),
                                                          height: 150,
                                                          width: 150,
                                                          child: Image.asset(
                                                              'assets/images/T.png')),
                                                    ),
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? const EdgeInsets.only(
                                                        left: 20.0)
                                                    : const EdgeInsets.only(
                                                        right: 20.0,
                                                      ),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 145,
                                                          //minWidth: 50,
                                                          maxHeight: 50,
                                                          minHeight: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      flaxibleGap(1),
                                                      Text(
                                                        _leagueData[index]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            height: 1,
                                                            fontSize: 13,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      flaxibleGap(1),
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              "en"
                                                          ? Text(
                                                              (DateFormat.yMMMMd(
                                                                      'en_US')
                                                                  .format(DateTime.parse(_leagueData[
                                                                          index]
                                                                      .startDate
                                                                      .toString()))),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                            )
                                                          : Text(
                                                              (DateFormat.yMMMMd(
                                                                      'ar_SA')
                                                                  .format(DateTime.parse(_leagueData[
                                                                          index]
                                                                      .startDate
                                                                      .toString()))),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                      flaxibleGap(1),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .04,
                                  right: sizeWidth * .04,
                                  top: sizeHeight * .03),
                              child: buildViewMore(
                                  onTapGesture: _tournamentData.isNotEmpty,
                                  language:
                                      AppLocalizations.of(context)!.locale,
                                  title:
                                      AppLocalizations.of(context)!.tournament,
                                  viewMore:
                                      AppLocalizations.of(context)!.viewMore,
                                  titleColor: const Color(0XFF032040),
                                  viewMoreColor: const Color(0XFF032040),
                                  width: sizeWidth,
                                  onTap: () {
                                    navigateToViewMore("Tournament");
                                  },
                                  pathColor: Colors.transparent)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .04,
                                right: sizeWidth * .04,
                                top: sizeHeight * .01),
                            child: GestureDetector(
                                onTap: () {
                                  onWillPop();
                                  // navigateTocreateEvevt("Tournament");
                                },
                                child: _buildCreateEvent(
                                    title: AppLocalizations.of(context)!
                                        .createYourTournamentHere,
                                    height: sizeHeight)),
                          ),
                          _tournamentData.isNotEmpty
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: sizeWidth * .03,
                                      right: sizeWidth * .03,
                                      top: sizeHeight * .01,
                                      bottom: sizeHeight * .02),
                                  child: SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _tournamentData.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Map detail = {
                                              "event": "Tournament",
                                              "id": _tournamentData[index].id
                                            };
                                            navigateToEventDetail(detail);
                                          },
                                          child: Stack(
                                            alignment:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? Alignment.bottomLeft
                                                    : Alignment.bottomRight,
                                            children: <Widget>[
                                              _tournamentData[index]
                                                          .tournamentfiles !=
                                                      null
                                                  ? LeagueListItem(
                                                      file:
                                                          _tournamentData[index]
                                                              .tournamentfiles!
                                                              .files!
                                                              .filePath
                                                              .toString(),
                                                    )
                                                  : Padding(
                                                      padding: AppLocalizations
                                                                      .of(
                                                                          context)!
                                                                  .locale ==
                                                              "en"
                                                          ? EdgeInsets.only(
                                                              left: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .02)
                                                          : EdgeInsets.only(
                                                              right: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  .02),
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            // border: Border.all(color: Colors.black),
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        5.0) //                 <--- border radius here
                                                                    ),
                                                          ),
                                                          height: 150,
                                                          width: 150,
                                                          child: Image.asset(
                                                              'assets/images/T.png')),
                                                    ),
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? const EdgeInsets.only(
                                                        left: 20.0)
                                                    : const EdgeInsets.only(
                                                        right: 20.0,
                                                      ),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 145,
                                                          maxHeight: 50,
                                                          minHeight: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      flaxibleGap(1),
                                                      Text(
                                                        _tournamentData[index]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            height: 1,
                                                            fontSize: 13,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      flaxibleGap(1),
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              "en"
                                                          ? Text(
                                                              (DateFormat.yMMMMd(
                                                                      'en_US')
                                                                  .format(DateTime.parse(_tournamentData[
                                                                          index]
                                                                      .startDate
                                                                      .toString()))),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                            )
                                                          : Text(
                                                              (DateFormat.yMMMMd(
                                                                      'ar_SA')
                                                                  .format(DateTime.parse(_tournamentData[
                                                                          index]
                                                                      .startDate
                                                                      .toString()))),
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          10),
                                                            ),
                                                      flaxibleGap(1),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              : Container(),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .04,
                                  right: sizeWidth * .04,
                                  top: sizeHeight * .03),
                              child: buildViewMore(
                                  onTapGesture: _pitchDetail.isNotEmpty,
                                  language:
                                      AppLocalizations.of(context)!.locale,
                                  title:
                                      AppLocalizations.of(context)!.myPitches,
                                  viewMore:
                                      AppLocalizations.of(context)!.viewMore,
                                  titleColor: const Color(0XFF032040),
                                  viewMoreColor: const Color(0XFF032040),
                                  width: sizeWidth,
                                  onTap: () {
                                    navigateToVenuesViewMore(_pitchDetail);
                                  },
                                  pathColor: Colors.transparent)),
                          Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .03,
                                right: sizeWidth * .03,
                                top: sizeHeight * .01,
                                bottom: sizeHeight * .02),
                            child: SizedBox(
                              height: 160,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _pitchDetail.length + 1,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: index == 0
                                        ? GestureDetector(
                                            onTap: () {
                                              navigateToSports();
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 30),
                                              child: Image.asset(
                                                "assets/images/addnew.png",
                                                fit: BoxFit.fitWidth,
                                                width: 100,
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {},
                                            child: buildMyVenue(
                                                _pitchDetail[index - 1]),
                                          ),
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    buildAppBar(
                        language: AppLocalizations.of(context)!.locale,
                        title: AppLocalizations.of(context)!.tahaddi,
                        height: sizeHeight,
                        width: sizeWidth),
                    Expanded(
                      child: InternetLoss(
                        onChange: () {
                          _networkCalls.checkInternetConnectivity(
                              onSuccess: (msg) {
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

  void navigateToViewMore(String event) {
    Navigator.pushNamed(context, RouteNames.viewMoreowner, arguments: event);
  }

  void navigateToVenuesViewMore(event) {
    Navigator.pushNamed(context, RouteNames.viewMoreVenue, arguments: event);
  }

  void navigateToEventDetail(Map event) {
    Navigator.pushNamed(context, RouteNames.eventDetailOwner, arguments: event);
  }

  void navigateToSports() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => SelectSportScreen(isBack: true)));
    // Navigator.pushNamed(context, RouteNames.selectSport, arguments: true);
  }

  void navigateTocreateEvevt(String detail) {
    // Navigator.pushNamed(context, createEventFirst, arguments: detail);
  }

  _buildShimmer(sizeHeight, sizeWidth) {
    return SizedBox(
      height: sizeHeight,
      width: sizeWidth,
      child: ListView(
        children: <Widget>[
          buildAppBar(
              language: AppLocalizations.of(context)!.locale,
              title: AppLocalizations.of(context)!.tahaddi,
              height: sizeHeight,
              width: sizeWidth),
          Container(
            height: sizeHeight * .05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeWidth * .04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.league,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0XFF032040)),
                ),
                _buildViewMoreShimmer(sizeWidth),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: sizeWidth * .04,
                  right: sizeWidth * .04,
                  top: sizeHeight * .01),
              child: _buildCreateEvent(
                  title: AppLocalizations.of(context)!.createYourLeagueHere,
                  height: sizeHeight)),
          _buildEventCardShimmer(sizeHeight, sizeWidth),
          Padding(
            padding: EdgeInsets.only(
                left: sizeWidth * .04,
                right: sizeWidth * .04,
                top: sizeHeight * .03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.tournament,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF032040)),
                ),
                _buildViewMoreShimmer(sizeWidth),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                  left: sizeWidth * .04,
                  right: sizeWidth * .04,
                  top: sizeHeight * .01),
              child: _buildCreateEvent(
                  title: AppLocalizations.of(context)!.createYourTournamentHere,
                  height: sizeHeight)),
          _buildEventCardShimmer(sizeHeight, sizeWidth),
        ],
      ),
    );
  }

  _buildViewMoreShimmer(double width) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Container(
        width: width * .25,
        height: 5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
      ),
    );
  }

  _buildEventCardShimmer(double height, double width) {
    return Padding(
      padding: EdgeInsets.only(
          left: width * .03, right: width * .03, top: height * .01),
      child: SizedBox(
        height: 120,
        child: SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //
                          ),
                    ),
                    width: 160,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _buildCreateEvent({required double height, required String title}) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(4.0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: ExactAssetImage('assets/images/languageAdd.png'),
            fit: BoxFit.fill),
        // border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.all(
            Radius.circular(10.0) //                 <--- border radius here
            ),
      ),
      height: height * .15,
      child: Text(
        title,
        style: const TextStyle(
            color: Color(0XFF032040),
            fontSize: 16,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
