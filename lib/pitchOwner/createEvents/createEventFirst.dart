import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class CreateEventFirst extends StatefulWidget {
  String event;
  CreateEventFirst({required this.event});
  @override
  _CreateEventFirstState createState() => _CreateEventFirstState();
}

class _CreateEventFirstState extends State<CreateEventFirst> {
  bool _isLoading = true;
  late String price;
  bool cancel = false;
  late bool _internet;
  bool ok = true;
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  var startDate;
  var startDateApi;
  int team = 00;
  var endDate;
  var endDateApi;
  late String leagueName;
  late String description;
  var startTime;
  var startHourApi;
  var startMinuteApi;
  var lastBookingDate;
  var lastBookingDateApi;
  final _formKey = GlobalKey<FormState>();
  var endTime;
  var endHourApi;
  var endMinuteApi;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool pitchStatus = false;
  final focus = FocusNode();
  final focuss = FocusNode();
  final focusss = FocusNode();
  late OverlayEntry? overlayEntry;
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: DoneButton(),
      );
    });
    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  veryfyPitchStatus() async {
    await _networkCalls.veryPitch(
        onSuccess: (pitchInfo) {
          var status = pitchInfo;
          print(status);
          setState(() {
            if (status == "verified pitches exist") {
              pitchStatus = false;
              _isLoading = false;
            } else {
              pitchStatus = true;
              _isLoading = false;
            }
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focusss.addListener(() {
        bool hasFocus = focusss.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      _internet
          ? veryfyPitchStatus()
          : {
              if (mounted)
                setState(() {
                  _isLoading = false;
                })
            };
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
        locale: Locale(AppLocalizations.of(context)!.locale));
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? buildShimmer(sizeWidth, sizeHeight)
        : _internet
            ? Stack(
                children: <Widget>[
                  Scaffold(
                    appBar: AppBar(
                      leading: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Color(0XFFFFFFFF),
                        ),
                      ),
                      automaticallyImplyLeading: false,
                      title: Text(
                        widget.event == "League"
                            ? AppLocalizations.of(context)!.createLeague
                            : AppLocalizations.of(context)!.createTournament,
                        style: TextStyle(
                            fontSize: appHeaderFont,
                            color: const Color(0XFFFFFFFF),
                            fontFamily:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? "Poppins"
                                    : "VIP",
                            fontWeight:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                      ),
                      backgroundColor: const Color(0XFF032040),
                    ),
                    bottomNavigationBar: startDate != null &&
                            endDate != null &&
                            team != 00 &&
                            lastBookingDate != null
                        ? Material(
                            color: const Color(0XFF25A163),
                            child: InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _formKey.currentState!.save();
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
                                      lastBookingDateApi + "T00:00:00Z";
                                  if (widget.event == "League") {
                                    Map details = {
                                      "leagueName": leagueName,
                                      "leagueDescription": description,
                                      "leaguePrice": price,
                                      "startDate": startdate,
                                      "endDate": enddate,
                                      "bookingLastDate": lastdate,
                                      "totalnumberofTeams": team,
                                      "event": widget.event
                                    };

                                    navigateTocreateEvent(details);
                                  } else {
                                    Map details = {
                                      "tournamentName": leagueName,
                                      "tournamentDescription": description,
                                      "tournamentPrice": price,
                                      "startDate": startdate,
                                      "endDate": enddate,
                                      "bookingLastDate": lastdate,
                                      "totalnumberofTeams": team,
                                      "event": widget.event
                                    };

                                    navigateTocreateEvent(details);
                                  }
                                }
                              },
                              splashColor: Colors.black,
                              child: Container(
                                  height: sizeHeight * .104,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.continueW,
                                    style: const TextStyle(
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Colors.white),
                                  )),
                            ),
                          )
                        : Container(
                            height: sizeHeight * .104,
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.continueW,
                              style: const TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white),
                            )),
                    body: SingleChildScrollView(
                      child: SizedBox(
                        height: sizeHeight * .79,
                        width: sizeWidth,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    height: sizeHeight * .005,
                                    width: sizeWidth * .49,
                                    color: const Color(0XFF25A163),
                                  ),
                                  flaxibleGap(1),
                                  Container(
                                    height: sizeHeight * .005,
                                    width: sizeWidth * .49,
                                    color: const Color(0XFFCBCBCB),
                                  ),
                                ],
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: Text(
                                  widget.event == "League"
                                      ? AppLocalizations.of(context)!
                                          .leagueDetails
                                      : AppLocalizations.of(context)!
                                          .tournamentDetails,
                                  style: const TextStyle(
                                      color: Color(0XFF032040),
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05),
                                child: Material(
                                  elevation: 10,
                                  child: Container(
                                    height: sizeHeight * .73,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: textField(
                                            font: 10,
                                            node: focus,
                                            submit: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(focuss);
                                            },
                                            name: widget.event == "League"
                                                ? AppLocalizations.of(context)!
                                                    .leagueName
                                                : AppLocalizations.of(context)!
                                                    .tournamentName,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseentername;
                                              }
                                              return '';
                                            },
                                            onSaved: (value) {
                                              leagueName = value!;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: sizeWidth * .05,
                                              top: sizeWidth * .05,
                                              right: sizeWidth * .05,
                                              bottom: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .description,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  // color: Color(0XFF25A163),
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              const Text(
                                                "0/30",
                                                style: TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
                                                  // color: Color(0XFF25A163),
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 10,
                                                  fontFamily: 'Poppins',
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: Container(
                                            height: sizeHeight * .13,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(0XFFA3A3A3))),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                textInputAction:
                                                    TextInputAction.next,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .pleaseenterDescription;
                                                  }
                                                  return null;
                                                },

                                                onSaved: (value) {
                                                  description = value!;
                                                },
                                                focusNode: focuss,
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontWeight:
                                                        FontWeight.w500),
                                                onFieldSubmitted: (value) {
                                                  FocusScope.of(context)
                                                      .requestFocus(focusss);
                                                },
                                                decoration: const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  enabledBorder:
                                                      InputBorder.none,
                                                  focusedBorder:
                                                      InputBorder.none,
                                                ),
                                                keyboardType:
                                                    TextInputType.multiline,

                                                maxLines: 3,
                                                // maxLength: 30,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: TextFormField(
                                            focusNode: focusss,
                                            textInputAction:
                                                TextInputAction.done,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterprice;
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              price = value!;
                                            },
                                            autofocus: false,
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.all(0),
                                              labelText: AppLocalizations.of(
                                                      context)!
                                                  .bookingPrice, //\uD83D\uDD12
                                              labelStyle: const TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12),
                                              suffixText:
                                                  AppLocalizations.of(context)!
                                                      .currency,
                                              suffixStyle: const TextStyle(
                                                  color: Color(0XFF858585)),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                              focusedBorder:
                                                  const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05,
                                              vertical: sizeHeight * .02),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .totalTeamParticipate,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Color(0XFFA3A3A3)),
                                              ),
                                              flaxibleGap(4),
                                              GestureDetector(
                                                onTap: () {
                                                  if (team >= 1) {
                                                    setState(() {
                                                      team = team - 1;
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: sizeWidth * .08,
                                                  height: sizeHeight * .04,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color(0XFF25A163)
                                                        .withOpacity(.3),
                                                  ),
                                                  child: const Text("-",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF25A163),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                ),
                                              ),
                                              flaxibleGap(1),
                                              team == 0
                                                  ? const Text(
                                                      "00",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color: Color(
                                                              0XFFA3A3A3)),
                                                    )
                                                  : Text(
                                                      "$team",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0XFF032040),
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                              flaxibleGap(1),
                                              GestureDetector(
                                                onTap: () {
                                                  //if(team<=15)
                                                  setState(() {
                                                    team = team + 1;
                                                  });
                                                },
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  width: sizeWidth * .08,
                                                  height: sizeHeight * .04,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: const Color(0XFF25A163)
                                                        .withOpacity(.3),
                                                  ),
                                                  child: const Text("+",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF25A163),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            flaxibleGap(1),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .startDate,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0XFF25A163)),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final selectDate =
                                                        await slecteDtateTime(
                                                            context);
                                                    if (selectDate != null) {
                                                      final selectTime =
                                                          // ignore: use_build_context_synchronously
                                                          await slecteTime(
                                                              context);
                                                      if (selectTime != null) {
                                                        print(selectTime);
                                                        setState(() {
                                                          startDate =
                                                              selectDate;
                                                          startDateApi = formatter
                                                              .format(
                                                                  (selectDate))
                                                              .toString();

                                                          startTime = selectTime
                                                              .format(context);
                                                          startHourApi =
                                                              selectTime.hour
                                                                  .toString();
                                                          startMinuteApi =
                                                              selectTime.minute
                                                                  .toString();
                                                          print(startDateApi);
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Material(
                                                    elevation: 5,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: sizeWidth * .3,
                                                      height: sizeHeight * .12,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: sizeHeight *
                                                                .02,
                                                            color: const Color(
                                                                0XFF25A163),
                                                          ),
                                                          flaxibleGap(1),
                                                          startTime == null
                                                              ? SizedBox(
                                                                  width:
                                                                      sizeWidth *
                                                                          .2,
                                                                  height:
                                                                      sizeHeight *
                                                                          .07,
                                                                  child: Text(
                                                                      AppLocalizations.of(context)!
                                                                          .clickStartTime,
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11,
                                                                          color: Color(
                                                                              0XFF858585),
                                                                          decoration: TextDecoration
                                                                              .none)))
                                                              : AppLocalizations.of(
                                                                              context)!
                                                                          .locale ==
                                                                      "en"
                                                                  ? Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          DateFormat.d('en_US').format(startDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 24),
                                                                        ),
                                                                        Text(
                                                                          DateFormat.yMMM('en_US').format(startDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12),
                                                                        ),
                                                                        Text(
                                                                          '$startTime',
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF25A163),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          DateFormat.d('ar_SA').format(startDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 20),
                                                                        ),
                                                                        Text(
                                                                          DateFormat.yMMM('ar_SA').format(startDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10),
                                                                        ),
                                                                        Text(
                                                                          '$startTime',
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF25A163),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 8),
                                                                        )
                                                                      ],
                                                                    ),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Flexible(
                                              flex: 4,
                                              child: Container(),
                                            ),
                                            Column(
                                              children: <Widget>[
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .endDate,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12,
                                                      color: Color(0XFFF63F3F)),
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    final selectDate =
                                                        await slecteDtateTime(
                                                            context);
                                                    if (selectDate != null) {
                                                      final selectTime =
                                                          // ignore: use_build_context_synchronously
                                                          await slecteTime(
                                                              context);
                                                      if (selectTime != null) {
                                                        print(selectTime);
                                                        setState(() {
                                                          endDate = selectDate;
                                                          endDateApi = formatter
                                                              .format(
                                                                  (selectDate))
                                                              .toString();
                                                          endTime = selectTime
                                                              .format(context);
                                                          endHourApi =
                                                              selectTime.hour
                                                                  .toString();
                                                          endMinuteApi =
                                                              selectTime.minute
                                                                  .toString();
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Material(
                                                    elevation: 5,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: sizeWidth * .3,
                                                      height: sizeHeight * .12,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            height: sizeHeight *
                                                                .02,
                                                            color: const Color(
                                                                0XFFF63F3F),
                                                          ),
                                                          flaxibleGap(1),
                                                          endDate == null
                                                              ? SizedBox(
                                                                  width:
                                                                      sizeWidth *
                                                                          .2,
                                                                  height:
                                                                      sizeHeight *
                                                                          .07,
                                                                  child: Text(
                                                                      AppLocalizations.of(context)!
                                                                          .clickEndTime,
                                                                      style: const TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              11,
                                                                          color: Color(
                                                                              0XFF858585),
                                                                          decoration: TextDecoration
                                                                              .none)))
                                                              : AppLocalizations.of(
                                                                              context)!
                                                                          .locale ==
                                                                      "en"
                                                                  ? Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          DateFormat.d('en_US').format(endDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 24),
                                                                        ),
                                                                        Text(
                                                                          DateFormat.yMMM('en_US').format(endDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 12),
                                                                        ),
                                                                        Text(
                                                                          '$endTime',
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF25A163),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10),
                                                                        )
                                                                      ],
                                                                    )
                                                                  : Column(
                                                                      children: <
                                                                          Widget>[
                                                                        Text(
                                                                          DateFormat.d('ar_SA').format(endDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 20),
                                                                        ),
                                                                        Text(
                                                                          DateFormat.yMMM('ar_SA').format(endDate),
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF032040),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 10),
                                                                        ),
                                                                        Text(
                                                                          '$endTime',
                                                                          style: const TextStyle(
                                                                              fontFamily: 'Poppins',
                                                                              decoration: TextDecoration.none,
                                                                              color: Color(0XFF25A163),
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 8),
                                                                        )
                                                                      ],
                                                                    ),
                                                          flaxibleGap(1),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        flaxibleGap(1),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final selectDate =
                                                  await slecteDtateTime(
                                                      context);
                                              if (selectDate != null) {
                                                setState(() {
                                                  lastBookingDate = selectDate;
                                                  lastBookingDateApi = formatter
                                                      .format((selectDate))
                                                      .toString();
                                                });
                                              }
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: const Color(0XFFF2F2F2),
                                                ),
                                                height: sizeHeight * .07,
                                                child: Row(children: <Widget>[
                                                  flaxibleGap(1),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .lastBooking,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 11,
                                                          color:
                                                              Color(0XFF9B9B9B),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  flaxibleGap(1),
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
                                                                  fontSize: 12),
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
                                                                  fontSize: 12),
                                                            ),
                                                  flaxibleGap(1),
                                                  const Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.green,
                                                  ),
                                                  flaxibleGap(1),
                                                ])),
                                          ),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              flaxibleGap(1),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  pitchStatus
                      ? BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black.withOpacity(.2),
                          ),
                        )
                      : Container(),
                  pitchStatus
                      ? Scaffold(
                          backgroundColor: Colors.transparent,
                          body: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07),
                              child: Container(
                                height: sizeHeight * .19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                width: sizeWidth,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: sizeWidth * .05,
                                      vertical: sizeHeight * .03),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          const Icon(
                                            Icons.adjust,
                                            color: Color(0XFF4A4A4A),
                                          ),
                                          flaxibleGap(1),
                                          SizedBox(
                                              height: sizeHeight * .09,
                                              width: sizeWidth * .66,
                                              child: Text(
                                                "${AppLocalizations.of(context)!.youcannotcreatea} ${widget.event == "League" ? AppLocalizations.of(context)!.league : AppLocalizations.of(context)!.tournament}, ${AppLocalizations.of(context)!.asyourpitchhasnotbeenverifiedyet}",
                                                style: const TextStyle(
                                                    color: Color(0XFF4A4A4A),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ))
                                        ],
                                      ),
                                      flaxibleGap(1),
                                      Row(
                                        children: <Widget>[
                                          flaxibleGap(7),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Container(
                                              height: sizeHeight * .04,
                                              width: sizeWidth * .1,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(0XFFA3A3A3)),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF25A163),
                                              ),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .ok),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              )
            : Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  title: Text(
                    widget.event == "League"
                        ? AppLocalizations.of(context)!.createLeague
                        : AppLocalizations.of(context)!.createTournament,
                    style: TextStyle(
                        fontSize: AppLocalizations.of(context)!.locale == "en"
                            ? 20
                            : 30,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                body: Expanded(
                  child: InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        _internet = msg;
                        if (_internet) veryfyPitchStatus();
                      });
                    },
                  ),
                ),
              );
  }

  Widget buildShimmer(sizeWidth, sizeHeight) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color(0XFFFFFFFF),
          ),
        ),
        automaticallyImplyLeading: false,
        title: Text(
          widget.event == "League"
              ? AppLocalizations.of(context)!.createLeague
              : AppLocalizations.of(context)!.createTournament,
          style: TextStyle(
              fontSize: appHeaderFont,
              color: const Color(0XFFFFFFFF),
              fontFamily: AppLocalizations.of(context)!.locale == "en"
                  ? "Poppins"
                  : "VIP",
              fontWeight: AppLocalizations.of(context)!.locale == "en"
                  ? FontWeight.bold
                  : FontWeight.normal),
        ),
        backgroundColor: const Color(0XFF032040),
      ),
      bottomNavigationBar: Container(
          height: sizeHeight * .104,
          color: Colors.grey,
          alignment: Alignment.center,
          child: Text(
            AppLocalizations.of(context)!.continueW,
            style: const TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500,
                fontSize: 20,
                color: Colors.white),
          )),
      body: SingleChildScrollView(
        child: SizedBox(
          height: sizeHeight * .79,
          width: sizeWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: sizeHeight * .005,
                    width: sizeWidth * .49,
                    color: const Color(0XFF25A163),
                  ),
                  flaxibleGap(1),
                  Container(
                    height: sizeHeight * .005,
                    width: sizeWidth * .49,
                    color: const Color(0XFFCBCBCB),
                  ),
                ],
              ),
              flaxibleGap(1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                child: Text(
                  widget.event == "League"
                      ? AppLocalizations.of(context)!.leagueDetails
                      : AppLocalizations.of(context)!.tournamentDetails,
                  style: const TextStyle(
                      color: Color(0XFF032040),
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600),
                ),
              ),
              flaxibleGap(1),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                child: Material(
                  elevation: 10,
                  child: Container(
                    height: sizeHeight * .73,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05, vertical: 5),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              width: sizeWidth,
                              height: 35,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05,
                              top: sizeWidth * .05,
                              right: sizeWidth * .05,
                              bottom: 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!.description,
                                style: const TextStyle(
                                  decoration: TextDecoration.none,
                                  // color: Color(0XFF25A163),
                                  color: Color(0XFFADADAD),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(),
                              ),
                              const Text(
                                "0/30",
                                style: TextStyle(
                                  decoration: TextDecoration.none,
                                  // color: Color(0XFF25A163),
                                  color: Color(0XFFADADAD),
                                  fontSize: 10,
                                  fontFamily: 'Poppins',
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Container(
                            height: sizeHeight * .13,
                            decoration: BoxDecoration(
                                border: Border.all(color: const Color(0XFFA3A3A3))),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05, vertical: 7),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              width: sizeWidth,
                              height: 35,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                              vertical: sizeHeight * .02),
                          child: Row(
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context)!
                                    .totalTeamParticipate,
                                style: const TextStyle(
                                    fontSize: 12, color: Color(0XFFA3A3A3)),
                              ),
                              flaxibleGap(4),
                              Container(
                                alignment: Alignment.center,
                                width: sizeWidth * .08,
                                height: sizeHeight * .04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0XFF25A163).withOpacity(.3),
                                ),
                                child: const Text("-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Color(0XFF25A163),
                                        decoration: TextDecoration.none)),
                              ),
                              flaxibleGap(1),
                              team == 0
                                  ? const Text(
                                      "00",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFFA3A3A3)),
                                    )
                                  : Text(
                                      "$team",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w700),
                                    ),
                              flaxibleGap(1),
                              Container(
                                alignment: Alignment.center,
                                width: sizeWidth * .08,
                                height: sizeHeight * .04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0XFF25A163).withOpacity(.3),
                                ),
                                child: const Text("+",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Color(0XFF25A163),
                                        decoration: TextDecoration.none)),
                              )
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            flaxibleGap(1),
                            Column(
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context)!.startDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0XFF25A163)),
                                ),
                                Material(
                                  elevation: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: sizeWidth * .3,
                                    height: sizeHeight * .12,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: sizeHeight * .02,
                                          color: const Color(0XFF25A163),
                                        ),
                                        flaxibleGap(1),
                                        startTime == null
                                            ? SizedBox(
                                                width: sizeWidth * .2,
                                                height: sizeHeight * .07,
                                                child: Text(
                                                    AppLocalizations.of(context)!
                                                        .clickStartTime,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11,
                                                        color:
                                                            Color(0XFF858585),
                                                        decoration:
                                                            TextDecoration
                                                                .none)))
                                            : AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? Column(
                                                    children: <Widget>[
                                                      Text(
                                                        DateFormat.d('en_US').format(startDate),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 24),
                                                      ),
                                                      Text(
                                                        DateFormat.yMMM('en_US').format(startDate),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        '$startTime',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF25A163),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 10),
                                                      )
                                                    ],
                                                  )
                                                : Column(
                                                    children: <Widget>[
                                                      Text(
                                                        DateFormat.d('ar_SA').format(startDate),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                        DateFormat.yMMM('ar_SA').format(startDate),
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF032040),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 10),
                                                      ),
                                                      Text(
                                                        '$startTime',
                                                        style: const TextStyle(
                                                            fontFamily:
                                                                'Poppins',
                                                            decoration:
                                                                TextDecoration
                                                                    .none,
                                                            color: Color(
                                                                0XFF25A163),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 8),
                                                      )
                                                    ],
                                                  ),
                                        flaxibleGap(1),
                                      ],
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
                                  AppLocalizations.of(context)!.endDate,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color(0XFFF63F3F)),
                                ),
                                Material(
                                  elevation: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: sizeWidth * .3,
                                    height: sizeHeight * .12,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: sizeHeight * .02,
                                          color: const Color(0XFFF63F3F),
                                        ),
                                        flaxibleGap(1),
                                        SizedBox(
                                            width: sizeWidth * .2,
                                            height: sizeHeight * .07,
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .clickEndTime,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 11,
                                                    color: Color(0XFF858585),
                                                    decoration:
                                                        TextDecoration.none))),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            flaxibleGap(1),
                          ],
                        ),
                        flaxibleGap(1),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: const Color(0XFFF2F2F2),
                              ),
                              height: sizeHeight * .07,
                              child: Row(children: <Widget>[
                                flaxibleGap(1),
                                Text(AppLocalizations.of(context)!.lastBooking,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 11,
                                        color: Color(0XFF9B9B9B),
                                        decoration: TextDecoration.none)),
                                flaxibleGap(2),
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.green,
                                ),
                                flaxibleGap(1),
                              ])),
                        ),
                        flaxibleGap(1),
                      ],
                    ),
                  ),
                ),
              ),
              flaxibleGap(1),
            ],
          ),
        ),
      ),
    );
  }

  void navigateTocreateEvent(Map detail) {
    Navigator.pushNamed(context, RouteNames.createEventSecond, arguments: detail);
  }
}
