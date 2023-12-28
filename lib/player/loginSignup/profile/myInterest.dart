import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/academy_list.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../main.dart';
import '../../../network/network_calls.dart';
import '../../../newStructure/app_colors/app_colors.dart';
import '../../../newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({super.key});

  @override
  _MyInterestState createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  var interest;
  bool? _internet;
  String? id;
  var _academyModel;
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = true;
  bool? data;
  int count = 0;

  getFavorites() {
    _networkCalls.getFavorites(
      onSuccess: (msg) {
        setState(() {
          _academyModel = msg;
          if (msg.isNotEmpty) {
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
        getFavorites();
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
            backgroundColor: AppColors.black,
            appBar: appBarWidget(
                sizeWidth: sizeWidth,
                sizeHeight: sizeHeight,
                context: context,
                title: AppLocalizations.of(context)!.myInterest,
                back: true),
            body: Container(
              height: sizeHeight,
              width: sizeWidth,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
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
                backgroundColor: AppColors.black,
                appBar: appBarWidget(
                    sizeWidth: sizeWidth,
                    sizeHeight: sizeHeight,
                    context: context,
                    title: AppLocalizations.of(context)!.myInterest,
                    back: true),
                body: data!
                    ? Container(
                        height: sizeHeight * .87,
                        width: sizeWidth,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // SizedBox(
                              //   height: sizeHeight * 0.01,
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(
                              //       horizontal: sizeWidth * .074),
                              //   child: Text(
                              //     AppLocalizations.of(context)!.viewInterest,
                              //     style: const TextStyle(
                              //         fontSize: 12, color: Color(0XFFA3A3A3)),
                              //   ),
                              // ),
                              _academyModel != null
                                  ? AcademyList(
                                auth: true,
                                      text:
                                          AppLocalizations.of(context)!.academy,
                                      academyDetail: _academyModel,
                                      searchflag: false,
                                      tagForView: false,
                                      myInterest: true,
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: sizeHeight,
                        width: sizeWidth,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                        ? AppColors.themeColor
                                        : AppColors.white,
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
                      getFavorites();
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GroundDetail(
                  detail: detail,
                )));
    // Navigator.pushNamed(context, RouteNames.venueDetailScreen,
    //     arguments: detail);
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5.0) //

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
