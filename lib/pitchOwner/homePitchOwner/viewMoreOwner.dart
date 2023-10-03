import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/leagueModelClass.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';

class ViewMoreowner extends StatefulWidget {
  final String eventType;
  const ViewMoreowner({super.key, required this.eventType});
  @override
  _ViewMoreownerState createState() => _ViewMoreownerState();
}

class _ViewMoreownerState extends State<ViewMoreowner> {
  bool _latestDate = false;
  bool _stattDate = true;
  late bool _internet;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  List<League> _leagueData = [];
  List<Turnament> _tournamentData = [];
  bool _isLoading = true;
  loadLeagueData(bool filter) async {
    await _networkCalls.leagueOwner(
      filter: filter,
      onSuccess: (tournamentInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _leagueData = tournamentInfo;
          });
        }
      },
      onFailure: (msg) {
        //showMessage(msg, scaffoldkey);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  loadTournamentData(bool filter) async {
    await _networkCalls.tournamentOwner(
      filter: filter,
      onSuccess: (tournamentInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _tournamentData = tournamentInfo;
          });
        }
      },
      onFailure: (msg) {
        //showMessage(msg, scaffoldkey);
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
      _internet = msg;
      if (msg == true) {
        widget.eventType == "League"
            ? loadLeagueData(true)
            : loadTournamentData(true);
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
    return _isLoading
        ? _buildShimmer(sizeWidth, sizeHeight)
        : _internet
            ? Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  centerTitle: true,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  //centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    widget.eventType == "League"
                        ? AppLocalizations.of(context)!.league
                        : AppLocalizations.of(context)!.tournament,
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
                body: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: sizeWidth * .04,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: sizeHeight * .02,
                            left: sizeWidth * .02,
                            right: sizeWidth * .02),
                        child: Row(
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context)!.sortBy,
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0XFF032040),
                                  fontWeight: FontWeight.w700),
                            ),
                            flaxibleGap(6),
                            GestureDetector(
                              onTap: () {
                                _networkCalls.checkInternetConnectivity(
                                    onSuccess: (msg) {
                                  if (msg) {
                                    setState(() {
                                      _latestDate = true;
                                      _stattDate = false;
                                      _isLoading = true;
                                      widget.eventType == "League"
                                          ? loadLeagueData(false)
                                          : loadTournamentData(false);
                                    });
                                  } else {
                                    if (mounted) {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });
                              },
                              child: _latestDate
                                  ? Container(
                                      height: sizeHeight * .04,
                                      width: sizeWidth * .25,
                                      decoration: const BoxDecoration(
                                        color: Color(0XFF032040),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.latest,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Container(
                                      height: sizeHeight * .04,
                                      width: sizeWidth * .25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0XFFE0E0E0),
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.latest,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                            ),
                            flaxibleGap(1),
                            GestureDetector(
                              onTap: () {
                                _networkCalls.checkInternetConnectivity(
                                    onSuccess: (msg) {
                                  if (msg) {
                                    setState(() {
                                      _stattDate = true;
                                      _latestDate = false;
                                      _isLoading = true;
                                      widget.eventType == "League"
                                          ? loadLeagueData(true)
                                          : loadTournamentData(true);
                                    });
                                  } else {
                                    if (mounted) {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });
                              },
                              child: _stattDate
                                  ? Container(
                                      height: sizeHeight * .04,
                                      width: sizeWidth * .25,
                                      decoration: const BoxDecoration(
                                        color: Color(0XFF032040),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.startDate,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Container(
                                      height: sizeHeight * .04,
                                      width: sizeWidth * .25,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0XFFE0E0E0),
                                            style: BorderStyle.solid),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.startDate,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: sizeHeight * .75,
                          child: GridView.count(
                              crossAxisCount: 2,
                              padding: const EdgeInsets.all(0),
                              children: List.generate(
                                  widget.eventType == "League"
                                      ? _leagueData.length
                                      : _tournamentData.length, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    Map detail = {
                                      "event": widget.eventType,
                                      "id": widget.eventType == "League"
                                          ? _leagueData[index].id
                                          : _tournamentData[index].id
                                    };
                                    navigateToEventDetail(detail);
                                  },
                                  child: Stack(
                                    alignment:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Alignment.bottomLeft
                                            : Alignment.bottomRight,
                                    children: <Widget>[
                                      widget.eventType == "League"
                                          ? _leagueData[index].leaguefiles !=
                                                  null
                                              ? LeagueListItem(
                                                  file: _leagueData[index]
                                                      .leaguefiles!
                                                      .files!
                                                      .filePath
                                                      .toString(),
                                                )
                                              : Padding(
                                                  padding: AppLocalizations.of(
                                                                  context)!
                                                              .locale ==
                                                          "en"
                                                      ? EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .02,
                                                        )
                                                      : EdgeInsets.only(
                                                          right: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .02),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
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
                                                )
                                          : _tournamentData[index]
                                                      .tournamentfiles !=
                                                  null
                                              ? LeagueListItem(
                                                  file: _tournamentData[index]
                                                      .tournamentfiles!
                                                      .files!
                                                      .filePath
                                                      .toString(),
                                                )
                                              : Padding(
                                                  padding: AppLocalizations.of(
                                                                  context)!
                                                              .locale ==
                                                          "en"
                                                      ? EdgeInsets.only(
                                                          left: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .02,
                                                        )
                                                      : EdgeInsets.only(
                                                          right: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              .02),
                                                  child: Container(
                                                      decoration:
                                                          const BoxDecoration(
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
                                        padding: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? const EdgeInsets.only(left: 20.0)
                                            : const EdgeInsets.only(
                                                right: 20.0,
                                              ),
                                        child: Container(
                                          constraints: const BoxConstraints(
                                              maxWidth: 145,
                                              //minWidth: 50,
                                              maxHeight: 50,
                                              minHeight: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              flaxibleGap(1),
                                              Text(
                                                widget.eventType == "League"
                                                    ? _leagueData[index]
                                                        .name
                                                        .toString()
                                                    : _tournamentData[index]
                                                        .name
                                                        .toString(),
                                                style: const TextStyle(
                                                    height: 1,
                                                    fontSize: 13,
                                                    color: Color(0XFF032040),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              flaxibleGap(1),
                                              widget.eventType == "League"
                                                  ? Text(
                                                      (DateFormat.yMMMMd(
                                                              'en_US')
                                                          .format(DateTime.parse(
                                                              _leagueData[index]
                                                                  .startDate
                                                                  .toString()))),
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  : Text(
                                                      (DateFormat.yMMMMd(
                                                              'en_US')
                                                          .format(DateTime.parse(
                                                              _tournamentData[
                                                                      index]
                                                                  .startDate
                                                                  .toString()))),
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                              flaxibleGap(1),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })),
                        ),
                      ),
                    ],
                  ),
                ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      widget.eventType == "League"
                          ? loadLeagueData(true)
                          : loadTournamentData(true);
                    }
                  });
                },
              );
  }

  void navigateToEventDetail(Map event) {
    Navigator.pushNamed(context, RouteNames.eventDetailOwner, arguments: event);
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
            widget.eventType == "League"
                ? AppLocalizations.of(context)!.league
                : AppLocalizations.of(context)!.tournament,
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
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: sizeHeight * .02,
                  left: sizeWidth * .06,
                  right: sizeWidth * .06),
              child: Row(
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.sortBy,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Color(0XFF032040),
                        fontWeight: FontWeight.w700),
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(),
                  ),
                  Container(
                    height: sizeHeight * .04,
                    width: sizeWidth * .25,
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 1,
                          color: const Color(0XFFE0E0E0),
                          style: BorderStyle.solid),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.latest,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0XFF032040),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(),
                  ),
                  Container(
                    height: sizeHeight * .04,
                    width: sizeWidth * .25,
                    decoration: const BoxDecoration(
                      color: Color(0XFF032040),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.startDate,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: SizedBox(
                height: sizeHeight * .75,
                child: GridView.count(
                    crossAxisCount: 2,
                    padding: const EdgeInsets.all(0),
                    children: List.generate(10, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                              decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          )),
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeagueListItem extends StatelessWidget {
  final String file;
  const LeagueListItem({super.key, required this.file});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: AppLocalizations.of(context)!.locale == "en"
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * .02)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * .02),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          Container(
              decoration: const BoxDecoration(
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.all(Radius.circular(
                        5.0) //                 <--- border radius here
                    ),
              ),
              height: 150,
              width: 160,
              child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: cachedNetworkImage(
                      height: 150, width: 160, cuisineImageUrl: file))),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              // border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(Radius.circular(
                      5.0) //                 <--- border radius here
                  ),
            ),
            height: 50,
            width: 160,
          ),
        ],
      ),
    );
  }
}
