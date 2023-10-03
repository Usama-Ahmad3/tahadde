import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';

class EventDetailOwner extends StatefulWidget {
  Map id;
  EventDetailOwner({super.key, required this.id});
  @override
  _EventDetailOwnerState createState() => _EventDetailOwnerState();
}

class _EventDetailOwnerState extends State<EventDetailOwner> {
  final List<String> imgList = [
    'assets/images/T.png',
  ];
  dynamic detail;
  bool editEvent = false;
  var id;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late String token;
  bool _isLoading = true;
  late bool _internet;
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  final itemSize = 120.0;
  late ScrollController _controller;
  var startDate;
  var startDateApi;
  var endDate;
  var endDateApi;
  var startTime;
  var startHourApi;
  var startMinuteApi;
  var lastBookingDate;
  var lastBookingDateApi;
  var endTime;
  var endHourApi;
  var endMinuteApi;

  loadProfile() async {
    widget.id["event"] == "League"
        ? _networkCalls.leagueOwnerDetail(
            id: widget.id['id'],
            onSuccess: (event) {
              setState(() {
                _isLoading = false;
                detail = event;
              });
            },
            onFailure: (msg) {
              setState(() {});
            },
            tokenExpire: () {
              if (mounted) on401(context);
            })
        : _networkCalls.tournamentOwnerDetail(
            id: widget.id['id'],
            onSuccess: (event) {
              setState(() {
                _isLoading = false;
                detail = event;
              });
            },
            onFailure: (msg) {
              setState(() {});
            },
            tokenExpire: () {
              if (mounted) on401(context);
            });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
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
              colorScheme: const ColorScheme.light(primary: appThemeColor),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );

