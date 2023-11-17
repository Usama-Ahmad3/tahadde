import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/bookingWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/shimmer_bookings.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/bookingModelClass.dart';
import '../../../../../network/network_calls.dart';
import '../../../player/HomeScreen/widgets/app_bar.dart';
import 'manageSlotWidget.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  var BookingDate;
  var bookingDateApi;
  late String datevalue;
  bool _internet = true;
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  var date;
  List<BookingModelClass>? bookingDetail;

  bookingDetails() async {
    await _networkCalls.booking(
      date:
          BookingDate != null ? bookingDateApi.toString() : date["currentDate"],
      onSuccess: (detail) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            bookingDetail = detail;
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

  findDate(String datevalue) async {
    await _networkCalls.currentDate(
      date: datevalue,
      onSuccess: (dateValue) {
        date = dateValue;
        bookingDetails();
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
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
      findDate('');
      print(date);
      print(DateTime.now());
    });
  }

  Future<DateTime?> slecteDtateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030),
        locale: Locale(AppLocalizations.of(context)!.locale),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  const ColorScheme.light(primary: AppColors.themeColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return RefreshIndicator(
        displacement: 200,
        onRefresh: () async {
          _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
            _internet = msg;
            findDate(datevalue ?? "");
          });
        },
        child: _isLoading
            ? ShimmerBookings.buildShimmer(width, height, context)
            : _internet
                ? DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      backgroundColor: AppColors.black,
                      appBar: appBarWidget(
                        width,
                        height,
                        context,
                        AppLocalizations.of(context)!.academyBook,
                        false,
                      ),
                      body: LayoutBuilder(
                        builder: (context, constraint) {
                          return SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(
                                  minHeight: constraint.maxHeight),
                              child: Container(
                                height: height * .1,
                                width: width,
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.white
                                        : AppColors.darkTheme,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .059,
                                          vertical: height * .01),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      "en"
                                                  ? Text(
                                                      DateFormat.yMMMMEEEEd(
                                                              'en_US')
                                                          .format(BookingDate ??
                                                              DateTime.parse(
                                                                  date["currentDate"] ??
                                                                      '')),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: MyAppState
                                                                          .mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? AppColors
                                                                      .themeColor
                                                                  : AppColors
                                                                      .white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    )
                                                  : Text(
                                                      DateFormat.yMMMMEEEEd(
                                                              'ar_SA')
                                                          .format(BookingDate ??
                                                              DateTime.parse(date[
                                                                  "currentDate"])),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                              color: MyAppState
                                                                          .mode ==
                                                                      ThemeMode
                                                                          .light
                                                                  ? AppColors
                                                                      .themeColor
                                                                  : AppColors
                                                                      .white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                              // Text(
                                              //   "${date["bookings"]} ${AppLocalizations.of(context)!.booking}",
                                              //   style: Theme.of(context)
                                              //       .textTheme
                                              //       .bodyMedium!
                                              //       .copyWith(
                                              //           color: MyAppState
                                              //                       .mode ==
                                              //                   ThemeMode.light
                                              //               ? const Color(
                                              //                   0XFF858585)
                                              //               : AppColors.white,
                                              //           fontWeight:
                                              //               FontWeight.w700),
                                              // ),
                                            ],
                                          ),
                                          flaxibleGap(4),
                                          GestureDetector(
                                            onTap: () async {
                                              final selectDate =
                                                  await slecteDtateTime(
                                                      context);
                                              if (selectDate != null) {
                                                setState(() {
                                                  _isLoading = true;
                                                  BookingDate = selectDate;
                                                  bookingDateApi = formatter
                                                      .format(selectDate);
                                                  datevalue = formatter
                                                      .format(selectDate)
                                                      .toString();
                                                  findDate(
                                                      "?slotDate=$datevalue");
                                                });
                                              }
                                            },
                                            child: Container(
                                              height: height * .06,
                                              width: height * .07,
                                              decoration: BoxDecoration(
                                                color: Colors.teal.shade100,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(12) //
                                                        ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/closed.png',
                                                    fit: BoxFit.cover,
                                                    height: height * .03,
                                                    color: AppColors.grey,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .closed,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleSmall!
                                                        .copyWith(
                                                            color: AppColors
                                                                .black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Material(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.teal.shade100),
                                        constraints: BoxConstraints(
                                            maxHeight: height * .06),
                                        child: TabBar(
                                          labelColor: AppColors.appThemeColor,
                                          //controller: tabController,
                                          labelStyle: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: "Poppins"),
                                          unselectedLabelColor:
                                              const Color(0XFFADADAD),
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorPadding:
                                              const EdgeInsets.only(),
                                          indicatorColor:
                                              AppColors.appThemeColor,
                                          indicatorWeight: 4,

                                          tabs: [
                                            Tab(
                                                child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 6.0),
                                              child: Container(
                                                width: width * .4,
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .booking,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            //color: Color(0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins")),
                                              ),
                                            )),
                                            Tab(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 6.0),
                                                child: Container(
                                                  width: width * .4,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .manageSlots,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            // color: Color(0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins"),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: TabBarView(
                                        children: [
                                          BookingWidget(
                                              // bookingDetail: bookingDetail,
                                              ),
                                          ManageSlotsWidget(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ), // This trailing comma makes auto-formatting nicer for build methods.
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
                              findDate(DateTime.now().toString());
                            });
                          },
                        ),
                      ),
                    ],
                  ));
  }
}
