import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class Member extends StatefulWidget {
  Function(int count)? onChange;
  Function(bool team)? onTeam;
  Member({this.onChange, this.onTeam});
  @override
  _MemberState createState() => _MemberState();
}

class _MemberState extends State<Member> {
  var teamdata;
  int? select;
  bool? internet;
  bool _isLoading = true;
  String date = "name";
  final NetworkCalls _networkCalls = NetworkCalls();
  loadData() {
    _networkCalls.captainMember(
      onSuccess: (msg) {
        setState(() {
          teamdata = msg;
          _isLoading = false;
          widget.onTeam!(teamdata.players.isNotEmpty ? true : false);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
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
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
            child: SizedBox(
              height: sizeHeight * .5,
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
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
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
        : internet!
            ? Scaffold(
                backgroundColor: const Color(0XFFF0F0F0),
                body: teamdata.players.isNotEmpty
                    ? Container(
                        height: sizeHeight * .65,
                        color: Colors.white,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: teamdata!.players!.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05,
                                    vertical: sizeHeight * .01),
                                child: Column(
                                  children: [
                                    Dismissible(
                                      key: UniqueKey(),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          internet = msg;
                                          if (msg == true) {
                                            _networkCalls.deletePlayer(
                                              id: teamdata!.players![index]!.id
                                                  .toString(),
                                              onSuccess: (msg) {
                                                setState(() {
                                                  _isLoading = true;
                                                  loadData();
                                                });
                                              },
                                              onFailure: (msg) {
                                                showMessage(msg);
                                              },
                                              tokenExpire: () {
                                                if (mounted) on401(context);
                                              },
                                            );
                                          } else {
                                            if (mounted) {
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        });
                                      },
                                      background: Container(
                                        color: Colors.red,
                                        child: Row(
                                          children: [
                                            flaxibleGap(
                                              1,
                                            ),
                                            Image.asset("images/deleteMem.png"),
                                          ],
                                        ),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (select == index) {
                                              select = null;
                                              widget.onChange!;
                                            } else {
                                              select = index;
                                              widget.onChange!(teamdata!
                                                  .players![index]!.id as int);
                                            }
                                          });
                                        },
                                        child: SizedBox(
                                          height: sizeHeight * .1,
                                          width: sizeWidth,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(
                                                    sizeHeight * .01),
                                                child: Container(
                                                    child: ClipRRect(
                                                  //clipBehavior: Clip.hardEdge,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  child: teamdata!
                                                              .players![index]!
                                                              .profile_pic ==
                                                          null
                                                      ? Image.asset(
                                                          "assets/images/profile.png",
                                                        )
                                                      : CachedNetworkImage(
                                                          fit: BoxFit.fill,
                                                          height:
                                                              sizeHeight * .08,
                                                          width:
                                                              sizeHeight * .08,
                                                          imageUrl: teamdata!
                                                              .players![index]!
                                                              .profile_pic!
                                                              .filePath
                                                              .toString(),
                                                          placeholder:
                                                              (context, url) {
                                                            return Image.asset(
                                                              'assets/images/T.png',
                                                            );
                                                          },
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              const Icon(
                                                                  Icons.error),
                                                        ),
                                                )),
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
                                                    Text(
                                                        "${teamdata!.players![index]!.first_name} ${teamdata!.players![index]!.last_name}",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 16)),
                                                    Text(
                                                        teamdata!
                                                                .players![
                                                                    index]!
                                                                .playerPosition!
                                                                .name
                                                                .toString() ??
                                                            "",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF646464),
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                              select == index
                                                  ? Image.asset(
                                                      "assets/images/check.png")
                                                  : Container(),
                                            ],
                                          ),
                                        ),
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
                                'assets/assets/images/Group.png',
                                fit: BoxFit.fill,
                              )),
                          flaxibleGap(
                            4,
                          ),
                          Text(
                              AppLocalizations.of(context)!
                                  .noplayershavebeenaddedyet,
                              style: const TextStyle(
                                  color: Color(0XFF424242),
                                  fontFamily: "Poppins",
                                  fontSize: 14)),
                          flaxibleGap(
                            31,
                          ),
                        ],
                      ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      loadData();
                    }
                  });
                },
              );
  }
}
