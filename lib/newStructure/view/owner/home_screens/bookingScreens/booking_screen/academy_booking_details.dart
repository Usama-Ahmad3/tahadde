import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_model.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:intl/intl.dart';

import '../../../../../../constant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/bookingModelClass.dart';

class AcademyBookingDetails extends StatefulWidget {
  BookedModel bookindDetail;
  List bookedSessionIds;
  AcademyBookingDetails(
      {super.key, required this.bookindDetail, required this.bookedSessionIds});
  @override
  _AcademyBookingDetailsState createState() => _AcademyBookingDetailsState();
}

class _AcademyBookingDetailsState extends State<AcademyBookingDetails> {
  NetworkCalls _networkCalls = NetworkCalls();
  List<BookedSessions> bookedSessions = [];
  SpecificAcademy? specificAcademy;
  bool loading = true;
  loadSpecificSession() {
    widget.bookedSessionIds.forEach((id) async {
      await _networkCalls.specificSession(
        id: id.toString(),
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
    loadSpecific();
  }

  loadSpecific() async {
    print('kks');
    await _networkCalls.specificAcademy(
      id: widget.bookindDetail.academy.toString(),
      onSuccess: (event) async {
        specificAcademy = event;
        if (mounted) {
          setState(() {
            loading = false;
          });
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
  }

  @override
  void initState() {
    loadSpecificSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: appBarWidget(
          sizeWidth: sizeWidth,
          sizeHeight: sizeHeight,
          context: context,
          title: AppLocalizations.of(context)!.booked,
          back: true,
        ),
        body: loading
            ? Container(
                height: sizeHeight,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * .07),
                        child: SizedBox(
                          height: bookedSessions.length == 1
                              ? sizeHeight * 0.55
                              : sizeHeight * .63,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${AppLocalizations.of(context)!.bookedOn} ${widget.bookindDetail.bookingDate}",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Color(0XFF032040)
                                        : Colors.white),
                              ),
                              SizedBox(
                                height: sizeHeight * 0.005,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.white24
                                        : AppColors.containerColorW12,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.containerColorB,
                                          spreadRadius: 3,
                                          blurRadius: 2,
                                          offset: const Offset(1, 1),
                                          blurStyle: BlurStyle.outer)
                                    ]),
                                height: bookedSessions.length == 1
                                    ? sizeHeight * 0.5
                                    : sizeHeight * .56,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: sizeHeight * 0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
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
                                                      BorderRadius.circular(
                                                          sizeHeight * .1),
                                                  child: cachedNetworkImage(
                                                      height: sizeHeight * .08,
                                                      cuisineImageUrl: widget
                                                              .bookindDetail
                                                              .playerPicture ??
                                                          '',
                                                      placeholder:
                                                          'assets/images/profile.png'))),
                                          flaxibleGap(2),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                widget.bookindDetail.playerName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Color(0XFF032040)
                                                        : AppColors.white),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.call,
                                                    color: Colors.green,
                                                    size: sizeHeight * .025,
                                                  ),
                                                  Text(
                                                    " ${widget.bookindDetail.playerPhoneno.toString()}",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Color(0XFFADADAD)
                                                            : AppColors.white),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.mail,
                                                    color: Colors.green,
                                                    size: sizeHeight * .025,
                                                  ),
                                                  Text(
                                                    "  ${widget.bookindDetail.playerEmail}" ??
                                                        "",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Color(0XFFADADAD)
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .bookingDetails,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.black
                                                : AppColors.white),
                                      ),
                                    ),
                                    SizedBox(
                                      height: sizeHeight * 0.01,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${AppLocalizations.of(context)!.academyName}:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Color(0XFF032040)
                                                        : AppColors.white),
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? specificAcademy!
                                                        .academyNameEnglish
                                                        .toString()
                                                    : specificAcademy!
                                                        .academyNameArabic
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Color(0XFF25A163)
                                                        : AppColors.grey),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: sizeWidth * .78,
                                                child: Text(
                                                  specificAcademy!
                                                      .academyLocation
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Color(0XFF9B9B9B)
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.status}:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF032040)
                                                    : AppColors.white),
                                          ),
                                          Text(
                                              AppLocalizations.of(context)!
                                                  .booked,
                                              style: TextStyle(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? Color(0XFF25A163)
                                                      : Colors.grey,
                                                  fontFamily: "Poppins",
                                                  fontSize: 14))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.bookedFor}:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF032040)
                                                    : AppColors.white),
                                          ),
                                          Text(
                                            "${widget.bookindDetail.playerCount} ${widget.bookindDetail.playerCount!.toInt() == 1 ? AppLocalizations.of(context)!.player : AppLocalizations.of(context)!.players}",
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF25A163)
                                                    : AppColors.grey,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.bookingDate}:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF032040)
                                                    : AppColors.white),
                                          ),
                                          Text(
                                            widget.bookindDetail.bookedDate
                                                .toString(),
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF25A163)
                                                    : Colors.grey,
                                                decoration: TextDecoration.none,
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .03),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${AppLocalizations.of(context)!.tranjectionId}:",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF032040)
                                                    : AppColors.white),
                                          ),
                                          Text(
                                            widget.bookindDetail.transactionId
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Color(0XFF25A163)
                                                    : AppColors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.slot,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? Colors.black
                                                  : AppColors.white),
                                    ),
                                    bookedSessions.isNotEmpty
                                        ? SizedBox(
                                            width: sizeWidth,
                                            height: bookedSessions.length == 1
                                                ? sizeHeight * 0.048
                                                : sizeHeight * 0.11,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: bookedSessions.length,
                                              itemBuilder:
                                                  (context, blockindex) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          sizeWidth * .03),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              AppLocalizations.of(
                                                                              context)!
                                                                          .locale ==
                                                                      'en'
                                                                  ? "${bookedSessions[blockindex].name} (${bookedSessions[blockindex].slotDuration} mins)"
                                                                  : "${bookedSessions[blockindex].nameArabic} (${bookedSessions[blockindex].slotDuration} mins)",
                                                              style: TextStyle(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? AppColors
                                                                          .black
                                                                      : AppColors
                                                                          .white,
                                                                  fontSize:
                                                                      14)),
                                                          Text(
                                                              "${bookedSessions[blockindex].startTime} ${AppLocalizations.of(context)!.to} ${bookedSessions[blockindex].endTime}",
                                                              // '(${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                                                              style: TextStyle(
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? AppColors
                                                                          .grey
                                                                      : Colors
                                                                          .grey,
                                                                  fontSize:
                                                                      13)),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : SizedBox(
                                            height: sizeHeight * 0.01,
                                          ),
                                    SizedBox(
                                      height: sizeHeight * 0.01,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: const Color(0XFFD8D8D8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      alignment: Alignment.center,
                                      height: sizeHeight * .06,
                                      width: sizeWidth * 0.9,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .paidTotal,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0XFF25A163),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                            flaxibleGap(1),
                                            Text(
                                              widget.bookindDetail.price
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0XFF25A163),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
                                            ),
                                            Text(
                                              widget.bookindDetail.currency
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0XFF25A163),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14),
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
                      ),
                    ],
                  ),
                ),
              ));
  }

  String timing({required int x}) {
    String day;
    switch (x) {
      case 0:
        day = "12 AM";
        break;
      case 1:
        day = "1 AM";
        break;
      case 2:
        day = "2 AM";
        break;
      case 3:
        day = "3 AM";
        break;
      case 4:
        day = "4 AM";
        break;
      case 5:
        day = "5 AM";
        break;
      case 6:
        day = "6 AM";
        break;
      case 7:
        day = "7 AM";
        break;
      case 8:
        day = "8 AM";
        break;
      case 9:
        day = "9 AM";
        break;
      case 10:
        day = "10 AM";
        break;
      case 11:
        day = "11 AM";
        break;
      case 12:
        day = "12 PM";
        break;
      case 13:
        day = "1 PM";
        break;
      case 14:
        day = "2 PM";
        break;
      case 15:
        day = "3 PM";
        break;
      case 16:
        day = "4 PM";
        break;
      case 17:
        day = "5 PM";
        break;
      case 18:
        day = "6 PM";
        break;
      case 19:
        day = "7 PM";
        break;
      case 20:
        day = "8 PM";
        break;
      case 21:
        day = "9 PM";
        break;
      case 22:
        day = "10 PM";
        break;
      default:
        day = "11 PM";
        break;
    }
    return day;
  }
}
