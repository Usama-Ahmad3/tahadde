import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class CreateSession extends StatefulWidget {
  Map pitchData;
  CreateSession({Key? key, required this.pitchData}) : super(key: key);

  @override
  _CreateSessionState createState() => _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {
  final _nameController = TextEditingController(text: '');
  final _nameControllerArabic = TextEditingController(text: '');
  final focusName = FocusNode();
  bool _holiday = false;
  late int indexItem;
  int _weakIndex = 0;
  int pitchTypeIndex = 1;
  int copyDaysIndex = 0;
  bool _isLoading = true;
  bool _isSession = false;
  var focusNode = FocusNode();
  List<String> _copyDays = [];
  // final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKeyBottomShit = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final List<WeekDays> _weakList = [];
  final Map<String, List<SessionDetail>> _sessionMap =
      <String, List<SessionDetail>>{};
  List<String> currenciesList = [
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100',
    '120',
    '140',
    '160',
  ];
  List<String> graceTimeList = [
    "0",
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
    '70',
    '80',
    '90',
    '100',
    '120',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.weekList(
        onSuccess: (detail) {
          detail.forEach((element) {
            setState(() {
              _weakList
                  .add(WeekDays(name: element["name"], slug: element["slug"]));
              _isLoading = false;
            });
          });
        },
        onFailure: (onFailure) {},
        tokenExpire: () {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(
            title: "Create Session",
            language: AppLocalizations.of(context)!.locale,
            isBack: false),
        bottomNavigationBar: _isSession
            ? Container(
                height: size.height * .104,
                alignment: Alignment.center,
                color: const Color(0XFF25A163),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ))
            : Material(
                color: const Color(0XFF25A163),
                child: InkWell(
                  onTap: () {
                    if (_sessionMap.length < 7) {
                      showMessage(
                          "Please create session for ${(7 - _sessionMap.length).toString()} more days");
                    } else {
                      setState(() {
                        _isSession = true;
                      });
                      String id = widget.pitchData["book_pitch_id"].toString();
                      List<Map<dynamic, dynamic>> sessionsPayload = [];

                      _sessionMap.forEach((k, v) {
                        List<Map<dynamic, dynamic>> sessionsData = [];
                        if (!v[0].isHoliday!) {
                          for (var element in v) {
                            Map detail = {
                              "session_name": element.sessionName,
                              "session_name_arabic": element.sessionNameAr,
                              "start_time":
                                  DateFormat.Hms().format(element.startTime!),
                              "end_time":
                                  DateFormat.Hms().format(element.endTime!),
                              "slot_time": element.slotDuration,
                              "grace_peroid": element.graceTime,
                              "slot_price": 0
                            };
                            sessionsData.add(detail);
                          }
                          Map<dynamic, dynamic> detail = {
                            "weekday": k,
                            "sessions_data": sessionsData
                          };
                          sessionsPayload.add(detail);
                        }
                      });

                      Map detail = {
                        "pitchtype_id": widget.pitchData["pitch_type_id"],
                        "sessions_payload": sessionsPayload
                      };
                      _networkCalls.createSession(
                          onSuccess: (onSuccess) {
                            Map detail = {
                              "id":
                                  widget.pitchData["book_pitch_id"].toString(),
                              "subPitchId":
                                  widget.pitchData["pitch_type_id"].toString()
                            };
                            _isSession = false;

                            navigateToSlotScreen(detail);
                          },
                          detail: detail,
                          id: id,
                          onFailure: (onFailure) {
                            showMessage("Please create session properly ");
                            setState(() {
                              _isSession = false;
                            });
                          },
                          tokenExpire: () {});
                    }
                  },
                  splashColor: Colors.black,
                  child: Container(
                      height: size.height * .104,
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
              ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                height: size.height,
                width: size.width,
                color: const Color(0XFFE5E5E5),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          height: size.height * .005,
                          width: size.width * .19,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Container(
                          height: size.height * .005,
                          width: size.width * .19,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Container(
                          height: size.height * .005,
                          width: size.width * .19,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Container(
                          height: size.height * .005,
                          width: size.width * .19,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Container(
                          height: size.height * .005,
                          width: size.width * .19,
                          color: const Color(0XFFCBCBCB),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Container(
                        color: Colors.white,
                        height: 60,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _weakList.length,
                            itemBuilder: (context, index) {
                              return _weakIndex == index
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _weakIndex = index;
                                              });
                                            },
                                            child: Container(
                                              width: 43,
                                              height: 43,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: _sessionMap
                                                          .containsKey(
                                                              _weakList[index]
                                                                  .slug)
                                                      ? _sessionMap[_weakList[
                                                                      index]
                                                                  .slug]![0]
                                                              .isHoliday!
                                                          ? const AssetImage(
                                                              "assets/images/holiday.png")
                                                          : const AssetImage(
                                                              "assets/images/book.png")
                                                      : const AssetImage(
                                                          "assets/images/un_book.png"),
                                                  fit: BoxFit.fitWidth,
                                                ),
                                              ),
                                              child: Text(
                                                _weakList[index]
                                                    .name
                                                    .substring(0, 3),
                                                style: const TextStyle(
                                                    color: Color(0XFFA3A3A3),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                          ),
                                          Image.asset(
                                            "assets/images/bar_icon.png",
                                            width: 43,
                                          )
                                        ],
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _weakIndex = index;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Container(
                                          width: 43,
                                          height: 43,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: _sessionMap.containsKey(
                                                      _weakList[index].slug)
                                                  ? _sessionMap[_weakList[index]
                                                              .slug]![0]
                                                          .isHoliday!
                                                      ? const AssetImage(
                                                          "assets/images/holiday.png")
                                                      : const AssetImage(
                                                          "assets/images/book.png")
                                                  : const AssetImage(
                                                      "assets/images/un_book.png"),
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          child: Text(
                                            _weakList[index]
                                                .name
                                                .substring(0, 3),
                                            style: const TextStyle(
                                                color: Color(0XFFA3A3A3),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                    );
                            }),
                      ),
                    ),
                    _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                            !_sessionMap[_weakList[_weakIndex].slug]![0]
                                .isHoliday! &&
                            _sessionMap[_weakList[_weakIndex].slug]!.isNotEmpty
                        ? const SizedBox.shrink()
                        : Expanded(
                            child: Container(
                              color: Colors.white,
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.addSession,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffA3A3A3)),
                                    ),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        _holiday = false;
                                        bottomSheet(onTap: () {
                                          setState(() {});
                                        });
                                      },
                                      child: Image.asset(
                                          "assets/images/add_venue.png")),
                                ],
                              ),
                            ),
                          ),
                    _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                            !_sessionMap[_weakList[_weakIndex].slug]![0]
                                .isHoliday! &&
                            _sessionMap[_weakList[_weakIndex].slug]!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            child: Container(
                              height: size.height * .1,
                              width: size.width,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.addSession,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xffA3A3A3)),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          _holiday = false;
                                          bottomSheet(onTap: () {
                                            setState(() {});
                                          });
                                        },
                                        child: Image.asset(
                                            "assets/images/add_venue.png")),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                    _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                            !_sessionMap[_weakList[_weakIndex].slug]![0]
                                .isHoliday! &&
                            _sessionMap[_weakList[_weakIndex].slug]!.isNotEmpty
                        ? Expanded(
                            child: SizedBox(
                                height: size.height * .4,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount:
                                        _sessionMap[_weakList[_weakIndex].slug]!
                                            .length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height * .01),
                                        child: Container(
                                          color: Colors.white,
                                          child: Dismissible(
                                            key: UniqueKey(),
                                            direction:
                                                DismissDirection.endToStart,
                                            onDismissed: (direction) {
                                              setState(() {
                                                if (_sessionMap[_weakList[
                                                                _weakIndex]
                                                            .slug]!
                                                        .length ==
                                                    1) {
                                                  _sessionMap.removeWhere(
                                                      (key, value) =>
                                                          key ==
                                                          _weakList[_weakIndex]
                                                              .slug);
                                                } else {
                                                  _sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .removeAt(index);
                                                }
                                              });
                                            },
                                            background: Container(
                                              color: const Color(0XFFFFE9E9),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  flaxibleGap(
                                                    10,
                                                  ),
                                                  Image.asset(
                                                    "assets/images/delete_icon.png",
                                                    color: Colors.red,
                                                    height: 20,
                                                    width: 20,
                                                  ),
                                                  flaxibleGap(
                                                    1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            child: Container(
                                              height: size.height * .1,
                                              width: size.width,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: size.width * .05),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${_sessionMap[_weakList[_weakIndex].slug]![index].sessionName} Session",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFA3A3A3),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                                      Text(
                                                        "( ${_sessionMap[_weakList[_weakIndex].slug]![index].slotDuration.toString()} min slot )",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFFA3A3A3),
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                          DateFormat.Hm('en_US')
                                                              .format(_sessionMap[
                                                                          _weakList[_weakIndex]
                                                                              .slug]![
                                                                      index]
                                                                  .startTime!),
                                                          style: const TextStyle(
                                                              color:
                                                                  appThemeColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins")),
                                                      const Text(" - ",
                                                          style: TextStyle(
                                                              color:
                                                                  appThemeColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontFamily:
                                                                  "Poppins")),
                                                      Text(
                                                        DateFormat.Hm('en_US').format(
                                                            _sessionMap[_weakList[
                                                                        _weakIndex]
                                                                    .slug]![index]
                                                                .endTime!),
                                                        style: const TextStyle(
                                                            color:
                                                                appThemeColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins"),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    })),
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
      ),
    );
  }

  void navigateToSlotScreen(Map detail) {
    Navigator.pushNamed(context, RouteNames.slotChart, arguments: detail);
  }

  bottomSheet({required Function onTap}) {
    var size = MediaQuery.of(context).size;
    _copyDays = _sessionMap.keys.toList();
    SessionDetail sessionDetail = SessionDetail();
    copyDaysIndex = 0;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
                heightFactor: .98,
                child: _holiday
                    ? Scaffold(
                        appBar: appBar(
                            title: AppLocalizations.of(context)!.createSession,
                            language: AppLocalizations.of(context)!.locale,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                        bottomNavigationBar: Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              List<SessionDetail> sessionList = [];
                              sessionList.add(sessionDetail);
                              _sessionMap[_weakList[_weakIndex].slug] =
                                  sessionList;
                              Navigator.of(context).pop();
                              onTap();
                            },
                            splashColor: Colors.black,
                            child: Container(
                                height: size.height * .104,
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
                        ),
                        body: SingleChildScrollView(
                          child: Container(
                            color: const Color(0XFFE5E5E5),
                            height: size.height * .8,
                            child: Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFFCBCBCB),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFFCBCBCB),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 17.0),
                                    child: Container(
                                      height: size.height * .05,
                                      width: size.height,
                                      color: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .markAsHoliday,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: appThemeColor),
                                          ),
                                          GestureDetector(
                                            child: _holiday
                                                ? SizedBox(
                                                    height: size.height * .03,
                                                    width: size.width * .055,
                                                    child: Image.asset(
                                                      "assets/images/Rectangle.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: size.height * .03,
                                                    width: size.width * .055,
                                                    child: Image.asset(
                                                      "assets/images/uncheck.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                            onTap: () {
                                              setState(() {
                                                _holiday = !_holiday;
                                                sessionDetail.isHoliday =
                                                    _holiday;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                          "${AppLocalizations.of(context)!.markAsHoliday} for ${_weakList[_weakIndex].name} "),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Scaffold(
                        key: scaffoldKeyBottomShit,
                        appBar: appBar(
                            title: AppLocalizations.of(context)!.createSession,
                            language: AppLocalizations.of(context)!.locale,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                        bottomNavigationBar: Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              // if (_formKey.currentState!.validate()) {
                              var maxEndDate;
                              var minStartDate;
                              if (_sessionMap.containsKey(
                                      _weakList[_weakIndex].slug) &&
                                  !_sessionMap[_weakList[_weakIndex].slug]![0]
                                      .isHoliday!) {
                                if (!sessionDetail.isHoliday!) {
                                  sessionDetail.isHoliday = false;
                                  sessionDetail.graceTime ??= 20;
                                  sessionDetail.slotDuration ??= 20;
                                  sessionDetail.startTime ??= DateTime.now();
                                  sessionDetail.endTime ??= DateTime.now();
                                  if (_sessionMap.containsKey(
                                      _weakList[_weakIndex].slug)) {
                                    if (_sessionMap[
                                            _weakList[_weakIndex].slug] !=
                                        null) {
                                      minStartDate = _sessionMap[
                                              _weakList[_weakIndex].slug]!
                                          .reduce((a, b) => (a.startTime)!
                                                  .isBefore(b.startTime!)
                                              ? a
                                              : b);
                                      maxEndDate = _sessionMap[
                                              _weakList[_weakIndex].slug]!
                                          .reduce((a, b) =>
                                              (a.endTime)!.isAfter(b.endTime!)
                                                  ? a
                                                  : b);
                                    }
                                    if ((sessionDetail.startTime!.isBefore(
                                                minStartDate.startTime) &&
                                            sessionDetail.endTime!.isBefore(
                                                minStartDate.startTime)) ||
                                        (sessionDetail.startTime!
                                                .isAfter(maxEndDate.endTime) &&
                                            sessionDetail.endTime!
                                                .isAfter(maxEndDate.endTime))) {
                                      _sessionMap[_weakList[_weakIndex].slug]!
                                          .add(sessionDetail);
                                    } else {
                                      showMessage(
                                          "Your time is not proper as compare to previous sessions");
                                    }
                                  } else {
                                    List<SessionDetail> sessionList = [];
                                    sessionList.add(sessionDetail);
                                    _sessionMap[_weakList[_weakIndex].slug] =
                                        sessionList;
                                  }
                                } else {
                                  List<SessionDetail> sessionList = [];
                                  sessionList.add(sessionDetail);
                                  _sessionMap[_weakList[_weakIndex].slug] =
                                      sessionList;
                                }
                              } else {
                                sessionDetail.graceTime ??= 20;
                                sessionDetail.slotDuration ??= 20;
                                sessionDetail.startTime ??= DateTime.now();
                                sessionDetail.endTime ??= DateTime.now();
                                List<SessionDetail> sessionList = [];
                                sessionList.add(sessionDetail);
                                if (_sessionMap[_weakList[_weakIndex].slug] ==
                                        null ||
                                    _sessionMap[_weakList[_weakIndex].slug]![0]
                                        .isHoliday!) {
                                  _sessionMap[_weakList[_weakIndex].slug] =
                                      sessionList;
                                } else {
                                  if (_sessionMap[_weakList[_weakIndex].slug] !=
                                      null) {
                                    minStartDate =
                                        _sessionMap[_weakList[_weakIndex].slug]!
                                            .reduce((a, b) => (a.startTime)!
                                                    .isBefore(b.startTime!)
                                                ? a
                                                : b);
                                    maxEndDate =
                                        _sessionMap[_weakList[_weakIndex].slug]!
                                            .reduce((a, b) =>
                                                (a.endTime)!.isAfter(b.endTime!)
                                                    ? a
                                                    : b);
                                  }
                                  if ((sessionDetail.startTime!.isBefore(
                                              minStartDate.startTime) &&
                                          sessionDetail.endTime!.isBefore(
                                              minStartDate.startTime)) ||
                                      (sessionDetail.startTime!
                                              .isAfter(maxEndDate.endTime) &&
                                          sessionDetail.endTime!
                                              .isAfter(maxEndDate.endTime))) {
                                    _sessionMap[_weakList[_weakIndex].slug]!
                                        .add(sessionDetail);
                                  } else {
                                    showMessage(
                                        "Your time is not proper as compare to previous sessions");
                                  }
                                }
                              }

                              Navigator.of(context).pop();
                              onTap();
                              // }
                            },
                            splashColor: Colors.black,
                            child: Container(
                                height: size.height * .104,
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
                        ),
                        body: SingleChildScrollView(
                          child: Container(
                            color: const Color(0XFFE5E5E5),
                            height: size.height * .8,
                            child: Form(
                              child: Column(
                                children: [
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .19,
                                        color: const Color(0XFFCBCBCB),
                                      ),
                                    ],
                                  ),
                                  flaxibleGap(1),
                                  Container(
                                    height: size.height * .05,
                                    width: size.height,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .markAsHoliday,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: appThemeColor),
                                        ),
                                        GestureDetector(
                                          child: _holiday
                                              ? SizedBox(
                                                  height: size.height * .03,
                                                  width: size.width * .055,
                                                  child: Image.asset(
                                                    "assets/images/Rectangle.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: size.height * .03,
                                                  width: size.width * .055,
                                                  child: Image.asset(
                                                    "assets/images/uncheck.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                          onTap: () {
                                            setState(() {
                                              _holiday = !_holiday;
                                              sessionDetail.isHoliday =
                                                  _holiday;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(2),
                                  _sessionMap.isNotEmpty &&
                                          (!_sessionMap.containsKey(
                                                  _weakList[_weakIndex].slug) ||
                                              _sessionMap[_weakList[_weakIndex]
                                                      .slug]![0]
                                                  .isHoliday!)
                                      ? SizedBox(
                                          width: size.width,
                                          height: size.height * .08,
                                          child: CustomDropdown(
                                            leadingIcon: false,
                                            icon: Image.asset(
                                              "assets/images/drop_down.png",
                                              height: 8,
                                            ),
                                            onChange: (int value, int index) =>
                                                setState(() {
                                              copyDaysIndex = index;
                                              _sessionMap[
                                                  _weakList[_weakIndex]
                                                      .slug] = List.generate(
                                                  _sessionMap[_copyDays[index]]!
                                                      .length,
                                                  (index2) => _sessionMap[
                                                          _copyDays[
                                                              index]]![index2]
                                                      .clone());
                                              Navigator.of(context).pop();
                                              onTap();
                                            }),
                                            dropdownButtonStyle:
                                                const DropdownButtonStyle(
                                              width: 170,
                                              height: 45,
                                              elevation: 1,
                                              backgroundColor: Colors.white,
                                              primaryColor: Colors.black87,
                                            ),
                                            dropdownStyle: DropdownStyle(
                                              borderRadius:
                                                  BorderRadius.circular(0),
                                              elevation: 6,
                                              padding: const EdgeInsets.all(5),
                                            ),
                                            items: _copyDays
                                                .asMap()
                                                .entries
                                                .map(
                                                  (item) => DropdownItem(
                                                    value: item.key + 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          _weakList[_weakIndex]
                                                                      .slug !=
                                                                  item.value
                                                              ? Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                        "Copy from ${item.value}"),
                                                                  ],
                                                                )
                                                              : const SizedBox
                                                                  .shrink(),
                                                          _weakList[_weakIndex]
                                                                      .slug !=
                                                                  item.value
                                                              ? const Divider()
                                                              : const SizedBox
                                                                  .shrink()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
                                            child: Text(
                                              "Copy from ${_copyDays[copyDaysIndex]}",
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                  flaxibleGap(2),
                                  Container(
                                    height: size.height * .2,
                                    width: size.height,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .CreateYourSession,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: appThemeColor,
                                              fontSize: 12),
                                        ),
                                        textField(
                                            name: AppLocalizations.of(context)!
                                                .name,
                                            controller: _nameController,
                                            // onchange: (value) {
                                            //     trans(value, "ar", _nameControllerArabic);
                                            //
                                            // },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterPitchName;
                                              }
                                              return '';
                                            },
                                            text: true,
                                            keybordType: false,
                                            submit: (value) =>
                                                FocusScope.of(context)
                                                    .requestFocus(focusName),
                                            onSaved: (value) => sessionDetail
                                                .sessionName = value!),
                                        textField(
                                            name: AppLocalizations.of(context)!
                                                .nameA,
                                            controller: _nameControllerArabic,
                                            text: false,
                                            text1: false,
                                            node: focusName,
                                            onSaved: (value) => sessionDetail
                                                .sessionNameAr = value!),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(1),
                                  Container(
                                    width: size.width,
                                    height: size.height * .08,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .createSlotDuration,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: appThemeColor),
                                        ),
                                        SizedBox(
                                          width: size.width * .3,
                                          height: size.height * .08,
                                          child: CupertinoPicker(
                                            backgroundColor: Colors.white,
                                            itemExtent: 30,
                                            scrollController:
                                                FixedExtentScrollController(
                                                    initialItem: 1),
                                            children: [
                                              for (String name
                                                  in currenciesList)
                                                Text("$name min"),
                                            ],
                                            onSelectedItemChanged: (value) {
                                              sessionDetail.slotDuration =
                                                  int.parse(
                                                      currenciesList[value]);
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(2),
                                  Container(
                                    height: size.height * .08,
                                    width: size.height,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)!.extraGraceTime}:",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: appThemeColor),
                                        ),
                                        SizedBox(
                                            width: size.width * .3,
                                            height: size.height * .08,
                                            child: SizedBox(
                                              width: size.width * .3,
                                              height: size.height * .08,
                                              child: CupertinoPicker(
                                                backgroundColor: Colors.white,
                                                itemExtent: 30,
                                                scrollController:
                                                    FixedExtentScrollController(
                                                        initialItem: 1),
                                                children: [
                                                  for (String name
                                                      in graceTimeList)
                                                    Text("$name min"),
                                                ],
                                                onSelectedItemChanged: (value) {
                                                  sessionDetail.graceTime =
                                                      value;
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(2),
                                  Container(
                                    height: size.height * .2,
                                    width: size.height,
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .startTime,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: appThemeColor),
                                            ),
                                            SizedBox(
                                              width: size.width * .3,
                                              height: size.height * .08,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                use24hFormat: true,
                                                onDateTimeChanged: (value) {
                                                  sessionDetail.startTime =
                                                      value;
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                        const Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .endTime,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: appThemeColor),
                                            ),
                                            SizedBox(
                                              width: size.width * .3,
                                              height: size.height * .08,
                                              child: CupertinoDatePicker(
                                                mode: CupertinoDatePickerMode
                                                    .time,
                                                use24hFormat: true,
                                                onDateTimeChanged: (value) {
                                                  sessionDetail.endTime = value;
                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )); //whatever you're returning, does not have to be a Container
          });
        });
  }

  // void trans(String Text, String language, TextEditingController controler) {
  //   if (Text == "") {
  //     setState(() {
  //       controler.text = "";
  //     });
  //   } else {
  //     translator.translate(Text, to: language).then((value) {
  //       setState(() {
  //         controler.text = value.toString();
  //       });
  //     });
  //   }
  // }
  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container();
        });
  }
}

class SessionDetail {
  bool? isHoliday;
  String? sessionName;
  String? sessionNameAr;
  int? slotDuration;
  int? graceTime;
  DateTime? startTime;
  DateTime? endTime;
  SessionDetail(
      {this.sessionName,
      this.sessionNameAr,
      this.slotDuration = 10,
      this.graceTime = 10,
      this.startTime,
      this.endTime,
      this.isHoliday = false});
  SessionDetail clone() {
    return SessionDetail(
      sessionNameAr: sessionNameAr,
      sessionName: sessionName,
      graceTime: graceTime,
      startTime: startTime,
      endTime: endTime,
      slotDuration: slotDuration,
      isHoliday: isHoliday,
    );
  }
}

class WeekDays {
  String name;
  String slug;
  WeekDays({required this.name, required this.slug});
}
