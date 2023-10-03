import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:intl/intl.dart';
import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class ClosingHour extends StatefulWidget {
  Map detail;
  ClosingHour({super.key, required this.detail});

  @override
  _ClosingHourState createState() => _ClosingHourState();
}

class _ClosingHourState extends State<ClosingHour> {
  late String comment;
  var slotData;
  bool _isLoading = true;
  var bookingDateStart;
  var bookingTimeStart;
  var bookingDateEnd;
  var bookingTimeEnd;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  var endHourApi;
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  var startDateApi;
  var endDateApi;
  var endMinuteApi;
  var startHourApi;
  var startMinuteApi;
  final _formKey = GlobalKey<FormState>();
  final NetworkCalls _networkCalls = NetworkCalls();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map urlDetail = {
      "pitchtype_id": widget.detail["pitchId"],
      "id": widget.detail["id"],
    };

    _networkCalls.closingHourGet(
      urlDate: urlDetail,
      onSuccess: (data) {
        setState(() {
          slotData = data;
          _isLoading = false;
        });
      },
      onFailure: (msg) {
        setState(() {
          _isLoading = false;
          showMessage(msg);
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
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
                    const ColorScheme.light(primary: Color(0XFF032040)),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );
    Future<TimeOfDay?> slecteTime(
      BuildContext context,
    ) {
      final now = DateTime.now();
      return showRoundedTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
        locale: Locale(AppLocalizations.of(context)!.locale),
        theme: ThemeData.light().copyWith(
            primaryColor: appThemeColor,
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: const ColorScheme.light(primary: appThemeColor).copyWith(secondary: appThemeColor)),
      );
    }

    return Scaffold(
        key: scaffoldkey,
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
          //centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.closedHours,
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
        bottomNavigationBar: bookingDateStart != null &&
                bookingTimeStart != null &&
                bookingDateEnd != null &&
                bookingTimeEnd != null
            ? Material(
                color: const Color(0XFF25A163),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _isLoading = true;
                        Map urlDetail = {
                          "pitchtype_id": widget.detail["pitchId"],
                          "id": widget.detail["id"],
                          "status": "unavailable"
                        };
                        Map detail = {
                          "comment": comment,
                          "startDate": startDateApi,
                          "endDate": endDateApi,
                          "startTime": "$startHourApi:00:00",
                          "endTime": "$endHourApi:00:00",
                        };
                        _networkCalls.closingHourSend(
                          urlDate: urlDetail,
                          bodyDate: detail,
                          onSuccess: (msg) {
                            setState(() {
                              _isLoading = false;
                              slotData = msg;
                            });
                          },
                          onFailure: (msg) {
                            setState(() {
                              _isLoading = false;
                              showMessage(msg);
                            });
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      }
                    });
                  },
                  splashColor: Colors.black,
                  child: Container(
                      height: sizeHeight * .07,
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context)!.save,
                        style: const TextStyle(
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                ),
              )
            : Container(
                height: sizeHeight * .09,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.save,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white),
                )),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: appThemeColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0XFF25A163),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.only(top: sizeHeight * .05),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: Container(
                            alignment: Alignment.topCenter,
                            height: sizeHeight * .05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: const Color(0XFFE0E0E0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .pleaseentercomment;
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  comment = value!;
                                },
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontWeight: FontWeight.w600),
                                decoration: InputDecoration(
                                  hintStyle: const TextStyle(
                                      fontSize: 12, color: Color(0XFFBCBCBC)),
                                  hintText: AppLocalizations.of(context)!
                                      .nameoftheclosedhours,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: SizedBox(
                            height: sizeHeight * .15,
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!.since,
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color(0XFFBCBCBC)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: sizeWidth * .35,
                                        height: sizeHeight * .04,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFBCBCBC)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeWidth * .01),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final selectDate =
                                                  await slecteDtateTime(
                                                      context);
                                              if (selectDate != null) {
                                                setState(() {
                                                  bookingDateStart = selectDate;
                                                  startDateApi = formatter
                                                      .format(selectDate)
                                                      .toString();
                                                });
                                              }
                                              print(selectDate);
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                flaxibleGap(1),
                                                Image.asset(
                                                  'images/calendarLock.png',
                                                  fit: BoxFit.cover,
                                                  height: 26,
                                                ),
                                                flaxibleGap(1),
                                                Text(
                                                  DateFormat.yMd('en_US').format(bookingDateStart ?? DateTime.now()),
                                                  style: const TextStyle(
                                                      color: Color(0XFFBCBCBC),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: Container(
                                        width: sizeWidth * .35,
                                        height: sizeHeight * .04,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFBCBCBC)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeWidth * .01),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final selectTime =
                                                  await slecteTime(context);
                                              if (selectTime != null) {
                                                setState(() {
                                                  bookingTimeStart = selectTime
                                                      .format(context);
                                                  startHourApi = selectTime.hour
                                                      .toString();
                                                  startMinuteApi = selectTime
                                                      .minute
                                                      .toString();
                                                });
                                              }
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                flaxibleGap(1),
                                                Image.asset(
                                                  'images/time.png',
                                                  fit: BoxFit.cover,
                                                  height: 15,
                                                ),
                                                flaxibleGap(1),
                                                bookingTimeStart == null
                                                    ? Text(
                                                        DateFormat.Hm('en_US').format(DateTime.now()),
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFBCBCBC),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    : Text(
                                                        "$bookingTimeStart",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFBCBCBC),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                flaxibleGap(2),
                                                Image.asset(
                                                  'images/arrow.png',
                                                  fit: BoxFit.cover,
                                                  height: 15,
                                                ),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                flaxibleGap(1),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        AppLocalizations.of(context)!.until,
                                        style: const TextStyle(
                                            fontFamily: "Poppins",
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                            color: Color(0XFFBCBCBC)),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: sizeWidth * .35,
                                        height: sizeHeight * .04,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFBCBCBC)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeWidth * .01),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final selectDate =
                                                  await slecteDtateTime(
                                                      context);
                                              if (selectDate != null) {
                                                setState(() {
                                                  bookingDateEnd = selectDate;
                                                  endDateApi = formatter
                                                      .format((selectDate))
                                                      .toString();
                                                });
                                              }
                                              print(selectDate);
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                flaxibleGap(1),
                                                Image.asset(
                                                  'images/calendarLock.png',
                                                  fit: BoxFit.cover,
                                                  height: 26,
                                                ),
                                                flaxibleGap(1),
                                                Text(
                                                  DateFormat.yMd('en_US').format(bookingDateEnd ?? DateTime.now()),
                                                  style: const TextStyle(
                                                      color: Color(0XFFBCBCBC),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Container(
                                        width: sizeWidth * .35,
                                        height: sizeHeight * .04,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFFBCBCBC)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeWidth * .01),
                                          child: GestureDetector(
                                            onTap: () async {
                                              final selectTime =
                                                  await slecteTime(context);
                                              if (selectTime != null) {
                                                setState(() {
                                                  bookingTimeEnd = selectTime
                                                      .format(context);
                                                  endHourApi = selectTime.hour
                                                      .toString();
                                                  endMinuteApi = selectTime
                                                      .minute
                                                      .toString();
                                                });
                                              }
                                            },
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                flaxibleGap(1),
                                                Image.asset(
                                                  'images/time.png',
                                                  fit: BoxFit.cover,
                                                  height: 15,
                                                ),
                                                flaxibleGap(1),
                                                bookingTimeEnd == null
                                                    ? Text(
                                                        DateFormat.Hm('en_US').format(DateTime.now()),
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFBCBCBC),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      )
                                                    : Text(
                                                        "$bookingTimeEnd",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFBCBCBC),
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                flaxibleGap(1),
                                                Image.asset(
                                                  'images/arrow.png',
                                                  fit: BoxFit.cover,
                                                  height: 15,
                                                ),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        slotData != null
                            ? Padding(
                                padding: EdgeInsets.only(top: sizeHeight * .05),
                                child: Container(
                                  height: sizeHeight * .5,
                                  color: const Color(0XFFF1F1F1).withOpacity(.2),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeWidth * .05,
                                        vertical: sizeHeight * .02),
                                    child: ListView.builder(
                                      itemCount: slotData.length,
                                      itemBuilder: (BuildContext, index) {
                                        return SizedBox(
                                          height: sizeHeight * .2,
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .02),
                                                    child: Image.asset(
                                                      'images/calendarLock.png',
                                                      fit: BoxFit.cover,
                                                      height: 26,
                                                      color: const Color(0XFF25A163),
                                                    ),
                                                  ),
                                                  Text(
                                                      slotData[index]
                                                          ["comment"],
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF646464),
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  flaxibleGap(1),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _isLoading = true;
                                                        Map urlDetail = {
                                                          "pitchtype_id":
                                                              widget.detail[
                                                                  "pitchId"],
                                                          "id": widget
                                                              .detail["id"],
                                                          "status": "available"
                                                        };
                                                        Map detail = {
                                                          "comment":
                                                              "available",
                                                          "startDate":
                                                              slotData[index]
                                                                  ["startDate"],
                                                          "endDate":
                                                              slotData[index]
                                                                  ["endDate"],
                                                          "startTime":
                                                              slotData[index]
                                                                  ["startTime"],
                                                          "endTime":
                                                              slotData[index]
                                                                  ["endTime"],
                                                        };
                                                        _networkCalls
                                                            .closingHourSend(
                                                          urlDate: urlDetail,
                                                          bodyDate: detail,
                                                          onSuccess: (msg) {
                                                            setState(() {
                                                              _isLoading =
                                                                  false;
                                                              slotData = msg;
                                                            });
                                                          },
                                                          onFailure: (msg) {
                                                            showMessage(msg);
                                                            setState(() {
                                                              _isLoading =
                                                                  false;
                                                            });
                                                          },
                                                          tokenExpire: () {
                                                            if (mounted) {
                                                              on401(context);
                                                            }
                                                          },
                                                        );
                                                      });
                                                    },
                                                    child: Image.asset(
                                                      'images/delete.png',
                                                      fit: BoxFit.cover,
                                                      height: 15,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: sizeHeight * .15,
                                                child: Row(
                                                  children: <Widget>[
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .since,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0XFFBCBCBC)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          child: Container(
                                                            width:
                                                                sizeWidth * .35,
                                                            height: sizeHeight *
                                                                .04,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFFBCBCBC)),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sizeWidth *
                                                                          .01),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  flaxibleGap(
                                                                      1),
                                                                  Image.asset(
                                                                    'images/calendarLock.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                  Text(
                                                                    DateFormat.yMd('en_US').format(DateTime.parse(slotData[index]["startDate"])),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0XFFBCBCBC),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                            top: 10,
                                                          ),
                                                          child: Container(
                                                            width:
                                                                sizeWidth * .35,
                                                            height: sizeHeight *
                                                                .04,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFFBCBCBC)),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sizeWidth *
                                                                          .01),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  flaxibleGap(
                                                                      1),
                                                                  Image.asset(
                                                                    'images/time.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                  Text(
                                                                    timing(x: int.parse(slotData[index]["startTime"].substring(0, 2))),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0XFFBCBCBC),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  flaxibleGap(
                                                                      2),
                                                                  Image.asset(
                                                                    'images/arrow.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    flaxibleGap(1),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .until,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    "Poppins",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0XFFBCBCBC)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          child: Container(
                                                            width:
                                                                sizeWidth * .35,
                                                            height: sizeHeight *
                                                                .04,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFFBCBCBC)),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sizeWidth *
                                                                          .01),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  flaxibleGap(
                                                                      1),
                                                                  Image.asset(
                                                                    'images/calendarLock.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                  Text(
                                                                    DateFormat.yMd('en_US').format(DateTime.parse(slotData[index]["endDate"])),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0XFFBCBCBC),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                  top: 10),
                                                          child: Container(
                                                            width:
                                                                sizeWidth * .35,
                                                            height: sizeHeight *
                                                                .04,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFFBCBCBC)),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsets.all(
                                                                      sizeWidth *
                                                                          .01),
                                                              child: Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <
                                                                    Widget>[
                                                                  flaxibleGap(
                                                                      1),
                                                                  Image.asset(
                                                                    'images/time.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                  Text(
                                                                    timing(x: int.parse(slotData[index]["endTime"].substring(0, 2))),
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0XFFBCBCBC),
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w700),
                                                                  ),
                                                                  Flexible(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(),
                                                                  ),
                                                                  Image.asset(
                                                                    'images/arrow.png',
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    height: 15,
                                                                  ),
                                                                  flaxibleGap(
                                                                      1),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ));
  }

  String timing({required int x}) {
    String day;
    switch (x) {
      case 0:
        day = "00:00";
        break;
      case 1:
        day = "01:00";
        break;
      case 2:
        day = "02:00";
        break;
      case 3:
        day = "03:00";
        break;
      case 4:
        day = "04:00";
        break;
      case 5:
        day = "05:00";
        break;
      case 6:
        day = "06:00";
        break;
      case 7:
        day = "07:00";
        break;
      case 8:
        day = "08:00";
        break;
      case 9:
        day = "09:00";
        break;
      case 10:
        day = "10:00";
        break;
      case 11:
        day = "11:00";
        break;
      case 12:
        day = "12:00";
        break;
      case 13:
        day = "13:00";
        break;
      case 14:
        day = "14:00";
        break;
      case 15:
        day = "15:00";
        break;
      case 16:
        day = "16:00";
        break;
      case 17:
        day = "17:00";
        break;
      case 18:
        day = "18:00";
        break;
      case 19:
        day = "19:00";
        break;
      case 20:
        day = "20:00";
        break;
      case 21:
        day = "21:00";
        break;
      case 22:
        day = "22:00";
        break;
      default:
        day = "23:00";
        break;
    }
    return day;
  }
}
