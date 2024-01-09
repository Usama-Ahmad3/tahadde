import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/common_widgets/internet_loss.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/academy_report.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';

class BookingReport extends StatefulWidget {
  const BookingReport({super.key});

  @override
  State<BookingReport> createState() => _BookingReportState();
}

class _BookingReportState extends State<BookingReport> {
  List<AcademyReport> bookingDetail = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _internet = true;
  bool _isLoading = true;
  getBookingDetails() async {
    await _networkCalls.bookingReport(
      onSuccess: (detail) {
        bookingDetail = detail;
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            bookingDetail;
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  showDetails(
      {required context,
      required width,
      required height,
      required AcademyReport booking}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 2,
          backgroundColor: MyAppState.mode == ThemeMode.light
              ? AppColors.grey200
              : AppColors.darkTheme,
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          titlePadding: EdgeInsets.symmetric(
              horizontal: width * .05, vertical: height * 0.02),
          title: Text(
            AppLocalizations.of(context)!.bookingDetails,
            style: TextStyle(
                color: MyAppState.mode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.white,
                fontSize: height * 0.017),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: width * 0.02),
          content: SizedBox(
            height: height * 0.3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          AppLocalizations.of(context)!.locale == 'en'
                              ? booking.academyName.toString()
                              : booking.academyNameArabic.toString(),
                          style: TextStyle(
                              fontSize: height * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : AppColors.grey),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: width * .6,
                            child: Text(
                              booking.academyLocation.toString(),
                              style: TextStyle(
                                  fontSize: height * 0.013,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? const Color(0XFF9B9B9B)
                                      : Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.totalBookings}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.totalProfit}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.commission}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.tax}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.totalBookings.toString(),
                              style: TextStyle(
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : Colors.grey,
                                fontFamily: "Poppins",
                                fontSize: height * 0.015,
                              )),
                          Text(
                            booking.totalProfit.toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : Colors.grey,
                                decoration: TextDecoration.none,
                                fontSize: height * 0.015),
                          ),
                          Text(
                            booking.commission.toString(),
                            style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : AppColors.grey,
                              fontSize: height * 0.015,
                            ),
                          ),
                          Text(
                            booking.tax.toString(),
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : AppColors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.mostBooked,
                      style: TextStyle(
                          fontSize: height * 0.015,
                          color: MyAppState.mode == ThemeMode.light
                              ? const Color(0XFF25A163)
                              : AppColors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.day}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            AppLocalizations.of(context)!.sessionName,
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),

