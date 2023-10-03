import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/bookPitchModelClass.dart';
import '../../../network/network_calls.dart';

class VarifiedPitch extends StatefulWidget {
  const VarifiedPitch({super.key});

  @override
  _VarifiedPitchState createState() => _VarifiedPitchState();
}

class _VarifiedPitchState extends State<VarifiedPitch> {
  late bool _internet;
  bool _isLoading = true;
  String date = "name";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  List<BookPitchDetail> pitchDetail = [];
  loadVerifiedPitch() async {
    await _networkCalls.verifiedPitchInfo(
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
        loadVerifiedPitch();
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
                    _buildbodySimmer(),
                  ],
                ),
              )
            : _internet
                ? pitchDetail.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          flaxibleGap(
                            30,
                          ),
                          SizedBox(
                              height: sizeHeight * .15,
                              width: sizeHeight * .2,
                              child: Image.asset(
                                'images/verified.png',
                                fit: BoxFit.fill,
                              )),
                          flaxibleGap(
                            4,
                          ),
                          Text(AppLocalizations.of(context)!.noverifiedpitchyet,
                              style: const TextStyle(
                                  color: Color(0XFF424242),
                                  fontFamily: "Poppins",
                                  fontSize: 14)),
                          flaxibleGap(
                            31,
                          ),
                        ],
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: pitchDetail.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Map detailPitch = {
                                "id": "${pitchDetail[index].id}",
                                "pitch": "verified"
                              };
                              AppLocalizations.of(context)!.locale == "en"
                                  ? detailPitch["language"] = ""
                                  : detailPitch["language"] = "&language=ar";
                              navigateToverifiedPitchDetail(detailPitch);
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
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                      //
                                    ),
                                    color: Colors.white),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.all(sizeHeight * .01),
                                      child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0) //
                                                ),
                                          ),
                                          child: ClipRRect(
                                              clipBehavior: Clip.hardEdge,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                              child: cachedNetworkImage(
                                                height: sizeHeight * .08,
                                                width: sizeWidth * .2,
                                                cuisineImageUrl:
                                                    pitchDetail[index]
                                                        .bookpitchfiles
                                                        ?.files![0]
                                                        ?.filePath,
                                              ))),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.all(sizeHeight * .005),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          flaxibleGap(
                                            1,
                                          ),
                                          Text("${pitchDetail[index].name}",
                                              style: const TextStyle(
                                                  color: Color(0XFF032040),
                                                  fontWeight: FontWeight.w700,
                                                  fontFamily: "Poppins",
                                                  fontSize: 16)),
                                          SizedBox(
                                            width: sizeWidth * .6,
                                            child: Text(
                                                "${pitchDetail[index].location}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Color(0XFF646464),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                    fontSize: 12)),
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
                            ),
                          );
                        })
                : InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        _internet = msg;
                        if (msg == true) {
                          loadVerifiedPitch();
                        }
                      });
                    },
                  ));
  }

  void navigateToverifiedPitchDetail(dynamic detail) {
    Navigator.pushNamed(context, RouteNames.verifiedPitchDetail,
        arguments: detail);
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
                    width: 250,
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
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }
}
