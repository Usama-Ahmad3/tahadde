import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/teamModelClass.dart';
import '../../../network/network_calls.dart';

class ViewMoreTeam extends StatefulWidget {
  @override
  _ViewMoreTeamState createState() => _ViewMoreTeamState();
}

class _ViewMoreTeamState extends State<ViewMoreTeam> {
  final NetworkCalls _networkCalls = NetworkCalls();
  List<TeamModelClass> teamdata = [];
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool? _internet;
  bool _isLoading = true;
  @override
  loadTeamData() async {
    await _networkCalls.teamList(
      onSuccess: (team) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            teamdata = team;
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

  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadTeamData();
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? _buildShimmer(sizeWidth, sizeHeight)
        : _internet!
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
                    AppLocalizations.of(context)!.team,
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
                      children: List.generate(teamdata.length ?? 0, (index) {
                        // scrollDirection: Axis.horizontal,
//          itemCount: AppLocalizations.of(context).locale == "en"
//              ? leagueData?.length ?? 0
//              : leagueDataAR?.length ?? 0,
//          itemBuilder: (context, index) {
//            print("index $index");
                        return Padding(
                          padding: AppLocalizations.of(context)!.locale == "en"
                              ? EdgeInsets.only(left: sizeWidth * .02)
                              : EdgeInsets.only(right: sizeWidth * .02),
                          child: GestureDetector(
                            onTap: () {
                              navigateToviewJoinTeam(teamdata[index]);
                            },
                            child: Container(
                              height: sizeHeight * .18,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  teamdata[index].teamLogo!.filePath != null
                                      ? Container(
                                          decoration: const BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  5.0), //                 <--- border radius here
                                            ),
                                          ),
                                          height: sizeHeight * .14,
                                          width: 160,
                                          child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5.0),
                                                topRight: Radius.circular(
                                                    5.0), //                 <--- border radius here
                                              ),
                                              child: cachedNetworkImage(
                                                height: sizeHeight * .16,
                                                width: 140,
                                                cuisineImageUrl: teamdata[index]
                                                    .teamLogo
                                                    ?.filePath,
                                              )))
                                      : Padding(
                                          padding: AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02)
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
                                              height: sizeHeight * .16,
                                              width: 160,
                                              child:
                                                  Image.asset('images/T.png')),
                                        ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: sizeHeight * .04,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Color(0XFF032040),
                                    ),
                                    width: 160,
                                    child: Text(
                                      '${teamdata[index].teamName}' ?? '',
                                      style: const TextStyle(
                                          height: 1,
                                          // letterSpacing: 1.0
                                          fontFamily: 'Poppins',
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
                ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadTeamData();
                    }
                  });
                },
              );
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
            AppLocalizations.of(context)!.team,
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
          child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(0),
              children: List.generate(10, (index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
    );
  }

  void navigateToviewJoinTeam(TeamModelClass detail) {
    Navigator.pushNamed(context, RouteNames.joinTeam, arguments: detail);
  }
}
