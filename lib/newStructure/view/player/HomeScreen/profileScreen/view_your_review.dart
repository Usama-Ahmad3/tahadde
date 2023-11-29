import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/player_rating.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';

class YourReviews extends StatefulWidget {
  String academyId;
  YourReviews({super.key, required this.academyId});

  @override
  State<YourReviews> createState() => _YourReviewsState();
}

class _YourReviewsState extends State<YourReviews> {
  List<PlayerRating> rating = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  bool loading = true;
  loadingRating() async {
    await _networkCalls.ratingGetForPlayer(
      id: widget.academyId,
      onSuccess: (msg) {
        setState(() {
          for (int i = 0; i < msg.length; i++) {
            rating.add(PlayerRating.fromJson(msg[i]));
          }
          loading = false;
          // rating = msg;
          print("rating$rating");
        });
      },
      onFailure: (msg) {
        setState(() {
          // loading = false;
          // data = false;
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    loadingRating();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: appBarWidget(
            sizeWidth: width,
            sizeHeight: height,
            context: context,
            title: AppLocalizations.of(context)!.reviews,
            back: true),
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                color: Colors.black,
                child: Container(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.05, vertical: height * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rating.length,
                              itemBuilder: (context, index) {
                                final reversed = rating.reversed.toList();
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.01,
                                      vertical: height * 0.01),
                                  child: Container(
                                    padding:
                                        EdgeInsets.only(bottom: height * 0.005),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0xffffffff)
                                          : AppColors.containerColorW12,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x0f050818),
                                          offset: const Offset(1, 4),
                                          blurRadius: height * 0.01,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: width * 0.01,
                                          top: height * 0.006),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              height: height * 0.064,
                                              width: width * 0.13,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: cachedNetworkImage(
                                                  cuisineImageUrl:
                                                      reversed[index]
                                                          .profilePicture,
                                                  height: height * 0.07,
                                                  width: width * 0.3,
                                                ),
                                              )),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.01),
                                                child: SizedBox(
                                                  width: width * 0.68,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        reversed[index]
                                                            .userName
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .black
                                                                : Colors.white),
                                                      ),
                                                      Text(
                                                        reversed[index]
                                                            .createdAt
                                                            .toString()
                                                            .substring(0, 10),
                                                        style: TextStyle(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .black
                                                                : Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: reversed[index]
                                                                .rating!
                                                                .toDouble() >
                                                            0
                                                        ? Colors.yellow
                                                        : AppColors.grey,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: reversed[index]
                                                                .rating!
                                                                .toDouble() >
                                                            1.0
                                                        ? Colors.yellow
                                                        : AppColors.grey,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: reversed[index]
                                                                .rating!
                                                                .toDouble() >
                                                            2.0
                                                        ? Colors.yellow
                                                        : AppColors.grey,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: reversed[index]
                                                                .rating!
                                                                .toDouble() >
                                                            4.0
                                                        ? Colors.yellow
                                                        : AppColors.grey,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    color: reversed[index]
                                                                .rating!
                                                                .toDouble() >
                                                            4.0
                                                        ? Colors.yellow
                                                        : AppColors.grey,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: width * 0.01),
                                                child: SizedBox(
                                                  width: width * 0.7,
                                                  child: Text(
                                                    reversed[index]
                                                        .review
                                                        .toString(),
                                                    style: TextStyle(
                                                        overflow:
                                                            TextOverflow.clip,
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? AppColors.black
                                                            : AppColors.white),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.005,
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ))));
  }
}
