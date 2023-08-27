import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';
import '../../../drop_down_file.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/specific_pitch_model_class.dart';
import '../../../network/network_calls.dart';

class EditSession extends StatefulWidget {
  Map pitchData;
  EditSession({Key? key, required this.pitchData}) : super(key: key);

  @override
  _EditSessionState createState() => _EditSessionState();
}

class _EditSessionState extends State<EditSession> {
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
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
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
  late SpecificModelClass specificPitchScreen;
  late String venueType;
  loadSpecific() async {
    await _networkCalls.specificVenue(
      id: widget.pitchData["id"],
      subPitch: "&subpitch_id=${widget.pitchData["subPitchId"]}",
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            specificPitchScreen = event;
            if (specificPitchScreen.isDeclined!) {
              venueType = "declined";
            } else if (specificPitchScreen.isVerified!) {
              venueType = "verified";
            } else {
              venueType = "inreview";
            }
            _isLoading = false;
          });
        }
        if (specificPitchScreen.sessions.isNotEmpty) {
          specificPitchScreen.sessions.forEach((element) {
            List<SessionDetail> sessionList = [];
            element["sessions_data"].forEach((value) {
              sessionList.add(SessionDetail(
                  sessionName: value["session_name"],
                  sessionNameAr: value["session_arabic_name"],
                  slotDuration: value["session_slot_time"],
                  graceTime: value["grace_time"],
                  startTime: DateFormat("yyyy-MM-dd hh:mm:ss")
                      .parse("2022-10-32 ${value["startTime"]}"),
                  endTime: DateFormat("yyyy-MM-dd hh:mm:ss")
                      .parse("2022-10-32 ${value["endTime"]}")));
            });
            _sessionMap[element["day"]] = sessionList;
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
    loadSpecific();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(
          title: "Create Session",
          language: AppLocalizations.of(context)!.locale,
          onTap: () {
            Navigator.of(context).pop();
          }),
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
                  // if(_sessionMap.length<7){
                  //   showMessage("Please create session for ${(7-_sessionMap.length).toString()} more days", scaffoldKey);
                  // }else{
                  setState(() {
                    _isSession = true;
                  });
                  String id = widget.pitchData["id"].toString();
                  List<Map<dynamic, dynamic>> sessionsPayload = [];

                  _sessionMap.forEach((k, v) {
                    List<Map<dynamic, dynamic>> sessionsData = [];
                    if (!v[0].isHoliday!) {
                      v.forEach((element) {
                        Map detail = {
                          "session_name": element.sessionName,
                          "session_name_arabic": element.sessionNameAr,
                          "start_time":
                              DateFormat.Hms().format(element.startTime!),
                          "end_time": DateFormat.Hms().format(element.endTime!),
                          "slot_time": element.slotDuration,
                          "grace_peroid": element.graceTime,
                          "slot_price": 0
                        };
                        sessionsData.add(detail);
                      });
                      Map<dynamic, dynamic> detail = {
                        "weekday": k,
                        "sessions_data": sessionsData
                      };
                      sessionsPayload.add(detail);
                    }
                  });

                  Map detail = {
                    "pitchtype_id": int.parse(widget.pitchData["subPitchId"]),
                    "sessions_payload": sessionsPayload
                  };
                  _networkCalls.editSession(
                      onSuccess: (onSuccess) {
                        _isSession = false;
                        if (mounted) {
                          Map detail = {
                            "id": widget.pitchData["id"],
                            "name": AppLocalizations.of(context)!.locale == "en"
                                ? specificPitchScreen.venueDetails!.name
                                : specificPitchScreen.venueDetails!.nameArabic
                          };
                          navigateToEditVenues(detail);
                        }
                      },
                      venueDetail: detail,
                      id: id,
                      venueType: venueType,
                      onFailure: (onFailure) {
                        showMessage("Please create session properly ");
                        setState(() {
                          _isSession = false;
                        });
                      },
                      tokenExpire: () {});

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
                                      mainAxisAlignment: MainAxisAlignment.end,
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
                                                image: _sessionMap.containsKey(
                                                        _weakList[index].slug)
                                                    ? _sessionMap[
                                                                _weakList[index]
                                                                    .slug]![0]
                                                            .isHoliday!
                                                        ? const AssetImage(
                                                            "images/holiday.png")
                                                        : const AssetImage(
                                                            "images/book.png")
                                                    : const AssetImage(
                                                        "images/holiday.png"),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                            child: Text(
                                              _weakList[index]
                                                  .name!
                                                  .substring(0, 3),
                                              style: const TextStyle(
                                                  color: Color(0XFFA3A3A3),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                        Image.asset(
                                          "images/bar_icon.png",
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
                                      padding: const EdgeInsets.only(right: 10),
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
                                                        "images/holiday.png")
                                                    : const AssetImage(
                                                        "images/book.png")
                                                : const AssetImage(
                                                    "images/holiday.png"),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        child: Text(
                                          _weakList[index]
                                              .name!
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
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    "Add Session",
                                    style: TextStyle(
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
                                    child: Image.asset("images/add_venue.png")),
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
                                  const Text(
                                    "Add Session",
                                    style: TextStyle(
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
                                      child:
                                          Image.asset("images/add_venue.png")),
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
                                              if (_sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .length ==
                                                  1) {
                                                _sessionMap.removeWhere((key,
                                                        value) =>
                                                    key ==
                                                    _weakList[_weakIndex].slug);
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
                                                  "images/delete_icon.png",
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
                                                          color:
                                                              Color(0XFFA3A3A3),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily:
                                                              "Poppins"),
                                                    ),
                                                    Text(
                                                      "( ${_sessionMap[_weakList[_weakIndex].slug]![index].slotDuration.toString()} min slot )",
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFFA3A3A3),
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
                                                      CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                        DateFormat.Hm('en_US').format(
                                                            _sessionMap[_weakList[
                                                                            _weakIndex]
                                                                        .slug]![
                                                                    index]
                                                                .startTime!),
                                                        style: const TextStyle(
                                                            color:
                                                                appThemeColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins")),
                                                    const Text(" - ",
                                                        style: TextStyle(
                                                            color:
                                                                appThemeColor,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontFamily:
                                                                "Poppins")),
                                                    Text(
                                                      DateFormat.Hm('en_US').format(
                                                          _sessionMap[_weakList[
                                                                      _weakIndex]
                                                                  .slug]![index]
                                                              .endTime!),
                                                      style: const TextStyle(
                                                          color: appThemeColor,
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
    );
  }

  void navigateToEditVenues(Map detail) {
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, RouteNames.editVenues,
        arguments: detail);
  }

  bottomSheet({required Function onTap}) {
    var size = MediaQuery.of(context).size;
    _copyDays = _sessionMap.keys.toList();
    SessionDetail _sessionDetail = SessionDetail();
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
                            title: "Create session",
                            language: AppLocalizations.of(context)!.locale,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                        bottomNavigationBar: Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              List<SessionDetail> _sessionList = [];
                              _sessionList.add(_sessionDetail);
                              _sessionMap[_weakList[_weakIndex].slug!] =
                                  _sessionList;
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
                              key: _formKey,
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
                                          const Text(
                                            "Mark as Holiday",
                                            style: TextStyle(
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
                                                      "images/Rectangle.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  )
                                                : SizedBox(
                                                    height: size.height * .03,
                                                    width: size.width * .055,
                                                    child: Image.asset(
                                                      "images/uncheck.png",
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                            onTap: () {
                                              setState(() {
                                                _holiday = !_holiday;
                                                _sessionDetail.isHoliday =
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
                                          "Mark as holiday for ${_weakList[_weakIndex].name} "),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Scaffold(
                        appBar: appBar(
                            title: "Create session",
                            language: AppLocalizations.of(context)!.locale,
                            onTap: () {
                              Navigator.of(context).pop();
                            }),
                        bottomNavigationBar: Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                if (_sessionMap.containsKey(
                                        _weakList[_weakIndex].slug) &&
                                    !_sessionMap[_weakList[_weakIndex].slug]![0]
                                        .isHoliday!) {
                                  if (!_sessionDetail.isHoliday!) {
                                    _sessionDetail.isHoliday = false;
                                    _sessionDetail.graceTime ??= 0;
                                    _sessionDetail.slotDuration ??= 20;
                                    _sessionDetail.startTime ??= DateTime.now();
                                    _sessionDetail.endTime ??= DateTime.now();
                                    if (_sessionMap.containsKey(
                                        _weakList[_weakIndex].slug)) {
                                      _sessionMap[_weakList[_weakIndex].slug]!
                                          .add(_sessionDetail);
                                    } else {
                                      List<SessionDetail> _sessionList = [];
                                      _sessionList.add(_sessionDetail);
                                      _sessionMap[_weakList[_weakIndex].slug!] =
                                          _sessionList;
                                    }
                                  } else {
                                    List<SessionDetail> _sessionList = [];
                                    _sessionList.add(_sessionDetail);
                                    _sessionMap[_weakList[_weakIndex].slug!] =
                                        _sessionList;
                                  }
                                } else {
                                  _sessionDetail.graceTime ??= 20;
                                  _sessionDetail.slotDuration ??= 20;
                                  _sessionDetail.startTime ??= DateTime.now();
                                  _sessionDetail.endTime ??= DateTime.now();
                                  List<SessionDetail> _sessionList = [];
                                  _sessionList.add(_sessionDetail);
                                  _sessionMap[_weakList[_weakIndex].slug!] =
                                      _sessionList;
                                }

                                Navigator.of(context).pop();
                                onTap();
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
                        body: SingleChildScrollView(
                          child: Container(
                            color: const Color(0XFFE5E5E5),
                            height: size.height * .8,
                            child: Form(
                              key: _formKey,
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
                                                    "images/Rectangle.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: size.height * .03,
                                                  width: size.width * .055,
                                                  child: Image.asset(
                                                    "images/uncheck.png",
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                          onTap: () {
                                            setState(() {
                                              _holiday = !_holiday;
                                              _sessionDetail.isHoliday =
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
                                            key: scaffoldKey,
                                            leadingIcon: false,
                                            child: Text(
                                              "Copy from ${_copyDays[copyDaysIndex]}",
                                            ),
                                            icon: Image.asset(
                                              "images/drop_down.png",
                                              height: 8,
                                            ),
                                            onChange: (int value, int index) =>
                                                setState(() {
                                              copyDaysIndex = index;
                                              _sessionMap[
                                                  _weakList[_weakIndex]
                                                      .slug!] = List.generate(
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
                                                    key: scaffoldKey,
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
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  "Copy from ${item.value}"),
                                                            ],
                                                          ),
                                                          const Divider()
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                                .toList(),
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
                                            onSaved: (value) => _sessionDetail
                                                .sessionName = value!),
                                        textField(
                                            name: AppLocalizations.of(context)!
                                                .nameA,
                                            controller: _nameControllerArabic,
                                            text: false,
                                            text1: false,
                                            node: focusName,
                                            onSaved: (value) => _sessionDetail
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
                                              _sessionDetail.slotDuration =
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
                                                  _sessionDetail.graceTime =
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
                                                  _sessionDetail.startTime =
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
                                                  _sessionDetail.endTime =
                                                      value;
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
  String? name;
  String? slug;
  WeekDays({this.name, this.slug});
}