                          Text(
                            "${AppLocalizations.of(context)!.slotDuration}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.startTime}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                          Text(
                            "${AppLocalizations.of(context)!.endTime}:",
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : AppColors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: width * 0.15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.mostBookedSession!.weekday.toString(),
                              style: TextStyle(
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : Colors.grey,
                                fontFamily: "Poppins",
                                fontSize: height * 0.015,
                              )),
                          Text(
                            AppLocalizations.of(context)!.locale == 'en'
                                ? booking.mostBookedSession!.sessionName
                                    .toString()
                                : booking.mostBookedSession!.arabicName
                                    .toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : Colors.grey,
                                decoration: TextDecoration.none,
                                fontSize: height * 0.015),
                          ),
                          Text(
                            booking.mostBookedSession!.slotDuration.toString(),
                            style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : AppColors.grey,
                              fontSize: height * 0.015,
                            ),
                          ),
                          Text(
                            booking.mostBookedSession!.startTime.toString(),
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : AppColors.grey),
                          ),
                          Text(
                            booking.mostBookedSession!.endTime.toString(),
                            style: TextStyle(
                                fontSize: height * 0.015,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : AppColors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop(true);
              },
              child: Center(
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.appThemeColor,
                    border: Border.all(width: 1, color: AppColors.transparent),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.ok,
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.015,
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      getBookingDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    print('object$bookingDetail');
    return RefreshIndicator(
      displacement: 200,
      onRefresh: () async {
        _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
          _internet = msg;
          getBookingDetails();
        });
      },
      child: Scaffold(
        appBar: appBarWidget(
            sizeWidth: width,
            sizeHeight: height,
            context: context,
            title: AppLocalizations.of(context)!.report,
            back: true),
        body: Container(
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
                        horizontal: width * 0.059, vertical: height * 0.02),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : _internet
                            ? SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: height,
                                      decoration: BoxDecoration(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.white
                                                  : AppColors.darkTheme,
                                          borderRadius: true
                                              ? const BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20))
                                              : BorderRadius.zero),
                                      child: Column(
                                        children: [
                                          bookingDetail.isNotEmpty ||
                                                  bookingDetail != null
                                              ? Expanded(
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount:
                                                          bookingDetail.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      height *
                                                                          0.01),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              if (bookingDetail[
                                                                          index]
                                                                      .mostBookedSession ==
                                                                  null) {
                                                                showMessage(
                                                                    'No Bookings Found');
                                                              } else {
                                                                showDetails(
                                                                    booking:
                                                                        bookingDetail[
                                                                            index],
                                                                    context:
                                                                        context,
                                                                    width:
                                                                        width,
                                                                    height:
                                                                        height);
                                                              }
                                                            },
                                                            child: Container(
                                                              height:
                                                                  height * .1,
                                                              width: width,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0),
                                                                ),
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? AppColors
                                                                        .grey200
                                                                    : AppColors
                                                                        .containerColorW12,
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.all(
                                                                        height *
                                                                            .007),
                                                                    child: Container(
                                                                        decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(5.0) //
                                                                              ),
                                                                        ),
                                                                        child: ClipRRect(clipBehavior: Clip.hardEdge, borderRadius: const BorderRadius.all(Radius.circular(5.0)), child: cachedNetworkImage(height: height * .08, width: width * .15, cuisineImageUrl: bookingDetail[index].academyPic![0] ?? ''))),
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      flaxibleGap(
                                                                          1),
                                                                      Text(
                                                                          AppLocalizations.of(context)!.locale == 'en'
                                                                              ? "${bookingDetail[index].academyName}"
                                                                              : "${bookingDetail[index].academyNameArabic}",
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .bodyMedium!
                                                                              .copyWith(
                                                                                color: MyAppState.mode == ThemeMode.light ? AppColors.themeColor : AppColors.white,
                                                                                fontWeight: FontWeight.w700,
                                                                                fontFamily: "Poppins",
                                                                              )),
                                                                      SizedBox(
                                                                        width: width *
                                                                            .7,
                                                                        child: Text(
                                                                            "${bookingDetail[index].academyLocation}",
                                                                            maxLines:
                                                                                2,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                                                  color: MyAppState.mode == ThemeMode.light ? const Color(0XFF646464) : AppColors.grey,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontFamily: "Poppins",
                                                                                )),
                                                                      ),
                                                                      flaxibleGap(
                                                                          1),
                                                                    ],
                                                                  ),
                                                                  flaxibleGap(
                                                                      4),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                )
                                              : SizedBox(
                                                  height: height * 0.8,
                                                  width: width,
                                                  child: Column(
                                                    children: [
                                                      flaxibleGap(30),
                                                      SizedBox(
                                                          height: height * .15,
                                                          width: height * .15,
                                                          child: Image.asset(
                                                            'assets/images/icon.png',
                                                            fit: BoxFit.fill,
                                                          )),
                                                      flaxibleGap(4),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .noAcademiesAvailable,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyMedium!
                                                                  .copyWith(
                                                                    color: MyAppState.mode ==
                                                                            ThemeMode
                                                                                .light
                                                                        ? const Color(
                                                                            0XFF424242)
                                                                        : AppColors
                                                                            .white,
                                                                    fontFamily:
                                                                        "Poppins",
                                                                  )),
                                                      flaxibleGap(1),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .youHaveNotAcademy,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall!
                                                            .copyWith(
                                                              color: MyAppState
                                                                          .mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? const Color(
                                                                      0XFF7A7A7A)
                                                                  : Colors
                                                                      .white38,
                                                              fontFamily:
                                                                  "Poppins",
                                                            ),
                                                      ),
                                                      flaxibleGap(30),
                                                    ],
                                                  ),
                                                )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Column(
                                children: [
                                  Expanded(
                                    child: InternetLoss(
                                      onChange: () {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          _internet = msg;
                                          getBookingDetails();
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              )))),
      ),
    );
  }
}
