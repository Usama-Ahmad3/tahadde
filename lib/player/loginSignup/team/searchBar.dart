import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/searchPlayerModelClass.dart';
import '../../../modelClass/teamModelClass.dart';
import '../../../network/network_calls.dart';

class SearchBarScreen extends StatefulWidget {
  const SearchBarScreen({super.key});

  @override
  _SearchBarScreenState createState() => _SearchBarScreenState();
}

class _SearchBarScreenState extends State<SearchBarScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TeamModelClass? teamInfoData;
  final NetworkCalls _networkCalls = NetworkCalls();
  List<SearchPlayerModelClass> searchData = [];
  bool _isLoading = true;
  final nameSearch = TextEditingController();
  String search = "";
  final focus = FocusNode();
  bool? _internet;
  bool _ignoring = true;

  void setIgnoring(bool newValue) {
    setState(() {
      _ignoring = newValue;
    });
  }

  headerData() {
    _networkCalls.teamInfo(
      teamType: "?team_type=internal",
      onSuccess: (msg) {
        teamInfoData = msg;
        loadData("");
      },
      onFailure: (msg) {
        showMessage(
          msg,
        );
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  loadData(String value) {
    _networkCalls.searchPlayer(
      search: value,
      onSuccess: (data) {
        setState(() {
          _ignoring = !_ignoring;
          searchData = data;
          _isLoading = false;
        });
      },
      onFailure: (msg) {
        setState(() {
          _isLoading = false;
          showMessage(msg);
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
      if (msg == true) {
        headerData();
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
    return Material(
      child: Scaffold(
          key: _scaffoldKey,
          body: _isLoading
              ? Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0XFFFFFFFF),
                  child: Column(
                    children: [
                      Container(
                        height: sizeHeight * .3,
                        width: sizeWidth,
                        color: const Color(0XFF032040),
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(0XFFFFFFFF),
                                ),
                              ),
                              flaxibleGap(4),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade100,
                                      enabled: true,
                                      child: Container(
                                        height: sizeHeight * .1,
                                        width: sizeWidth * .2,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    flaxibleGap(2),
                                    SizedBox(
                                      height: sizeHeight * .1,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          shimmer(width: sizeWidth * .5),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          shimmer(width: sizeWidth * .5),
                                        ],
                                      ),
                                    ),
                                    flaxibleGap(4),
                                  ],
                                ),
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 58.0,
                                      width: sizeWidth * .8,
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            right: sizeWidth * .01),
                                        child: searchbar(
                                            controller: nameSearch,
                                            node: focus,
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .searchplayerstahaddi,
                                            color: 0xFFDADADA,
                                            colorText: 0XFFD8D8D8,
                                            size: 12,
                                            textOpacity: .55,
                                            icon: 'assets/images/Shape.png',
                                            opacity: .28),
                                      ),
                                    ),
                                    flaxibleGap(1),
                                  ],
                                ),
                              ),
                              flaxibleGap(1),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: sizeHeight * .5,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: sizeWidth * .05,
                                    right: sizeWidth * .05,
                                    top: sizeHeight * .02),
                                child: Container(
                                  alignment:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? Alignment.centerLeft
                                          : Alignment.centerRight,
                                  child: Text(
                                      AppLocalizations.of(context)!
                                          .availablePlayers,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontFamily: "Poppins",
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeWidth * .05),
                                  child: SizedBox(
                                    height: sizeHeight * .5,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: 10,
                                        itemBuilder: (context, index) {
                                          return Column(
                                            children: [
                                              SizedBox(
                                                height: sizeHeight * .1,
                                                width: sizeWidth,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical:
                                                                  sizeHeight *
                                                                      .01),
                                                      child: Shimmer.fromColors(
                                                        baseColor: Colors
                                                            .grey.shade300,
                                                        highlightColor: Colors
                                                            .grey.shade100,
                                                        enabled: true,
                                                        child: Container(
                                                          height:
                                                              sizeHeight * .15,
                                                          width:
                                                              sizeHeight * .07,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          sizeHeight * .01),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          flaxibleGap(1),
                                                          shimmer(
                                                              width: sizeWidth *
                                                                  .5),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          shimmer(
                                                              width: sizeWidth *
                                                                  .2),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    ),
                                                    flaxibleGap(2),
                                                    shimmer(
                                                        width: sizeWidth * .15),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                height: 1,
                                                width: sizeWidth,
                                                color: Colors.grey,
                                              )
                                            ],
                                          );
                                        }),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : _internet!
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: const Color(0XFFFFFFFF),
                      child: Column(
                        children: [
                          Container(
                            height: sizeHeight * .3,
                            width: sizeWidth,
                            color: const Color(0XFF032040),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .05,
                                  right: sizeWidth * .05),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  flaxibleGap(3),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0XFFFFFFFF),
                                    ),
                                  ),
                                  flaxibleGap(1),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      //mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                            height: sizeHeight * .1,
                                            width: sizeWidth * .2,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                            ),
                                            child: cachedNetworkImage(
                                                cuisineImageUrl: teamInfoData
                                                    ?.captain
                                                    ?.profile_pic
                                                    ?.filePath,
                                                placeholder:
                                                    "assets/images/profile.png")),
                                        flaxibleGap(2),
                                        SizedBox(
                                          height: sizeHeight * .1,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Usama',
                                                // teamInfoData!.teamName
                                                //     .toString(),
                                                style: TextStyle(
                                                    fontSize: appHeaderFont,
                                                    color:
                                                        const Color(0XFFFFFFFF),
                                                    fontFamily:
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                "en"
                                                            ? "Poppins"
                                                            : "VIP",
                                                    fontWeight: AppLocalizations
                                                                    .of(context)!
                                                                .locale ==
                                                            "en"
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              const Text('Ahmad',
                                                  // "${teamInfoData!.captain!.first_name} ${teamInfoData!.captain!.last_name}",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16,
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                        flaxibleGap(4),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(1),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 58.0,
                                          width: sizeWidth * .8,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                right: sizeWidth * .01),
                                            child: searchbar(
                                                controller: nameSearch,
                                                onchange: (value) {
                                                  _networkCalls
                                                      .checkInternetConnectivity(
                                                          onSuccess: (msg) {
                                                    _internet = msg;
                                                    if (msg == true) {
                                                      setState(() {
                                                        search = value ?? "";
                                                        if (search == "") {
                                                          search = "";
                                                          loadData(search);
                                                        } else {
                                                          search =
                                                              "?player_name=$search";
                                                          loadData(search);
                                                        }
                                                      });
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
                                                node: focus,
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .searchplayerstahaddi,
                                                color: 0xFFDADADA,
                                                colorText: 0XFFD8D8D8,
                                                size: 12,
                                                textOpacity: .55,
                                                icon: 'assets/images/Shape.png',
                                                opacity: .28),
                                          ),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(1),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                              height: sizeHeight * .7,
                              child: Column(
                                children: [
                                  searchData.isNotEmpty
                                      ? Container()
                                      : Flexible(
                                          flex: 10,
                                          child: Container(),
                                        ),
                                  searchData.isNotEmpty
                                      ? Container()
                                      : SizedBox(
                                          height: sizeHeight * .2,
                                          width: sizeHeight * .2,
                                          child: Icon(
                                            Icons.search,
                                            size: sizeHeight * .2,
                                            color: const Color(0XFFD6D6D6)
                                                .withOpacity(.2),
                                          )),
                                  searchData.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: sizeWidth * .05,
                                              right: sizeWidth * .05,
                                              top: sizeHeight * .02),
                                          child: Container(
                                            alignment:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? Alignment.centerLeft
                                                    : Alignment.centerRight,
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .availablePlayers,
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontFamily: "Poppins",
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
                                        )
                                      : Text(
                                          AppLocalizations.of(context)!
                                              .noplayershavebeenfoundnearyou,
                                          style: const TextStyle(
                                              color: Color(0XFFADADAD),
                                              fontFamily: "Poppins",
                                              fontSize: 14)),
                                  searchData.isNotEmpty
                                      ? Container()
                                      : flaxibleGap(30),
                                  Expanded(
                                    child: IgnorePointer(
                                      ignoring: _ignoring,
                                      child: Container(
                                          height: sizeHeight * .65,
                                          color: Colors.white,
                                          child: ListView.builder(
                                              scrollDirection: Axis.vertical,
                                              itemCount: searchData.length,
                                              itemBuilder: (context, index) {
                                                return searchData[index]
                                                            .is_sent ==
                                                        true
                                                    ? Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    sizeWidth *
                                                                        .05),
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height:
                                                                  sizeHeight *
                                                                      .1,
                                                              width: sizeWidth,
                                                              color: const Color(
                                                                      0xFF25A163)
                                                                  .withOpacity(
                                                                      .25),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.all(
                                                                        sizeHeight *
                                                                            .01),
                                                                    child: ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                50.0),
                                                                        child: cachedNetworkImage(
                                                                            height: sizeHeight *
                                                                                .08,
                                                                            width: sizeHeight *
                                                                                .08,
                                                                            cuisineImageUrl:
                                                                                searchData[index].profile_pic?.filePath,
                                                                            placeholder: "images/profile.png")),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.all(
                                                                        sizeHeight *
                                                                            .005),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <Widget>[
                                                                        flaxibleGap(
                                                                            1),
                                                                        SizedBox(
                                                                          width:
                                                                              sizeWidth * .5,
                                                                          child: Text(
                                                                              "${searchData[index].first_name} ${searchData[index].last_name}",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(color: Color(0XFF032040), fontWeight: FontWeight.w700, fontFamily: "Poppins", fontSize: 16)),
                                                                        ),
                                                                        Text(
                                                                            searchData[index].playerPosition!.name.toString() ??
                                                                                "",
                                                                            style: const TextStyle(
                                                                                color: Color(0XFF646464),
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "Poppins",
                                                                                fontSize: 12)),
                                                                        flaxibleGap(
                                                                            1),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  flaxibleGap(
                                                                      2),
                                                                  Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      height:
                                                                          sizeHeight *
                                                                              .04,
                                                                      width: sizeWidth *
                                                                          .15,
                                                                      color: Colors
                                                                          .transparent,
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .sent,
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Color(0xFF25A163)),
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              height: 1,
                                                              width: sizeWidth,
                                                              color:
                                                                  Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : GestureDetector(
                                                        onTap: () {
                                                          _networkCalls
                                                              .checkInternetConnectivity(
                                                                  onSuccess:
                                                                      (msg) {
                                                            _internet = msg;
                                                            if (msg == true) {
                                                              setIgnoring(
                                                                  !_ignoring);
                                                              Map detail = {
                                                                "playerId":
                                                                    searchData[
                                                                            index]
                                                                        .id
                                                              };
                                                              _networkCalls
                                                                  .captainInvitationSend(
                                                                id: detail,
                                                                onSuccess:
                                                                    (msg) {
                                                                  showSucess(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .sendMessage,
                                                                      _scaffoldKey);
                                                                  loadData(
                                                                      search);
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
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      sizeWidth *
                                                                          .05),
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    sizeHeight *
                                                                        .1,
                                                                width:
                                                                    sizeWidth,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Padding(
                                                                      padding: EdgeInsets.all(
                                                                          sizeHeight *
                                                                              .01),
                                                                      child: Container(
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50.0),
                                                                              child: cachedNetworkImage(height: sizeHeight * .08, width: sizeHeight * .08, cuisineImageUrl: searchData[index].profile_pic?.filePath, placeholder: "images/profile.png"))),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsets.all(
                                                                          sizeHeight *
                                                                              .005),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          flaxibleGap(
                                                                              1),
                                                                          SizedBox(
                                                                            width:
                                                                                sizeWidth * .5,
                                                                            child: Text("${searchData[index].first_name} ${searchData[index].last_name}",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: const TextStyle(color: Color(0XFF032040), fontWeight: FontWeight.w700, fontFamily: "Poppins", fontSize: 16)),
                                                                          ),
                                                                          Text(
                                                                              searchData[index].playerPosition!.name.toString() ?? " ",
                                                                              style: const TextStyle(color: Color(0XFF646464), fontWeight: FontWeight.w500, fontFamily: "Poppins", fontSize: 12)),
                                                                          flaxibleGap(
                                                                              1),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    flaxibleGap(
                                                                        1),
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .center,
                                                                        height: sizeHeight *
                                                                            .04,
                                                                        width: sizeWidth *
                                                                            .15,
                                                                        color: const Color(
                                                                            0xFF25A163),
                                                                        child:
                                                                            Text(
                                                                          AppLocalizations.of(context)!
                                                                              .send,
                                                                          style:
                                                                              const TextStyle(color: Colors.white),
                                                                        )),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 1,
                                                                width:
                                                                    sizeWidth,
                                                                color:
                                                                    Colors.grey,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                              })),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : InternetLoss(
                      onChange: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          _internet = msg;
                          if (msg == true) {
                            headerData();
                          }
                        });
                      },
                    )),
    );
  }
}