  Future<TimeOfDay?> slecteTime(BuildContext context) {
    final now = DateTime.now();
    return showRoundedTimePicker(
      context: context,
      theme: ThemeData.light().copyWith(
          primaryColor: appThemeColor,
          buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: const ColorScheme.light(primary: appThemeColor).copyWith(secondary: appThemeColor)),
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      locale: Locale(AppLocalizations.of(context)!.locale),
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? _buildShimmer(sizeheight, sizewidth)
        : _internet
            ? Stack(
                children: <Widget>[
                  Scaffold(
                    key: scaffoldkey,
                    appBar: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: AppBar(
                          backgroundColor: const Color(0XFF032040),
                        )),
                    body: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 320,
                              color: const Color(0XFF032040),
                              child: Column(
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      ClipPath(
                                          clipper: Cliping(),
                                          child: cachedNetworkImage(
                                            height: 220,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            cuisineImageUrl: tornamentchecking()
                                                ? detail.tournamentfiles != null
                                                    ? detail.tournamentfiles
                                                        .files.filePath
                                                    : ''
                                                : detail.leaguefiles != null
                                                    ? detail.leaguefiles.files
                                                        .filePath
                                                    : '',
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10, right: 20, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(
                                                Icons.arrow_back_ios,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const Icon(
                                              Icons.share,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  flaxibleGap(
                                    2,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? EdgeInsets.only(
                                                left: sizewidth * .08)
                                            : EdgeInsets.only(
                                                right: sizewidth * .08),
                                        child: SizedBox(
                                          width: sizewidth * .6,
                                          child: Text(
                                            detail.name ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 18,
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: sizeheight * .04,
                                        width: sizewidth * .1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color(0XFF25A163),
                                        ),
                                        child: const Icon(
                                          Icons.call,
                                        ),
                                      ),
                                      flaxibleGap(
                                        4,
                                      ),
                                      Container(
                                        height: sizeheight * .04,
                                        width: sizewidth * .1,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color: const Color(0XFF25A163),
                                        ),
                                        child: const Icon(
                                          Icons.mail,
                                        ),
                                      ),
                                      flaxibleGap(
                                        10,
                                      ),
                                    ],
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? EdgeInsets.only(
                                                left: sizewidth * .08)
                                            : EdgeInsets.only(
                                                right: sizewidth * .08),
                                        child: Text(
                                          detail.pitchType.name ?? '',
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Color(0XFF25A163),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                      flaxibleGap(
                                        2,
                                      ),
                                      Container(
                                        width: 2,
                                        height: 15,
                                        color: Colors.grey,
                                      ),
                                      Flexible(
                                        flex: 2,
                                        child: Container(),
                                      ),
                                      Text(
                                        detail.gamePlay.name ?? '',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0XFF25A163),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      flaxibleGap(
                                        20,
                                      ),
                                    ],
                                  ),
                                  flaxibleGap(
                                    2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: const Color(0XFFF0F0F0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 20,
                                        left: 20,
                                        right: 20),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? const EdgeInsets.only(right: 10)
                                              : const EdgeInsets.only(left: 10),
                                          child: const Icon(Icons.event),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.dateTime,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Color(0XFF424242),
                                              decoration: TextDecoration.none),
                                        ),
                                        flaxibleGap(
                                          1,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              editEvent = true;
                                            });
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            size: 20,
                                            color: Color(0XFFBCBCBC),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!.start,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Color(0XFF898989),
                                              decoration: TextDecoration.none),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.end,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Color(0XFF898989),
                                              decoration: TextDecoration.none),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Text(
                                                (DateFormat.yMMMEd('en_US').format(DateTime.parse(detail.startDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0XFF898989),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                            : Text(
                                                (DateFormat.yMMMEd('ar_SA').format(DateTime.parse(detail.startDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0XFF898989),
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                        Text(
                                          AppLocalizations.of(context)!.to,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: Color(0XFF898989),
                                              decoration: TextDecoration.none),
                                        ),
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Text(
                                                (DateFormat.yMMMEd('en_US').format(DateTime.parse(detail.endDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0XFF898989),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                            : Text(
                                                (DateFormat.yMMMEd('ar_SA').format(DateTime.parse(detail.endDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 16,
                                                    color: Color(0XFF898989),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Text(
                                                (DateFormat.jm('en_US').format(DateTime.parse(detail.startDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20,
                                                    color: Color(0XFF4A4A4A),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                            : Text(
                                                (DateFormat.jm('ar_SA').format(DateTime.parse(detail.startDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20,
                                                    color: Color(0XFF4A4A4A),
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? Text(
                                                (DateFormat.jm('en_US').format(DateTime.parse(detail.endDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20,
                                                    color: Color(0XFF4A4A4A),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                            : Text(
                                                (DateFormat.jm('ar_SA').format(DateTime.parse(detail.endDate))),
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 20,
                                                    color: Color(0XFF4A4A4A),
                                                    decoration:
                                                        TextDecoration.none),
                                              )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, bottom: 20),
                                    child: AppLocalizations.of(context)!
                                                .locale ==
                                            "en"
                                        ? Text(
                                            '${AppLocalizations.of(context)!.lastDate} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(detail.bookingLastDate))}',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color(0XFF25A163),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          )
                                        : Text(
                                            '${AppLocalizations.of(context)!.lastDate} ${DateFormat.yMMMMd('ar_SA').format(DateTime.parse(detail.bookingLastDate))}',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                decoration:
                                                    TextDecoration.underline,
                                                color: Color(0XFF25A163),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          ),
                                  ),
                                  Container(
                                    color: const Color(0XFFD8D8D8),
                                    alignment: Alignment.center,
                                    height: sizeheight * .1,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              widget.id["event"] == "League"
                                                  ? AppLocalizations.of(context)!
                                                      .bookingpricefortheleague
                                                  : AppLocalizations.of(context)!
                                                      .bookingpricefortheTournament,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Color(0XFF4A4A4A),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 80,
                                            child: Text(
                                              '${AppLocalizations.of(context)!.currency} ${detail.paymentSummary.grandTotal.round()}',
                                              style: const TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: appThemeColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: sizeheight * .27,
                                color: const Color(0XFFF0F0F0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          "en"
                                                      ? const EdgeInsets.only(
                                                          right: 10,
                                                        )
                                                      : const EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                              child: const Icon(Icons.description),
                                            ),
                                            SizedBox(
                                              width: sizewidth * .75,
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .chooseFacilitiesProvided,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: Color(0XFF424242),
                                                      decoration:
                                                          TextDecoration.none)),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizeheight * .15,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: detail.facilities.length,
                                            itemBuilder: (BuildContext context,
                                                int blockIdx) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Container(
                                                  width: sizewidth * .28,
                                                  height: sizewidth * .07,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: const Color(0XFF25A163)
                                                        .withOpacity(.3),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      flaxibleGap(
                                                        2,
                                                      ),
                                                      cachedNetworkImage(
                                                        height:
                                                            sizeheight * .08,
                                                        width: sizewidth * .18,
                                                        cuisineImageUrl: detail
                                                            ?.facilities[
                                                                blockIdx]
                                                            ?.image
                                                            ?.filePath,
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          detail
                                                              .facilities[
                                                                  blockIdx]
                                                              .name,
                                                          style: const TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontSize: 12,
                                                              color: Color(
                                                                  0XFF424242),
                                                              decoration:
                                                                  TextDecoration
                                                                      .none)),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          detail.registeredTeam.length != 0
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                      height: sizeheight * .27 +
                                          (detail.registeredTeam.length > 1
                                              ? (sizeheight * .17) * 1
                                              : (sizeheight * .17) *
                                                  (detail.registeredTeam
                                                          .length -
                                                      1)),
                                      width: MediaQuery.of(context).size.width,
                                      color: const Color(0XFFF0F0F0),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: 10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20, bottom: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                "en"
                                                            ? const EdgeInsets.only(
                                                                right: 10)
                                                            : const EdgeInsets.only(
                                                                left: 10),
                                                    child: const Icon(Icons.person),
                                                  ),
                                                  Text(
                                                      "${AppLocalizations.of(context)!.registeredTeamC} (${detail.registeredTeam.length})",
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 16,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      navigateToverifiedPitchDetail();
                                                    },
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .viewAll,
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            fontSize: 14,
                                                            color: Color(
                                                                0XFF424242),
                                                            decoration:
                                                                TextDecoration
                                                                    .none)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: sizeheight * .16 +
                                                  (detail.registeredTeam
                                                              .length >
                                                          1
                                                      ? (sizeheight * .16) * 1
                                                      : (sizeheight * .16) *
                                                          (detail.registeredTeam
                                                                  .length -
                                                              1)),
                                              child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: detail
                                                              .registeredTeam
                                                              .length >
                                                          2
                                                      ? 2
                                                      : detail.registeredTeam
                                                          .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int blockIdx) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              sizeheight * .01),
                                                      child: Container(
                                                        color:
                                                            const Color(0XFF032040),
                                                        height:
                                                            sizeheight * .14,
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      sizeheight *
                                                                          .02),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height:
                                                                    sizeheight *
                                                                        .1,
                                                                width:
                                                                    sizewidth,
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                        height: sizeheight *
                                                                            .08,
                                                                        width: sizeheight *
                                                                            .08,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Color(0XFF4F5C6A),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(100.0),
                                                                          child: detail.registeredTeam[blockIdx].user.profile_pic != null
                                                                              ? Image.network(
                                                                                  detail.registeredTeam[blockIdx].user.profile_pic.filePath,
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/profile.png",
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        )),
                                                                    flaxibleGap(
                                                                      3,
                                                                    ),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <
                                                                          Widget>[
                                                                        Flexible(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              Container(),
                                                                        ),
                                                                        Text(
                                                                          "${detail.registeredTeam[blockIdx].user.first_name} ${detail.registeredTeam[blockIdx].user.last_name}",
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.white),
                                                                        ),
                                                                        Text(
                                                                          AppLocalizations.of(context)!
                                                                              .captain,
                                                                          style: const TextStyle(
                                                                              fontSize: 10,
                                                                              color: Color(0XFF25A163)),
                                                                        ),
                                                                        flaxibleGap(
                                                                          1,
                                                                        ),
                                                                        Text(
                                                                          detail.registeredTeam[blockIdx].team == null
                                                                              ? ""
                                                                              : detail.registeredTeam[blockIdx].team.teamName ?? "",
                                                                          style: const TextStyle(
                                                                              fontSize: 15,
                                                                              color: Colors.grey),
                                                                        ),
                                                                        flaxibleGap(
                                                                          3,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    flaxibleGap(
                                                                      4,
                                                                    ),
                                                                    Container(
                                                                        height: sizeheight *
                                                                            .08,
                                                                        width: sizeheight *
                                                                            .08,
                                                                        decoration:
                                                                            const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              Color(0XFF4F5C6A),
                                                                        ),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              const BorderRadius.all(Radius.circular(10)),
                                                                          child: detail.registeredTeam[blockIdx].team != null
                                                                              ? Image.network(
                                                                                  detail.registeredTeam[blockIdx].team.teamLogo.filePath,
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  "images/profile.png",
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        )),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                      )),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0XFFF0F0F0),
                                child: Padding(
                                  padding:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? const EdgeInsets.only(
                                              left: 20,
                                              bottom: 20,
                                            )
                                          : const EdgeInsets.only(
                                              right: 20,
                                              bottom: 20,
                                            ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: AppLocalizations.of(
                                                              context)!
                                                          .locale ==
                                                      "en"
                                                  ? const EdgeInsets.only(right: 10)
                                                  : const EdgeInsets.only(left: 10),
                                              child: const Icon(Icons.person),
                                            ),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .organisedby,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 18,
                                                    color: Color(0XFF424242),
                                                    decoration:
                                                        TextDecoration.none))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 5),
                                        child: Text(
                                            detail.organisedBy.name ?? '',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0XFF032040),
                                                decoration:
                                                    TextDecoration.none)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(detail.description,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                color: Color(0XFF424242),
                                                decoration:
                                                    TextDecoration.none)),
//
                                      ),
//
                                    ],
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                  editEvent
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        )
                      : Container(),
                  editEvent
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizewidth * .07),
                            child: Container(
                              height: sizeheight * .45,
                              width: sizewidth,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  flaxibleGap(
                                    1,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .05),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            AppLocalizations.of(context)!
                                                .editdatetime,
                                            style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Color(0XFFADADAD),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins")),
                                        flaxibleGap(
                                          1,
                                        ),
                                        SizedBox(
                                          height: sizeheight * .035,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              setState(() {
                                                editEvent = false;
                                              });
                                            },
                                            backgroundColor: const Color(0XFFD8D8D8),
                                            splashColor: Colors.black,
                                            child: Image.asset(
                                              "images/deletImage.png",
                                              height: sizeheight * .03,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .03),
                                    child: SizedBox(
                                      height: sizeheight * .3,
                                      child: Column(
                                        children: <Widget>[
                                          flaxibleGap(
                                            1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizewidth * .03),
                                            child: Row(
                                              children: <Widget>[
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .startDateC,
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          color: Color(
                                                              0XFF25A163)),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final selectDate =
                                                            await slecteDtateTime(
                                                                context);
                                                        if (selectDate !=
                                                            null) {
                                                          final selectTime =
                                                              await slecteTime(
                                                                  context);
                                                          if (selectTime !=
                                                              null) {
                                                            print(selectTime);
                                                            setState(() {
                                                              startDate =
                                                                  selectDate;
                                                              startDateApi = formatter
                                                                  .format(
                                                                      (selectDate))
                                                                  .toString();

                                                              startTime =
                                                                  selectTime
                                                                      .format(
                                                                          context);
                                                              startHourApi =
                                                                  selectTime
                                                                      .hour
                                                                      .toString();
                                                              startMinuteApi =
                                                                  selectTime
                                                                      .minute
                                                                      .toString();
                                                              if (startMinuteApi
                                                                      .length ==
                                                                  1) {
                                                                startMinuteApi =
                                                                    // ignore: prefer_interpolation_to_compose_strings
                                                                    "0" +
                                                                        startMinuteApi;
                                                              }
                                                            });
                                                          }
                                                        }
                                                      },
                                                      child: Material(
                                                        elevation: 5,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: sizewidth * .3,
                                                          height:
                                                              sizeheight * .12,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                height:
                                                                    sizeheight *
                                                                        .02,
                                                                color: const Color(
                                                                    0XFF25A163),
                                                              ),
                                                              flaxibleGap(
                                                                1,
                                                              ),
                                                              startTime == null
                                                                  ? SizedBox(
                                                                      width:
                                                                          sizewidth *
                                                                              .15,
                                                                      height:
                                                                          sizeheight *
                                                                              .07,
                                                                      child: Text(
                                                                          AppLocalizations.of(context)!
                                                                              .clickStartTime,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 11,
                                                                              color: Color(0XFF858585),
                                                                              decoration: TextDecoration.none)))
                                                                  : AppLocalizations.of(context)!.locale == "en"
                                                                      ? Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              DateFormat.d('en_US').format(startDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 24),
                                                                            ),
                                                                            Text(
                                                                              DateFormat.yMMM('en_US').format(startDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 12),
                                                                            ),
                                                                            Text(
                                                                              '$startTime',
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF25A163), fontWeight: FontWeight.w500, fontSize: 10),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              DateFormat.d('ar_SA').format(startDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 20),
                                                                            ),
                                                                            Text(
                                                                              DateFormat.yMMM('ar_SA').format(startDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 10),
                                                                            ),
                                                                            Text(
                                                                              '$startTime',
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF25A163), fontWeight: FontWeight.w500, fontSize: 8),
                                                                            )
                                                                          ],
                                                                        ),
                                                              flaxibleGap(
                                                                1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                flaxibleGap(
                                                  4,
                                                ),
                                                Column(
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .endDateC,
                                                      style: const TextStyle(
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 12,
                                                          color: Color(
                                                              0XFFF63F3F)),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () async {
                                                        final selectDate =
                                                            await slecteDtateTime(
                                                                context);
                                                        if (selectDate !=
                                                            null) {
                                                          final selectTime =
                                                              await slecteTime(
                                                                  context);
                                                          if (selectTime !=
                                                              null) {
                                                            print(selectTime);
                                                            setState(() {
                                                              endDate =
                                                                  selectDate;
                                                              endDateApi = formatter
                                                                  .format(
                                                                      (selectDate))
                                                                  .toString();
                                                              endTime = selectTime
                                                                  .format(
                                                                      context);
                                                              endHourApi =
                                                                  selectTime
                                                                      .hour
                                                                      .toString();
                                                              endMinuteApi =
                                                                  selectTime
                                                                      .minute
                                                                      .toString();
                                                              if (endMinuteApi
                                                                      .length ==
                                                                  1) {
                                                                endMinuteApi = "0" +
                                                                    endMinuteApi;
                                                              }
                                                            });
                                                          }
                                                        }
                                                      },
                                                      child: Material(
                                                        elevation: 5,
                                                        child: Container(
                                                          alignment:
                                                              Alignment.center,
                                                          width: sizewidth * .3,
                                                          height:
                                                              sizeheight * .12,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                height:
                                                                    sizeheight *
                                                                        .02,
                                                                color: const Color(
                                                                    0XFFF63F3F),
                                                              ),
                                                              flaxibleGap(
                                                                1,
                                                              ),
                                                              endDate == null
                                                                  ? SizedBox(
                                                                      width:
                                                                          sizewidth *
                                                                              .15,
                                                                      height:
                                                                          sizeheight *
                                                                              .07,
                                                                      child: Text(
                                                                          AppLocalizations.of(context)!
                                                                              .clickEndTime,
                                                                          style: const TextStyle(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 11,
                                                                              color: Color(0XFF858585),
                                                                              decoration: TextDecoration.none)))
                                                                  : AppLocalizations.of(context)!.locale == "en"
                                                                      ? Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              DateFormat.d('en_US').format(endDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 24),
                                                                            ),
                                                                            Text(
                                                                              DateFormat.yMMM('en_US').format(endDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 12),
                                                                            ),
                                                                            Text(
                                                                              '$endTime',
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF25A163), fontWeight: FontWeight.w500, fontSize: 10),
                                                                            )
                                                                          ],
                                                                        )
                                                                      : Column(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              DateFormat.d('ar_SA').format(endDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 20),
                                                                            ),
                                                                            Text(
                                                                              DateFormat.yMMM('ar_SA').format(endDate),
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF032040), fontWeight: FontWeight.w500, fontSize: 10),
                                                                            ),
                                                                            Text(
                                                                              '$endTime',
                                                                              style: const TextStyle(fontFamily: 'Poppins', decoration: TextDecoration.none, color: Color(0XFF25A163), fontWeight: FontWeight.w500, fontSize: 8),
                                                                            )
                                                                          ],
                                                                        ),
                                                              flaxibleGap(
                                                                1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: sizewidth * .03),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final selectDate =
                                                    await slecteDtateTime(
                                                        context);
                                                if (selectDate != null) {
                                                  setState(() {
                                                    lastBookingDate =
                                                        selectDate;
                                                    lastBookingDateApi =
                                                        formatter
                                                            .format(
                                                                (selectDate))
                                                            .toString();
                                                  });
                                                }
                                              },
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color(0XFFF2F2F2),
                                                  ),
                                                  height: sizeheight * .07,
                                                  child: Row(
                                                    children: <Widget>[
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .lastBooking,
                                                          style: const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontSize: 11,
                                                              color: Color(
                                                                  0XFF9B9B9B),
                                                              decoration:
                                                                  TextDecoration
                                                                      .none)),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      lastBookingDate == null
                                                          ? Container()
                                                          : AppLocalizations.of(
                                                                          context)!
                                                                      .locale ==
                                                                  "en"
                                                              ? Text(
                                                                  '${DateFormat.d('en_US').format(lastBookingDate)} ${DateFormat.yMMM('en_US').format(lastBookingDate)}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      color: Color(
                                                                          0XFF032040),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              : Text(
                                                                  '${DateFormat.d('ar_SA').format(lastBookingDate)} ${DateFormat.yMMM('ar_SA').format(lastBookingDate)}',
                                                                  style: const TextStyle(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none,
                                                                      color: Color(
                                                                          0XFF032040),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      const Icon(
                                                        Icons.calendar_today,
                                                        color: Colors.green,
                                                      ),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                    ],
                                                  )),
                                            ),
                                          ),
                                          flaxibleGap(
                                            1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  startDate != null &&
                                          endDate != null &&
                                          lastBookingDate != null
                                      ? GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              editEvent = false;
                                              _isLoading = true;
                                              String startdate = startDateApi +
                                                  "T" +
                                                  startHourApi +
                                                  ":" +
                                                  startMinuteApi +
                                                  ":00Z";
                                              String enddate = endDateApi +
                                                  "T" +
                                                  endHourApi +
                                                  ":" +
                                                  endMinuteApi +
                                                  ":00Z";
                                              String lastdate =
                                                  lastBookingDateApi +
                                                      "T00:00:00Z";
                                              Map details = {
                                                "startDate": startdate,
                                                "endDate": enddate,
                                                "bookingLastDate": lastdate,
                                              };

                                              if (widget.id["event"] ==
                                                  "League") {
                                                _networkCalls
                                                    .editLeagueOwnerDetail(
                                                  id: widget.id['id'],
                                                  bodyDetail: details,
                                                  onSuccess: (event) {
                                                    setState(() {
                                                      detail = event;
                                                      _isLoading = false;
                                                    });
                                                  },
                                                  onFailure: (msg) {
                                                    setState(() {
                                                      showMessage(
                                                          msg);
                                                      _isLoading = false;
                                                    });
                                                  },
                                                  tokenExpire: () {
                                                    if (mounted) on401(context);
                                                  },
                                                );
                                              } else {
                                                _networkCalls
                                                    .editTournamentOwnerDetail(
                                                  id: widget.id['id'],
                                                  bodyDetail: details,
                                                  onSuccess: (event) {
                                                    setState(() {
                                                      detail = event;
                                                      _isLoading = false;
                                                    });
                                                  },
                                                  onFailure: (msg) {
                                                    setState(() {
                                                      showMessage(
                                                          msg);
                                                      _isLoading = false;
                                                    });
                                                  },
                                                  tokenExpire: () {
                                                    if (mounted) on401(context);
                                                  },
                                                );
                                              }
                                            });
                                          },
                                          child: Container(
                                              color: const Color(0XFF25A163),
                                              height: sizeheight * .08,
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .save,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                ),
                                              )),
                                        )
                                      : Container(
                                          color: const Color(0XFFBCBCBC),
                                          height: sizeheight * .08,
                                          alignment: Alignment.center,
                                          child: Text(
                                            AppLocalizations.of(context)!.save,
                                            style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Poppins",
                                            ),
                                          )),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadProfile();
                    }
                  });
                },
              );
  }

  bool tornamentchecking() {
    if (detail is Turnament) {
      return true;
    } else {
      return false;
    }
  }

  void navigateToverifiedPitchDetail() {
    Navigator.pushNamed(context, RouteNames.registerTeam,
        arguments: detail.registeredTeam);
  }

  Widget _buildShimmer(sizeheight, sizewidth) {
    return Scaffold(
      key: scaffoldkey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 320,
                color: const Color(0XFF032040),
                child: Column(
                  children: <Widget>[
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade300,
                      enabled: true,
                      child: ClipPath(
                          clipper: Cliping(),
                          child: Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white,
                          )),
                    ),
                    flaxibleGap(
                      2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: AppLocalizations.of(context)!.locale == "en"
                              ? EdgeInsets.only(left: sizewidth * .08)
                              : EdgeInsets.only(right: sizewidth * .08),
                          child: Container(
                            height: 30,
                            width: sizewidth * .6,
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                        ),
                        flaxibleGap(
                          2,
                        ),
                        Container(
                          height: sizeheight * .04,
                          width: sizewidth * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0XFF25A163),
                          ),
                          child: const Icon(
                            Icons.call,
                          ),
                        ),
                        flaxibleGap(
                          4,
                        ),
                        Container(
                          height: sizeheight * .04,
                          width: sizewidth * .1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: const Color(0XFF25A163),
                          ),
                          child: const Icon(
                            Icons.mail,
                          ),
                        ),
                        flaxibleGap(
                          10,
                        ),
                      ],
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: AppLocalizations.of(context)!.locale == "en"
                              ? EdgeInsets.only(left: sizewidth * .08)
                              : EdgeInsets.only(right: sizewidth * .08),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                        flaxibleGap(
                          2,
                        ),
                        Container(
                          width: 2,
                          height: 15,
                          color: Colors.grey,
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade300,
                          enabled: true,
                          child: Container(
                            height: 20,
                            width: sizewidth * .2,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0) //

                                      ),
                            ),
                          ),
                        ),
                        flaxibleGap(
                          20,
                        ),
                      ],
                    ),
                    flaxibleGap(
                      2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0XFFF0F0F0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: AppLocalizations.of(context)!.locale == "en"
                                ? const EdgeInsets.only(right: 10)
                                : const EdgeInsets.only(left: 10),
                            child: const Icon(Icons.event),
                          ),
                          Text(
                            AppLocalizations.of(context)!.dateTime,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0XFF424242),
                                decoration: TextDecoration.none),
                          ),
                          flaxibleGap(
                            1,
                          ),
                          const Icon(
                            Icons.edit,
                            size: 20,
                            color: Color(0XFFBCBCBC),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                          Text(
                            AppLocalizations.of(context)!.to,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Color(0XFF898989),
                                decoration: TextDecoration.none),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade300,
                        enabled: true,
                        child: Container(
                          height: 30,
                          width: sizewidth * .6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                    ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: const Color(0XFFD8D8D8),
                      alignment: Alignment.center,
                      height: sizeheight * .1,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                widget.id["event"] == "League"
                                    ? AppLocalizations.of(context)!
                                        .bookingpricefortheleague
                                    : AppLocalizations.of(context)!
                                        .bookingpricefortheTournament,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Color(0XFF4A4A4A),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            ),
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade300,
                              enabled: true,
                              child: Container(
                                height: 20,
                                width: sizewidth * .2,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0) //

                                          ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: sizeheight * .27,
                  color: const Color(0XFFF0F0F0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? const EdgeInsets.only(
                                            right: 10,
                                          )
                                        : const EdgeInsets.only(
                                            left: 10,
                                          ),
                                child: const Icon(Icons.description),
                              ),
                              SizedBox(
                                width: sizewidth * .75,
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .chooseFacilitiesProvided,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0XFF424242),
                                        decoration: TextDecoration.none)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: sizewidth,
                          child: Row(
                            children: [
                              const Icon(Icons.arrow_back_ios),
                              Expanded(
                                child: SizedBox(
                                  height: sizeheight * .15,
                                  width: sizewidth * .82,
                                  child: ListView.builder(
                                      controller: _controller,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 5,
                                      itemExtent: itemSize,
                                      itemBuilder:
                                          (BuildContext context, int blockIdx) {
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey.shade300,
                                            highlightColor: Colors.grey.shade300,
                                            enabled: true,
                                            child: Container(
                                              width: sizewidth * .28,
                                              height: sizewidth * .07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF25A163)
                                                    .withOpacity(.3),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_ios)
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  height: sizeheight * .27,
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0XFFF0F0F0),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? const EdgeInsets.only(right: 10)
                                        : const EdgeInsets.only(left: 10),
                                child: const Icon(Icons.person),
                              ),
                              Text(
                                  AppLocalizations.of(context)!.registeredTeamC,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: Color(0XFF424242),
                                      decoration: TextDecoration.none)),
                              flaxibleGap(
                                1,
                              ),
                              Text(AppLocalizations.of(context)!.viewAll,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Color(0XFF424242),
                                      decoration: TextDecoration.none)),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: sizeheight * .16,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: 1,
                              itemBuilder:
                                  (BuildContext context, int blockIdx) {
                                return Padding(
                                  padding:
                                      EdgeInsets.only(bottom: sizeheight * .01),
                                  child: Container(
                                    color: const Color(0XFF032040),
                                    height: sizeheight * .14,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeheight * .02),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: sizeheight * .1,
                                            width: sizewidth,
                                            child: Row(
                                              children: <Widget>[
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade300,
                                                  enabled: true,
                                                  child: Container(
                                                    height: sizeheight * .08,
                                                    width: sizeheight * .08,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                flaxibleGap(
                                                  3,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    flaxibleGap(
                                                      4,
                                                    ),
                                                    Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.grey.shade300,
                                                      enabled: true,
                                                      child: Container(
                                                        height: 25,
                                                        width: sizewidth * .4,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0) //

                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .captain,
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color(
                                                              0XFF25A163)),
                                                    ),
                                                    flaxibleGap(
                                                      1,
                                                    ),
                                                    Shimmer.fromColors(
                                                      baseColor: Colors.grey.shade300,
                                                      highlightColor: Colors.grey.shade300,
                                                      enabled: true,
                                                      child: Container(
                                                        height: 25,
                                                        width: sizewidth * .3,
                                                        decoration:
                                                            const BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0) //

                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                    flaxibleGap(
                                                      3,
                                                    ),
                                                  ],
                                                ),
                                                flaxibleGap(
                                                  4,
                                                ),
                                                Shimmer.fromColors(
                                                  baseColor: Colors.grey.shade300,
                                                  highlightColor: Colors.grey.shade300,
                                                  enabled: true,
                                                  child: Container(
                                                    height: sizeheight * .08,
                                                    width: sizeheight * .08,
                                                    decoration: const BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: const Color(0XFFF0F0F0),
                  child: Padding(
                    padding: AppLocalizations.of(context)!.locale == "en"
                        ? const EdgeInsets.only(
                            left: 20,
                            bottom: 20,
                          )
                        : const EdgeInsets.only(
                            right: 20,
                            bottom: 20,
                          ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? const EdgeInsets.only(right: 10)
                                        : const EdgeInsets.only(left: 10),
                                child: const Icon(Icons.person),
                              ),
                              Text(AppLocalizations.of(context)!.organisedby,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: Color(0XFF424242),
                                      decoration: TextDecoration.none))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 60,
                              width: sizewidth * .6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

class Cliping extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 3, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 20);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
