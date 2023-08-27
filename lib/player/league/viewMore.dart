import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/leagueModelClass.dart';
import '../../network/network_calls.dart';
// import 'league.dart';

class ViewMoreLeague extends StatefulWidget {
  Map leagueType;
  ViewMoreLeague({required this.leagueType});
  @override
  _ViewMoreLeagueState createState() => _ViewMoreLeagueState();
}

class _ViewMoreLeagueState extends State<ViewMoreLeague> {
  final NetworkCalls _networkCalls = NetworkCalls();
  late List<League> leagueData;
  late bool internet;
  bool _isLoading = true;
  @override
  loadLeageData() async {
    await _networkCalls.league(
      urldetail: "all",
      onSuccess: (tournamentInfo) {
        setState(() {
          leagueData = tournamentInfo;
          _isLoading = false;
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

  loadLeageDataFilter() async {
    await _networkCalls.leagueFilter(
      language: AppLocalizations.of(context)!.locale,
      detail: widget.leagueType,
      onSuccess: (tournamentInfo) {
        setState(() {
          leagueData = tournamentInfo;
          _isLoading = false;
        });
      },
      onFailure: (msg) {
        showMessage(msg);
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        widget.leagueType["bool"] ? loadLeageDataFilter() : loadLeageData();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? _buildShimmer(sizeWidth, sizeHeight)
        : internet
            ? Scaffold(
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
                  //centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    AppLocalizations.of(context)!.league,
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
                  padding: EdgeInsets.only(
                      left: sizeWidth * .04, right: sizeWidth * .04),
                  child: GridView.count(
                      crossAxisCount: 2,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(leagueData.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToDetail2(leagueData[index]);
                          },
                          child: Stack(
                            alignment:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                            children: <Widget>[
                              leagueData[index].leaguefiles != null
                                  ? LeagueListItem(
                                      file: leagueData[index]
                                          .leaguefiles!
                                          .files!
                                          .filePath
                                          .toString(),
                                    )
                                  : Padding(
                                      padding: AppLocalizations.of(context)!
                                                  .locale ==
                                              "en"
                                          ? EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02,
                                            )
                                          : EdgeInsets.only(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .02),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.all(
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
                                padding:
                                    AppLocalizations.of(context)!.locale == "en"
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(1),
                                      Text(
                                        '${leagueData[index].name}',
                                        style: const TextStyle(
                                            height: 1,
                                            fontSize: 13,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      flaxibleGap(1),
                                      Text(
                                        (DateFormat.yMMMMd('en_US').format(
                                            DateTime.parse(leagueData[index]
                                                .startDate
                                                .toString()))),
                                        style: const TextStyle(fontSize: 10),
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
                ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      loadLeageData();
                    }
                  });
                },
              );
  }

  void navigateToDetail2(dynamic leaguedata) {
    Navigator.pushNamed(context, RouteNames.league, arguments: leaguedata);
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Material(
      color: Colors.white,
      child: Scaffold(
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
          //centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.league,
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
        body: SizedBox(
          height: sizeHeight,
          child: Padding(
            padding: EdgeInsets.only(
                left: sizeWidth * .04,
                right: sizeWidth * .04,
                top: sizeHeight * .03),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(10, (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 130,
                        width: 160,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}

class LeagueListItem extends StatelessWidget {
  final String file;
  LeagueListItem({required this.file});
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
