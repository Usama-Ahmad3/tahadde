import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/booking.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/shimmer_bookings.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/bookingModelClass.dart';
import '../../../../../network/network_calls.dart';
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
  late bool _internet;
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
              colorScheme: const ColorScheme.light(primary: Color(0XFF032040)),
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
                      backgroundColor: Colors.black,
                      appBar: PreferredSize(
                          preferredSize: Size(width, height * 0.105),
                          child: AppBar(
                            title: Text(
                              AppLocalizations.of(context)!.pitchBookings,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: Colors.white),
                            ),
                            centerTitle: true,
                            backgroundColor: Colors.black,
                          )),
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
                                        ? Colors.white
                                        : const Color(0xff686868),
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * .05,
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
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    )
                                                  : Text(
                                                      DateFormat.yMMMMEEEEd(
                                                              'ar_SA')
                                                          .format(BookingDate ??
                                                              DateTime.parse(date[
                                                                  "currentDate"])),
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? const Color(
                                                                  0XFF032040)
                                                              : Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                              Text(
                                                "${date["bookings"]}",
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF858585)
                                                        : Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
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
                                                children: <Widget>[
                                                  Image.asset(
                                                    'assets/images/closed.png',
                                                    fit: BoxFit.cover,
                                                    height: height * .03,
                                                    color: Colors.grey,
                                                  ),
                                                  Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .closed,
                                                    style: const TextStyle(
                                                        fontSize: 8,
                                                        color: Colors.black),
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
                                          labelColor: const Color(0XFF032040),
                                          //controller: tabController,
                                          labelStyle: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Poppins"),
                                          unselectedLabelColor:
                                              const Color(0XFFADADAD),
                                          indicatorSize:
                                              TabBarIndicatorSize.label,
                                          indicatorPadding:
                                              const EdgeInsets.only(),
                                          indicatorColor:
                                              const Color(0XFF032040),
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
                                                    style: const TextStyle(
                                                        //color: Color(0XFF032040),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Poppins")),
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
                                                    style: const TextStyle(
                                                        // color: Color(0XFF032040),
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily: "Poppins"),
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
                                          BookingsWidget(
                                            bookingDetail: bookingDetail,
                                          ),
                                          const ManageSlotsWidget(),
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

  _buildShimmer(sizeWidth, sizeHeight) {
    return SizedBox(
      width: sizeWidth,
      height: sizeHeight,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
              preferredSize: Size(sizeWidth, sizeHeight * 0.105),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.pitchBookings,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
              )),
          body: Container(
            height: sizeHeight,
            width: sizeWidth,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeWidth * .05, vertical: sizeHeight * .01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .4,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .2,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      flaxibleGap(4),
                      Container(
                        height: sizeHeight * .06,
                        width: sizeHeight * .07,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade100,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/closed.png',
                              fit: BoxFit.cover,
                              height: sizeHeight * .03,
                            ),
                            Text(
                              AppLocalizations.of(context)!.closed,
                              style: const TextStyle(
                                  fontSize: 8, color: Color(0XFF9B9B9B)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF25A163).withOpacity(.18),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                    ),
                    constraints: BoxConstraints(maxHeight: sizeHeight * .06),
                    child: TabBar(
                      labelColor: const Color(0XFF032040),
                      //controller: tabController,
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      unselectedLabelColor: const Color(0XFFADADAD),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: const EdgeInsets.only(),
                      indicatorColor: const Color(0XFF032040),
                      indicatorWeight: 4,

                      tabs: [
                        Tab(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: sizeWidth * .4,
                            alignment: Alignment.bottomCenter,
                            child: Text(AppLocalizations.of(context)!.booking,
                                style: const TextStyle(
                                    //color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                          ),
                        )),
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Container(
                              width: sizeWidth * .4,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                AppLocalizations.of(context)!.manageSlots,
                                style: const TextStyle(
                                    // color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
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
                    children: [_buildBodySimmer(), _buildBodySimmer()],
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  Widget _buildBodySimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _shimmerCard(),
        ),
        itemCount: 5,
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
          color: Color(0XFFF7F7F7),
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
                  shape: BoxShape.circle,
                  color: Colors.white,
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
