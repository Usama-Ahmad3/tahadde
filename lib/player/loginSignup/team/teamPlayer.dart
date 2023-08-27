import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/teamModelClass.dart';
import '../../../network/network_calls.dart';

class TeamPlayer extends StatefulWidget {
  @override
  _TeamPlayerState createState() => _TeamPlayerState();
}

class _TeamPlayerState extends State<TeamPlayer> {
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  bool? _internet;
  List<TeamModelClass> teamdata = [];

  loadData() {
    _networkCalls.player(
      onSuccess: (msg) {
        setState(() {
          _isLoading = false;
          teamdata = msg;
        });
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
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
        loadData();
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
        ? _buildLoadingShemmer(sizeWidth, sizeHeight)
        : _internet!
            ? SafeArea(
                child: Scaffold(
                  body: Container(
                    height: sizeHeight,
                    width: sizeWidth,
                    color: const Color(0xffff0f0f0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: sizeHeight * .25,
                          width: sizeWidth,
                          color: const Color(0XFF032040),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .05, right: sizeWidth * .03),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    height: sizeHeight * .19,
                                    width: sizeWidth * .3,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: cachedNetworkImage(
                                      cuisineImageUrl:
                                          teamdata[0].teamLogo?.filePath,
                                    )),
                                flaxibleGap(
                                  2,
                                ),
                                SizedBox(
                                  width: sizeWidth * .5,
                                  height: sizeHeight * .19,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      flaxibleGap(
                                        1,
                                      ),
                                      Text(
                                        teamdata[0].teamName.toString(),
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
                                          Text(
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? "${teamdata[0].countryCode ?? ""} ${teamdata[0].contactNumber ?? ""}"
                                                : "${teamdata[0].countryCode == null ? "" : teamdata[0].countryCode!.substring(1)} ${teamdata[0].contactNumber ?? ""}${teamdata[0].countryCode == null ? "" : teamdata[0].countryCode!.substring(0, 1)}",
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              decoration: TextDecoration.none,
                                              color: Color(0xFFBCBCBC),
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.mail,
                                            color: Color(0xFFBCBCBC),
                                            size: 20,
                                          ),
                                          Container(
                                            width: 10,
                                          ),
                                          SizedBox(
                                            width: sizeWidth * .4,
                                            child: Text(
                                                teamdata[0].email.toString(),
                                                style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12,
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Color(0xFFBCBCBC),
                                                )),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                      flaxibleGap(
                                        1,
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
                        Container(
                          height: sizeHeight * .02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Container(
                            height: sizeHeight * .13,
                            width: sizeWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Row(
                              children: <Widget>[
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                    height: sizeHeight * .09,
                                    width: sizeHeight * .09,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0XFF4F5C6A),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            sizeHeight * .09),
                                        child: cachedNetworkImage(
                                            cuisineImageUrl: teamdata[0]
                                                .captain
                                                ?.profile_pic
                                                ?.filePath,
                                            placeholder:
                                                "assets/images/profile.png"))),
                                flaxibleGap(
                                  1,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    flaxibleGap(
                                      2,
                                    ),
                                    Text(
                                      "${teamdata[0].captain!.first_name} ${teamdata[0].captain!.last_name}",
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0XFF032040)),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.captain,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Color(0XFF25A163)),
                                    ),
                                    teamdata[0].players!.isEmpty
                                        ? Text(
                                            "${teamdata[0].players!.length + 1} ${AppLocalizations.of(context)!.playerTeam}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFFBCBCBC)),
                                          )
                                        : Text(
                                            "${teamdata[0].players!.length + 1} ${AppLocalizations.of(context)!.playersTeam}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                color: Color(0xFFBCBCBC)),
                                          ),
                                    flaxibleGap(
                                      2,
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  6,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: sizeHeight * .02,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Text(AppLocalizations.of(context)!.teamplayers,
                              style: const TextStyle(
                                  color: Color(0XFF032040),
                                  fontFamily: "Poppins",
                                  fontSize: 14)),
                        ),
                        Container(
                          height: sizeHeight * .01,
                        ),
                        Expanded(
                          child: Container(
                              height: sizeHeight * .4,
                              color: Colors.white,
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: teamdata[0].players!.length,
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
                                                  padding: EdgeInsets.all(
                                                      sizeHeight * .01),
                                                  child: Container(
                                                      child: ClipRRect(
                                                          //clipBehavior: Clip.hardEdge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      50.0),
                                                          child:
                                                              cachedNetworkImage(
                                                            height: sizeHeight *
                                                                .08,
                                                            cuisineImageUrl:
                                                                teamdata[0]
                                                                    .players![
                                                                        index]
                                                                    ?.profile_pic
                                                                    ?.filePath,
                                                            placeholder:
                                                                "assets/images/profile.png",
                                                          ))),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(
                                                      sizeHeight * .005),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        flex: 1,
                                                        child: Container(),
                                                      ),
                                                      Text(
                                                          "${teamdata[0].players![index]!.first_name} ${teamdata[0].players![index]!.last_name}",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF032040),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 16)),
                                                      Text(
                                                          teamdata[0]
                                                                  .players![
                                                                      index]!
                                                                  .playerPosition!
                                                                  .name ??
                                                              "",
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF646464),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 12)),
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
        color: const Color(0xffff0f0f0),
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
                    SizedBox(
                      width: sizeWidth * .5,
                      height: sizeHeight * .19,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .6,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                          flaxibleGap(
                            1,
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
}
