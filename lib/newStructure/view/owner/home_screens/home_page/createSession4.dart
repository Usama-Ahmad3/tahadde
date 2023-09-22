import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/slot_chart_screen5.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../constant.dart';
import '../../../../../drop_down_file.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../player/HomeScreen/widgets/textFormField.dart';

// ignore: must_be_immutable
class CreateSessionScreen extends StatefulWidget {
  Map pitchData;
  CreateSessionScreen({Key? key, required this.pitchData}) : super(key: key);

  @override
  State<CreateSessionScreen> createState() => _CreateSessionScreenState();
}

class _CreateSessionScreenState extends State<CreateSessionScreen> {
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
          backgroundColor: MyAppState.mode == ThemeMode.light
              ? Colors.white
              : const Color(0xff686868),
          appBar: PreferredSize(
              preferredSize: Size(size.width, size.height * 0.105),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.price,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
                leadingWidth: size.width * 0.18,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(size.height * 0.008),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            shape: BoxShape.circle),
                        child: const Center(
                          child: FaIcon(
                            FontAwesomeIcons.close,
                            color: Colors.white,
                          ),
                        )),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size(size.width, 10),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.035),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * .005,
                          width: size.width * .17,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(1),
                        Container(
                          height: size.height * .005,
                          width: size.width * .17,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(1),
                        Container(
                          height: size.height * .005,
                          width: size.width * .17,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(1),
                        Container(
                          height: size.height * .005,
                          width: size.width * .17,
                          color: const Color(0XFF25A163),
                        ),
                        flaxibleGap(1),
                        Container(
                          height: size.height * .005,
                          width: size.width * .17,
                          color: const Color(0XFFCBCBCB),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: Align(
            alignment: const Alignment(1.1, 0.9),
            child: SpeedDial(
              elevation: 3,
              label: Text(
                AppLocalizations.of(context)!.addSession,
                style: TextStyle(
                    color: MyAppState.mode == ThemeMode.light
                        ? Colors.white
                        : Colors.black,
                    fontSize: 11),
              ),
              animationCurve: Curves.easeInOutCirc,
              backgroundColor: MyAppState.mode == ThemeMode.light
                  ? const Color(0xff686868)
                  : Colors.tealAccent.shade100,
              onPress: () {
                _holiday = false;
                _nameController.clear();
                _nameControllerArabic.clear();
                bottomSheet(onTap: () {
                  setState(() {});
                });
              },
              child: Icon(
                Icons.add,
                color: MyAppState.mode == ThemeMode.light
                    ? Colors.white
                    : Colors.black,
                size: size.height * 0.03,
              ),
            ),
          ),
          body: _isLoading
              ? Container(
                  color: Colors.black,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.033),
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
              : Container(
                  color: Colors.black,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.033),
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        ///Top WeakList
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              ...List.generate(_weakList.length, (index) {
                                return _weakIndex == index
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
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
                                                width: size.width * 0.2,
                                                height: size.height * 0.05,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  color: _sessionMap
                                                          .containsKey(
                                                              _weakList[index]
                                                                  .slug)
                                                      ? _sessionMap[_weakList[
                                                                      index]
                                                                  .slug]![0]
                                                              .isHoliday!
                                                          ? Colors.redAccent
                                                              .shade200
                                                          : const Color(
                                                              0xffffc300)
                                                      : Colors.grey.shade200,
                                                ),
                                                child: Text(
                                                  _weakList[index]
                                                      .name
                                                      .substring(0, 3),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ),
                                            Image.asset(
                                              "assets/images/bar_icon.png",
                                              width: size.width * 0.22,
                                              height: size.height * 0.018,
                                              color: Colors.grey,
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
                                            width: size.width * 0.2,
                                            height: size.height * 0.05,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: _sessionMap.containsKey(
                                                      _weakList[index].slug)
                                                  ? _sessionMap[_weakList[index]
                                                              .slug]![0]
                                                          .isHoliday!
                                                      ? Colors
                                                          .redAccent.shade200
                                                      : const Color(0xffffc300)
                                                  : Colors.grey.shade200,
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
                              })
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        ///Center Add Session Button
                        // _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                        //         !_sessionMap[_weakList[_weakIndex].slug]![0]
                        //             .isHoliday! &&
                        //         _sessionMap[_weakList[_weakIndex].slug]!
                        //             .isNotEmpty
                        //     ? const SizedBox.shrink()
                        //     : Expanded(
                        //         child: Container(
                        //           color: Colors.white,
                        //           width: size.width,
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               Padding(
                        //                 padding:
                        //                     const EdgeInsets.only(bottom: 20.0),
                        //                 child: Text(
                        //                   AppLocalizations.of(context)!
                        //                       .addSession,
                        //                   style: const TextStyle(
                        //                       fontSize: 18,
                        //                       fontWeight: FontWeight.w500,
                        //                       color: Color(0xffA3A3A3)),
                        //                 ),
                        //               ),
                        //               GestureDetector(
                        //                   onTap: () {
                        //                     _holiday = false;
                        //                     bottomSheet(onTap: () {
                        //                       setState(() {});
                        //                     });
                        //                   },
                        //                   child: Image.asset(
                        //                       "assets/images/add_venue.png")),
                        //             ],
                        //           ),
                        //         ),
                        //       ),

                        ///Line Add Session
                        //     _sessionMap
                        //         .containsKey(_weakList[_weakIndex].slug) &&
                        //     !_sessionMap[_weakList[_weakIndex].slug]![0]
                        //         .isHoliday! &&
                        //     _sessionMap[_weakList[_weakIndex].slug]!
                        //         .isNotEmpty
                        // ? Padding(
                        //     padding:
                        //         const EdgeInsets.symmetric(vertical: 20.0),
                        //     child: Container(
                        //       height: size.height * .1,
                        //       width: size.width,
                        //       color: Colors.white,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(15.0),
                        //         child: Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //               AppLocalizations.of(context)!
                        //                   .addSession,
                        //               style: const TextStyle(
                        //                   fontSize: 14,
                        //                   fontWeight: FontWeight.w500,
                        //                   color: Color(0xffA3A3A3)),
                        //             ),
                        //             GestureDetector(
                        //                 onTap: () {
                        //                   _holiday = false;
                        //                   bottomSheet(onTap: () {
                        //                     setState(() {});
                        //                   });
                        //                 },
                        //                 child: Image.asset(
                        //                     "assets/images/add_venue.png")),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //   )
                        // : const SizedBox.shrink(),
                        _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                                !_sessionMap[_weakList[_weakIndex].slug]![0]
                                    .isHoliday! &&
                                _sessionMap[_weakList[_weakIndex].slug]!
                                    .isNotEmpty
                            ? Expanded(
                                child: SizedBox(
                                    height: size.height * .4,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: _sessionMap[
                                                _weakList[_weakIndex].slug]!
                                            .length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: size.height * .01),
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
                                                            _weakList[
                                                                    _weakIndex]
                                                                .slug);
                                                  } else {
                                                    _sessionMap[_weakList[
                                                                _weakIndex]
                                                            .slug]!
                                                        .removeAt(index);
                                                  }
                                                });
                                              },
                                              background: Container(
                                                height: size.height * 0.09,
                                                decoration: BoxDecoration(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.grey.shade200
                                                        : Colors.black12,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            13)),
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
                                              child: InkWell(
                                                onTap: () {
                                                  showMessage(
                                                      'Swipe to delete');
                                                },
                                                child: Container(
                                                  height: size.height * 0.09,
                                                  decoration: BoxDecoration(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.grey.shade200
                                                          : Colors.black12,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              13)),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              "${_sessionMap[_weakList[_weakIndex].slug]![index].sessionName} Session",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFFA3A3A3),
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
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
                                                                      FontWeight
                                                                          .w500,
                                                                  fontFamily:
                                                                      "Poppins"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    size.height *
                                                                        0.01),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                                DateFormat.Hm(
                                                                        'en_US')
                                                                    .format(_sessionMap[_weakList[_weakIndex].slug]![
                                                                            index]
                                                                        .startTime!),
                                                                style: const TextStyle(
                                                                    color:
                                                                        appThemeColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        "Poppins")),
                                                            const Text(" - ",
                                                                style: TextStyle(
                                                                    color:
                                                                        appThemeColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontFamily:
                                                                        "Poppins")),
                                                            Text(
                                                              DateFormat.Hm(
                                                                      'en_US')
                                                                  .format(_sessionMap[
                                                                          _weakList[_weakIndex]
                                                                              .slug]![index]
                                                                      .endTime!),
                                                              style: const TextStyle(
                                                                  color:
                                                                      appThemeColor,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Poppins"),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        })),
                              )
                            : _sessionMap.containsKey(
                                        _weakList[_weakIndex].slug) &&
                                    _sessionMap[_weakList[_weakIndex].slug]![0]
                                        .isHoliday! &&
                                    _sessionMap[_weakList[_weakIndex].slug]!
                                        .isNotEmpty
                                ? Expanded(
                                    child: SizedBox(
                                        height: size.height * .4,
                                        child: Center(
                                            child: Text('Marked as holiday',
                                                style: TextStyle(
                                                    fontSize:
                                                        size.height * 0.025)))))
                                : Expanded(
                                    child: SizedBox(
                                        height: size.height * .4,
                                        child: Center(
                                            child: Text(
                                          'No session created',
                                          style: TextStyle(
                                              fontSize: size.height * 0.025),
                                        )))),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _isSession
                              ? ButtonWidget(
                                  onTaped: () {},
                                  title: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                  isLoading: _isLoading,
                                )
                              : ButtonWidget(
                                  onTaped: () {
                                    if (_sessionMap.length < 7) {
                                      showMessage(
                                          "Please create session for ${(7 - _sessionMap.length).toString()} more days");
                                    } else {
                                      setState(() {
                                        _isSession = true;
                                      });
                                      String id = widget
                                          .pitchData["book_pitch_id"]
                                          .toString();
                                      List<Map<dynamic, dynamic>>
                                          sessionsPayload = [];

                                      _sessionMap.forEach((k, v) {
                                        List<Map<dynamic, dynamic>>
                                            sessionsData = [];
                                        if (!v[0].isHoliday!) {
                                          v.forEach((element) {
                                            Map detail = {
                                              "session_name":
                                                  element.sessionName,
                                              "session_name_arabic":
                                                  element.sessionNameAr,
                                              "start_time": DateFormat.Hms()
                                                  .format(element.startTime!),
                                              "end_time": DateFormat.Hms()
                                                  .format(element.endTime!),
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
                                        "pitchtype_id":
                                            widget.pitchData["pitch_type_id"],
                                        "sessions_payload": sessionsPayload
                                      };
                                      _networkCalls.createSession(
                                          onSuccess: (onSuccess) {
                                            Map detail = {
                                              "id": widget
                                                  .pitchData["book_pitch_id"]
                                                  .toString(),
                                              "subPitchId": widget
                                                  .pitchData["pitch_type_id"]
                                                  .toString()
                                            };
                                            _isSession = false;

                                            navigateToSlotScreen(detail);
                                          },
                                          detail: detail,
                                          id: id,
                                          onFailure: (onFailure) {
                                            showMessage(
                                                "Please create session properly ");
                                            setState(() {
                                              _isSession = false;
                                            });
                                          },
                                          tokenExpire: () {});
                                    }
                                  },
                                  title: Text(
                                      AppLocalizations.of(context)!.continu),
                                  isLoading: _isLoading,
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
        ));
  }

  void navigateToSlotScreen(Map detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => SlotChartScreen(pitchDetail: detail)));
    // Navigator.pushNamed(context, RouteNames.slotChart, arguments: detail);
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
                heightFactor: 0.98,
                child: _holiday
                    ? Scaffold(
                        backgroundColor: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        appBar: PreferredSize(
                            preferredSize:
                                Size(size.width, size.height * 0.105),
                            child: AppBar(
                              title: Text(
                                AppLocalizations.of(context)!.price,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              centerTitle: true,
                              backgroundColor: Colors.black,
                              leadingWidth: size.width * 0.18,
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      padding:
                                          EdgeInsets.all(size.height * 0.008),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.close,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                              bottom: PreferredSize(
                                preferredSize: Size(size.width, 10),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.035),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFFCBCBCB),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        body: SingleChildScrollView(
                          child: Container(
                            color: Colors.black,
                            child: Container(
                              width: size.width,
                              height: size.height * 0.85,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.033),
                              decoration: BoxDecoration(
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.white
                                      : const Color(0xff686868),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Form(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            tileColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            onTap: () {},
                                            shape: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            titleTextStyle: const TextStyle(
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .markAsHoliday,
                                              style: TextStyle(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 14),
                                            ),
                                            trailing: GestureDetector(
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
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Center(
                                        child: Text(
                                            "${AppLocalizations.of(context)!.markAsHoliday} for ${_weakList[_weakIndex].name} "),
                                      ),
                                    ),
                                    ButtonWidget(
                                        onTaped: () {
                                          List<SessionDetail> sessionList = [];
                                          sessionList.add(sessionDetail);
                                          _sessionMap[_weakList[_weakIndex]
                                              .slug] = sessionList;
                                          Navigator.of(context).pop();
                                          onTap();
                                        },
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .continueW),
                                        isLoading: false)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    : Scaffold(
                        backgroundColor: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        appBar: PreferredSize(
                            preferredSize:
                                Size(size.width, size.height * 0.105),
                            child: AppBar(
                              title: Text(
                                AppLocalizations.of(context)!.price,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: Colors.white),
                              ),
                              centerTitle: true,
                              backgroundColor: Colors.black,
                              leadingWidth: size.width * 0.18,
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                      padding:
                                          EdgeInsets.all(size.height * 0.008),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.grey),
                                          shape: BoxShape.circle),
                                      child: const Center(
                                        child: FaIcon(
                                          FontAwesomeIcons.close,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                              bottom: PreferredSize(
                                preferredSize: Size(size.width, 10),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.035),
                                  child: Row(
                                    children: [
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFF25A163),
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                        height: size.height * .005,
                                        width: size.width * .17,
                                        color: const Color(0XFFCBCBCB),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                        body: SingleChildScrollView(
                          child: Container(
                            color: Colors.black,
                            child: Container(
                              width: size.width,
                              height: _sessionMap.isNotEmpty &&
                                      (!_sessionMap.containsKey(
                                              _weakList[_weakIndex].slug) ||
                                          _sessionMap[_weakList[_weakIndex]
                                                  .slug]![0]
                                              .isHoliday!)
                                  ? size.height * 0.93
                                  : size.height * 0.85,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.033),
                              decoration: BoxDecoration(
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.white
                                      : const Color(0xff686868),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    flaxibleGap(1),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            tileColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            onTap: () {},
                                            shape: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            titleTextStyle: const TextStyle(
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .markAsHoliday,
                                              style: TextStyle(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? Colors.black
                                                      : Colors.white,
                                                  fontSize: 14),
                                            ),
                                            trailing: GestureDetector(
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
                                          ),
                                        ),
                                      ),
                                    ),
                                    flaxibleGap(2),
                                    _sessionMap.isNotEmpty &&
                                            (!_sessionMap.containsKey(
                                                    _weakList[_weakIndex]
                                                        .slug) ||
                                                _sessionMap[
                                                        _weakList[_weakIndex]
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
                                              onChange:
                                                  (int value, int index) =>
                                                      setState(() {
                                                copyDaysIndex = index;
                                                _sessionMap[
                                                    _weakList[_weakIndex]
                                                        .slug] = List.generate(
                                                    _sessionMap[
                                                            _copyDays[index]]!
                                                        .length,
                                                    (index2) => _sessionMap[
                                                            _copyDays[
                                                                index]]![index2]
                                                        .clone());
                                                Navigator.of(context).pop();
                                                onTap();
                                              }),
                                              dropdownButtonStyle:
                                                  DropdownButtonStyle(
                                                width: 170,
                                                height: 45,
                                                elevation: 1,
                                                backgroundColor:
                                                    MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.grey.shade200
                                                        : Colors.white12,
                                                primaryColor: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Colors.black
                                                    : Colors.white,
                                              ),
                                              dropdownStyle: DropdownStyle(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                elevation: 6,
                                                padding:
                                                    const EdgeInsets.all(5),
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Colors.grey.shade200
                                                    : Colors.black12,
                                              ),
                                              items: _copyDays
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (item) => DropdownItem(
                                                      value: item.key + 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            _weakList[_weakIndex]
                                                                        .slug !=
                                                                    item.value
                                                                ? Text(
                                                                    "Copy from ${item.value}",
                                                                    style: TextStyle(
                                                                        color: MyAppState.mode ==
                                                                                ThemeMode.light
                                                                            ? Colors.black
                                                                            : Colors.white),
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
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .CreateYourSession,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : Colors.white),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    textFieldWidget(
                                        controller: _nameController,
                                        hintText:
                                            AppLocalizations.of(context)!.name,
                                        onSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(focusName);
                                          return null;
                                        },
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterPitchName;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          sessionDetail.sessionName = value;
                                          return '';
                                        },
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        enableBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    textFieldWidget(
                                        controller: _nameControllerArabic,
                                        hintText:
                                            AppLocalizations.of(context)!.nameA,
                                        focus: focusName,
                                        onValidate: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseentername;
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          sessionDetail.sessionNameAr = value;
                                          return '';
                                        },
                                        border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        enableBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    flaxibleGap(1),

                                    ///create Slot Duration
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              onTap: () {
                                                var time = 20;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(AppLocalizations
                                                            .of(context)!
                                                        .createSlotDuration),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            sessionDetail
                                                                    .slotDuration =
                                                                time;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                    content: Container(
                                                      height:
                                                          size.height * 0.28,
                                                      width: size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: CupertinoPicker(
                                                        itemExtent: 40,
                                                        scrollController:
                                                            FixedExtentScrollController(
                                                                initialItem: 1),
                                                        children: [
                                                          for (String name
                                                              in currenciesList)
                                                            Text(
                                                              "$name min",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.03),
                                                            ),
                                                        ],
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          time = int.parse(
                                                              currenciesList[
                                                                  value]);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              titleTextStyle: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even),
                                              title: Text(
                                                AppLocalizations.of(context)!
                                                    .createSlotDuration,
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14),
                                              ),
                                              trailing: sessionDetail
                                                          .slotDuration ==
                                                      10
                                                  ? Icon(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? Icons
                                                              .keyboard_arrow_right
                                                          : Icons
                                                              .keyboard_arrow_left,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )
                                                  : Text(
                                                      '${sessionDetail.slotDuration} min')),
                                        ),
                                      ),
                                    ),

                                    ///extra time
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              onTap: () {
                                                var time = 20;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .extraGraceTime),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            sessionDetail
                                                                    .graceTime =
                                                                time;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                    content: Container(
                                                      height:
                                                          size.height * 0.28,
                                                      width: size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: CupertinoPicker(
                                                        itemExtent: 40,
                                                        scrollController:
                                                            FixedExtentScrollController(
                                                                initialItem: 1),
                                                        children: [
                                                          for (String name
                                                              in currenciesList)
                                                            Text(
                                                              "$name min",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      size.height *
                                                                          0.03),
                                                            ),
                                                        ],
                                                        onSelectedItemChanged:
                                                            (value) {
                                                          time = int.parse(
                                                              currenciesList[
                                                                  value]);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              titleTextStyle: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even),
                                              title: Text(
                                                AppLocalizations.of(context)!
                                                    .extraGraceTime,
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14),
                                              ),
                                              trailing: sessionDetail
                                                          .graceTime ==
                                                      10
                                                  ? Icon(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? Icons
                                                              .keyboard_arrow_right
                                                          : Icons
                                                              .keyboard_arrow_left,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )
                                                  : Text(
                                                      '${sessionDetail.graceTime} min')),
                                        ),
                                      ),
                                    ),

                                    ///start time
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              onTap: () {
                                                var time;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(AppLocalizations
                                                            .of(context)!
                                                        .createSlotDuration),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            print(sessionDetail
                                                                .startTime);
                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            sessionDetail
                                                                    .startTime =
                                                                time;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                    content: Container(
                                                      height:
                                                          size.height * 0.28,
                                                      width: size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child:
                                                          CupertinoDatePicker(
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .time,
                                                        use24hFormat: true,
                                                        onDateTimeChanged:
                                                            (value) {
                                                          time = value;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              titleTextStyle: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even),
                                              title: Text(
                                                AppLocalizations.of(context)!
                                                    .startTime,
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14),
                                              ),
                                              trailing: sessionDetail
                                                          .startTime ==
                                                      null
                                                  ? Icon(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? Icons
                                                              .keyboard_arrow_right
                                                          : Icons
                                                              .keyboard_arrow_left,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )
                                                  : Text(
                                                      '${sessionDetail.startTime!.hour}:${sessionDetail.startTime!.minute}')),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? Colors.grey.shade200
                                                : Colors.black12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              onTap: () {
                                                var time;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .endTime),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: const Text(
                                                              'Cancel')),
                                                      TextButton(
                                                          onPressed: () {
                                                            sessionDetail
                                                                .endTime = time;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child:
                                                              const Text('OK')),
                                                    ],
                                                    content: Container(
                                                      height:
                                                          size.height * 0.28,
                                                      width: size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child:
                                                          CupertinoDatePicker(
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .time,
                                                        use24hFormat: true,
                                                        onDateTimeChanged:
                                                            (value) {
                                                          time = value;
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              titleTextStyle: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even),
                                              title: Text(
                                                AppLocalizations.of(context)!
                                                    .endTime,
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontSize: 14),
                                              ),
                                              trailing: sessionDetail.endTime ==
                                                      null
                                                  ? Icon(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? Icons
                                                              .keyboard_arrow_right
                                                          : Icons
                                                              .keyboard_arrow_left,
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? Colors.black
                                                          : Colors.white,
                                                    )
                                                  : Text(
                                                      '${sessionDetail.endTime!.hour}:${sessionDetail.endTime!.minute}')),
                                        ),
                                      ),
                                    ),
                                    ButtonWidget(
                                        onTaped: () {
                                          // if (_formKey.currentState!.validate()) {
                                          var maxEndDate;
                                          var minStartDate;
                                          if (_sessionMap.containsKey(
                                                  _weakList[_weakIndex].slug) &&
                                              !_sessionMap[_weakList[_weakIndex]
                                                      .slug]![0]
                                                  .isHoliday!) {
                                            if (!sessionDetail.isHoliday!) {
                                              sessionDetail.isHoliday = false;
                                              sessionDetail.graceTime ??= 20;
                                              sessionDetail.slotDuration ??= 20;
                                              sessionDetail.startTime ??=
                                                  DateTime.now();
                                              sessionDetail.endTime ??=
                                                  DateTime.now();
                                              if (_sessionMap.containsKey(
                                                  _weakList[_weakIndex].slug)) {
                                                if (_sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug] !=
                                                    null) {
                                                  minStartDate = _sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .reduce((a, b) => (a
                                                                  .startTime)!
                                                              .isBefore(
                                                                  b.startTime!)
                                                          ? a
                                                          : b);
                                                  maxEndDate = _sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .reduce((a, b) =>
                                                          (a.endTime)!.isAfter(
                                                                  b.endTime!)
                                                              ? a
                                                              : b);
                                                }
                                                if (minStartDate != null &&
                                                        (sessionDetail
                                                                .startTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime) &&
                                                            sessionDetail
                                                                .endTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime)) ||
                                                    (sessionDetail.startTime!
                                                            .isAfter(maxEndDate
                                                                .endTime) &&
                                                        sessionDetail.endTime!
                                                            .isAfter(maxEndDate
                                                                .endTime))) {
                                                  _sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .add(sessionDetail);
                                                  print(
                                                      "1${_sessionMap[_weakList[_weakIndex].slug]}");
                                                  print(
                                                      "1${_sessionMap[_weakList[_weakIndex].name]}");
                                                } else {
                                                  showMessage(
                                                      "Your time is not proper as compare to previous sessions");
                                                }
                                              } else {
                                                List<SessionDetail>
                                                    sessionList = [];
                                                sessionList.add(sessionDetail);
                                                _sessionMap[
                                                    _weakList[_weakIndex]
                                                        .slug] = sessionList;
                                                print(
                                                    "@${_sessionMap[_weakList[_weakIndex].slug]}");
                                              }
                                            } else {
                                              List<SessionDetail> sessionList =
                                                  [];
                                              sessionList.add(sessionDetail);
                                              _sessionMap[_weakList[_weakIndex]
                                                  .slug] = sessionList;
                                            }
                                          } else {
                                            sessionDetail.graceTime ??= 20;
                                            sessionDetail.slotDuration ??= 20;
                                            sessionDetail.startTime ??=
                                                DateTime.now();
                                            sessionDetail.endTime ??=
                                                DateTime.now();
                                            List<SessionDetail> sessionList =
                                                [];
                                            sessionList.add(sessionDetail);
                                            if (_sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug] ==
                                                    null ||
                                                _sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug]![0]
                                                    .isHoliday!) {
                                              _sessionMap[_weakList[_weakIndex]
                                                  .slug] = sessionList;
                                            } else {
                                              if (_sessionMap[
                                                      _weakList[_weakIndex]
                                                          .slug] !=
                                                  null) {
                                                minStartDate = _sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug]!
                                                    .reduce((a, b) =>
                                                        (a.startTime)!.isBefore(
                                                                b.startTime!)
                                                            ? a
                                                            : b);
                                                maxEndDate = _sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug]!
                                                    .reduce((a, b) => (a
                                                                .endTime)!
                                                            .isAfter(b.endTime!)
                                                        ? a
                                                        : b);
                                              }
                                              if (minStartDate != null &&
                                                      (sessionDetail.startTime!
                                                              .isBefore(minStartDate
                                                                  .startTime) &&
                                                          sessionDetail.endTime!
                                                              .isBefore(minStartDate
                                                                  .startTime)) ||
                                                  (sessionDetail.startTime!
                                                          .isAfter(maxEndDate
                                                              .endTime) &&
                                                      sessionDetail.endTime!
                                                          .isAfter(maxEndDate
                                                              .endTime))) {
                                                _sessionMap[
                                                        _weakList[_weakIndex]
                                                            .slug]!
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
                                        title: Text(
                                            AppLocalizations.of(context)!
                                                .continu),
                                        isLoading: false)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))); //whatever you're returning, does not have to be a Container
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
  String name;
  String slug;
  WeekDays({required this.name, required this.slug});
}
