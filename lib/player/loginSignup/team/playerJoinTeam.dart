import 'package:flutter/material.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class PlayerJoinTeam extends StatefulWidget {
  const PlayerJoinTeam({super.key});

  @override
  _PlayerJoinTeamState createState() => _PlayerJoinTeamState();
}

class _PlayerJoinTeamState extends State<PlayerJoinTeam> {
  List detail = [];
  bool addPlayer = false;
  bool _isLoading = true;
  bool _internet = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  loadData() {
    _networkCalls.playerInvitationReceive(
      onSuccess: (msg) {
        setState(() {
          _isLoading = false;
          detail = msg;
        });
      },
      onFailure: (msg) {
        navigateToHome();
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
      msg
          ? loadData()
          : setState(() {
              _isLoading = false;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            body: SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (_, __) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  shimmer(width: double.infinity),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 8.0),
                                  ),
                                  shimmer(width: double.infinity),
                                  Container(
                                    height: sizeHeight * .15,
                                  ),
                                  const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.0),
                                  ),
                                  shimmer(width: double.infinity),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            ),
          )
        : _internet
            ? SafeArea(
                child: Scaffold(
                  body: Container(
                    height: sizeHeight,
                    width: sizeWidth,
                    color: const Color(0xffff0f0f0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Stack(
                          alignment:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? Alignment.bottomLeft
                                  : Alignment.bottomRight,
                          children: <Widget>[
                            AppLocalizations.of(context)!.locale == "en"
                                ? Image.asset(
                                    'assets/images/header.png',
                                    fit: BoxFit.cover,
                                    width: sizeWidth,
                                    height: sizeHeight * .2,
                                  )
                                : Image.asset(
                                    'assets/images/arabicHeader.png',
                                    fit: BoxFit.cover,
                                    width: sizeWidth,
                                    height: sizeHeight * .2,
                                  ),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: sizeHeight * .05,
                                  left: sizeWidth * .1,
                                  right: sizeWidth * .1),
                              child: Text(
                                AppLocalizations.of(context)!.teamC,
                                style: TextStyle(
                                    fontSize: appHeaderFont,
                                    color: const Color(0XFFFFFFFF),
                                    fontFamily:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? "Poppins"
                                            : "VIP",
                                    fontWeight:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? FontWeight.bold
                                            : FontWeight.normal),
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: sizeHeight * .03),
                            child: SizedBox(
                                height: sizeHeight * .52,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: detail.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            left: sizeWidth * .05,
                                            right: sizeWidth * .05,
                                            bottom: sizeHeight * .02),
                                        child: Container(
                                          height: sizeHeight * .2,
                                          width: sizeWidth,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              flaxibleGap(
                                                1,
                                              ),
                                              SizedBox(
                                                width: sizeWidth * .8,
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.captain} ${detail[index]["captain"]["first_name"]} ${detail[index]["captain"]["last_name"]} ${AppLocalizations.of(context)!.hasrequestedtojointheteam}",
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0XFF032040)),
                                                ),
                                              ),
                                              flaxibleGap(
                                                1,
                                              ),
                                              SizedBox(
                                                width: sizeWidth * .8,
                                                child: Row(
                                                  children: [
                                                    flaxibleGap(
                                                      4,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _networkCalls
                                                            .checkInternetConnectivity(
                                                                onSuccess:
                                                                    (msg) {
                                                          _internet = msg;
                                                          if (msg == true) {
                                                            Map detailData = {
                                                              "id": detail[
                                                                          index]
                                                                      ["id"]
                                                                  .toString(),
                                                              "type": "join"
                                                            };
                                                            _networkCalls
                                                                .playerInvitationAccept(
                                                              detail:
                                                                  detailData,
                                                              onSuccess: (msg) {
                                                                navigateToHome();
                                                              },
                                                              onFailure: (msg) {
                                                                showMessage(
                                                                    msg);
                                                              },
                                                              tokenExpire: () {
                                                                if (mounted) {
                                                                  on401(
                                                                      context);
                                                                }
                                                              },
                                                            );
                                                          } else {
                                                            if (mounted) {
                                                              showMessage(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .noInternetConnection);
                                                            }
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0XFF25A163)),
                                                          ),
                                                          height:
                                                              sizeHeight * .05,
                                                          width:
                                                              sizeWidth * .25,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .join,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0XFF25A163)),
                                                          )),
                                                    ),
                                                    flaxibleGap(
                                                      1,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _networkCalls
                                                            .checkInternetConnectivity(
                                                                onSuccess:
                                                                    (msg) {
                                                          _internet = msg;
                                                          if (msg == true) {
                                                            Map detailData = {
                                                              "id": detail[
                                                                          index]
                                                                      ["id"]
                                                                  .toString(),
                                                              "type": "cancel"
                                                            };
                                                            _networkCalls
                                                                .playerInvitationAccept(
                                                              detail:
                                                                  detailData,
                                                              onSuccess: (msg) {
                                                                setState(() {
                                                                  _isLoading =
                                                                      true;
                                                                  loadData();
                                                                });
                                                              },
                                                              onFailure: (msg) {
                                                                showMessage(
                                                                    msg);
                                                              },
                                                              tokenExpire: () {
                                                                if (mounted) {
                                                                  on401(
                                                                      context);
                                                                }
                                                              },
                                                            );
                                                          } else {
                                                            if (mounted) {
                                                              showMessage(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .noInternetConnection);
                                                            }
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0XFFE73D3B)),
                                                          ),
                                                          height:
                                                              sizeHeight * .05,
                                                          width:
                                                              sizeWidth * .25,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cancelRequest,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0XFFE73D3B)),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              flaxibleGap(
                                                1,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    })),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadData();
                    }
                  });
                },
              );
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }
}
