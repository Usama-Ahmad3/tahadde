import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchModelClass.dart';
import '../../network/network_calls.dart';

class CreateEventSecond extends StatefulWidget {
  Map event;
  CreateEventSecond({super.key, required this.event});
  @override
  _CreateEventSecondState createState() => _CreateEventSecondState();
}

class _CreateEventSecondState extends State<CreateEventSecond> {
  bool _isLoading = true;
  late List<BookPitchDetail> _pitchDetail;
  late int pitchId;
  late int subPitchId;
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool varifyPitch = false;
  late String _facility;
  late String pitchType;
  List<int> indexList = [];
  late int count;
  late int countPitch;
  late String pitchTypeArea;
  Future<bool?> onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(
              widget.event['event'] == "League"
                  ? AppLocalizations.of(context)!.areCreateleague
                  : AppLocalizations.of(context)!.areCreateTournament,
              style: const TextStyle(
                  color: Color(0XFF032040),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0XFFA3A3A3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("  ${AppLocalizations.of(context)!.cancel}  ",
                          style: const TextStyle(color: Color(0XFF696969))),
                    )),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0XFF25A163),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("  ${AppLocalizations.of(context)!.confirm}  ",
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      _facility = "";
                      for (int i = 0; i < indexList.length; i++) {
                        print(indexList);
                        _facility = "$_facility${facilitySlug[i]},";
                      }
                      _facility = _facility.substring(0, _facility.length - 1);
                      _facility = _facility.substring(0);
                      widget.event['event'] == "League"
                          ? widget.event["leagueLocation"] =
                              _pitchDetail[0].location
                          : widget.event["tournamentLocation"] =
                              _pitchDetail[0].location;
                      widget.event["subpitchtypeId"] = subPitchId;
                      widget.event["pitchId"] = pitchId;
                      widget.event["facilitySlug"] = _facility;
                      Map newMap = {
                        for (var e
                            in widget.event.keys.where((k) => k != "event"))
                          e: widget.event[e]
                      };
                      widget.event['event'] == "League"
                          ? _networkCalls.createLeague(
                              detail: newMap,
                              onSuccess: (msg) {
                                if (mounted) navigateToOwnerHome();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {
                                if (mounted) on401(context);
                              })
                          : _networkCalls.createTournament(
                              detail: newMap,
                              onSuccess: (msg) {
                                if (mounted) navigateToOwnerHome();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {
                                if (mounted) on401(context);
                              });
                    } else {
                      showMessage(
                          AppLocalizations.of(context)!.noInternetConnection);
                    }
                  });
                },
              )
            ],
          );
        });
  }

  veryfiedPitch() async {
    await _networkCalls.verifiedPitch(
      onSuccess: (pitchInfo) {
        _pitchDetail = pitchInfo;
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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
    veryfiedPitch();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
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
                widget.event["event"] == "League"
                    ? AppLocalizations.of(context)!.createLeague
                    : AppLocalizations.of(context)!.createTournament,
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
            bottomNavigationBar: Container(
                height: sizeHeight * .104,
                color: const Color(0XFFBCBCBC),
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.finish,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                )),
            body: SingleChildScrollView(
              child: SizedBox(
                height: sizeHeight * .79,
                width: sizeWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: sizeHeight * .006,
                          width: sizeWidth * .495,
                          color: const Color(0XFF25A163),
                        ),
                        Flexible(
                          flex: 1,
                          child: Container(),
                        ),
                        Container(
                          height: sizeHeight * .006,
                          width: sizeWidth * .495,
                          color: const Color(0XFF25A163),
                        ),
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                      child: Text(
                        widget.event["event"] == "League"
                            ? AppLocalizations.of(context)!
                                .selectAsidePitchLeague
                            : AppLocalizations.of(context)!
                                .selectAsidePitchTournament,
                        style: const TextStyle(
                            color: Color(0XFF032040),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .1, top: sizeHeight * .03),
                      child: SizedBox(
                        height: 110,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: sizeHeight * .01),
                              child: Material(
                                elevation: 10,
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade300,
                                  enabled: true,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                    ),
                                    width: 250,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .1, top: sizeHeight * .03),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .chooseFacilitiesProvided,
                          style: const TextStyle(
                            decoration: TextDecoration.none,
                            // color: Color(0XFF25A163),
                            color: Color(0XFFADADAD),
                            fontSize: 15,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, bottom: 10),
                      child: SizedBox(
                        height: sizeHeight * .13,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: facility.length,
                            itemBuilder: (BuildContext context, int blockIdx) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                  width: sizeWidth * .28,
                                  height: sizeWidth * .07,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0XFFA3A3A3)),
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Flexible(
                                        flex: 2,
                                        child: Container(),
                                      ),
                                      Image.asset(
                                        facilityImage[blockIdx],
                                        width: sizeWidth * .1,
                                        height: sizeWidth * .1,
                                        fit: BoxFit.fill,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                      Text(facility[blockIdx],
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              color: Color(0XFF424242),
                                              decoration: TextDecoration.none)),
                                      Flexible(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Stack(
            children: <Widget>[
              Scaffold(
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
                    widget.event["event"] == "League"
                        ? AppLocalizations.of(context)!.createLeague
                        : AppLocalizations.of(context)!.createTournament,
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
                bottomNavigationBar: indexList.isNotEmpty
                    ? Material(
                        color: const Color(0XFF25A163),
                        child: InkWell(
                          onTap: () {
                            onWillPop();
                          },
                          child: Container(
                              height: sizeHeight * .104,
                              color: const Color(0XFF25A163),
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.finish,
                                style: const TextStyle(
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              )),
                        ))
                    : Container(
                        height: sizeHeight * .104,
                        color: const Color(0XFFBCBCBC),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.finish,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: sizeHeight * .79,
                    width: sizeWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              height: sizeHeight * .006,
                              width: sizeWidth * .495,
                              color: const Color(0XFF25A163),
                            ),
                            flaxibleGap(1),
                            Container(
                              height: sizeHeight * .006,
                              width: sizeWidth * .495,
                              color: const Color(0XFF25A163),
                            ),
                          ],
                        ),
                        flaxibleGap(1),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Text(
                            widget.event["event"] == "League"
                                ? AppLocalizations.of(context)!
                                    .selectAsidePitchLeague
                                : AppLocalizations.of(context)!
                                    .selectAsidePitchTournament,
                            style: const TextStyle(
                                color: Color(0XFF032040),
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .1, top: sizeHeight * .03),
                          child: SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: RouteNames.pitchDetail.length,
                              itemBuilder: (context, index) {
                                return countPitch == index
                                    ? GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            varifyPitch = true;
                                            countPitch = index;
                                            pitchId = _pitchDetail[index].id!;
                                          });
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color(0XFF032040),
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? EdgeInsets.symmetric(
                                                        horizontal:
                                                            sizeWidth * .01,
                                                        vertical:
                                                            sizeHeight * .01)
                                                    : EdgeInsets.only(
                                                        right: sizeWidth * .01,
                                                      ),
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      // border: Border.all(color: Colors.black),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0) //                 <--- border radius here
                                                              ),
                                                    ),
                                                    height: 140,
                                                    width: 100,
                                                    child: cachedNetworkImage(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      cuisineImageUrl:
                                                          _pitchDetail[index]
                                                              .bookpitchfiles
                                                              ?.files![0]
                                                              ?.filePath,
                                                    )),
                                              ),
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? const EdgeInsets.only(
                                                        left: 10.0)
                                                    : const EdgeInsets.only(
                                                        right: 10.0,
                                                      ),
                                                child: Expanded(
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 140,
                                                            //minWidth: 50,
                                                            maxHeight: 75,
                                                            minHeight: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        flaxibleGap(1),
                                                        Text(
                                                          _pitchDetail[index]
                                                              .name
                                                              .toString(),
                                                          style: const TextStyle(
                                                              height: 1,
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0XFF25A163),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                        flaxibleGap(1),
                                                        SizedBox(
                                                          height: 40,
                                                          child: Text(
                                                            _pitchDetail[index]
                                                                .location
                                                                .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 4,
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                height: 1,
                                                                color: Color(
                                                                    0XFFA3A3A3)),
                                                          ),
                                                        ),
                                                        Text(
                                                          ('$pitchTypeArea ${AppLocalizations.of(context)!.asidePitch}'),
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Material(
                                        elevation: 10,
                                        child: GestureDetector(
                                          onTap: () {
                                            if (mounted) {
                                              setState(() {
                                                varifyPitch = true;
                                                countPitch = index;
                                                pitchId =
                                                    _pitchDetail[index].id!;
                                              });
                                            }
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? EdgeInsets.symmetric(
                                                        horizontal:
                                                            sizeWidth * .01,
                                                        vertical:
                                                            sizeHeight * .01)
                                                    : EdgeInsets.only(
                                                        right: sizeWidth * .01,
                                                      ),
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5.0) //                 <--- border radius here
                                                              ),
                                                    ),
                                                    height: 140,
                                                    width: 100,
                                                    child: cachedNetworkImage(
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      cuisineImageUrl:
                                                          _pitchDetail[index]
                                                              .bookpitchfiles
                                                              ?.files![0]
                                                              ?.filePath,
                                                    )),
                                              ),
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? const EdgeInsets.only(
                                                        left: 10.0)
                                                    : const EdgeInsets.only(
                                                        right: 10.0,
                                                      ),
                                                child: Container(
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 140,
                                                          //minWidth: 50,
                                                          maxHeight: 75,
                                                          minHeight: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      flaxibleGap(1),
                                                      Text(
                                                        _pitchDetail[index]
                                                            .name
                                                            .toString(),
                                                        style: const TextStyle(
                                                            height: 1,
                                                            fontSize: 12,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      flaxibleGap(1),
                                                      SizedBox(
                                                        height: 40,
                                                        child: Text(
                                                          _pitchDetail[index]
                                                              .location
                                                              .toString(),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 4,
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              height: 1,
                                                              color: Color(
                                                                  0XFFA3A3A3)),
                                                        ),
                                                      ),
                                                      flaxibleGap(1),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .1, top: sizeHeight * .03),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .chooseFacilitiesProvided,
                              style: const TextStyle(
                                decoration: TextDecoration.none,
                                // color: Color(0XFF25A163),
                                color: Color(0XFFADADAD),
                                fontSize: 15,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, bottom: 10),
                          child: SizedBox(
                            height: sizeHeight * .13,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: facility.length,
                                itemBuilder:
                                    (BuildContext context, int blockIdx) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (indexList.contains(blockIdx)) {
                                            indexList.remove(blockIdx);
                                          } else {
                                            indexList.add(blockIdx);
                                          }
                                        });
                                      },
                                      child: indexList.contains(blockIdx)
                                          ? Container(
                                              width: sizeWidth * .28,
                                              height: sizeWidth * .07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0XFFA3A3A3)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF25A163)
                                                    .withOpacity(.3),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  flaxibleGap(2),
                                                  Image.asset(
                                                    facilityImageS[blockIdx],
                                                    width: sizeWidth * .1,
                                                    height: sizeWidth * .1,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  flaxibleGap(1),
                                                  Text(facility[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  flaxibleGap(1),
                                                ],
                                              ),
                                            )
                                          : Container(
                                              width: sizeWidth * .28,
                                              height: sizeWidth * .07,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0XFFA3A3A3)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: Colors.white,
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  flaxibleGap(2),
                                                  Image.asset(
                                                    facilityImage[blockIdx],
                                                    width: sizeWidth * .1,
                                                    height: sizeWidth * .1,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  flaxibleGap(1),
                                                  Text(facility[blockIdx],
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  flaxibleGap(1),
                                                ],
                                              ),
                                            ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        flaxibleGap(6),
                      ],
                    ),
                  ),
                ),
              ),
              varifyPitch
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(.2),
                      ),
                    )
                  : Container(),
              varifyPitch
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * .07),
                        child: Container(
                          height: sizeHeight * .5,
                          width: sizeWidth,
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                        widget.event == "League"
                                            ? AppLocalizations.of(context)!
                                                .selectAsidePitchLeague
                                            : AppLocalizations.of(context)!
                                                .selectAsidePitchTournament,
                                        style: const TextStyle(
                                            decoration: TextDecoration.none,
                                            color: Color(0XFFADADAD),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins")),
                                    flaxibleGap(1),
                                    SizedBox(
                                      height: sizeHeight * .035,
                                      child: FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            varifyPitch = false;
                                            count = 0;
                                            countPitch = 0;
                                          });
                                        },
                                        backgroundColor:
                                            const Color(0XFFD8D8D8),
                                        splashColor: Colors.black,
                                        child: Image.asset(
                                          "images/deletImage.png",
                                          height: sizeHeight * .03,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: SizedBox(
                                  height: sizeHeight * .3,
                                  child: ListView.builder(
                                      itemCount: _pitchDetail[countPitch]
                                          .pitchType!
                                          .length,
                                      itemBuilder:
                                          (BuildContext context, int blockIdx) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Material(
                                              color: Colors.white,
                                              elevation: 5,
                                              child: Container(
                                                height: sizeHeight * .08,
                                                width: sizeHeight * .6,
                                                alignment: Alignment.center,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            if (count ==
                                                                blockIdx) {
                                                              count = 0;
                                                              subPitchId = 0;
                                                            } else {
                                                              count = blockIdx;
                                                            }
                                                            subPitchId =
                                                                _pitchDetail[
                                                                        countPitch]
                                                                    .pitchType![
                                                                        blockIdx]!
                                                                    .id!
                                                                    .toInt();
                                                            pitchTypeArea = _pitchDetail[
                                                                            countPitch]
                                                                        .pitchType![
                                                                            blockIdx]!
                                                                        .area!
                                                                        .length ==
                                                                    3
                                                                ? _pitchDetail[
                                                                        countPitch]
                                                                    .pitchType![
                                                                        blockIdx]!
                                                                    .area![0]
                                                                : _pitchDetail[
                                                                        countPitch]
                                                                    .pitchType![
                                                                        blockIdx]!
                                                                    .area!
                                                                    .substring(
                                                                        0, 2);
                                                          });
                                                        },
                                                        child: SizedBox(
                                                          height:
                                                              sizeHeight * .03,
                                                          width:
                                                              sizeHeight * .03,
                                                          child: count ==
                                                                  blockIdx
                                                              //checks.contains(blockIdx)
                                                              ? Image.asset(
                                                                  "images/checks.png",
                                                                  height:
                                                                      sizeHeight *
                                                                          .03,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                )
                                                              : Image.asset(
                                                                  "images/unchecks.png",
                                                                  height:
                                                                      sizeHeight *
                                                                          .03,
                                                                  fit: BoxFit
                                                                      .fill,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      _pitchDetail[countPitch]
                                                          .pitchType![blockIdx]!
                                                          .area
                                                          .toString(),
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color:
                                                              Color(0XFF032040),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 10),
                                                      child: Container(
                                                        height:
                                                            sizeHeight * .04,
                                                        color: const Color(
                                                            0XFF979797),
                                                        width: 2,
                                                      ),
                                                    ),
                                                    Text(
                                                      _pitchDetail[countPitch]
                                                          .pitchType![blockIdx]!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color:
                                                              Color(0XFF696969),
                                                          fontFamily: 'Poppins',
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    flaxibleGap(1),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              flaxibleGap(
                                3,
                              ),
                              count != null
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          varifyPitch = false;
                                        });
                                      },
                                      child: Container(
                                          color: const Color(0XFF25A163),
                                          height: sizeHeight * .08,
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!.save,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                            ),
                                          )),
                                    )
                                  : Container(
                                      color: const Color(0XFFBCBCBC),
                                      height: sizeHeight * .08,
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.save,
                                        style: const TextStyle(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Poppins",
                                        ),
                                      )),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
  }

  void navigateToOwnerHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.homePitchOwner, (r) => false);
  }
}
