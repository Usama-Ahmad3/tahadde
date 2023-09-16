import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../main.dart';
import '../../../network/network_calls.dart';

class MyInterest extends StatefulWidget {
  @override
  _MyInterestState createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  var interest;
  bool? _internet;
  String? id;
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = true;
  bool? data;
  int count = 0;

  loagingRating() {
    _networkCalls.myInterest(
      onSuccess: (msg) {
        setState(() {
          if (msg["pitch"].isNotEmpty) {
            loading = false;
            data = true;
            interest = msg;
          } else {
            setState(() {
              loading = false;
              data = false;
            });
          }
        });
      },
      onFailure: (msg) {
        setState(() {
          loading = false;
          data = false;
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (_internet = true) {
        loagingRating();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return loading
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: PreferredSize(
              preferredSize: Size(sizeWidth, sizeHeight * 0.108),
              child: AppBar(
                  title: Text(
                    AppLocalizations.of(context)!.myInterest,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.black,
                  leadingWidth: sizeWidth * 0.18,
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(sizeHeight * 0.008),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              shape: BoxShape.circle),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.close,
                              color: Colors.white,
                            ),
                          )),
                    ),
                  )),
            ),
            body: Container(
              height: sizeHeight,
              width: sizeWidth,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.white
                      : const Color(0xff686868),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizeWidth * .1),
                      child: Container(
                          height: sizeHeight * .1,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            AppLocalizations.of(context)!.viewInterest,
                            style: const TextStyle(
                                fontSize: 12, color: Color(0XFFA3A3A3)),
                          )),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                      child: SizedBox(
                        height: sizeHeight * .75,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5.0),
                                child: _shimmerCard(),
                              );
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ))
        : _internet!
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: PreferredSize(
                  preferredSize: Size(sizeWidth, sizeHeight * 0.108),
                  child: AppBar(
                      title: Text(
                        AppLocalizations.of(context)!.myInterest,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                      centerTitle: true,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.black,
                      leadingWidth: sizeWidth * 0.18,
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(sizeHeight * 0.008),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.close,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )),
                ),
                body: data!
                    ? Container(
                        height: sizeHeight * .87,
                        width: sizeWidth,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? Colors.white
                                : const Color(0xff686868),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .1),
                                child: Container(
                                    height: sizeHeight * .1,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .viewInterest,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          color: Color(0XFFA3A3A3)),
                                    )),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: SizedBox(
                                  height: sizeHeight * .75,
                                  child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: 2,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: sizeHeight * .01),
                                          child: GestureDetector(
                                            onTap: () {
                                              Map<String, dynamic> detail = {
                                                "pitchId": interest["pitch"]
                                                    [index]["id"],
                                                "subPitchId": interest["pitch"]
                                                        [index]["venue_details"]
                                                    ["pitchType"][0]
                                              };
                                              navigateToBookPitchDetail(detail);
                                            },
                                            child: Container(
                                              height: sizeHeight * .1,
                                              width: sizeWidth * .8,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors
                                                          .blueGrey.shade200),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(12.0),
                                                    //
                                                  ),
                                                  color: Colors.grey.shade300),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.all(
                                                        sizeHeight * .01),
                                                    child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0) //
                                                                  ),
                                                        ),
                                                        child: ClipRRect(
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          5.0)),
                                                          child: interest["pitch"][index]
                                                                              [
                                                                              "images"]
                                                                          [
                                                                          "files"][0]
                                                                      [
                                                                      "filePath"] !=
                                                                  null
                                                              ? ClipRRect(
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              5.0)),
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height:
                                                                        sizeHeight *
                                                                            .08,
                                                                    width:
                                                                        sizeWidth *
                                                                            .15,
                                                                    imageUrl: interest["pitch"][index]["images"]
                                                                            [
                                                                            "files"][0]
                                                                        [
                                                                        "filePath"],
                                                                    placeholder:
                                                                        (context,
                                                                            url) {
                                                                      return Image
                                                                          .asset(
                                                                        'assets/images/T.png',
                                                                        height: sizeHeight *
                                                                            .08,
                                                                        width: sizeWidth *
                                                                            .15,
                                                                      );
                                                                    },
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        const Icon(
                                                                            Icons.error),
                                                                  ),
                                                                )
                                                              : Image.asset(
                                                                  'assets/images/T.png',
                                                                  fit: BoxFit
                                                                      .fill,
                                                                  height:
                                                                      sizeHeight *
                                                                          .1,
                                                                  width:
                                                                      sizeWidth *
                                                                          .15,
                                                                ),
                                                        )),
                                                  ),
                                                  Container(
                                                    width: sizeWidth * .1,
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: sizeWidth * .4,
                                                    child: Text(
                                                        interest["pitch"][index]
                                                                [
                                                                "venue_details"]
                                                            ["name"],
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 16)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: sizeHeight,
                        width: sizeWidth,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? Colors.white
                                : const Color(0xff686868),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            flaxibleGap(
                              10,
                            ),
                            Lottie.asset('assets/lottiefiles/my.json',
                                height: sizeHeight * .3,
                                width: sizeWidth * .7,
                                fit: BoxFit.cover),
                            flaxibleGap(
                              2,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .25,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.addYourFavorite,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF032040)
                                        : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            flaxibleGap(
                              20,
                            ),
                          ],
                        ),
                      ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (_internet = true) {
                      loagingRating();
                    } else {
                      setState(() {
                        loading = false;
                      });
                    }
                  });
                },
              );
  }

  void navigateToBookPitchDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.venueDetailScreen,
        arguments: detail);
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
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
                width: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0) //

                      ),
                ),
              ),
            ),
            flaxibleGap(2),
            shimmer(width: 200),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }
}
