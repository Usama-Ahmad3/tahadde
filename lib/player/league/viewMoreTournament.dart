import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';
import '../../pitchOwner/homePitchOwner/viewMoreOwner.dart';

class ViewMoreTournament extends StatefulWidget {
  Map tournamentType;
  ViewMoreTournament({super.key, required this.tournamentType});
  @override
  _ViewMoreTournamentState createState() => _ViewMoreTournamentState();
}

class _ViewMoreTournamentState extends State<ViewMoreTournament> {
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late List<Turnament> tournamentData;
  bool _isLoading = true;
  late bool internet;
  loadTournamentData() async {
    await _networkCalls.tournament(
      urldetail: "all",
      onSuccess: (leagueInfo) {
        setState(() {
          tournamentData = leagueInfo;
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

  loadTournamentDataFilter() async {
    await _networkCalls.tournamentFilter(
      detail: widget.tournamentType,
      onSuccess: (leagueInfo) {
        setState(() {
          tournamentData = leagueInfo;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        widget.tournamentType["bool"]
            ? loadTournamentDataFilter()
            : loadTournamentData();
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
        : internet
            ? Scaffold(
                key: scaffoldkey,
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
                    AppLocalizations.of(context)!.tournament,
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
                      padding: const EdgeInsets.all(0),
                      // Generate 100 widgets that display their index in the List.
                      children:
                          List.generate(tournamentData.length ?? 0, (index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToDetail2(tournamentData[index]);
                          },
                          child: Stack(
                            alignment:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                            children: <Widget>[
                              LeagueListItem(
                                  file: tournamentData[index]
                                      .tournamentfiles!
                                      .files!
                                      .filePath
                                      .toString()),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${tournamentData[index].name}' ?? '',
                                        style: const TextStyle(
                                            height: 1,
                                            fontSize: 13,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        ('  ${DateFormat.yMMMMd('en_US').format(DateTime.parse(tournamentData[index].startDate.toString()))}' ??
                                            ''),
                                        style: const TextStyle(fontSize: 8),
                                      ),
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
                      loadTournamentData();
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
            AppLocalizations.of(context)!.tournament,
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
