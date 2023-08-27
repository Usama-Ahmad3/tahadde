import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class PendingMember extends StatefulWidget {
  @override
  _PendingMemberState createState() => _PendingMemberState();
}

class _PendingMemberState extends State<PendingMember> {
  bool? _internet;
  bool _isLoading = true;
  String date = "name";
  var pendindData;
  final NetworkCalls _networkCalls = NetworkCalls();
  loadData() {
    _networkCalls.captainPendind(
      onSuccess: (msg) {
        setState(() {
          _isLoading = false;
          pendindData = msg;
        });
      },
      onFailure: (msg) {
        setState(() {
          pendindData = null;
          _isLoading = false;
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
    return Scaffold(
        backgroundColor: const Color(0XFFF0F0F0),
        body: _isLoading
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                child: SizedBox(
                  height: sizeHeight * .65,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top: sizeHeight * .02),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: sizeHeight * .13,
                              width: sizeWidth * .8,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                    //
                                  ),
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }),
                ),
              )
            : _internet!
                ? pendindData != null
                    ? Container(
                        height: sizeHeight * .65,
                        color: Colors.grey.withOpacity(.1),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: pendindData.length,
                            itemBuilder: (context, index) {
                              return Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeWidth * .05),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: sizeHeight * .18,
                                        width: sizeWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeHeight * .01,
                                                  vertical: sizeHeight * .03),
                                              child: Image.asset(
                                                'assets/images/cross.png',
                                                height: sizeHeight * .035,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  sizeHeight * .005),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: sizeHeight * .02),
                                                    child: Text(
                                                        "${pendindData[index]["player"]["first_name"]} ${pendindData[index]["player"]["last_name"]}",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF424242),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 16)),
                                                  ),
                                                  Text(
                                                      "${pendindData[index]["player"]["first_name"]} ${pendindData[index]["player"]["last_name"]} ${AppLocalizations.of(context)!.hasrequestedyoutojoin}",
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF646464),
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: "Poppins",
                                                          fontSize: 12)),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  SizedBox(
                                                    width: sizeWidth * .7,
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
                                                                Map detailData =
                                                                    {
                                                                  "id": pendindData[
                                                                              index]
                                                                          ["id"]
                                                                      .toString(),
                                                                  "type":
                                                                      "approve"
                                                                };
                                                                _networkCalls
                                                                    .captainInvitationAccept(
                                                                  detail:
                                                                      detailData,
                                                                  onSuccess:
                                                                      (msg) {
                                                                    setState(
                                                                        () {
                                                                      _isLoading =
                                                                          true;
                                                                      loadData();
                                                                    });
                                                                  },
                                                                  onFailure:
                                                                      (msg) {
                                                                    showMessage(
                                                                        msg);
                                                                  },
                                                                  tokenExpire:
                                                                      () {
                                                                    if (mounted) {
                                                                      on401(
                                                                          context);
                                                                    }
                                                                  },
                                                                );
                                                              } else {
                                                                if (mounted) {
                                                                  showMessage(AppLocalizations.of(
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
                                                                  sizeHeight *
                                                                      .05,
                                                              width: sizeWidth *
                                                                  .25,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .approve,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
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
                                                                Map detailData =
                                                                    {
                                                                  "id": pendindData[
                                                                              index]
                                                                          ["id"]
                                                                      .toString(),
                                                                  "type":
                                                                      "reject"
                                                                };
                                                                _networkCalls
                                                                    .captainInvitationAccept(
                                                                  detail:
                                                                      detailData,
                                                                  onSuccess:
                                                                      (msg) {
                                                                    setState(
                                                                        () {
                                                                      _isLoading =
                                                                          true;
                                                                      loadData();
                                                                    });
                                                                  },
                                                                  onFailure:
                                                                      (msg) {
                                                                    showMessage(
                                                                        msg);
                                                                  },
                                                                  tokenExpire:
                                                                      () {
                                                                    if (mounted) {
                                                                      on401(
                                                                          context);
                                                                    }
                                                                  },
                                                                );
                                                              } else {
                                                                if (mounted) {
                                                                  showMessage(AppLocalizations.of(
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
                                                                  sizeHeight *
                                                                      .05,
                                                              width: sizeWidth *
                                                                  .25,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .reject,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    color: Color(
                                                                        0XFFE73D3B)),
                                                              )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            flaxibleGap(
                                              6,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 1,
                                        width: sizeWidth,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          flaxibleGap(
                            10,
                          ),
                          SizedBox(
                              height: sizeHeight * .2,
                              width: sizeHeight * .2,
                              child: Image.asset(
                                'assets/images/Group.png',
                                fit: BoxFit.fill,
                              )),
                          flaxibleGap(
                            4,
                          ),
                          Text(AppLocalizations.of(context)!.noPlayerRequests,
                              style: const TextStyle(
                                  color: Color(0XFF424242),
                                  fontFamily: "Poppins",
                                  fontSize: 14)),
                          flaxibleGap(
                            31,
                          ),
                        ],
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
                  ));
  }
}
