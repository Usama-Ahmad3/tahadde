import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/manageSlotScreens/edit_academy-screen_main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/slot_chart_screen5.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../drop_down_file.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/specific_pitch_model_class.dart';
import '../../../../../network/network_calls.dart';
import '../../../player/HomeScreen/widgets/textFormField.dart';

// ignore: must_be_immutable
class CreateSessionScreen extends StatefulWidget {
  Map academyData;
  bool createdTag;
  CreateSessionScreen(
      {Key? key, required this.academyData, this.createdTag = false})
      : super(key: key);

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
  // int firstTime = 0;
  // bool firstTimeTag = true;
  var focusNode = FocusNode();
  List<String> _copyDays = [];
  List<String> _copySessions = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final scaffoldKeyBottomShit = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final List<WeekDays> _weakList = [];
  List copySessionIndex = [];
  final Map<String, List<SessionDetail>> _sessionMap =
      <String, List<SessionDetail>>{};
  List<String> currenciesList = [
    '0',
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
  SpecificAcademy? specificAcademy;
  List indexes = [];
  late SpecificModelClass specificPitchScreen;
  late String venueType;

  editAcademy(Map detail, String academyId) async {
    print('reaches');
    await _networkCalls.editAcademy(
      id: academyId,
      academyDetail: detail,
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            showMessage('Success');
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          showMessage(AppLocalizations.of(context)!.youCant);
          setState(() {
            _isLoading = true;
          });
        }
        loadSpecificAcademy();
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  loadSpecificAcademy() async {
    print('kks');
    await _networkCalls.specificAcademy(
      id: widget.academyData["id"].toString(),
      onSuccess: (event) async {
        specificAcademy = event;
        if (mounted) {
          setState(() {
            if (specificAcademy!.session!.isNotEmpty) {
              specificAcademy!.session!.forEach((element) {
                List<SessionDetail> sessionList = [];
                element.sessions!.forEach((value) {
                  sessionList.add(SessionDetail(
                      id: value.id,
                      sessionName: value.name,
                      sessionNameAr: value.nameArabic,
                      slotDuration: value.slotDuration as int,
                      graceTime: value.extraSlot as int,
                      startTime: Intl.withLocale(
                          'en',
                          () => DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                              "2022-10-32 ${value.startTime ?? "13:00:00"}")),
                      endTime: Intl.withLocale(
                          'en',
                          () => DateFormat("yyyy-MM-dd hh:mm:ss").parse(
                              "2022-10-32 ${value.endTime ?? "13:40:00"}"))));
                });
                _sessionMap[element.weekday!] = sessionList;
              });
            }
            _isLoading = false;
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

  weakList() {
    _networkCalls.weekList(
        onSuccess: (detail) {
          print("Session Week Detail $detail");
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
  void initState() {
    super.initState();
    print('kk');
    weakList();
    widget.createdTag ? loadSpecificAcademy() : null;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: MyAppState.mode == ThemeMode.light
              ? AppColors.white
              : AppColors.darkTheme,
          appBar: appBarForCreatingAcademy(
            size,
            context,
            AppLocalizations.of(context)!.createSession,
            true,
            AppColors.appThemeColor,
            AppColors.appThemeColor,
            AppColors.appThemeColor,
            AppColors.appThemeColor,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: Align(
            alignment: Alignment(size.width * 0.0027, 0.87),
            child: SpeedDial(
              elevation: 3,
              label: Text(
                AppLocalizations.of(context)!.add,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.black,
                    ),
              ),
              animationCurve: Curves.easeInOutCirc,
              backgroundColor: MyAppState.mode == ThemeMode.light
                  ? AppColors.appThemeColor
                  : AppColors.appThemeColor,
              onPress: () {
                _holiday = false;
                _nameController.clear();
                _nameControllerArabic.clear();
                // firstTime == 1
                //     ? _sessionMap[_weakList[0].slug] != null
                //         ? showDialog(
                //             context: context,
                //             builder: (context) => AlertDialog(
                //                   elevation: 2,
                //                   backgroundColor:
                //                       MyAppState.mode == ThemeMode.light
                //                           ? AppColors.grey200
                //                           : AppColors.darkTheme,
                //                   shape: OutlineInputBorder(
                //                       borderRadius: BorderRadius.circular(12)),
                //                   title: Text(
                //                       AppLocalizations.of(context)!.copy,
                //                       style: Theme.of(context)
                //                           .textTheme
                //                           .bodyLarge!
                //                           .copyWith(
                //                               color: MyAppState.mode ==
                //                                       ThemeMode.light
                //                                   ? AppColors.black
                //                                   : AppColors.white)),
                //                   contentPadding: EdgeInsets.symmetric(
                //                       horizontal: size.width * 0.065),
                //                   content: Text(
                //                     AppLocalizations.of(context)!.copySession,
                //                     style: Theme.of(context)
                //                         .textTheme
                //                         .bodyMedium!
                //                         .copyWith(color: AppColors.red),
                //                   ),
                //                   actions: [
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceEvenly,
                //                       children: [
                //                         InkWell(
                //                           onTap: () {
                //                             Navigator.pop(context);
                //                           },
                //                           child: Center(
                //                             child: Container(
                //                               height: 35,
                //                               width: MediaQuery.of(context)
                //                                       .size
                //                                       .width *
                //                                   0.3,
                //                               decoration: BoxDecoration(
                //                                 borderRadius:
                //                                     BorderRadius.circular(20),
                //                                 color: AppColors.appThemeColor,
                //                                 border: Border.all(
                //                                     width: 1,
                //                                     color: AppColors.white),
                //                               ),
                //                               child: Center(
                //                                 child: Text(
                //                                   AppLocalizations.of(context)!
                //                                       .no,
                //                                   style: TextStyle(
                //                                       color: AppColors.white),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                         InkWell(
                //                           onTap: () {
                //                             for (int i = _weakIndex;
                //                                 i < 7;
                //                                 i++) {
                //                               if (_sessionMap[
                //                                       _weakList[i].slug] ==
                //                                   null) {
                //                                 _sessionMap[
                //                                     _weakList[i]
                //                                         .slug] = List.generate(
                //                                     _sessionMap[_copyDays[
                //                                             _weakIndex - 1]]!
                //                                         .length,
                //                                     (index2) => _sessionMap[
                //                                             _copyDays[
                //                                                 _weakIndex -
                //                                                     1]]![index2]
                //                                         .clone());
                //                               }
                //                             }
                //                             Navigator.pop(context);
                //                             setState(() {});
                //                           },
                //                           child: Center(
                //                             child: Container(
                //                               height: 35,
                //                               width: MediaQuery.of(context)
                //                                       .size
                //                                       .width *
                //                                   0.3,
                //                               decoration: BoxDecoration(
                //                                 borderRadius:
                //                                     BorderRadius.circular(20),
                //                                 color: AppColors.appThemeColor,
                //                                 border: Border.all(
                //                                     width: 1,
                //                                     color: AppColors.white),
                //                               ),
                //                               child: Center(
                //                                 child: Text(
                //                                   AppLocalizations.of(context)!
                //                                       .yes,
                //                                   style: TextStyle(
                //                                       color: AppColors.white),
                //                                 ),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                     const SizedBox(
                //                       height: 10,
                //                     ),
                //                   ],
                //                 ))
                //         : null
                //     : null;
                bottomSheet(onTap: () {
                  setState(() {});
                });
              },
              child: Icon(
                Icons.add,
                color: MyAppState.mode == ThemeMode.light
                    ? AppColors.white
                    : AppColors.black,
                size: size.height * 0.03,
              ),
            ),
          ),
          body: _isLoading
              ? Container(
                  color: AppColors.black,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.033),
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ))
              : Container(
                  color: AppColors.black,
                  child: Container(
                    width: size.width,
                    height: size.height,
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.033),
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Column(
                      children: [
                        ///Top WeakList
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        _weakList.isNotEmpty
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    ...List.generate(_weakList.length ?? 0,
                                        (index) {
                                      return _weakIndex == index
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                                                      height:
                                                          size.height * 0.05,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        color: _sessionMap
                                                                .containsKey(
                                                                    _weakList[
                                                                            index]
                                                                        .slug)
                                                            ? _sessionMap[_weakList[
                                                                                index]
                                                                            .slug]![
                                                                        0]
                                                                    .isHoliday!
                                                                ? Colors
                                                                    .redAccent
                                                                    .shade200
                                                                : AppColors
                                                                    .appThemeColor
                                                            : widget.createdTag
                                                                ? Colors
                                                                    .redAccent
                                                                    .shade200
                                                                : AppColors
                                                                    .grey200,
                                                      ),
                                                      child: Text(
                                                        "${_weakList[index].name[0].toString().toUpperCase()}${_weakList[index].name.substring(1, 3)}",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? _sessionMap.containsKey(_weakList[index]
                                                                            .slug)
                                                                        ? AppColors
                                                                            .white
                                                                        : AppColors
                                                                            .black
                                                                    : AppColors
                                                                        .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                  Image.asset(
                                                    "assets/images/bar_icon.png",
                                                    width: size.width * 0.22,
                                                    height: size.height * 0.018,
                                                    color: AppColors.grey,
                                                  )
                                                ],
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _weakIndex = index;
                                                  // if (firstTime == 0) {
                                                  //   firstTimeTag
                                                  //       ? firstTime = 1
                                                  //       : firstTime = 0;
                                                  //   firstTimeTag = false;
                                                  // } else {
                                                  //   firstTime = 0;
                                                  // }
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  width: size.width * 0.2,
                                                  height: size.height * 0.05,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
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
                                                            : AppColors
                                                                .appThemeColor
                                                        : widget.createdTag
                                                            ? Colors.redAccent
                                                                .shade200
                                                            : AppColors.grey200,
                                                  ),
                                                  child: Text(
                                                    "${_weakList[index].name[0].toString().toUpperCase()}${_weakList[index].name.substring(1, 3)}",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                            color: const Color(
                                                                0XFFA3A3A3),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                  ),
                                                ),
                                              ),
                                            );
                                    })
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: size.height * 0.02,
                        ),

                        _weakList.isNotEmpty
                            ? _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                                    !_sessionMap[_weakList[_weakIndex].slug]![0]
                                        .isHoliday! &&
                                    _sessionMap[_weakList[_weakIndex].slug]!
                                        .isNotEmpty

                                ///list of sessions that was created
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
                                                    vertical: size.height * .01,
                                                    horizontal:
                                                        size.width * 0.02),
                                                child: Dismissible(
                                                  key: UniqueKey(),
                                                  direction: DismissDirection
                                                      .endToStart,
                                                  onDismissed: (direction) {
                                                    setState(() {
                                                      Map sessions = {
                                                        "sessions": [
                                                          {
                                                            "weekday": _weakList[
                                                                    _weakIndex]
                                                                .name,
                                                            "sessions": [
                                                              {
                                                                "id": _sessionMap[
                                                                        _weakList[_weakIndex]
                                                                            .slug]![index]
                                                                    .id,
                                                                "delete": true
                                                              }
                                                            ]
                                                          }
                                                        ]
                                                      };
                                                      print('ssssssssssssss');
                                                      print(_sessionMap[
                                                              _weakList[
                                                                      _weakIndex]
                                                                  .slug]!
                                                          .length);
                                                      editAcademy(
                                                          sessions,
                                                          specificAcademy!
                                                              .academyId
                                                              .toString());
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
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? AppColors.grey200
                                                            : AppColors
                                                                .containerColorB,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(13)),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        flaxibleGap(
                                                          10,
                                                        ),
                                                        Image.asset(
                                                          "assets/images/delete_icon.png",
                                                          color: AppColors.red,
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
                                                      // showMessage(
                                                      //     AppLocalizations.of(
                                                      //             context)!
                                                      //         .swipeDelete);
                                                    },
                                                    child: Container(
                                                      height:
                                                          size.height * 0.09,
                                                      decoration: BoxDecoration(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .grey200
                                                              : AppColors
                                                                  .containerColorW12,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                                  "${AppLocalizations.of(context)!.locale == 'en' ? _sessionMap[_weakList[_weakIndex].slug]![index].sessionName : _sessionMap[_weakList[_weakIndex].slug]![index].sessionNameAr} ${AppLocalizations.of(context)!.sessions}",
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? const Color(
                                                                              0XFFA3A3A3)
                                                                          : AppColors
                                                                              .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          "Poppins"),
                                                                ),
                                                                Text(
                                                                  "( ${_sessionMap[_weakList[_weakIndex].slug]![index].slotDuration.toString()} ${AppLocalizations.of(context)!.minuteSlot} )",
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? const Color(
                                                                              0XFFA3A3A3)
                                                                          : AppColors
                                                                              .white,
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
                                                              children: [
                                                                Text(
                                                                    DateFormat.Hm(
                                                                            'en_US')
                                                                        .format(_sessionMap[_weakList[_weakIndex].slug]![index]
                                                                            .startTime!),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .bodyMedium!
                                                                        .copyWith(
                                                                            color: MyAppState.mode == ThemeMode.light
                                                                                ? AppColors.appThemeColor
                                                                                : AppColors.grey,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontFamily: "Poppins")),
                                                                Text(" - ",
                                                                    style: TextStyle(
                                                                        color: MyAppState.mode == ThemeMode.light
                                                                            ? AppColors
                                                                                .appThemeColor
                                                                            : AppColors
                                                                                .grey,
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
                                                                      .format(_sessionMap[_weakList[_weakIndex].slug]![
                                                                              index]
                                                                          .endTime!),
                                                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? AppColors
                                                                              .appThemeColor
                                                                          : AppColors
                                                                              .grey,
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
                                : _sessionMap.containsKey(_weakList[_weakIndex].slug) &&
                                        _sessionMap[_weakList[_weakIndex].slug]![0]
                                            .isHoliday! &&
                                        _sessionMap[_weakList[_weakIndex].slug]!
                                            .isNotEmpty

                                    ///if the session is holiday
                                    ? Expanded(
                                        child: SizedBox(
                                          height: size.height * .4,
                                          child: Center(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .holiday,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium),
                                          ),
                                        ),
                                      )
                                    : widget.createdTag
                                        ? Expanded(
                                            child: SizedBox(
                                                height: size.height * .4,
                                                child: Center(
                                                    child: Text(
                                                        AppLocalizations.of(context)!
                                                            .holiday,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium))))
                                        : Expanded(
                                            child: SizedBox(
                                                height: size.height * .4,
                                                child: Center(child: Text(_sessionMap.isEmpty ? AppLocalizations.of(context)!.firstSession : AppLocalizations.of(context)!.noSession, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white)))))
                            : SizedBox.shrink(),

                        ///button for navigation and creating
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: ButtonWidget(
                            onTaped: widget.createdTag
                                ?

                                ///when editing the sessions
                                () {
                                    // if (_sessionMap.length < 7) {
                                    //   showMessage(
                                    //     "Please create session for ${(7 - _sessionMap.length).toString()} more days",
                                    //   );
                                    // } else {
                                    print('already created');
                                    setState(() {
                                      _isSession = true;
                                    });
                                    List<Map<dynamic, dynamic>>
                                        sessionsPayload = [];
                                    List<Map<dynamic, dynamic>>
                                        sessionsPayloadNew = [];

                                    _sessionMap.forEach((k, v) {
                                      List<Map<dynamic, dynamic>> sessionsData =
                                          [];
                                      if (!v[0].isHoliday!) {
                                        v.forEach((element) {
                                          Map detail = {
                                            'id': element.id,
                                            "Holiday":
                                                SessionDetail().isHoliday,
                                            "Name": element.sessionName,
                                            "Name_Arabic":
                                                element.sessionNameAr,
                                            "Slot_duration":
                                                element.slotDuration,
                                            "Extra_slot": element.graceTime,
                                            "Start_time": DateFormat.Hms()
                                                .format(element.startTime!),
                                            "End_time": DateFormat.Hms()
                                                .format(element.endTime!),
                                          };
                                          sessionsData.add(detail);
                                        });
                                        for (var element in v) {}
                                        Map<String, dynamic> detail = {
                                          "weekday": k,
                                          "sessions": sessionsData
                                              .where((element) =>
                                                  element.containsKey('id') &&
                                                  element['id'] != null)
                                              .toList()
                                        };
                                        Map<String, dynamic> newDetail = {
                                          "weekday": k,
                                          "sessions": sessionsData
                                                  .where((element) =>
                                                      element['id'] == null)
                                                  .toList() ??
                                              ''
                                        };
                                        sessionsPayload.add(detail);
                                        sessionsPayloadNew.add(newDetail);
                                      }
                                    });
                                    List<Map<dynamic, dynamic>>
                                        sessionsPayloadNewData =
                                        sessionsPayloadNew
                                            .where((day) =>
                                                day['sessions'] != null &&
                                                (day['sessions'] as List)
                                                    .isNotEmpty)
                                            .toList();
                                    Map sessionUpdate = {
                                      'new_sessions': sessionsPayloadNewData,
                                      'session': sessionsPayload
                                    };
                                    print(sessionUpdate);

                                    ///do it later
                                    editAcademy(sessionUpdate,
                                        specificAcademy!.academyId.toString());
                                    Navigator.pop(context);
                                  }
                                : () {
                                    if (_sessionMap.isEmpty) {
                                      showMessage(AppLocalizations.of(context)!
                                          .atLeast);
                                    } else {
                                      setState(() {
                                        _isSession = true;
                                      });
                                      List<Map<dynamic, dynamic>>
                                          sessionsPayload = [];
                                      indexes.clear();
                                      for (int i = 0; i < 7; i++) {
                                        _sessionMap[_weakList[i].name] == null
                                            ? indexes.add(i)
                                            : null;
                                        print("object$indexes");
                                      }
                                      if (_sessionMap.length < 7) {
                                        ///if total 7 sessions are not created then add first created session then in for loop to make holiday that sessions left
                                        _sessionMap.forEach((k, v) {
                                          List<Map<dynamic, dynamic>>
                                              sessionsData = [];
                                          if (!v[0].isHoliday!) {
                                            for (var element in v) {
                                              Map detail = {
                                                "Holiday":
                                                    SessionDetail().isHoliday,
                                                "Name": element.sessionName,
                                                "Name_Arabic":
                                                    element.sessionNameAr,
                                                "Slot_duration":
                                                    element.slotDuration,
                                                "Extra_slot": false,
                                                "Start_time": DateFormat.Hms()
                                                    .format(element.startTime!),
                                                "End_time": DateFormat.Hms()
                                                    .format(element.endTime!),
                                              };
                                              sessionsData.add(detail);
                                            }
                                            Map<dynamic, dynamic> detail = {
                                              "weekday": k,
                                              "sessions": sessionsData
                                            };
                                            sessionsPayload.add(detail);
                                          }
                                        });

                                        ///make sessions holiday that are not created
                                        if (indexes.isNotEmpty) {
                                          List<Map<dynamic, dynamic>>
                                              sessionsData = [];
                                          for (int i = 0;
                                              i < indexes.length;
                                              i++) {
                                            Map detail = {
                                              "Holiday": true,
                                              "Name": 'sessionName',
                                              "Name_Arabic": "sessionNameAr",
                                              "Slot_duration": 40,
                                              "Extra_slot": false,
                                              "Start_time": DateFormat.Hms()
                                                  .format(DateTime.now()),
                                              "End_time": DateFormat.Hms()
                                                  .format(DateTime.now())
                                              // "${DateTime.now().hour.toString()}:${DateTime.now().minute.toString()}:${DateTime.now().second.toString()}",
                                            };
                                            sessionsData.add(detail);
                                            Map<dynamic, dynamic> details = {
                                              "weekday":
                                                  _weakList[indexes[i]].name,
                                              "sessions": sessionsData
                                            };
                                            sessionsPayload.add(details);
                                          }
                                        }
                                      } else {
                                        _sessionMap.forEach((k, v) {
                                          List<Map<dynamic, dynamic>>
                                              sessionsData = [];
                                          if (!v[0].isHoliday!) {
                                            for (var element in v) {
                                              Map detail = {
                                                "Holiday":
                                                    SessionDetail().isHoliday,
                                                "Name": element.sessionName,
                                                "Name_Arabic":
                                                    element.sessionNameAr,
                                                "Slot_duration":
                                                    element.slotDuration,
                                                "Extra_slot": false,
                                                "Start_time": DateFormat.Hms()
                                                    .format(element.startTime!),
                                                "End_time": DateFormat.Hms()
                                                    .format(element.endTime!),
                                              };
                                              sessionsData.add(detail);
                                            }
                                            Map<dynamic, dynamic> detail = {
                                              "weekday": k,
                                              "sessions": sessionsData
                                            };
                                            sessionsPayload.add(detail);
                                          }
                                        });
                                      }
                                      Map sessionsPay = {
                                        "sessions": sessionsPayload
                                      };
                                      print(sessionsPay);
                                      widget.academyData.addAll(sessionsPay);

                                      ///create session Api
                                      _networkCalls.createSession(
                                          detail: widget.academyData,
                                          id: 2,
                                          onSuccess: (onSuccess) {
                                            Map detail = {
                                              "id": onSuccess['academy_id']
                                                  .toString(),
                                              "message": onSuccess['message']
                                                  .toString()
                                            };
                                            print(detail);
                                            _isSession = false;

                                            navigateToSlotScreen(detail);
                                          },
                                          onFailure: (onFailure) {
                                            showMessage(
                                                AppLocalizations.of(context)!
                                                    .pleaseCreateProper);
                                            setState(() {
                                              _isSession = false;
                                            });
                                          },
                                          tokenExpire: () {});
                                    }
                                  },
                            title: Text(
                              widget.createdTag
                                  ? AppLocalizations.of(context)!.update
                                  : AppLocalizations.of(context)!.continu,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.white),
                            ),
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
            builder: (_) => SlotChartScreen(academyDetail: detail)));
    // Navigator.pushNamed(context, RouteNames.slotChart, arguments: detail);
  }

  void navigateToEditVenues(Map detail) {
    Navigator.of(context).pop();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditAcademyScreen(detail: detail)));
  }

  bottomSheet({required Function onTap}) {
    DateTime selectedDate = DateTime.now();
    String zero = '0';
    var size = MediaQuery.of(context).size;
    SessionDetail sessionDetail = SessionDetail();
    copyDaysIndex = 0;
    _copyDays = _sessionMap.keys.toList();
    print(_copyDays);
    copySessionIndex.clear();
    return showModalBottomSheet(
        backgroundColor: AppColors.transparent,
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
                            ? AppColors.white
                            : AppColors.darkTheme,
                        appBar: appBarForCreatingAcademy(
                          size,
                          context,
                          AppLocalizations.of(context)!.createSession,
                          true,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                        ),
                        body: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          child: Container(
                            color: AppColors.black,
                            child: Container(
                              width: size.width,
                              height: size.height * 0.85,
                              padding: EdgeInsets.symmetric(
                                  horizontal: size.width * 0.033),
                              decoration: BoxDecoration(
                                  color: MyAppState.mode == ThemeMode.light
                                      ? AppColors.white
                                      : AppColors.darkTheme,
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
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            tileColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            onTap: () {},
                                            shape: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .containerColorW12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            titleTextStyle: const TextStyle(
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .markAsHoliday,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                  ),
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
                                          "${AppLocalizations.of(context)!.markAsHoliday} ${AppLocalizations.of(context)!.forr} ${_weakList[_weakIndex].name} ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
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
                                              .continueW,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        isLoading: false)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    : Scaffold(
                        backgroundColor: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        appBar: appBarForCreatingAcademy(
                          size,
                          context,
                          AppLocalizations.of(context)!.createSession,
                          true,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                          AppColors.appThemeColor,
                        ),
                        body: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
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
                                      ? AppColors.white
                                      : AppColors.darkTheme,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              child: Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),

                                    ///Mark as Holiday
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            tileColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            onTap: () {},
                                            shape: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .containerColorW12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            titleTextStyle: const TextStyle(
                                                leadingDistribution:
                                                    TextLeadingDistribution
                                                        .even),
                                            title: Text(
                                              AppLocalizations.of(context)!
                                                  .markAsHoliday,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                  ),
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
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),

                                    ///Create Your Session
                                    Text(
                                      AppLocalizations.of(context)!
                                          .CreateYourSession,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.themeColor
                                                  : AppColors.white),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFieldWidget(
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
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        enableBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    TextFieldWidget(
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
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        enableBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        focusBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: AppColors.grey),
                                            borderRadius:
                                                BorderRadius.circular(12))),
                                    SizedBox(height: size.height * 0.02),

                                    ///create Slot Duration
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.grey200
                                                  : AppColors.containerColorW12,
                                              onTap: () {
                                                var time = 20;
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text(AppLocalizations
                                                            .of(context)!
                                                        .createSlotDuration),
                                                    backgroundColor: MyAppState
                                                                .mode ==
                                                            ThemeMode.light
                                                        ? AppColors.white
                                                        : AppColors.darkTheme,
                                                    elevation: 2,
                                                    shape: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            BorderSide.none),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cancel,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .appThemeColor),
                                                          )),
                                                      TextButton(
                                                          onPressed: () {
                                                            sessionDetail
                                                                    .slotDuration =
                                                                time;
                                                            Navigator.pop(
                                                                context);
                                                            setState(() {});
                                                          },
                                                          child: Text(
                                                              AppLocalizations.of(
                                                                      context)!
                                                                  .ok,
                                                              style: const TextStyle(
                                                                  color: AppColors
                                                                      .appThemeColor))),
                                                    ],
                                                    content: Container(
                                                      height:
                                                          size.height * 0.15,
                                                      width: size.width * 0.8,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: CupertinoPicker(
                                                        itemExtent: 35,
                                                        scrollController:
                                                            FixedExtentScrollController(
                                                                initialItem: 0),
                                                        children: [
                                                          for (String name
                                                              in currenciesList)
                                                            Text(
                                                              "$name ${AppLocalizations.of(context)!.mins}",
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
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .containerColorW12),
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
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                    fontSize: 14),
                                              ),
                                              trailing: sessionDetail
                                                          .slotDuration ==
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
                                                          ? AppColors.black
                                                          : AppColors.white,
                                                    )
                                                  : Text(
                                                      '${sessionDetail.slotDuration} ${AppLocalizations.of(context)!.mins}')),
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
                                                    ? AppColors.grey200
                                                    : AppColors
                                                        .containerColorW12,
                                                borderRadius:
                                                    BorderRadius.circular(13)),
                                            child: Center(
                                                child: SizedBox(
                                              width: size.width,
                                              child: ListTile(
                                                titleAlignment:
                                                    ListTileTitleAlignment
                                                        .center,
                                                tileColor: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.grey200
                                                    : AppColors
                                                        .containerColorW12,
                                                onTap: () {
                                                  var time;
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        AlertDialog(
                                                      title: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .startTime),
                                                      backgroundColor:
                                                          MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors.white
                                                              : AppColors
                                                                  .darkTheme,
                                                      elevation: 2,
                                                      shape: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide.none),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context);
                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .cancel,
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .appThemeColor))),
                                                        TextButton(
                                                            onPressed: () {
                                                              sessionDetail
                                                                      .startTime =
                                                                  time;
                                                              sessionDetail
                                                                      .endTime =
                                                                  time.add(Duration(
                                                                      minutes: sessionDetail.slotDuration !=
                                                                              null
                                                                          ? sessionDetail
                                                                              .slotDuration!
                                                                          : 0));

                                                              Navigator.pop(
                                                                  context);

                                                              setState(() {});
                                                            },
                                                            child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .ok,
                                                                style: const TextStyle(
                                                                    color: AppColors
                                                                        .appThemeColor))),
                                                      ],
                                                      content: Container(
                                                        height:
                                                            size.height * 0.15,
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
                                                          initialDateTime:
                                                              DateTime(
                                                                  selectedDate
                                                                      .year,
                                                                  selectedDate
                                                                      .month,
                                                                  selectedDate
                                                                      .day,
                                                                  0,
                                                                  0),
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
                                                    borderSide: BorderSide(
                                                        color: AppColors
                                                            .containerColorW12),
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
                                                          ? AppColors.black
                                                          : AppColors.white,
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
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Colors.black
                                                            : Colors.white,
                                                      )
                                                    : Text(
                                                        '${sessionDetail.startTime!.hour.toInt() < 10 ? zero + sessionDetail.startTime!.hour.toString() : sessionDetail.startTime!.hour}:'
                                                        '${sessionDetail.startTime!.minute.toInt() < 10 ? zero + sessionDetail.startTime!.minute.toString() : sessionDetail.startTime!.minute}'),
                                              ),
                                            )))),

                                    ///end time
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height * 0.01),
                                      child: Container(
                                        height: size.height * 0.09,
                                        decoration: BoxDecoration(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
                                            borderRadius:
                                                BorderRadius.circular(13)),
                                        child: Center(
                                          child: ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.center,
                                            tileColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.grey200
                                                : AppColors.containerColorW12,
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
                                                  backgroundColor:
                                                      MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.white
                                                          : AppColors.darkTheme,
                                                  elevation: 2,
                                                  shape: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide:
                                                          BorderSide.none),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .cancel,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .appThemeColor))),
                                                    TextButton(
                                                        onPressed: () {
                                                          sessionDetail
                                                              .endTime = time;
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .ok,
                                                            style: const TextStyle(
                                                                color: AppColors
                                                                    .appThemeColor))),
                                                  ],
                                                  content: Container(
                                                    height: size.height * 0.15,
                                                    width: size.width * 0.8,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: CupertinoDatePicker(
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .time,
                                                      use24hFormat: true,
                                                      initialDateTime: DateTime(
                                                          selectedDate.year,
                                                          selectedDate.month,
                                                          selectedDate.day,
                                                          0,
                                                          0),
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
                                                borderSide: BorderSide(
                                                    color: AppColors
                                                        .containerColorW12),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
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
                                                      ? AppColors.black
                                                      : AppColors.white,
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
                                                        ? AppColors.black
                                                        : AppColors.white,
                                                  )
                                                : Text(
                                                    '${sessionDetail.endTime!.hour.toInt() < 10 ? zero + sessionDetail.endTime!.hour.toString() : sessionDetail.endTime!.hour}:'
                                                    '${sessionDetail.endTime!.minute.toInt() < 10 ? zero + sessionDetail.endTime!.minute.toString() : sessionDetail.endTime!.minute}'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.015,
                                    ),
                                    Expanded(
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        children: _weakList
                                            .asMap()
                                            .entries
                                            .map(
                                              (item) => DropdownItem(
                                                value: item.key + 1,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: item.value.name ==
                                                          _weakList[_weakIndex]
                                                              .name
                                                      ? null
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            _weakList[_weakIndex]
                                                                        .slug !=
                                                                    item.value
                                                                ? InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        if (copySessionIndex
                                                                            .contains(item.key)) {
                                                                          copySessionIndex
                                                                              .remove(item.key);
                                                                        } else {
                                                                          copySessionIndex
                                                                              .add(item.key);
                                                                        }
                                                                      });
                                                                      print(
                                                                          copySessionIndex);
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          copySessionIndex.contains(item.key)
                                                                              ? SizedBox(
                                                                                  height: size.height * .04,
                                                                                  width: size.width * .055,
                                                                                  child: Container(
                                                                                    width: size.width * 0.1,
                                                                                    height: size.height * 0.045,
                                                                                    decoration: BoxDecoration(color: AppColors.appThemeColor, borderRadius: BorderRadius.circular(size.height * 0.005)),
                                                                                    child: Icon(
                                                                                      FontAwesomeIcons.check,
                                                                                      color: AppColors.white,
                                                                                    ),
                                                                                  ))
                                                                              : SizedBox(
                                                                                  height: size.height * .03,
                                                                                  width: size.width * .055,
                                                                                  child: Image.asset(
                                                                                    "assets/images/uncheck.png",
                                                                                    fit: BoxFit.fill,
                                                                                  ),
                                                                                ),
                                                                          SizedBox(
                                                                            width:
                                                                                size.width * 0.01,
                                                                          ),
                                                                          Text(
                                                                            '${item.value.name[0].toUpperCase()}${item.value.name.substring(1)}',
                                                                            style:
                                                                                TextStyle(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
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
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.005,
                                    ),
                                    ButtonWidget(
                                        onTaped: () {
                                          DateTime startTime = Intl.withLocale(
                                              'en',
                                              () => DateFormat("hh:mm").parse(
                                                  '${sessionDetail.startTime!.hour.toInt() < 10 ? zero + sessionDetail.startTime!.hour.toString() : sessionDetail.startTime!.hour}:${sessionDetail.startTime!.minute.toInt() < 10 ? zero + sessionDetail.startTime!.minute.toString() : sessionDetail.startTime!.minute}'));
                                          DateTime endTime = Intl.withLocale(
                                              'en',
                                              () => DateFormat("hh:mm").parse(
                                                  '${sessionDetail.endTime!.hour.toInt() < 10 ? zero + sessionDetail.endTime!.hour.toString() : sessionDetail.endTime!.hour}:${sessionDetail.endTime!.minute.toInt() < 10 ? zero + sessionDetail.endTime!.minute.toString() : sessionDetail.endTime!.minute}'));
                                          if (startTime.isAfter(endTime)) {
                                            showMessage(
                                                'Please Select Valid Start And End Time');
                                          } else {
                                            var maxEndDate;
                                            var minStartDate;
                                            final startMinutes = sessionDetail
                                                        .startTime!.hour *
                                                    60 +
                                                sessionDetail.startTime!.minute;
                                            final endMinutes = sessionDetail
                                                        .endTime!.hour *
                                                    60 +
                                                sessionDetail.endTime!.minute;
                                            final availableDurations =
                                                sessionDetail.slotDuration;

                                            ///(First)
                                            if ((endMinutes - startMinutes) !=
                                                availableDurations) {
                                              showMessage('Time Mismatched');
                                            }

                                            ///(First)
                                            else {
                                              /// (1) if there is already a session then if statement, for second or third session if statement not run on first session
                                              if (_sessionMap.containsKey(
                                                      _weakList[_weakIndex]
                                                          .slug) &&
                                                  !_sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]![0]
                                                      .isHoliday!) {
                                                print('1');
                                                if (!sessionDetail.isHoliday!) {
                                                  sessionDetail.isHoliday =
                                                      false;

                                                  sessionDetail.graceTime ??=
                                                      20;
                                                  sessionDetail.slotDuration ??=
                                                      20;
                                                  sessionDetail.startTime ??=
                                                      Intl.withLocale('en',
                                                          () => DateTime.now());
                                                  sessionDetail.endTime ??=
                                                      Intl.withLocale('en',
                                                          () => DateTime.now());
                                                  int index = _sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug]!
                                                      .length;

                                                  ///adding sessions that want to copy
                                                  if (_sessionMap[
                                                          _weakList[_weakIndex]
                                                              .slug] !=
                                                      null) {
                                                    minStartDate = _sessionMap[
                                                            _weakList[
                                                                    _weakIndex]
                                                                .slug]!
                                                        .reduce((previous,
                                                                element) =>
                                                            (previous.startTime)!
                                                                    .isBefore(
                                                                        element
                                                                            .startTime!)
                                                                ? previous
                                                                : element);
                                                    maxEndDate = _sessionMap[
                                                            _weakList[
                                                                    _weakIndex]
                                                                .slug]!
                                                        .reduce((previous,
                                                                current) =>
                                                            (previous.endTime)!
                                                                    .isAfter(current
                                                                        .endTime!)
                                                                ? previous
                                                                : current);
                                                    _copySessions.clear();

                                                    ///A
                                                    if ((sessionDetail
                                                                .startTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime) &&
                                                            sessionDetail
                                                                .endTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime)) ||
                                                        (sessionDetail
                                                                .startTime!
                                                                .isAfter(maxEndDate
                                                                    .endTime) &&
                                                            sessionDetail
                                                                .endTime!
                                                                .isAfter(maxEndDate
                                                                    .endTime))) {
                                                      copySessionIndex
                                                          .forEach((element) {
                                                        _copySessions.add(
                                                            _weakList[element]
                                                                .slug);
                                                      });
                                                      _copySessions
                                                          .forEach((element) {
                                                        ///check if the copy day session is not conflict then add otherwise don't add on that day this session
                                                        minStartDate = _sessionMap[
                                                                element]!
                                                            .reduce((previous,
                                                                    current) =>
                                                                (previous.startTime)!
                                                                        .isBefore(
                                                                            current.startTime!)
                                                                    ? previous
                                                                    : current);
                                                        maxEndDate = _sessionMap[
                                                                element]!
                                                            .reduce((previous,
                                                                    current) =>
                                                                (previous.endTime)!
                                                                        .isAfter(
                                                                            current.endTime!)
                                                                    ? previous
                                                                    : current);

                                                        ///(B) check that the other days are not conflicting with current session
                                                        if ((sessionDetail
                                                                    .startTime!
                                                                    .isBefore(
                                                                        minStartDate
                                                                            .startTime) &&
                                                                sessionDetail
                                                                    .endTime!
                                                                    .isBefore(
                                                                        minStartDate
                                                                            .startTime)) ||
                                                            (sessionDetail
                                                                    .startTime!
                                                                    .isAfter(
                                                                        maxEndDate
                                                                            .endTime) &&
                                                                sessionDetail
                                                                    .endTime!
                                                                    .isAfter(
                                                                        maxEndDate
                                                                            .endTime))) {
                                                          _sessionMap[element]!
                                                              .add(
                                                                  SessionDetail(
                                                            slotDuration:
                                                                sessionDetail
                                                                    .slotDuration,
                                                            endTime:
                                                                sessionDetail
                                                                    .endTime,
                                                            startTime:
                                                                sessionDetail
                                                                    .startTime,
                                                            sessionNameAr:
                                                                sessionDetail
                                                                    .sessionNameAr,
                                                            sessionName:
                                                                sessionDetail
                                                                    .sessionName,
                                                          ));
                                                        }

                                                        ///(B) if conflict then don't add this sessions just show the message
                                                        else {
                                                          showMessage(
                                                              "Your Time Is Not Proper As Compare To Previous Sessions of $element");
                                                        }
                                                      });
                                                      _sessionMap[_weakList[
                                                                  _weakIndex]
                                                              .slug]!
                                                          .add(sessionDetail);
                                                    } else {
                                                      showMessage(
                                                          "Your Time Is Not Proper As Compare To Previous Sessions");
                                                    }
                                                  }
                                                }

                                                /// if Holiday
                                                else {
                                                  List<SessionDetail>
                                                      sessionList = [];
                                                  sessionList
                                                      .add(sessionDetail);
                                                  _sessionMap[
                                                      _weakList[_weakIndex]
                                                          .slug] = sessionList;
                                                }
                                                Navigator.pop(context);
                                              }

                                              /// (1) adding first session if there is no session created before
                                              else {
                                                print('2sessions');
                                                sessionDetail.graceTime ??= 20;
                                                sessionDetail.slotDuration ??=
                                                    20;
                                                sessionDetail.startTime ??=
                                                    Intl.withLocale('en',
                                                        () => DateTime.now());
                                                sessionDetail.endTime ??=
                                                    Intl.withLocale('en',
                                                        () => DateTime.now());
                                                List<SessionDetail>
                                                    sessionList = [];
                                                sessionList.add(sessionDetail);
                                                _sessionMap[
                                                    _weakList[_weakIndex]
                                                        .slug] = sessionList;
                                                _copySessions.clear();
                                                copySessionIndex
                                                    .forEach((element) {
                                                  _copySessions.add(
                                                      _weakList[element].slug);
                                                });
                                                _copySessions
                                                    .forEach((element) {
                                                  ///initialize to empty list if there is no session otherwise just add
                                                  if (_sessionMap[element] ==
                                                      null) {
                                                    _sessionMap[element] = [];
                                                    _sessionMap[element]!
                                                        .add(SessionDetail(
                                                      slotDuration:
                                                          sessionDetail
                                                              .slotDuration,
                                                      endTime:
                                                          sessionDetail.endTime,
                                                      startTime: sessionDetail
                                                          .startTime,
                                                      sessionNameAr:
                                                          sessionDetail
                                                              .sessionNameAr,
                                                      sessionName: sessionDetail
                                                          .sessionName,
                                                    ));
                                                  } else {
                                                    minStartDate = _sessionMap[
                                                            element]!
                                                        .reduce((previous,
                                                                current) =>
                                                            (previous.startTime)!
                                                                    .isBefore(
                                                                        current
                                                                            .startTime!)
                                                                ? previous
                                                                : current);
                                                    maxEndDate = _sessionMap[
                                                            element]!
                                                        .reduce((previous,
                                                                current) =>
                                                            (previous.endTime)!
                                                                    .isAfter(current
                                                                        .endTime!)
                                                                ? previous
                                                                : current);
                                                    if ((sessionDetail
                                                                .startTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime) &&
                                                            sessionDetail
                                                                .endTime!
                                                                .isBefore(
                                                                    minStartDate
                                                                        .startTime)) ||
                                                        (sessionDetail
                                                                .startTime!
                                                                .isAfter(maxEndDate
                                                                    .endTime) &&
                                                            sessionDetail
                                                                .endTime!
                                                                .isAfter(maxEndDate
                                                                    .endTime))) {
                                                      _sessionMap[element]!
                                                          .add(SessionDetail(
                                                        slotDuration:
                                                            sessionDetail
                                                                .slotDuration,
                                                        endTime: sessionDetail
                                                            .endTime,
                                                        startTime: sessionDetail
                                                            .startTime,
                                                        sessionNameAr:
                                                            sessionDetail
                                                                .sessionNameAr,
                                                        sessionName:
                                                            sessionDetail
                                                                .sessionName,
                                                      ));
                                                    }

                                                    ///(B)show message if conflicting with previous days sessions while copying
                                                    else {
                                                      showMessage(
                                                          "Your Time Is Not Proper As Compare To Previous Sessions Of $element");
                                                    }
                                                  }
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            }
                                            onTap();
                                          }
                                        },
                                        title: Text(
                                          AppLocalizations.of(context)!.continu,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: AppColors.white),
                                        ),
                                        isLoading: false)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )));
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
  int? id;
  bool? isHoliday;
  String? sessionName;
  String? sessionNameAr;
  int? slotDuration;
  int? graceTime;
  DateTime? startTime;
  DateTime? endTime;
  SessionDetail(
      {this.id,
      this.sessionName,
      this.sessionNameAr,
      this.slotDuration,
      this.graceTime,
      this.startTime,
      this.endTime,
      this.isHoliday = false});
  SessionDetail clone() {
    return SessionDetail(
      id: id,
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
