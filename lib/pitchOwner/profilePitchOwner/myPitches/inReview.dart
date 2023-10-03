import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/bookPitchModelClass.dart';
import '../../../network/network_calls.dart';

class ReviewPitch extends StatefulWidget {
  const ReviewPitch({super.key});

  @override
  _ReviewPitchState createState() => _ReviewPitchState();
}

class _ReviewPitchState extends State<ReviewPitch> {
  late bool _internet;
  bool _isLoading = true;
  String date = "name";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  List<BookPitchDetail> pitchDetail = [];
  loadInreviewPitch() async {
    await _networkCalls.inreviewPitchInfo(
      onSuccess: (event) {
        setState(() {
          _isLoading = false;
          pitchDetail = event;
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
      _internet = msg;
      if (msg == true) {
        loadInreviewPitch();
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
    return Scaffold(
        backgroundColor: const Color(0XFFF0F0F0),
        body: _isLoading
            ? SizedBox(
                width: sizeWidth,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .05,
                          right: sizeWidth * .05,
                          top: sizeHeight * .05),
                      child: Container(
                        height: sizeHeight * .08,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0XFF032040)),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .07,
                              vertical: sizeHeight * .01),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: sizeHeight * .06,
                                width: sizeHeight * .06,
                                decoration: BoxDecoration(
                                  color: const Color(0XFF25A163).withOpacity(.3),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Image.asset(
                                  'images/addnew.png',
                                ),
                              ),
                              Container(
                                width: sizeWidth * .03,
                              ),
                              Text(
                                  AppLocalizations.of(context)!
                                      .addNewGroundPitch,
                                  style: const TextStyle(
                                      color: Color(0XFF032040),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins")),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildbodySimmer(),
                  ],
                ),
              )
            : _internet
                ? SizedBox(
                    height: sizeHeight,
                    width: sizeWidth,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05,
                              right: sizeWidth * .05,
                              top: sizeHeight * .05),
                          child: GestureDetector(
                            onTap: () {
                              navigateToSports();
                            },
                            child: Container(
                              height: sizeHeight * .08,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0XFF032040)),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .07,
                                    vertical: sizeHeight * .01),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: sizeHeight * .06,
                                      width: sizeHeight * .06,
                                      decoration: BoxDecoration(
                                        color:
                                            const Color(0XFF25A163).withOpacity(.3),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Image.asset(
                                        'images/addnew.png',
                                      ),
                                    ),
                                    Container(
                                      width: sizeWidth * .03,
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .addNewGroundPitch,
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins")),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        pitchDetail.isNotEmpty
                            ? Expanded(
                                child: SizedBox(
                                  height: sizeHeight * .65,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: pitchDetail.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Map detailPitch = {
                                              "id": "${pitchDetail[index].id}",
                                              "pitch": "inreview"
                                            };
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? detailPitch["language"] = ""
                                                : detailPitch["language"] =
                                                    "&language=ar";
                                            pitchDetail[index].is_declined!
                                                ? navigateToRejectPitch(
                                                    detailPitch)
                                                : navigateToverifiedPitchDetail(
                                                    detailPitch);
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: sizeWidth * .05,
                                                right: sizeWidth * .05,
                                                top: sizeHeight * .02),
                                            child: Container(
                                              height: sizeHeight * .12,
                                              width: sizeWidth * .8,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                    //
                                                  ),
                                                  color: Colors.white),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeHeight *
                                                                    .01,
                                                            vertical:
                                                                sizeHeight *
                                                                    .03),
                                                    child: Image.asset(
                                                      'images/clock.png',
                                                      height: sizeHeight * .03,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical:
                                                                sizeHeight *
                                                                    .01),
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0)),
                                                        ),
                                                        child: ClipRRect(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5.0)),
                                                            child:
                                                                cachedNetworkImage(
                                                              height:
                                                                  sizeHeight *
                                                                      .08,
                                                              width:
                                                                  sizeHeight *
                                                                      .08,
                                                              cuisineImageUrl:
                                                                  pitchDetail[
                                                                          index]
                                                                      .bookpitchfiles
                                                                      ?.files![0]
                                                                      ?.filePath,
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
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              sizeWidth * .55,
                                                          child: Text(
                                                              "${pitchDetail[index].name}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF032040),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontSize:
                                                                      15)),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              sizeWidth * .55,
                                                          child: Text(
                                                            "${pitchDetail[index].location}",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF646464),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontSize: 11),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              sizeWidth * .55,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                  pitchDetail[index].createdDate == 0 ? AppLocalizations.of(context)!.today : pitchDetail[index].createdDate == 1 ? AppLocalizations.of(context)!.yesterday : "${pitchDetail[index].createdDate} ${AppLocalizations.of(context)!.daysago}",
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0XFF25A163),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          "Poppins",
                                                                      fontSize:
                                                                          10)),
                                                              flaxibleGap(
                                                                1,
                                                              ),
                                                              pitchDetail[index]
                                                                      .is_declined!
                                                                  ? Text(
                                                                      AppLocalizations.of(context)!
                                                                          .rejected,
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0XFFE73D3B),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontSize:
                                                                              12))
                                                                  : Text(
                                                                      AppLocalizations.of(
                                                                              context)!
                                                                          .pending,
                                                                      style: const TextStyle(
                                                                          color: Color(
                                                                              0XFF979797),
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                              "Poppins",
                                                                          fontSize:
                                                                              10)),
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
                                                    4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  )
                : InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        _internet = msg;
                        if (msg == true) {
                          loadInreviewPitch();
                        }
                      });
                    },
                  ));
  }

  Widget _buildbodySimmer() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: _shimmerCard(),
          ),
          itemCount: 5,
        ),
      ),
    );
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Image.asset(
                'images/clock.png',
                height: 20,
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 60,
                width: 70,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0) //

                      ),
                ),
              ),
            ),
            flaxibleGap(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 200,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //

                              ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }

  void navigateToSports() {
    Navigator.pushReplacementNamed(context, RouteNames.selectSport,arguments: true);
  }

  void navigateToverifiedPitchDetail(dynamic detail) {
    Navigator.pushNamed(context, RouteNames.verifiedPitchDetail, arguments: detail);
  }

  void navigateToRejectPitch(Map detail) {
    Navigator.pushNamed(context, RouteNames.rejectPitch, arguments: detail);
  }
}
