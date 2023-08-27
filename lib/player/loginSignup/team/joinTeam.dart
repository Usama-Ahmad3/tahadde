import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/teamModelClass.dart';
import '../../../network/network_calls.dart';

class JoinTeam extends StatefulWidget {
  TeamModelClass? detailTeam;

  JoinTeam({this.detailTeam});

  @override
  _JoinTeamState createState() => _JoinTeamState();
}

class _JoinTeamState extends State<JoinTeam> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? _auth;
  String? subToken;
  bool loading = true;
  bool? _internet;
  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() async {
    _auth = await checkAuthorizaton();
    _networkCalls.role(
      onSuccess: (msg) {
        setState(() {
          subToken = msg["sub-role"];
          loading = false;
        });
      },
      onFailure: (msg) {
        setState(() {
          loading = false;
        });
      },
//      tokenExpire: () {
//      if (mounted) on401(context);
//    },
    );
  }

  Future onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            //title: Text('Are you sure?'),
            content:
                Text(AppLocalizations.of(context)!.needcreateaccountorlogin),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.login),
                onPressed: () {
                  navigateToDetail1();
                },
              )
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
      _internet = msg;
      msg
          ? loadProfile()
          : setState(() {
              loading = false;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return loading
        ? Material(
            child: Scaffold(
              backgroundColor: const Color(0XFF032040),
              key: _scaffoldKey,
              bottomNavigationBar: Material(
                color: const Color(0XFF25A163),
                child: Container(
                    height: sizeHeight * .09,
                    alignment: Alignment.center,
                    child: Text(
                      AppLocalizations.of(context)!.requestjointeam,
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          color: Colors.white),
                    )),
              ),
              body: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: const Color(0XFFFFFFFF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: sizeHeight * .2,
                      width: sizeWidth,
                      color: const Color(0XFF032040),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05, right: sizeWidth * .05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0XFFFFFFFF),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      height: 5,
                                      width: sizeWidth * .5,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0) //

                                            ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 2,
                                    child: Container(),
                                  ),
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      height: sizeHeight * .1,
                                      width: sizeWidth * .2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: sizeHeight * .1,
                      color: const Color(0XFFF0F0F0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .05),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              enabled: true,
                              child: Container(
                                height: sizeHeight * .08,
                                width: sizeHeight * .08,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  // image: Image.network(profileDetail.profile_pic),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: sizeHeight * .08,
                            width: sizeWidth * .5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade300,
                                  enabled: true,
                                  child: Container(
                                    height: 5,
                                    width: sizeWidth * .5,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

                                          ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.captainC,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          color: Color(0XFF25A163),
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                        height: 14,
                                        width: 1,
                                        color: const Color(0XFFADADAD)),
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: Container(
                                        height: 5,
                                        width: sizeWidth * .2,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0) //

                                              ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05,
                            top: sizeHeight * .02),
                        child: Text(
                            AppLocalizations.of(context)!.currentPlayers,
                            style: const TextStyle(
                                color: Color(0XFF032040),
                                fontFamily: "Poppins",
                                fontSize: 14))),
                    Expanded(
                      child: SizedBox(
                          height: sizeHeight * .45,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeWidth * .05),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: sizeHeight * .1,
                                        width: sizeWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: sizeHeight * .01,
                                              ),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                    Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  height: sizeHeight * .08,
                                                  width: sizeHeight * .08,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10))),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.all(
                                                  sizeHeight * .005),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 1,
                                                    child: Container(),
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      height: 5,
                                                      width: sizeWidth * .5,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0) //

                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey.shade300,
                                                    highlightColor:
                                                        Colors.grey.shade100,
                                                    enabled: true,
                                                    child: Container(
                                                      height: 5,
                                                      width: sizeWidth * .3,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0) //

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
                                );
                              })),
                    )
                  ],
                ),
              ),
            ),
          )
        : _internet!
            ? Material(
                child: Scaffold(
                  backgroundColor: const Color(0XFF032040),
                  key: _scaffoldKey,
                  bottomNavigationBar: subToken != null
                      ? Container(
                          height: 0,
                        )
                      : Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              _auth!
                                  ? navigateToEnterDetailJoinTeam()
                                  : onWillPop();
                            },
                            splashColor: Colors.black,
                            child: Container(
                                height: sizeHeight * .09,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.requestjointeam,
                                  style: const TextStyle(
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white),
                                )),
                          ),
                        ),
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: const Color(0XFFFFFFFF),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: sizeHeight * .2,
                          width: sizeWidth,
                          color: const Color(0XFF032040),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .05, right: sizeWidth * .05),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0XFFFFFFFF),
                                  ),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    //mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: sizeHeight * .1,
                                        width: sizeWidth * .5,
                                        child: Text(
                                          widget.detailTeam!.teamName
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: const Color(0XFFFFFFFF),
                                              fontFamily:
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          "en"
                                                      ? "Poppins"
                                                      : "VIP",
                                              fontWeight:
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          "en"
                                                      ? FontWeight.bold
                                                      : FontWeight.normal),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      flaxibleGap(2),
                                      SizedBox(
                                          height: sizeHeight * .1,
                                          width: sizeWidth * .2,
                                          child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10.0)),
                                              child: cachedNetworkImage(
                                                  cuisineImageUrl: widget
                                                      .detailTeam
                                                      ?.teamLogo
                                                      ?.filePath,
                                                  placeholder:
                                                      'images/profile.png'))),
                                    ],
                                  ),
                                ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeHeight * .1,
                          color: const Color(0XFFF0F0F0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: Container(
                                    height: sizeHeight * .08,
                                    width: sizeHeight * .08,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0XFF4F5C6A),
                                      // image: Image.network(profileDetail.profile_pic),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            sizeHeight * .1),
                                        child: cachedNetworkImage(
                                            cuisineImageUrl: widget.detailTeam!
                                                .captain?.profile_pic?.filePath,
                                            placeholder:
                                                'images/profile.png'))),
                              ),
                              SizedBox(
                                height: sizeHeight * .08,
                                width: sizeWidth * .5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: sizeWidth * .5,
                                      child: Text(
                                        "${widget.detailTeam!.captain!.first_name} ${widget.detailTeam!.captain!.last_name}",
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .captainC,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: Color(0XFF25A163),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Container(
                                            height: 14,
                                            width: 1,
                                            color: const Color(0XFFADADAD)),
                                        Text(
                                          widget.detailTeam!.captain!
                                                  .playerPosition!.name ??
                                              "",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: Color(0XFFADADAD),
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05,
                              right: sizeWidth * .05,
                              top: sizeHeight * .02),
                          child: widget.detailTeam!.players!.isNotEmpty
                              ? Text(
                                  AppLocalizations.of(context)!.currentPlayers,
                                  style: const TextStyle(
                                      color: Color(0XFF032040),
                                      fontFamily: "Poppins",
                                      fontSize: 14))
                              : Container(),
                        ),
                        Expanded(
                          child: SizedBox(
                              height: sizeHeight * .45,
                              child: widget.detailTeam!.players!.isNotEmpty
                                  ? ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          widget.detailTeam!.players!.length,
                                      itemBuilder: (context, index) {
                                        print(widget.detailTeam!.players![index]
                                            ?.profile_pic?.filePath);
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: sizeHeight * .1,
                                                width: sizeWidth,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          sizeHeight * .01),
                                                      child: ClipRRect(
                                                          //clipBehavior: Clip.hardEdge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                          child: cachedNetworkImage(
                                                              height:
                                                                  sizeHeight *
                                                                      .08,
                                                              width:
                                                                  sizeHeight *
                                                                      .08,
                                                              cuisineImageUrl: widget
                                                                  .detailTeam!
                                                                  .players![
                                                                      index]
                                                                  ?.profile_pic
                                                                  ?.filePath,
                                                              placeholder:
                                                                  'images/profile.png')),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          sizeHeight * .005),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          flaxibleGap(1),
                                                          Text(
                                                              "${widget.detailTeam!.players![index]!.first_name} ${widget.detailTeam!.players![index]!.last_name}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF032040),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      16)),
                                                          Text(
                                                              // ignore: prefer_if_null_operators
                                                              widget
                                                                          .detailTeam!
                                                                          .players![
                                                                              index]!
                                                                          .playerPosition!
                                                                          .name
                                                                          .toString() !=
                                                                      null
                                                                  ? widget
                                                                      .detailTeam!
                                                                      .players![
                                                                          index]!
                                                                      .playerPosition!
                                                                      .name
                                                                      .toString()
                                                                  : "",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF646464),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      12)),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    ),
                                                    flaxibleGap(6),
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
                                        );
                                      })
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        flaxibleGap(10),
                                        SizedBox(
                                            height: sizeHeight * .2,
                                            width: sizeHeight * .2,
                                            child: Image.asset(
                                              'assets/images/Group.png',
                                              fit: BoxFit.fill,
                                            )),
                                        flaxibleGap(4),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .noplayershavebeenaddedyet,
                                            style: const TextStyle(
                                                color: Color(0XFF424242),
                                                fontFamily: "Poppins",
                                                fontSize: 14)),
                                        flaxibleGap(31),
                                      ],
                                    )),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : InternetLoss(onChange: () {
                _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                  _internet = msg;
                  if (msg == true) loadProfile();
                });
              });
  }

  void navigateToEnterDetailJoinTeam() {
    Navigator.pushNamed(context, RouteNames.enterDetailJoinTeam,
        arguments: widget.detailTeam);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }
}
