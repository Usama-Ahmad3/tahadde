import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_model.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookingModelClass.dart';

class PitchBookingDetails extends StatefulWidget {
  BookedModel bookindDetail;
  List bookedSessionIds;
  PitchBookingDetails(
      {super.key, required this.bookindDetail, required this.bookedSessionIds});
  @override
  _PitchBookingDetailsState createState() => _PitchBookingDetailsState();
}

class _PitchBookingDetailsState extends State<PitchBookingDetails> {
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
            setState(() {
              // _isLoading = false;
              // if (specificPitchScreen.isDeclined!) {
              //   venueType = "declined";
              // } else if (specificPitchScreen.isVerified!) {
              //   venueType = "verified";
              // } else {
              //   venueType = "inreview";
              // }
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
            // if (specificPitchScreen.isDeclined!) {
            //   venueType = "declined";
            // } else if (specificPitchScreen.isVerified!) {
            //   venueType = "verified";
            // } else {
            //   venueType = "inreview";
            // }
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
          sizeWidth,
          sizeHeight,
          context,
          AppLocalizations.of(context)!.academyBook,
          true,
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: sizeHeight * .02,
                          horizontal: sizeWidth * .08),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            color: AppColors.white24,
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.containerColorB,
                                  spreadRadius: 3,
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                  blurStyle: BlurStyle.outer)
                            ]),
                        height: sizeHeight * .6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            flaxibleGap(1),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                      height: sizeHeight * .08,
                                      width: sizeHeight * .08,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0XFF4F5C6A),
                                      ),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
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
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF032040)),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.call,
                                            color: Colors.green,
                                            size: sizeHeight * .025,
                                          ),
                                          Text(
                                            " ${widget.bookindDetail.playerPhoneno.toString()}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0XFF25A163)),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Icon(
                                            Icons.mail,
                                            color: Colors.green,
                                            size: sizeHeight * .025,
                                          ),
                                          Text(
                                            "  ${widget.bookindDetail.playerEmail}" ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Color(0XFF25A163)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  flaxibleGap(10),
                                ],
                              ),
                            ),
                            flaxibleGap(1),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Text(
                                AppLocalizations.of(context)!.bookingDetails,
                                style: const TextStyle(
                                    fontSize: 14, color: Color(0XFFADADAD)),
                              ),
                            ),
                            SizedBox(
                              height: sizeHeight * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Row(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)!.locale ==
                                                'en'
                                            ? specificAcademy!
                                                .academyNameEnglish
                                                .toString()
                                            : specificAcademy!.academyNameArabic
                                                .toString(),
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0XFF032040)),
                                      ),
                                      SizedBox(
                                        width: sizeWidth * .65,
                                        child: Text(
                                          widget.bookindDetail.location
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF9B9B9B)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  flaxibleGap(1),
                                  Container(
                                    width: 2,
                                    height: sizeHeight * .05,
                                    color: const Color(0XFF979797),
                                  ),
                                  flaxibleGap(1),
                                  Text(
                                    widget.bookindDetail.currency.toString(),
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0XFF25A163),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            flaxibleGap(1),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.slots,
                                    style: const TextStyle(
                                        color: Color(0XFFADADAD)),
                                  ),
                                  // widget.bookindDetail.booking_cancelled!
                                  //     ? Text(AppLocalizations.of(context)!.canceled,
                                  //         style: const TextStyle(
                                  //             color: Color(0XFF25A163),
                                  //             fontWeight: FontWeight.w600,
                                  //             fontFamily: "Poppins",
                                  //             fontSize: 10))
                                  //     :
                                  Text(AppLocalizations.of(context)!.booked,
                                      style: const TextStyle(
                                        color: Color(0XFF25A163),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins",
                                      ))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Text(
                                widget.bookindDetail.bookedDate.toString(),
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0XFF032040),
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: bookedSessions.length,
                                itemBuilder: (context, blockindex) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  'en'
                                              ? bookedSessions[blockindex]
                                                  .name
                                                  .toString()
                                              : bookedSessions[blockindex]
                                                  .nameArabic
                                                  .toString(),
                                          style: const TextStyle(
                                            color: Color(0XFF25A163),
                                          )),
                                      Text(
                                          "${bookedSessions[blockindex].startTime} To ${bookedSessions[blockindex].endTime}",
                                          // '(${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                                          style: const TextStyle(
                                            color: Color(0XFF25A163),
                                          )),
                                    ],
                                  );
                                },
                              ),
                            ),
                            flaxibleGap(1),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Text(
                                AppLocalizations.of(context)!.tranjectionId,
                                style:
                                    const TextStyle(color: Color(0XFFADADAD)),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .03),
                              child: Text(
                                widget.bookindDetail.transactionId.toString(),
                                style:
                                    const TextStyle(color: Color(0XFF032040)),
                              ),
                            ),
                            Container(
                              color: const Color(0XFFD8D8D8),
                              alignment: Alignment.center,
                              height: sizeHeight * .06,
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
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0XFF25A163),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                    flaxibleGap(1),
                                    Text(
                                      widget.bookindDetail.price.toString(),
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
                    ),
                  ],
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
