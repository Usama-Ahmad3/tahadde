import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import '../../../pitchOwner/loginSignupPitchOwner/createSession.dart';

class BookingSummary extends StatefulWidget {
  var price;
  BookingSummary({super.key, this.price});
  @override
  _BookingSummary createState() => _BookingSummary();
}

class _BookingSummary extends State<BookingSummary> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  Map? profileDetail;
  bool loading = true;
  var keys;
  var now;
  bool? internet;
  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
          loading = false;
          now = DateTime.now();
        });
      },
      onFailure: (msg) {},
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
        loadProfile();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    List<BookedSessions> session = widget.price["sessions"];
    return WillPopScope(
        onWillPop: () async => false,
        child: loading
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: appBarWidget(sizewidth, sizeheight, context,
                    AppLocalizations.of(context)!.bookingDetails, true),
                body: SizedBox(
                  width: sizewidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 10),
                                          child: Container(
                                            width: double.infinity,
                                            height: 300.0,
                                            color: Colors.white,
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemCount: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : internet!
                ? Scaffold(
                    backgroundColor: Colors.black,
                    appBar: appBarWidget(sizewidth, sizeheight, context,
                        AppLocalizations.of(context)!.bookingDetails, false),
                    body: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: MyAppState.mode == ThemeMode.light
                              ? Colors.white
                              : AppColors.darkTheme,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizewidth * .059),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: sizeheight * .02,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .slotDetails,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : AppColors.white,
                                            ),
                                      ),
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                      Text(
                                          "${AppLocalizations.of(context)!.academyOnly} (${widget.price["AcademyName"]})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF424242)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600)),
                                      Text(
                                        widget.price['startingDate']
                                            .toString()
                                            .substring(0, 10),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.appThemeColor
                                                    : AppColors.white,
                                                fontFamily: "Poppins"),
                                      ),
                                      ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          shrinkWrap: true,
                                          itemCount: session.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${AppLocalizations.of(context)!.sessionName} ${AppLocalizations.of(context)!.locale == 'en' ? session[index].name : session[index].nameArabic}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .appThemeColor
                                                              : AppColors
                                                                  .white),
                                                ),
                                                SizedBox(
                                                  height: sizeheight * 0.0056,
                                                ),
                                                SizedBox(
                                                    height: 35,
                                                    width: sizewidth * 0.5,
                                                    child: Container(
                                                      height: 30,
                                                      width: 110,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .appThemeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade50)),
                                                      child: Text(
                                                        '${session[index].startTime.toString()} - ${session[index].endTime.toString()}' ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )),
                                              ],
                                            );
                                          }),
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: sizeheight * .01,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: SizedBox(
                                  height: sizeheight * .2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizewidth * .05,
                                        right: sizewidth * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bookingUser,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF032040)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                          profileDetail != null
                                              ? '${profileDetail!['first_name']} ${profileDetail!['last_name']}'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF424242)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail!['email']
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF898989)
                                                        : AppColors.white)),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail![
                                                        'contact_number'] ??
                                                    ""
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF898989)
                                                        : AppColors.white)),
                                        Text(
                                            "${AppLocalizations.of(context)!.tranjectionId} : ${widget.price["transactionId"]}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF898989)
                                                        : AppColors.white)),
                                        flaxibleGap(6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: sizeheight * .01,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: SizedBox(
                                  height: sizeheight * .16,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizewidth * .05,
                                        right: sizewidth * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        flaxibleGap(4),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .paymentSummary,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF032040)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        flaxibleGap(2),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .subTotal,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            flaxibleGap(18),
                                            Text(
                                              '${AppLocalizations.of(context)!.currency} ${widget.price["price"].toString()} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF7A7A7A)
                                                          : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.tex,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            flaxibleGap(18),
                                            // widget.detail["detail"].tax != null
                                            //     ? Text(
                                            //         "${AppLocalizations.of(context).currency} ${widget.detail["count"] * widget.detail["detail"].tax.round()}",
                                            //         style: TextStyle(
                                            //             color: Color(0XFF7A7A7A)),
                                            //       )
                                            //     :
                                            Text(
                                              "${AppLocalizations.of(context)!.currency} 00 ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF7A7A7A)
                                                          : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        flaxibleGap(1),
                                        Container(
                                          height: 1,
                                          color: const Color(0XFFD6D6D6),
                                        ),
                                        flaxibleGap(1),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .grandTotal,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            flaxibleGap(18),
                                            Text(
                                              '${AppLocalizations.of(context)!.currency} ${widget.price["price"].toString()}',
                                              style: TextStyle(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? Color(0XFF424242)
                                                      : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        flaxibleGap(3),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: sizeheight * 0.05,
                              ),
                              ButtonWidget(
                                  onTaped: () {
                                    navigateToDetail();
                                  },
                                  title: Text(
                                    AppLocalizations.of(context)!.gotoHomepage,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(color: AppColors.white),
                                  ),
                                  isLoading: false)
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        internet = msg;
                        if (msg == true) {
                          loadProfile();
                        }
                      });
                    },
                  ));
  }

  void navigateToDetail() {
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     RouteNames.playerHome, (Route<dynamic> route) => false
    // );
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerHomeScreen(index: 0),
        ));
  }
}
// DefaultTextStyle(
// style: TextStyle(
// fontSize: sizeheight * 0.02,
// color: MyAppState.mode == ThemeMode.light
// ? AppColors.grey
//     : AppColors.white),
// child: Container(
// color: Colors.black54,
// child: Container(
// height: sizeheight,
// decoration: BoxDecoration(
// color: MyAppState.mode == ThemeMode.light
// ? AppColors.white
//     : AppColors.darkTheme,
// borderRadius: const BorderRadius.only(
// topLeft: Radius.circular(20),
// topRight: Radius.circular(20))),
// child: Padding(
// padding: EdgeInsets.symmetric(
// horizontal: sizewidth * 0.03,
// vertical: sizeheight * 0.02),
// child: Column(
// children: [
// Flexible(
// flex: 2,
// child: Container(),
// ),
// Padding(
// padding: EdgeInsets.only(
// left: sizewidth * .05,
// right: sizewidth * .05),
// child: Material(
// elevation: 5,
// color: const Color(0XFFFFFFFF),
// borderRadius: const BorderRadius.only(
// topLeft: Radius.circular(10.0),
// topRight: Radius.circular(10.0)),
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: <Widget>[
// Padding(
// padding: EdgeInsets.symmetric(
// horizontal: sizewidth * 0.02),
// child: Text(
// '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
// style: Theme.of(context)
//     .textTheme
//     .bodyLarge,
// ),
// ),
// const SizedBox(
// height: 10,
// ),
// Padding(
// padding: EdgeInsets.symmetric(
// horizontal: sizewidth * 0.02),
// child: Text(
// '${AppLocalizations.of(context)!.academyName}: ${widget.price["AcademyName"]}',
// ),
// ),
// const SizedBox(
// height: 10,
// ),
// ListView.builder(
// shrinkWrap: true,
// itemCount: session.length,
// itemBuilder: (context, index) {
// return Material(
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment
//     .start,
// children: <Widget>[
// Padding(
// padding: EdgeInsets
//     .symmetric(
// horizontal:
// sizewidth *
// 0.02),
// child: Text(
// " Session Name: ${session[index].sessionName}",
// ),
// ),
// Padding(
// padding: EdgeInsets
//     .symmetric(
// horizontal:
// sizewidth *
// 0.02),
// child: const Text(
// " Slots Timing Information",
// ),
// ),
// // SizedBox(
// //   height: 40,
// //   width: sizewidth,
// //   child: ListView.builder(
// //     scrollDirection:
// //         Axis.horizontal,
// //     itemCount:
// //         session.length,
// //     itemBuilder:
// //         (BuildContext
// //                 context,
// //             int childIdx) {
// //       return
// //     },
// //   ),
// // ),
// Padding(
// padding: EdgeInsets
//     .symmetric(
// horizontal:
// sizewidth *
// 0.02),
// child: Container(
// height: 30,
// alignment:
// Alignment.center,
// decoration: BoxDecoration(
// color: const Color(
// 0XFF25A163),
// borderRadius:
// BorderRadius
//     .circular(
// 12),
// border: Border.all(
// color: const Color(
// 0XFF25A163))),
// child: Text(
// '${session[index].startTime.toString().substring(11, 19)} To ${session[index].endTime.toString().substring(11, 19)}' ??
// "",
// ),
// ),
// ),
// Container(
// height:
// sizeheight * .01,
// ),
// Container(
// height: 1,
// color: const Color(
// 0XFFD6D6D6),
// )
// ],
// ),
// );
// }),
// Padding(
// padding: EdgeInsets.symmetric(
// horizontal: sizewidth * 0.02),
// child: Text(
// "${AppLocalizations.of(context)!.tranjectionId} : ${widget.price["transactionId"]}",
// ),
// ),
// ],
// ),
// ),
// ),
// Padding(
// padding: EdgeInsets.only(
// left: sizewidth * .05,
// right: sizewidth * .05),
// child: Container(
// height: sizeheight * .08,
// decoration: const BoxDecoration(
// color: Color(0XFF25A163),
// borderRadius: BorderRadius.only(
// bottomRight: Radius.circular(10.0),
// bottomLeft: Radius.circular(10.0)),
// ),
// child: Padding(
// padding: EdgeInsets.only(
// left: sizewidth * .05,
// right: sizewidth * .05),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Text(
// AppLocalizations.of(context)!
//     .paidTotal,
// style: const TextStyle(
// color: Color(0XFFFFFFFF),
// fontSize: 16,
// fontWeight: FontWeight.w600,
// fontFamily: "Poppins"),
// ),
// Text(
// '${AppLocalizations.of(context)!.currency} ${widget.price["price"]} ',
// style: const TextStyle(
// color: Color(0XFFFFFFFF),
// fontSize: 16,
// fontWeight: FontWeight.w600,
// fontFamily: "Poppins"),
// ),
// ],
// ),
// ),
// ),
// ),
// flaxibleGap(
// 18,
// ),
// Padding(
// padding: EdgeInsets.symmetric(
// horizontal: sizewidth * 0.05),
// child: ButtonWidget(
// onTaped: () {
// navigateToDetail();
// },
// title: Text(
// 'Go To Home Page',
// style: Theme.of(context)
//     .textTheme
//     .bodyMedium!
//     .copyWith(color: AppColors.white),
// ),
// isLoading: false),
// )
// ],
// ),
// ),
// ),
// )),
