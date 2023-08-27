import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import 'members.dart';
import 'pendingMembers.dart';

class AddPlayer extends StatefulWidget {
  int index = 0;
  AddPlayer({required this.index});
  @override
  _AddPlayerState createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer>
    with SingleTickerProviderStateMixin {
  late int index;
  late int memberId;
  bool teamMember = false;
  final NetworkCalls _networkCalls = NetworkCalls();
  final _scaffoldkey = GlobalKey<ScaffoldState>();
  // _AddPl?ayerState(this.index,this.);
  bool addPlayer = false;
  bool _isLoading = true;
  late bool _internet;
  var teamdata;
  loadData() {
    _networkCalls.captainMember(
      onSuccess: (msg) {
        setState(() {
          teamdata = msg;
          _isLoading = false;
        });
      },
      onFailure: (msg) {
        setState(() {
          _isLoading = false;
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  Future onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(AppLocalizations.of(context)!.doyouwanttoleaveteam),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      teamMember == false
                          ? _networkCalls.deleteTeam(
                              onSuccess: (msg) {
                                navigateToHome();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {
                                if (mounted) on401(context);
                              },
                            )
                          : memberId != null
                              ? _networkCalls.captonAssign(
                                  id: memberId,
                                  onSuccess: (msg) {
                                    navigateToHome();
                                  },
                                  onFailure: (msg) {
                                    showMessage(msg);
                                  },
                                  tokenExpire: () {
                                    if (mounted) on401(context);
                                  },
                                )
                              : {
                                  Navigator.of(context).pop(false),
                                  showMessage(AppLocalizations.of(context)!
                                      .pleaseselectnewcaptain)
                                };
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                        Navigator.of(context).pop(false);
                      }
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadData();
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
        ? _buildLoadingShemmer(sizeWidth, sizeHeight)
        : _internet
            ? SafeArea(
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    key: _scaffoldkey,
                    body: Container(
                      height: sizeHeight,
                      width: sizeWidth,
                      color: const Color(0XFFFF0F0F0),
                      child: Flex(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Container(
                            height: sizeHeight * .25,
                            width: sizeWidth,
                            decoration: BoxDecoration(
                                color: const Color(0XFF032040),
                                image: DecorationImage(
                                    image: AppLocalizations.of(context)!
                                                .locale ==
                                            "en"
                                        ? const AssetImage(
                                            'assets/images/header.png')
                                        : const AssetImage(
                                            'assets/images/arabicHeader.png'),
                                    fit: BoxFit.cover)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .05,
                                  right: sizeWidth * .05),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: sizeHeight * .19,
                                    width: sizeWidth * .3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10.0)),
                                        child: cachedNetworkImage(
                                            cuisineImageUrl:
                                                teamdata?.teamLogo?.filePath)),
                                  ),
                                  flaxibleGap(
                                    2,
                                  ),
                                  Container(
                                    width: sizeWidth * .5,
                                    height: sizeHeight * .19,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          teamdata.teamName ?? "",
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                          ),
                                        ),
                                        flaxibleGap(
                                          1,
                                        ),
                                        Text(
                                            "${teamdata.captain!.first_name} ${teamdata.captain!.last_name}",
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                decoration: TextDecoration.none,
                                                color: Colors.white)),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .captainC,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15,
                                                decoration: TextDecoration.none,
                                                color: Color(0xFF25A163))),
                                        flaxibleGap(
                                          1,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            teamdata.contactNumber != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      makePhoneCall(
                                                          "tel:${teamdata.countryCode! + teamdata.contactNumber.toString()}");
                                                    },
                                                    child: const Icon(
                                                      Icons.call,
                                                      color: Color(0xFFBCBCBC),
                                                      size: 20,
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons.call,
                                                    color: Color(0xFFBCBCBC),
                                                    size: 20,
                                                  ),
                                            Container(
                                              width: 10,
                                            ),
                                            teamdata.captain!.email != null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      launch(
                                                          "mailto:${teamdata.captain!.email}?subject=Tahaddi&body= Tahaddi");
                                                    },
                                                    child: const Icon(
                                                      Icons.mail,
                                                      color: Color(0xFFBCBCBC),
                                                      size: 20,
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons.mail,
                                                    color: Color(0xFFBCBCBC),
                                                    size: 20,
                                                  ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                onWillPop();
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                height: 30,
                                                width: sizeWidth * .25,
                                                color: const Color(0xFF25A163),
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .leaveTeam,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(
                                    4,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Material(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0XFF25A163).withOpacity(.18),
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(15),
                                  topLeft: Radius.circular(15),
                                ),
                              ),
                              constraints:
                                  BoxConstraints(maxHeight: sizeHeight * .06),
                              child: TabBar(
                                labelColor: const Color(0XFF032040),
                                labelStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                                unselectedLabelColor: const Color(0XFFADADAD),
                                indicatorSize: TabBarIndicatorSize.label,
                                indicatorPadding: const EdgeInsets.only(),
                                indicatorColor: const Color(0XFF032040),
                                indicatorWeight: 4,
                                tabs: [
                                  Tab(
                                      child: Padding(
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    child: Container(
                                      width: sizeWidth * .4,
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                          AppLocalizations.of(context)!.players,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins")),
                                    ),
                                  )),
                                  Tab(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      child: Container(
                                        width: sizeWidth * .4,
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .joiningRequests,
                                          style: const TextStyle(
                                              // color: Color(0XFF032040),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Stack(
                              children: [
                                TabBarView(
                                  children: [
                                    Member(
                                      onChange: (count) {
                                        setState(() {
                                          memberId = count;
                                        });
                                      },
                                      onTeam: (team) {
                                        teamMember = team;
                                      },
                                    ),
                                    PendingMember(),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? EdgeInsets.only(
                                              left: sizeWidth * .1,
                                              right: sizeWidth * .05)
                                          : EdgeInsets.only(
                                              right: sizeWidth * .1,
                                              left: sizeWidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        30,
                                      ),
                                      addPlayer
                                          ? Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 50,
                                                  child: Container(),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    navigateToDetail();
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: sizeHeight * .04,
                                                    width: sizeWidth * .2,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        color: const Color(
                                                            0XFF032040)),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .search,
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.white,
                                                            fontSize: 13)),
                                                  ),
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                Container(
                                                  height: 40,
                                                  child: FloatingActionButton(
                                                    heroTag: null,
                                                    backgroundColor:
                                                        const Color(0xFF25A163),
                                                    splashColor: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        navigateToDetail();
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.search,
                                                      size: 15,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                      flaxibleGap(
                                        1,
                                      ),
                                      addPlayer
                                          ? Row(
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 50,
                                                  child: Container(),
                                                ),
                                                Material(
                                                  child: InkWell(
                                                    splashColor: Colors.black,
                                                    onTap: () {
                                                      Share.share(
                                                          'check out my website https://example.com',
                                                          subject:
                                                              'Look what I made!');
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      height: sizeHeight * .04,
                                                      width: sizeWidth * .2,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: const Color(
                                                              0XFF032040)),
                                                      child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .share,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  'Poppins',
                                                              decoration:
                                                                  TextDecoration
                                                                      .none,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13)),
                                                    ),
                                                  ),
                                                ),
                                                flaxibleGap(
                                                  1,
                                                ),
                                                Container(
                                                  height: 40,
                                                  child: FloatingActionButton(
                                                    backgroundColor:
                                                        const Color(0xFF25A163),
                                                    heroTag: null,
                                                    splashColor: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        Share.share(
                                                            'check out my website https://example.com',
                                                            subject:
                                                                'Look what I made!');
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.share,
                                                      size: 15,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Container(),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          flaxibleGap(
                                            6,
                                          ),
                                          addPlayer
                                              ? Container()
                                              : Text(
                                                  AppLocalizations.of(context)!
                                                      .addPlayers,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                      decoration:
                                                          TextDecoration.none,
                                                      color:
                                                          Color(0xFF25A163))),
                                          flaxibleGap(
                                            1,
                                          ),
                                          addPlayer
                                              ? Container(
                                                  height: 50,
                                                  child: FloatingActionButton(
                                                    backgroundColor:
                                                        const Color(0xFFD8D8D8),
                                                    heroTag: null,
                                                    child: const Icon(
                                                      Icons.clear,
                                                      size: 30,
                                                      color: Color(0XFF032040),
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        addPlayer = false;
                                                      });
                                                    },
                                                  ),
                                                )
                                              : Container(
                                                  height: 50,
                                                  child: FloatingActionButton(
                                                    heroTag: null,
                                                    backgroundColor:
                                                        const Color(0xFF25A163),
                                                    splashColor: Colors.black,
                                                    onPressed: () {
                                                      setState(() {
                                                        addPlayer = true;
                                                      });
                                                    },
                                                    child: const Icon(
                                                      Icons.add,
                                                      size: 30,
                                                    ),
                                                  ),
                                                )
                                        ],
                                      ),
                                      flaxibleGap(
                                        4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                    } else {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  });
                },
              );
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
            Container(
              height: sizeHeight * .25,
              width: sizeWidth,
              decoration: BoxDecoration(
                  color: const Color(0XFF032040),
                  image: DecorationImage(
                      image: AppLocalizations.of(context)!.locale == "en"
                          ? const AssetImage('assets/images/header.png')
                          : const AssetImage('assets/images/arabicHeader.png'),
                      fit: BoxFit.cover)),
              child: Padding(
                padding: EdgeInsets.only(
                    left: sizeWidth * .05, right: sizeWidth * .05),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: sizeHeight * .19,
                        width: sizeWidth * .3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: const ClipRRect(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                    flaxibleGap(
                      2,
                    ),
                    Container(
                      width: sizeWidth * .5,
                      height: sizeHeight * .19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          shimmer(width: sizeWidth * .6),
                          Flexible(
                            flex: 1,
                            child: Container(),
                          ),
                          shimmer(width: sizeWidth * .6),
                          flaxibleGap(
                            1,
                          ),
                          shimmer(width: sizeWidth * .2),
                          flaxibleGap(
                            1,
                          ),
                          Row(
                            children: <Widget>[
                              const Icon(
                                Icons.call,
                                color: Color(0xFFBCBCBC),
                                size: 20,
                              ),
                              Container(
                                width: 10,
                              ),
                              const Icon(
                                Icons.mail,
                                color: Color(0xFFBCBCBC),
                                size: 20,
                              ),
                              flaxibleGap(
                                1,
                              ),
                              shimmer(width: sizeWidth * .3),
                            ],
                          ),
                        ],
                      ),
                    ),
                    flaxibleGap(
                      4,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                enabled: true,
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
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Container(
                                  width: sizeWidth,
                                  height: 80.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToDetail() {
    Navigator.pushNamed(context, RouteNames.searchBar);
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }
}
