import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/routingConstant.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/modelClass/player_bookings.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:intl/intl.dart';

class PlayerBookingScreen extends StatefulWidget {
  bool bookingTag;
  PlayerBookingScreen({super.key, this.bookingTag = false});
  @override
  _PlayerBookingScreenState createState() => _PlayerBookingScreenState();
}

class _PlayerBookingScreenState extends State<PlayerBookingScreen> {
  bool? internet;
  bool state = true;
  final bool _auth = false;
  List<Map> academyDetail = [];
  String date = "name";
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  List<BookedSessions> bookedSessions = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  late PlayerBookings bookings;

  loadBookings() async {
    await _networkCalls.loadPlayerbookings(
      onSuccess: (event) {
        setState(() {
          bookings = event;
        });
        loadSpecificSession();
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) {
          on401(context);
          showMessage(AppLocalizations.of(context)!.loginRequired);
        }
      },
    );
  }

  List<dynamic> reversedItemAfter = [];
  List<dynamic> reversedItemAfterCurrent = [];
  List<dynamic> reversedItemBefore = [];
  separateListbefore() {
    final reversed = bookings.bookings!.reversed.toList();
    reversedItemBefore = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.isBefore(currentDateWithoutTime);
    }).toList();

    print(reversedItemBefore.length);
  }

  separateListAfter() {
    final reversed = bookings.bookings!.reversed.toList();
    reversedItemAfterCurrent = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.day == DateTime.now().day;
    }).toList();
    print('shdgdg');
    print(reversedItemAfter.length);
    reversedItemAfter = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.isAfter(currentDateWithoutTime);
    }).toList();
    reversedItemAfter.addAll(reversedItemAfterCurrent);
    print(reversedItemAfter.length);
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
                  const ColorScheme.light(primary: AppColors.appThemeColor),
              buttonTheme:
                  const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

  loadSpecificSession() {
    if (bookings.bookings!.isNotEmpty) {
      bookings.bookings!.forEach((element) async {
        element.bookedSession!.forEach((sessionsId) async {
          await _networkCalls.specificSession(
            id: sessionsId.toString(),
            onSuccess: (event) async {
              BookedSessions session = BookedSessions.fromJson(event);
              bookedSessions.add(session);
              if (mounted) {
                setState(() {});
              }
            },
            onFailure: (msg) {
              if (mounted) {
                showMessage(msg);
              }
            },
            tokenExpire: () {
              if (mounted) on401(context);
            },
          );
        });
      });
      separateListAfter();
      separateListbefore();
      state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadBookings();
      } else {
        setState(() {
          state = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)!.booking,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.black,
            leadingWidth: widget.bookingTag ? sizeWidth * 0.13 : 0,
            leading: widget.bookingTag
                ? InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                        height: sizeHeight * 0.03,
                        child: Image.asset(
                          'assets/images/back.png',
                          color: AppColors.white,
                        )),
                  )
                : null,
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppColors.grey,
              tabAlignment: TabAlignment.center,
              automaticIndicatorColorAdjustment: true,
              indicatorColor: AppColors.appThemeColor,
              dividerColor: AppColors.black,
              isScrollable: true,
              physics: const AlwaysScrollableScrollPhysics(),
              // indicator: BoxDecoration(
              //   color: Color(0xff1d7e55),
              //   borderRadius: BorderRadius.circular(8),
              // ),
              padding: EdgeInsets.symmetric(vertical: sizeHeight * 0.003),
              tabs: [
                SizedBox(
                  width: sizeWidth * 0.34,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(sizeHeight * 0.01),
                    child: Text(
                      AppLocalizations.of(context)!.onGoing,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  )),
                ),
                SizedBox(
                  width: sizeWidth * 0.34,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(sizeHeight * 0.012),
                    child: Text(
                      AppLocalizations.of(context)!.complete,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  )),
                ),
              ],
            ),
          ),
          body: state
              ? Container(
                  height: sizeHeight * 0.9,
                  width: sizeWidth,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appThemeColor,
                    ),
                  ),
                )
              : Container(
                  height: sizeHeight,
                  width: sizeWidth,
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.00),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: sizeHeight * 0.015,
                            ),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight),
                              child: TabBarView(
                                children: [
                                  reversedItemAfter.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            flaxibleGap(30),
                                            SizedBox(
                                                height: sizeHeight * .15,
                                                width: sizeHeight * .15,
                                                child: Image.asset(
                                                  'assets/images/icon.png',
                                                  fit: BoxFit.fill,
                                                )),
                                            flaxibleGap(4),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .noBookingsFound,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontFamily: "Poppins",
                                                    )),
                                            flaxibleGap(1),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .youHaveBooked,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF7A7A7A)
                                                        : Colors.white38,
                                                    fontFamily: "Poppins",
                                                  ),
                                            ),
                                            flaxibleGap(30),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            controller: ScrollController(),
                                            scrollDirection: Axis.vertical,
                                            itemCount: reversedItemAfter.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  reversedItemAfter[index];
                                              // String zero = '0';
                                              // print(item.bookedDate);
                                              // DateTime date = Intl.withLocale(
                                              //     'en',
                                              //     () => DateTime.parse(
                                              //         '${item.bookedDate ?? '2023-11-29'} ${TimeOfDay.now().hour < 10 ? zero + TimeOfDay.now().hour.toString() : TimeOfDay.now().hour}:${TimeOfDay.now().minute < 10 ? zero + TimeOfDay.now().minute.toString() : TimeOfDay.now().minute}'));
                                              return bookingsList(
                                                  sizeWidth,
                                                  sizeHeight,
                                                  item,
                                                  index,
                                                  false);
                                            },
                                          )),
                                  reversedItemBefore.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            flaxibleGap(30),
                                            SizedBox(
                                                height: sizeHeight * .15,
                                                width: sizeHeight * .15,
                                                child: Image.asset(
                                                  'assets/images/icon.png',
                                                  fit: BoxFit.fill,
                                                )),
                                            flaxibleGap(4),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .noBookingsFound,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontFamily: "Poppins",
                                                    )),
                                            flaxibleGap(1),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .youHaveBooked,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF7A7A7A)
                                                        : Colors.white38,
                                                    fontFamily: "Poppins",
                                                  ),
                                            ),
                                            flaxibleGap(30),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemCount:
                                                reversedItemBefore.length,
                                            itemBuilder: (context, index) {
                                              final item =
                                                  reversedItemBefore[index];
                                              return bookingsList(
                                                  sizeWidth,
                                                  sizeHeight,
                                                  item,
                                                  index,
                                                  true);
                                            },
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                )),
    );
  }

  navigateToPayment(index, dateTime) {
    Map detial = {
      'totalPrice': bookings.bookings![index].price,
      "price": bookings.bookings![index].price,
      "name": bookings.bookings![index].academyName,
      'academy_id': bookings.bookings![index].academy,
      "apidetail": dateTime,
      "id": bookings.bookings![index].player,
      'sessionId': bookings.bookings![index].bookedSession,
      'location': bookings.bookings![index].location,
      "player_count": bookings.bookings![index].playerCount,
      "slug": 'price-per-player'
    };
    print(detial);
    academyDetail.add(detial);
    Navigator.pushNamed(context, RouteNames.payment, arguments: academyDetail);
  }

  ///Whole widget of booking detail list
  Widget bookingsList(sizeWidth, sizeHeight, booking, index, completed) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: sizeWidth * .07),
      child: SizedBox(
        height: booking.bookedSession!.length == 1
            ? sizeHeight * 0.51
            : sizeHeight * .57,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${AppLocalizations.of(context)!.bookedOn} ${booking.bookingDate.toString()}",
              style: TextStyle(
                  fontSize: sizeHeight * 0.017,
                  color: MyAppState.mode == ThemeMode.light
                      ? const Color(0XFF032040)
                      : Colors.white),
            ),
            SizedBox(
              height: sizeHeight * 0.005,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.grey200
                      : AppColors.containerColorW12,
                  boxShadow: [
                    BoxShadow(
                        color: AppColors.containerColorB,
                        spreadRadius: 3,
                        blurRadius: 2,
                        offset: const Offset(1, 1),
                        blurStyle: BlurStyle.outer)
                  ]),
              height: booking.bookedSession!.length == 1
                  ? sizeHeight * 0.47
                  : sizeHeight * .53,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: sizeHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Row(
                      children: [
                        Container(
                            height: sizeHeight * .08,
                            width: sizeHeight * .08,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0XFF4F5C6A),
                            ),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(sizeHeight * .1),
                                child: cachedNetworkImage(
                                    height: sizeHeight * .08,
                                    cuisineImageUrl:
                                        booking.playerPicture ?? '',
                                    placeholder: 'assets/images/profile.png'))),
                        flaxibleGap(2),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              booking.playerName.toString(),
                              style: TextStyle(
                                  fontSize: sizeHeight * 0.017,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? const Color(0XFF032040)
                                      : AppColors.white),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.call,
                                  color: Colors.green,
                                  size: sizeHeight * .025,
                                ),
                                Text(
                                  " ${booking.playerPhoneno.toString()}",
                                  style: TextStyle(
                                      fontSize: sizeHeight * 0.012,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFFADADAD)
                                          : AppColors.white),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Icon(
                                  Icons.mail,
                                  color: Colors.green,
                                  size: sizeHeight * .025,
                                ),
                                Text(
                                  "  ${booking.playerEmail}" ?? "",
                                  style: TextStyle(
                                      fontSize: sizeHeight * 0.012,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFFADADAD)
                                          : Colors.white),
                                )
                              ],
                            )
                          ],
                        ),
                        flaxibleGap(10),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Text(
                      AppLocalizations.of(context)!.bookingDetails,
                      style: TextStyle(
                          fontSize: sizeHeight * 0.017,
                          color: MyAppState.mode == ThemeMode.light
                              ? Colors.black
                              : AppColors.white),
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Text(
                            //   "${AppLocalizations.of(context)!.academyName}:",
                            //   style: TextStyle(
                            //       fontSize: 14,
                            //       color: MyAppState.mode == ThemeMode.light
                            //           ? const Color(0XFF032040)
                            //           : AppColors.white),
                            // ),
                            Text(
                              AppLocalizations.of(context)!.locale == 'en'
                                  ? booking.academyName.toString()
                                  : booking.academyNameArabic.toString(),
                              style: TextStyle(
                                  fontSize: sizeHeight * 0.015,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? const Color(0XFF25A163)
                                      : AppColors.grey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: sizeWidth * .78,
                              child: Text(
                                booking.location.toString(),
                                style: TextStyle(
                                    fontSize: sizeHeight * 0.013,
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF9B9B9B)
                                        : Colors.grey),
                              ),
                            ),
                          ],
                        )
                        // Container(
                        //   width: 2,
                        //   height: sizeHeight * .05,
                        //   color: const Color(0XFF979797),
                        // ),
                        // flaxibleGap(1),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.status}:",
                          style: TextStyle(
                              fontSize: sizeHeight * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF032040)
                                  : AppColors.white),
                        ),
                        Text(AppLocalizations.of(context)!.booked,
                            style: TextStyle(
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF25A163)
                                    : Colors.grey,
                                fontFamily: "Poppins",
                                fontSize: sizeHeight * 0.015,))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.playerCount}:",
                          style: TextStyle(
                              fontSize: sizeHeight * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF032040)
                                  : AppColors.white),
                        ),
                        Text(
                          "${booking.playerCount} ${booking.playerCount!.toInt() == 1 ? AppLocalizations.of(context)!.player : AppLocalizations.of(context)!.players}",
                          style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : AppColors.grey,
                              fontSize: sizeHeight * 0.015,),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.bookingDate}:",
                          style: TextStyle(
                              fontSize: sizeHeight * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF032040)
                                  : AppColors.white),
                        ),
                        Text(
                          booking.bookedDate.toString(),
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : Colors.grey,
                              decoration: TextDecoration.none,
                              fontSize: sizeHeight * 0.015),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${AppLocalizations.of(context)!.tranjectionId}:",
                          style: TextStyle(
                              fontSize: sizeHeight * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF032040)
                                  : AppColors.white),
                        ),
                        Text(
                          booking.transactionId.toString(),
                          style: TextStyle(
                              fontSize: sizeHeight * 0.015,
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF25A163)
                                  : AppColors.grey),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.slot,
                    style: TextStyle(
                        fontSize: sizeHeight * 0.017,
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.black
                            : AppColors.white),
                  ),
                  SizedBox(
                    width: sizeWidth,
                    height: booking.bookedSession!.length == 1
                        ? sizeHeight * 0.048
                        : sizeHeight * 0.11,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: bookedSessions.length,
                      itemBuilder: (context, blockindex) {
                        return booking.bookedSession!
                                .contains(bookedSessions[blockindex].id)
                            ? Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .03),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    'en'
                                                ? "${bookedSessions[blockindex].name} (${bookedSessions[blockindex].slotDuration} mins)"
                                                : "${bookedSessions[blockindex].nameArabic} (${bookedSessions[blockindex].slotDuration} mins)",
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontSize: sizeHeight * 0.015)),
                                        Text(
                                            "${bookedSessions[blockindex].startTime} ${AppLocalizations.of(context)!.to} ${bookedSessions[blockindex].endTime}",
                                            // '(${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.grey
                                                    : Colors.grey,
                                                fontSize: sizeHeight * 0.014)),
                                      ],
                                    ),
                                    completed == false
                                        ? SizedBox.shrink()
                                        : InkWell(
                                            onTap: () async {
                                              final selectDate =
                                                  await slecteDtateTime(
                                                      context);
                                              String dateTime = apiFormatter
                                                  .format(selectDate!);
                                              print(dateTime);

                                              ///dialog Box For reBook
                                              // ignore: use_build_context_synchronously
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (context) => AlertDialog(
                                                            elevation: 2,
                                                            backgroundColor: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .grey200
                                                                : AppColors
                                                                    .darkTheme,
                                                            shape: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            title: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .areYouSure,
                                                              style: TextStyle(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white),
                                                            ),
                                                            content: Text(
                                                              '${AppLocalizations.of(context)!.rebookThis} $dateTime',
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .appThemeColor),
                                                            ),
                                                            actions: [
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false);
                                                                },
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: AppColors
                                                                          .appThemeColor,
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .no,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          true);
                                                                  navigateToPayment(
                                                                      index,
                                                                      dateTime);

                                                                  ///close the app
                                                                  // exit(0);
                                                                },
                                                                child: Center(
                                                                  child:
                                                                      Container(
                                                                    height: 50,
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width *
                                                                        0.8,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: AppColors
                                                                          .appThemeColor,
                                                                      border: Border.all(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              AppColors.transparent),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        AppLocalizations.of(context)!
                                                                            .yes,
                                                                        style: TextStyle(
                                                                            color:
                                                                                AppColors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ));
                                            },
                                            child: Container(
                                              height: sizeHeight * 0.04,
                                              width: sizeWidth * 0.25,
                                              decoration: BoxDecoration(
                                                  color:
                                                      AppColors.appThemeColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Center(
                                                child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .bookAgain,
                                                    style:  TextStyle(
                                                        color: Colors.white,
                                                        fontSize: sizeHeight * 0.015,)),
                                              ),
                                            ),
                                          )
                                  ],
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.01,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0XFFD8D8D8),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    height: sizeHeight * .06,
                    width: sizeWidth * 0.91,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            AppLocalizations.of(context)!.paidTotal,
                            style:  TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0XFF25A163),
                                fontWeight: FontWeight.w500,
                                fontSize: sizeHeight * 0.015),
                          ),
                          flaxibleGap(1),
                          Text(
                            booking.price.toString(),
                            style:  TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0XFF25A163),
                                fontWeight: FontWeight.w500,
                                fontSize: sizeHeight * 0.015,),
                          ),
                          Text(
                            booking.currency.toString(),
                            style:  TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0XFF25A163),
                                fontWeight: FontWeight.w500,
                                fontSize: sizeHeight * 0.015,),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
