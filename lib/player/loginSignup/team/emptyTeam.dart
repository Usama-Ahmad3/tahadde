import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import 'addPlayer.dart';
import 'playerJoinTeam.dart';
import 'teamPlayer.dart';

class TeamEmpaty extends StatefulWidget {
  @override
  _TeamEmpatyState createState() => _TeamEmpatyState();
}

class _TeamEmpatyState extends State<TeamEmpaty> {
  bool? _auth;
  String? subRole;
  bool _isLoading = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  SharedPreferences? pref;
  bool invitatiionStatus = false;
  bool? internet;
  loadProfile() async {
    _auth = await checkAuthorizaton();
    _auth!
        ? _networkCalls.role(
            onSuccess: (msg) {
              subRole = msg["sub-role"];
              if (_auth! && subRole == null) {
                _networkCalls.playerInvitationReceive(
                  onSuccess: (msg) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        invitatiionStatus = true;
                      });
                    }
                  },
                  onFailure: (msg) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        invitatiionStatus = false;
                      });
                    }
                  },
                  tokenExpire: () {
                    if (mounted) on401(context);
                  },
                );
              } else {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
            onFailure: (msg) {
              if (_auth! && subRole == null) {
                _networkCalls.playerInvitationReceive(
                  onSuccess: (msg) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        invitatiionStatus = true;
                      });
                    }
                  },
                  onFailure: (msg) {
                    if (mounted) {
                      setState(() {
                        _isLoading = false;
                        invitatiionStatus = false;
                      });
                    }
                  },
                  tokenExpire: () {
                    if (mounted) on401(context);
                  },
                );
              } else {
                if (mounted) {
                  setState(() {
                    _isLoading = false;
                  });
                }
              }
            },
          )
        : {
            if (mounted)
              setState(() {
                _isLoading = false;
              })
          };
  }

  Future onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: const Text("Coming Soon"),
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
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
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
    return Material(
        color: const Color(0XFF032040),
        child: _isLoading
            ? _buildLoadingShemmer(sizeWidth, sizeHeight)
            : internet!
                ? subRole == "captain"
                    ? AddPlayer(
                        index: 0,
                      )
                    : subRole == "member"
                        ? TeamPlayer()
                        : subRole == null
                            ? invitatiionStatus
                                ? PlayerJoinTeam()
                                : Material(
                                    child: Scaffold(
                                        appBar: PreferredSize(
                                            preferredSize:
                                                const Size.fromHeight(0),
                                            child: AppBar(
                                              backgroundColor:
                                                  const Color(0XFF032040),
                                            )),
                                        backgroundColor:
                                            const Color(0XFFD6D6D6),
                                        body: Column(
                                          children: <Widget>[
                                            buildAppBar(
                                                language: AppLocalizations.of(
                                                        context)!
                                                    .locale,
                                                title: AppLocalizations.of(
                                                        context)!
                                                    .teamC,
                                                height: sizeHeight,
                                                width: sizeWidth),
                                            Container(
                                              height: sizeHeight * .6,
                                              width: sizeWidth,
                                              color: const Color(0XFFD6D6D6),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(30),
                                                child: Container(
                                                  height: sizeHeight * .55,
                                                  color:
                                                      const Color(0XFFFFFFFF),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 22,
                                                                right: 22),
                                                        child: Center(
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .createTeam,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 18,
                                                                color: Color(
                                                                    0XFF032040),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                        ),
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Image.asset(
                                                        'assets/images/Group.png',
                                                        height: sizeHeight * .2,
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 20,
                                                                right: 20),
                                                        child: Material(
                                                          child: Ink(
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4),
                                                              color: const Color(
                                                                  0XFF25A163),
                                                              //color: Color(color),
                                                            ),
                                                            child: InkWell(
                                                              splashColor:
                                                                  Colors.black,
                                                              child: button(
                                                                  name: AppLocalizations.of(
                                                                          context)!
                                                                      .createTeamC),
                                                              onTap: () {
                                                                if (_auth!) {
                                                                  onWillPop();
                                                                  // navigateToDetail();
                                                                } else {
                                                                  onWillPop();
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                            : TeamPlayer()
                : Scaffold(
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: AppBar(
                          backgroundColor: const Color(0XFF032040),
                        )),
                    backgroundColor: const Color(0XFFD6D6D6),
                    body: Column(
                      children: [
                        buildAppBar(
                            language: AppLocalizations.of(context)!.locale,
                            title: AppLocalizations.of(context)!.teamC,
                            height: sizeHeight,
                            width: sizeWidth),
                        Expanded(
                          child: InternetLoss(onChange: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              internet = msg;
                              if (msg == true) {
                                loadProfile();
                              } else {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            });
                          }),
                        ),
                      ],
                    ),
                  ));
  }

  Widget _buildLoadingShemmer(sizeWidth, sizeHeight) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      body: Container(
        height: sizeHeight,
        width: sizeWidth,
        color: const Color(0XFFFF0F0F0),
        child: Column(
          children: <Widget>[
            buildAppBar(
                language: AppLocalizations.of(context)!.locale,
                title: AppLocalizations.of(context)!.teamC,
                height: sizeHeight,
                width: sizeWidth),
            // Container(
            //   height: sizeHeight * .25,
            //   width: sizeWidth,
            // decoration: BoxDecoration(
            //     color: Color(0XFF032040),
            //     image: DecorationImage(
            //         image: AppLocalizations.of(context)
            //             .locale ==
            //             "en"
            //             ? AssetImage('images/header.png')
            //             : AssetImage(
            //             'images/arabicHeader.png'),
            //         fit: BoxFit.cover)),
            //   child: Padding(
            //     padding: EdgeInsets.only(
            //         left: sizeWidth * .05,
            //         right: sizeWidth * .05),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       //mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Shimmer.fromColors(
            //           baseColor: Colors.grey[300],
            //           highlightColor: Colors.grey[100],
            //           enabled: true,
            //           child: Container(
            //             height: sizeHeight * .19,
            //             width: sizeWidth * .3,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(10),
            //               color: Colors.white,
            //             ),
            //             child: ClipRRect(
            //               clipBehavior: Clip.hardEdge,
            //               borderRadius: BorderRadius.all(
            //                   Radius.circular(10.0)),
            //             ),
            //           ),
            //         ),
            //         flaxibleGap( 2,
            //         ),
            //         Container(
            //           width: sizeWidth * .5,
            //           height: sizeHeight * .19,
            //           child: Column(
            //             crossAxisAlignment:
            //             CrossAxisAlignment.start,
            //             children: [
            //               Shimmer.fromColors(
            //                 baseColor: Colors.grey[300],
            //                 highlightColor: Colors.grey[100],
            //                 enabled: true,
            //                 child: Container(
            //                   width: sizeWidth * .6,
            //                   height: 20,
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.all(Radius.circular(5.0) //
            //
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               flaxibleGap( 1,
            //               ),
            //               Shimmer.fromColors(
            //                 baseColor: Colors.grey[300],
            //                 highlightColor: Colors.grey[100],
            //                 enabled: true,
            //                 child: Container(
            //                   width: sizeWidth * .6,
            //                   height: 20,
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.all(Radius.circular(5.0) //
            //
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               flaxibleGap( 1,
            //               ),
            //               Shimmer.fromColors(
            //                 baseColor: Colors.grey[300],
            //                 highlightColor: Colors.grey[100],
            //                 enabled: true,
            //                 child: Container(
            //                   width: sizeWidth * .2,
            //                   height: 20,
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.all(Radius.circular(5.0) //
            //
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //               flaxibleGap( 1,
            //               ),
            //               Row(children: <Widget>[
            //                   Icon(
            //                     Icons.call,
            //                     color: Color(0xFFBCBCBC),
            //                     size: 20,
            //                   ),
            //                   Container(
            //                     width: 10,
            //                   ),
            //                    Icon(
            //                     Icons.mail,
            //                     color: Color(0xFFBCBCBC),
            //                     size: 20,
            //                   ),
            //                   flaxibleGap( 1,
            //                   ),
            //                   Shimmer.fromColors(
            //                     baseColor: Colors.grey[300],
            //                     highlightColor: Colors.grey[100],
            //                     enabled: true,
            //                     child: Container(
            //                       width: sizeWidth * .3,
            //                       height: 30,
            //                       decoration: BoxDecoration(
            //                         color: Colors.white,
            //                         borderRadius: BorderRadius.all(Radius.circular(5.0) //
            //
            //                         ),
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         flaxibleGap( 4,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      fixedGap(height: 20.0),
                      _shimmerCard(),
                    ],
                  ),
                ),
                itemCount: 5,
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    // image: Image.network(profileDetail.profile_pic),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                shimmer(width: 200),
                const SizedBox(
                  height: 10,
                ),
                shimmer(width: 150),
              ],
            ),
            flaxibleGap(1),
          ],
        ),
      ),
    );
  }

  void navigateToDetail() {
    Navigator.pushNamed(context, RouteNames.createTeam);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }
}
