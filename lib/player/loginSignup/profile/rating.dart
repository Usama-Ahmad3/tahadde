import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class Rate extends StatefulWidget {
  @override
  _RateState createState() => _RateState();
}

class _RateState extends State<Rate> {
  bool rateValue = false;
  String? review;
  var rating;
  String? id;
  final _formKey = GlobalKey<FormState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool loading = true;
  bool? _internet;
  bool? data;
  int count = 0;

  loadingRating() {
    _networkCalls.ratingGet(
      onSuccess: (msg) {
        setState(() {
          loading = false;
          rating = msg;
          data = true;
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
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadingRating();
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
            appBar: appBar(
              title: AppLocalizations.of(context)!.myReviewsRatings,
              language: AppLocalizations.of(context)!.locale,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            body: Container(
              height: sizeHeight * .87,
              width: sizeWidth,
              color: const Color(0XFFF0F0F0),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .1),
                    child: Container(
                        height: sizeHeight * .1,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!
                              .addyourexperienceforthepitchesyouhaveplayedupon,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0XFFA3A3A3)),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
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
            ))
        : _internet!
            ? Scaffold(
                appBar: appBar(
                  title: AppLocalizations.of(context)!.myReviewsRatings,
                  language: AppLocalizations.of(context)!.locale,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                body: data!
                    ? Stack(
                        children: [
                          Container(
                            height: sizeHeight * .87,
                            width: sizeWidth,
                            color: const Color(0XFFF0F0F0),
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
                                            .addyourexperienceforthepitchesyouhaveplayedupon,
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
                                        itemCount: rating.length,
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                rateValue = true;
                                                id = rating[index]["id"]
                                                    .toString();
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: sizeHeight * .02),
                                              child: Container(
                                                height: sizeHeight * .13,
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
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all(
                                                          sizeHeight * .01),
                                                      child: Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        5.0) //
                                                                    ),
                                                          ),
                                                          child: ClipRRect(
                                                            clipBehavior:
                                                                Clip.hardEdge,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        5.0)),
                                                            child: rating[index]["bookpitchfiles"]
                                                                            ["files"][0]
                                                                        [
                                                                        "filePath"] !=
                                                                    null
                                                                ? ClipRRect(
                                                                    clipBehavior:
                                                                        Clip
                                                                            .hardEdge,
                                                                    borderRadius:
                                                                        const BorderRadius
                                                                            .all(
                                                                            Radius.circular(
                                                                                5.0)),
                                                                    child:
                                                                        cachedNetworkImage(
                                                                      height:
                                                                          sizeHeight *
                                                                              .08,
                                                                      width:
                                                                          sizeWidth *
                                                                              .15,
                                                                      cuisineImageUrl:
                                                                          rating[index]["bookpitchfiles"]["files"][0]
                                                                              [
                                                                              "filePath"],
                                                                    ))
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
                                                    flaxibleGap(
                                                      1,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: sizeWidth * .4,
                                                      child: Text(
                                                          rating[index]["name"],
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF032040),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 16)),
                                                    ),
                                                    flaxibleGap(
                                                      2,
                                                    ),
                                                    Padding(
                                                        padding: EdgeInsets.all(
                                                            sizeHeight * .005),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${rating[index]["reviewAndratings"]["rating"] ?? "0"}/5",
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0XFF9B9B9B),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Container(
                                                                  width: 5,
                                                                ),
                                                                Image.asset(
                                                                    "assets/images/star.png")
                                                              ],
                                                            ),
                                                            Container(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "${rating[index]["reviewAndratings"]["review"] ?? "0"}",
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0XFF9B9B9B),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                                Container(
                                                                  width: 5,
                                                                ),
                                                                Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .review,
                                                                  style: const TextStyle(
                                                                      color: Color(
                                                                          0XFF9B9B9B),
                                                                      fontSize:
                                                                          14),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                    flaxibleGap(
                                                      2,
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
                          rateValue
                              ? BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                  child: Container(
                                    color: Colors.black.withOpacity(0),
                                  ),
                                )
                              : Container(),
                          rateValue
                              ? Center(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeWidth * .05),
                                    child: Form(
                                      key: _formKey,
                                      child: Container(
                                        height: sizeHeight * .5,
                                        width: sizeWidth,
                                        color: Colors.white,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            flaxibleGap(
                                              1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeWidth * .05),
                                              child: Row(
                                                children: <Widget>[
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .yourexperience,
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color:
                                                              Color(0XFFADADAD),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              "Poppins")),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * .03,
                                                    child: FloatingActionButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          rateValue = false;
                                                        });
                                                      },
                                                      backgroundColor:
                                                          const Color(
                                                              0XFFD8D8D8),
                                                      splashColor: Colors.black,
                                                      child: Icon(
                                                        Icons.clear,
                                                        color: const Color(
                                                            0XFF4A4A4A),
                                                        size: sizeHeight * .02,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizeWidth * .05),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .ratethepitch,
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color:
                                                              Color(0XFF858585),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              "Poppins")),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      count = 0;
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .05),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .clear,
                                                        style: const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF25A163),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins")),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeWidth * .05),
                                              child: Row(
                                                children: <Widget>[
                                                  count > 0
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 1;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                            height: sizeHeight *
                                                                .04,
                                                            width: sizeHeight *
                                                                .04,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 1;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_border,
                                                            color: const Color(
                                                                0XFF4A4A4A),
                                                            size: sizeHeight *
                                                                .04,
                                                          ),
                                                        ),
                                                  count > 1
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 2;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                            height: sizeHeight *
                                                                .04,
                                                            width: sizeHeight *
                                                                .04,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 2;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_border,
                                                            color: const Color(
                                                                0XFF4A4A4A),
                                                            size: sizeHeight *
                                                                .04,
                                                          ),
                                                        ),
                                                  count > 2
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 3;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                            height: sizeHeight *
                                                                .04,
                                                            width: sizeHeight *
                                                                .04,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 3;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_border,
                                                            color: const Color(
                                                                0XFF4A4A4A),
                                                            size: sizeHeight *
                                                                .04,
                                                          ),
                                                        ),
                                                  count > 3
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 4;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                            height: sizeHeight *
                                                                .04,
                                                            width: sizeHeight *
                                                                .04,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 4;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_border,
                                                            color: const Color(
                                                                0XFF4A4A4A),
                                                            size: sizeHeight *
                                                                .04,
                                                          ),
                                                        ),
                                                  count > 4
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 5;
                                                            });
                                                          },
                                                          child: Image.asset(
                                                            "assets/images/star.png",
                                                            height: sizeHeight *
                                                                .04,
                                                            width: sizeHeight *
                                                                .04,
                                                          ))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              count = 5;
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.star_border,
                                                            color: const Color(
                                                                0XFF4A4A4A),
                                                            size: sizeHeight *
                                                                .04,
                                                          ),
                                                        ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  Text("$count/5",
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          color:
                                                              Color(0XFF858585),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              "Poppins")),
                                                ],
                                              ),
                                            ),
                                            flaxibleGap(
                                              3,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeWidth * .05),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .reviews,
                                                  style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Color(0XFF858585),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins")),
                                            ),
                                            flaxibleGap(
                                              1,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeWidth * .05),
                                              child: Container(
                                                height: sizeHeight * .15,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0XFFA3A3A3))),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: TextFormField(
                                                    validator: (value) {
                                                      if (value!.isEmpty) {
                                                        return AppLocalizations
                                                                .of(context)!
                                                            .pleaseenterReviews;
                                                      }
                                                      return null;
                                                    },
                                                    onSaved: (value) {
                                                      review = value;
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.all(0),
                                                      enabledBorder:
                                                          InputBorder.none,
                                                      focusedBorder:
                                                          InputBorder.none,
                                                    ),
                                                    keyboardType:
                                                        TextInputType.multiline,
                                                    maxLines: 3,
                                                    //maxLength: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            flaxibleGap(
                                              4,
                                            ),
                                            count != 0
                                                ? GestureDetector(
                                                    onTap: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        _formKey.currentState!
                                                            .save();
                                                        Map detail = {
                                                          "rating": count,
                                                          "review": review
                                                        };
                                                        _networkCalls
                                                            .ratingSend(
                                                          detail: detail,
                                                          id: id!,
                                                          onSuccess: (msg) {
                                                            setState(() {
                                                              rateValue = false;
                                                              loading = true;
                                                              loadingRating();
                                                            });
                                                          },
                                                          onFailure: (msg) {
                                                            showMessage(msg);
                                                          },
                                                          tokenExpire: () {
                                                            if (mounted) {
                                                              on401(context);
                                                            }
                                                          },
                                                        );
                                                      }
                                                    },
                                                    child: Container(
                                                        color: const Color(
                                                            0XFF25A163),
                                                        height:
                                                            sizeHeight * .08,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .save,
                                                          style:
                                                              const TextStyle(
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins",
                                                          ),
                                                        )),
                                                  )
                                                : Container(
                                                    color:
                                                        const Color(0XFFBCBCBC),
                                                    height: sizeHeight * .08,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .save,
                                                      style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins",
                                                      ),
                                                    )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : SizedBox(
                        height: sizeHeight,
                        width: sizeWidth,
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
                                AppLocalizations.of(context)!
                                    .ratepitchafteryourgame,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            flaxibleGap(
                              20,
                            ),
                          ],
                        ),
                      ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadingRating();
                    }
                  });
                },
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
