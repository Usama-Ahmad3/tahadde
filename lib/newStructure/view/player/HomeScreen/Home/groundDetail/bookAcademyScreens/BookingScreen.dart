import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/modelClass/avalaible_slots.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/bookAcademyScreens/bookingShimmer.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/bookAcademyScreens/enterYourDetailAcademy.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../../homeFile/utility.dart';
import '../../../../../../../localizations.dart';
import '../../../../../../../main.dart';
import '../../../../../../../modelClass/venue_slot_model_class.dart';
import '../../../../../../../network/network_calls.dart';
import '../../../../../../../pitchOwner/loginSignupPitchOwner/createSession.dart';
import '../../../../../../../player/bookPitch/venueDetail.dart';
import '../../../../../../app_colors/app_colors.dart';

class PlayerBookingScreenView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var detail;

  PlayerBookingScreenView({super.key, required this.detail});

  @override
  State<PlayerBookingScreenView> createState() => _PlayerBookingScreenViewState();
}

class _PlayerBookingScreenViewState extends State<PlayerBookingScreenView> {
  int? selectedIndex;
  final NetworkCalls _networkCalls = NetworkCalls();
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  bool? isSelected;
  List<Map> academyDetail = [];
  bool _auth = false;
  List sessionIdList = [];
  List<String> academyId = [];
  List<int> listMaxPlayer = [];
  Map<String, List<String>> slotInformation = {};
  late SlotPrice _slotPrice =
      SlotPrice(isPlayer: false, pricePerPlayer: [], pricePerVenue: []);
  List<SlotModelClass> slotModelClass = [];
  final Map<String, List<SessionDetail>> _sessionMap =
      <String, List<SessionDetail>>{};
  List<SessionDetail> list = [];
  late String dataTime;
  var playerController = TextEditingController();
  bool isPerPlayer = true;
  int slots = 0;
  AvalaibleSlots avalaibleSlots = AvalaibleSlots();
  final List<WeekDays> _weakList = [];
  int indexItemSubPitch = 1;
  final List _slotTime = [];
  int indexItem = 1;
  int _weekIndex = 0;
  List<SlotDetail> slotD = [];
  bool internet = true;
  bool isStateLoading = true;
  int date = 0;
  List<AcademyModel> _specificAcademy = [];

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            content: Text(
              AppLocalizations.of(context)!.toReserve,
              style: TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.normal),
            ),
            actions: [
              TextButton(
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.login),
                onPressed: () {
                  navigateToLogin();
                },
              )
            ],
          );
        });
  }

  loadVerifiedSpecific() async {
    avalaibleSlotCounts();
    await _networkCalls.loadVerifiedAcademies(
      sport: widget.detail['academy_id'].toString(),
      onSuccess: (academyInfo) {
        List<AcademyModel> bookAcademy = [];
        for (int i = 0; i < academyInfo.length; i++) {
          bookAcademy.add(AcademyModel.fromJson(academyInfo[i]));
        }
        _specificAcademy = bookAcademy;
        if (_specificAcademy[0].session!.isNotEmpty) {
          _specificAcademy[0].session!.forEach((element) {
            List<SessionDetail> sessionList = [];
            element.sessions!.forEach((value) {
              sessionList.add(SessionDetail(
                  id: value.id,
                  sessionName: value.name,
                  sessionNameAr: value.nameArabic,
                  slotDuration: value.slotDuration as int,
                  startTime: Intl.withLocale(
                      'en',
                      () => DateFormat("yyyy-MM-dd HH:mm:ss")
                          .parse('2022-11-31 ${value.startTime.toString()}')),
                  endTime: Intl.withLocale(
                      'en',
                      () => DateFormat("yyyy-MM-dd hh:mm:ss")
                          .parse('2022-10-31 ${value.endTime.toString()}')
                          .toLocal())));
            });
            _sessionMap[element.weekday!] = sessionList;
            // print(_sessionMap[element.weekday]);
          });
          // print('kkkk');
          // print("SessionId${_sessionMap[_weakList[0].name]![0].id}");
          // print("SessionId${_sessionMap[_weakList[0].name]![0].endTime}");
        }
        isStateLoading = false;
        setState(() {});
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            isStateLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) {
          print('load Specific');
          on401(context);
        }
      },
    );
  }

  slotDetail() async {
    await _networkCalls.slotDetail(
        id: widget.detail["pitchId"].toString(),
        subPitchId: widget.detail["subPitchId"]["id"].toString(),
        date: dataTime,
        dateTime: "&today_datetime=${DateTime.now().toString()}",
        onSuccess: (detail) {
          setState(() {
            isStateLoading = false;
            slotModelClass = detail;
            if (slotModelClass.isNotEmpty &&
                slotModelClass[0].slotDetail!.isNotEmpty) {
              listMaxPlayer = List<int>.generate(
                  slotModelClass[0].slotDetail![0]!.maximumPlayers!.toInt(),
                  (i) => i + 1);
            } else {
              listMaxPlayer.clear();
            }
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  avalaibleSlotCounts() async {
    await _networkCalls.avalaibleSlotsCount(
        id: widget.detail['academy_id'].toString(),
        onSuccess: (detail) {
          setState(() {
            print(detail);
            avalaibleSlots = AvalaibleSlots.fromJson(detail);
            slots = avalaibleSlots.remainingSessions!.toInt();
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  checkAuth() async {
    _auth = (await checkAuthorizaton())!;
  }

  weekdays() async {
    await _networkCalls.weekList(
        onSuccess: (detail) {
          print("Session Week Detail $detail");
          detail.forEach((element) {
            setState(() {
              _weakList
                  .add(WeekDays(name: element["name"], slug: element["slug"]));
            });
          });
        },
        onFailure: (onFailure) {},
        tokenExpire: () {});
  }
  doYouWantProceedNow(Map detail,int cartId){
   return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.darkTheme,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              AppLocalizations.of(context)!.doYouWantProceed,
              style: TextStyle(
                fontSize:15,
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            content: Text(
              AppLocalizations.of(context)!.bookNow,
              style: const TextStyle(color: AppColors.appThemeColor),
            ),
            actions: [
              InkWell(
                onTap: () {
                  navigateToHomeScreen(detail);
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.gotoHomepage,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap:() {
                    Map detailForProceed = {
                    'cart_id':
                    cartId,
                    'academyNameEnglish':
                    _specificAcademy[0].academyNameEnglish,
                    'academyNameArabic':_specificAcademy[0].academyNameArabic,
                    "academy": _specificAcademy[0].academyId,
                    "session": sessionIdList,
                      "price": _specificAcademy[0].prices![0].price,
                    "location": _specificAcademy[0].academyLocation,
                    "booked_date": dataTime,
                    "player_count":indexItem,
                    'price_per_player':
                    _specificAcademy[0].prices![0].price
                    };
                    academyDetail.add(detailForProceed);
                    navigateToEditAcademyDetail(academyDetail);
                    },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
                      border: Border.all(width: 1, color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.checkout,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }
  addToCart(details) async {
    await _networkCalls.addToCard(
      detail: details,
        onSuccess: (detail) {
          doYouWantProceedNow(details,detail['id']);
        },
        onFailure: (onFailure) {},
        tokenExpire: () {});
  }

  @override
  void initState() {
    super.initState();
    dataTime = apiFormatter.format(DateTime.now());
    checkAuth();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        // slotDetail();
        weekdays();
        loadVerifiedSpecific();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? AppColors.white
          : AppColors.darkTheme,
      body: isStateLoading
          ? BookingShimmer.bookingShimmer(width, height, context)
          : internet
              ? Container(
                  color: AppColors.black,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ///Top Widget
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.02,
                            vertical: height * 0.07,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: SizedBox(
                                    height: height * 0.06,
                                    child: Image.asset(
                                      'assets/images/back.png',
                                      color: AppColors.white,
                                    )),
                              ),
                              SizedBox(
                                width: width * 0.1,
                              ),
                              Text(
                                AppLocalizations.of(context)!.bookingGround,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.white),
                              )
                            ],
                          ),
                        ),

                        ///Date Widget
                        Padding(
                          padding: AppLocalizations.of(context)!.locale == 'en'
                              ? EdgeInsets.only(left: width * 0.022)
                              : EdgeInsets.only(right: width * 0.022),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(14, (index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (date != index) {
                                          _weekIndex = Intl.withLocale(
                                                          'en', () => DateFormat('EEEE').format(DateTime.now().add(Duration(days: index))))
                                                      .toLowerCase() ==
                                                  'monday'
                                              ? 0
                                              : Intl.withLocale('en', () => DateFormat('EEEE')
                                                          .format(DateTime.now()
                                                              .add(Duration(
                                                                  days: index))))
                                                          .toLowerCase() ==
                                                      'tuesday'
                                                  ? 1
                                                  :Intl.withLocale('en', () => DateFormat('EEEE').format(DateTime.now().add(Duration(days: index)))).toLowerCase() ==
                                                          "wednesday"
                                                      ? 2
                                                      : Intl.withLocale('en', () => DateFormat('EEEE')
                                                                  .format(DateTime.now().add(Duration(days: index))))
                                                                  .toLowerCase() ==
                                                              'thursday'
                                                          ? 3
                                                          :Intl.withLocale('en', () => DateFormat('EEEE').format(DateTime.now().add(Duration(days: index)))).toLowerCase() == 'friday'
                                                              ? 4
                                                              : Intl.withLocale('en', () => DateFormat('EEEE').format(DateTime.now().add(Duration(days: index)))).toLowerCase() == "saturday"
                                                                  ? 5
                                                                  : 6;
                                          print(_weekIndex);
                                          _slotTime.clear();
                                          indexItem = 1;
                                          playerController.clear();
                                          _slotPrice.pricePerPlayer.clear();
                                          slotInformation = {};
                                          list.clear();
                                          academyId.clear();
                                          slots = 22;
                                          date = index;
                                          dataTime = apiFormatter.format(
                                              DateTime.now()
                                                  .add(Duration(days: index)));
                                          print(dataTime);
                                          // slotDetail();
                                          // _slotPrice = SlotPrice(
                                          //     pricePerVenue: [],
                                          //     pricePerPlayer: []);
                                        }
                                      });
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.018),
                                      child: Container(
                                        width: width * 0.12,
                                        height: AppLocalizations.of(context)!
                                                    .locale ==
                                                'en'
                                            ? height * 0.08
                                            : height * 0.1,
                                        decoration: BoxDecoration(
                                            color: date == index
                                                ? AppColors.appThemeColor
                                                : AppColors.white24,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                                DateTime.now()
                                                    .add(Duration(days: index))
                                                    .day
                                                    .toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: date == index
                                                            ? AppColors.black
                                                            : AppColors.grey)),
                                            Text(
                                              DateFormat('E').format(
                                                  DateTime.now().add(
                                                      Duration(days: index))),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: date == index
                                                          ? AppColors.black
                                                          : AppColors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: height * 0.032,
                        ),

                        ///down white Container
                        Container(
                          width: width,
                          height: height * 0.69,
                          decoration: BoxDecoration(
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.white
                                  : AppColors.darkTheme,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(height * 0.03),
                                  topRight: Radius.circular(height * 0.03))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: height * 0.022,
                                vertical: height * 0.02),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///ground List
                                // Text(AppLocalizations.of(context)!.academyList,
                                //     style: Theme.of(context)
                                //         .textTheme
                                //         .titleMedium!
                                //         .copyWith(
                                //           color:
                                //               MyAppState.mode == ThemeMode.light
                                //                   ? AppColors.black
                                //                   : AppColors.white,
                                //         )),
                                // ...List.generate(
                                //     3,
                                //     (index) => Padding(
                                //           padding: EdgeInsets.symmetric(
                                //               vertical: height * 0.01),
                                //           child: Container(
                                //             height: height * 0.08,
                                //             decoration: BoxDecoration(
                                //               color: AppColors.white,
                                //               borderRadius:
                                //                   BorderRadius.circular(10),
                                //               boxShadow: [
                                //                 BoxShadow(
                                //                     color: Colors.black38
                                //                         .withOpacity(0.17),
                                //                     blurStyle: BlurStyle.normal,
                                //                     offset: const Offset(1, 1),
                                //                     blurRadius: 12,
                                //                     spreadRadius: 2)
                                //               ],
                                //             ),
                                //             child: Row(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.center,
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 SizedBox(
                                //                   width: width * 0.01,
                                //                 ),
                                //                 Container(
                                //                   height: height * 0.06,
                                //                   width: width * 0.12,
                                //                   decoration: BoxDecoration(
                                //                       borderRadius:
                                //                           BorderRadius.circular(
                                //                               10),
                                //                       image: const DecorationImage(
                                //                           fit: BoxFit.fill,
                                //                           image: NetworkImage(
                                //                               'https://tse1.mm.bing.net/th?id=OIP.Pi1ySxKBf7DyNStcLdOASwHaEo&pid=Api&rs=1&c=1&qlt=95&w=168&h=105'))),
                                //                 ),
                                //                 SizedBox(
                                //                   width: width * 0.03,
                                //                 ),
                                //                 Text(
                                //                   ground[index],
                                //                   style: Theme.of(context)
                                //                       .textTheme
                                //                       .bodyMedium!
                                //                       .copyWith(
                                //                           color: MyAppState
                                //                                       .mode ==
                                //                                   ThemeMode
                                //                                       .light
                                //                               ? AppColors.black
                                //                               : AppColors
                                //                                   .white),
                                //                 ),
                                //                 SizedBox(
                                //                   width: width * 0.25,
                                //                 ),
                                //                 Checkbox(
                                //                     shape: const CircleBorder(),
                                //                     activeColor:
                                //                         Colors.greenAccent,
                                //                     value:
                                //                         selectedIndex == index
                                //                             ? true
                                //                             : false,
                                //                     onChanged: (onChanged) {
                                //                       selectedIndex = index;
                                //                       setState(() {});
                                //                     }),
                                //               ],
                                //             ),
                                //           ),
                                //         )),
                                SizedBox(
                                  height: height * 0.01,
                                ),

                                ///select area,player
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     SizedBox(
                                //       height: height * 0.067,
                                //       child: Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: [
                                //           Container(
                                //             width: width * 0.9,
                                //             alignment: Alignment.center,
                                //             padding: const EdgeInsets.all(10.0),
                                //             decoration: BoxDecoration(
                                //               color: AppColors.appThemeColor,
                                //               borderRadius:
                                //                   BorderRadius.circular(8),
                                //               border: Border.all(
                                //                 color: AppColors.white24,
                                //                 style: BorderStyle.solid,
                                //               ),
                                //             ),
                                //             child: Text(
                                //               AppLocalizations.of(context)!
                                //                   .perPlayer,
                                //               style: Theme.of(context)
                                //                   .textTheme
                                //                   .bodyMedium!
                                //                   .copyWith(
                                //                     color: MyAppState.mode ==
                                //                             ThemeMode.light
                                //                         ? AppColors.white
                                //                         : AppColors.grey,
                                //                   ),
                                //             ),
                                //           ),
                                //           // SizedBox(
                                //           //   width: width * 0.01,
                                //           // ),
                                //           // InkWell(
                                //           //   onTap: !isPerPlayer
                                //           //       ? null
                                //           //       : () {
                                //           //           if (GroundDetailState
                                //           //                   .privateVenueDetail
                                //           //                   .sports!
                                //           //                   .sportSlug ==
                                //           //               "swimming") {
                                //           //             showMessage(
                                //           //                 "${AppLocalizations.of(context)!.perAcademy} ${AppLocalizations.of(context)!.unavailable} for ${GroundDetailState.privateVenueDetail.sports!.name}");
                                //           //           } else {
                                //           //             setState(() {
                                //           //               _slotTime
                                //           //                   .clear();
                                //           //               _slotPrice
                                //           //                   .pricePerPlayer
                                //           //                   .clear();
                                //           //               _slotPrice
                                //           //                   .pricePerVenue
                                //           //                   .clear();
                                //           //               slotInformation =
                                //           //                   {};
                                //           //               isPerPlayer =
                                //           //                   false;
                                //           //             });
                                //           //           }
                                //           //         },
                                //           //   child: Container(
                                //           //     width: width * 0.44,
                                //           //     padding:
                                //           //         const EdgeInsets.all(
                                //           //             10.0),
                                //           //     alignment:
                                //           //         Alignment.center,
                                //           //     decoration: BoxDecoration(
                                //           //       color: isPerPlayer
                                //           //           ? AppColors.white
                                //           //           : MyAppState.mode ==
                                //           //                   ThemeMode
                                //           //                       .light
                                //           //               ? AppColors.grey
                                //           //               : Colors
                                //           //                   .indigoAccent,
                                //           //       borderRadius:
                                //           //           BorderRadius
                                //           //               .circular(8),
                                //           //       border: Border.all(
                                //           //         color: isPerPlayer
                                //           //             ? AppColors
                                //           //                 .blueGrey
                                //           //             : AppColors
                                //           //                 .white24,
                                //           //         style:
                                //           //             BorderStyle.solid,
                                //           //       ),
                                //           //     ),
                                //           //     child: Text(
                                //           //       AppLocalizations.of(
                                //           //               context)!
                                //           //           .perAcademy,
                                //           //       style: TextStyle(
                                //           //         color: MyAppState
                                //           //                     .mode ==
                                //           //                 ThemeMode
                                //           //                     .light
                                //           //             ? AppColors.black
                                //           //             : AppColors.grey,
                                //           //       ),
                                //           //     ),
                                //           //   ),
                                //           // )
                                //         ],
                                //       ),
                                //     )
                                //   ],
                                // ),
                                // SizedBox(
                                //   height: height * 0.02,
                                // ),
                                /// slot Selecting
                                // slotModelClass.isEmpty
                                //     ? SizedBox(
                                //         height: height * 0.22,
                                //         child: Center(
                                //           child: Text(
                                //             AppLocalizations.of(context)!
                                //                 .thisDayHoliday,
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .bodyMedium!
                                //                 .copyWith(
                                //                     color: MyAppState.mode ==
                                //                             ThemeMode.light
                                //                         ? AppColors.black
                                //                         : AppColors.white),
                                //           ),
                                //         ),
                                //       ) :
                                _weakList.isNotEmpty?
                               _sessionMap[_weakList[_weekIndex].name] != null
                                    ? SizedBox(
                                        height: height * 0.54,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Wrap(children: [
                                                ...List.generate(
                                                    _sessionMap[_weakList[
                                                                    _weekIndex]
                                                                .name]!
                                                            .length ??
                                                        0, (i) {
                                                  final sessionToAddOrRemove =
                                                      SessionDetail(
                                                    id: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .id,
                                                    sessionNameAr: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .sessionNameAr,
                                                    sessionName: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .sessionName,
                                                    graceTime: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .graceTime,
                                                    endTime: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .endTime,
                                                    startTime: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .startTime,
                                                    slotDuration: _sessionMap[
                                                            _weakList[_weekIndex]
                                                                .name]![i]
                                                        .slotDuration,
                                                  );
                                                  bool isSessionInList = false;
                                                  print('hi');
                                                  print(_sessionMap[
                                                          _weakList[_weekIndex]
                                                              .name]!
                                                      .length);
                                                  return InkWell(
                                                    onTap: () {
                                                      setState(() {

                                                      });

                                                      if (list.isEmpty) {
                                                        // If the list is empty, add the session
                                                        list.add(
                                                            sessionToAddOrRemove);
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                'en'
                                                            ? academyId.add(
                                                                _sessionMap[_weakList[
                                                                            _weekIndex]
                                                                        .name]![i]
                                                                    .sessionName
                                                                    .toString())
                                                            : academyId.add(
                                                                (_sessionMap[_weakList[
                                                                            _weekIndex]
                                                                        .name]![i]
                                                                    .sessionNameAr
                                                                    .toString()));
                                                        _slotPrice.pricePerPlayer
                                                            .add(_specificAcademy[0]
                                                                .prices![0]
                                                                .price!
                                                                .toDouble());
                                                        slots != 0 ?slots = slots -1:null;
                                                        playerController.text =
                                                            indexItem.toString();
                                                      } else {
                                                        isSessionInList =
                                                            list.any((item) {
                                                          return item.id ==
                                                                  sessionToAddOrRemove
                                                                      .id &&
                                                              item.sessionNameAr ==
                                                                  sessionToAddOrRemove
                                                                      .sessionNameAr &&
                                                              item.sessionName ==
                                                                  sessionToAddOrRemove
                                                                      .sessionName &&
                                                              item.graceTime ==
                                                                  sessionToAddOrRemove
                                                                      .graceTime &&
                                                              item.endTime ==
                                                                  sessionToAddOrRemove
                                                                      .endTime &&
                                                              item.startTime ==
                                                                  sessionToAddOrRemove
                                                                      .startTime &&
                                                              item.slotDuration ==
                                                                  sessionToAddOrRemove
                                                                      .slotDuration;
                                                        });
                                                        if (isSessionInList) {
                                                            slots < 22 ?slots = slots + 1 : null;
                                                          playerController.text =
                                                              indexItem.toString();
                                                          AppLocalizations.of(context)!
                                                                      .locale ==
                                                                  'en'
                                                              ? academyId.remove(
                                                                  _sessionMap[_weakList[
                                                                              _weekIndex]
                                                                          .name]![i]
                                                                      .sessionName)
                                                              : academyId.remove(
                                                                  _sessionMap[_weakList[
                                                                              _weekIndex]
                                                                          .name]![i]
                                                                      .sessionNameAr);
                                                          list.removeWhere((item) {
                                                            return item.id ==
                                                                    sessionToAddOrRemove
                                                                        .id &&
                                                                item.sessionNameAr ==
                                                                    sessionToAddOrRemove
                                                                        .sessionNameAr &&
                                                                item.sessionName ==
                                                                    sessionToAddOrRemove
                                                                        .sessionName &&
                                                                item.graceTime ==
                                                                    sessionToAddOrRemove
                                                                        .graceTime &&
                                                                item.endTime ==
                                                                    sessionToAddOrRemove
                                                                        .endTime &&
                                                                item.startTime ==
                                                                    sessionToAddOrRemove
                                                                        .startTime &&
                                                                item.slotDuration ==
                                                                    sessionToAddOrRemove
                                                                        .slotDuration;
                                                          });
                                                          _slotPrice.pricePerPlayer
                                                              .removeLast();
                                                        } else {
                                                          slots != 0 ?slots = slots - 1 : null;
                                                          playerController.text =
                                                              indexItem.toString();
                                                          AppLocalizations.of(
                                                                          context)!
                                                                      .locale ==
                                                                  'en'
                                                              ? academyId.add(
                                                                  _sessionMap[_weakList[
                                                                              _weekIndex]
                                                                          .name]![i]
                                                                      .sessionName
                                                                      .toString())
                                                              : academyId.add(
                                                                  (_sessionMap[_weakList[
                                                                              _weekIndex]
                                                                          .name]![i]
                                                                      .sessionNameAr
                                                                      .toString()));
                                                          list.add(
                                                              sessionToAddOrRemove);
                                                          _slotPrice.pricePerPlayer
                                                              .add(_specificAcademy[
                                                                      0]
                                                                  .prices![0]
                                                                  .price!
                                                                  .toDouble());
                                                        }
                                                      }
                                                      print(list.length);
                                                      print(academyId);
                                                      setState(() {});
                                                    },
                                                    child: SizedBox(
                                                      width: width * 0.43,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${_sessionMap[_weakList[_weekIndex].name]![i].sessionName}(${_sessionMap[_weakList[_weekIndex].name]![i].slotDuration} mins)",
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium!
                                                                .copyWith(
                                                                    color: MyAppState
                                                                                .mode ==
                                                                            ThemeMode
                                                                                .light
                                                                        ? AppColors
                                                                            .black
                                                                        : AppColors
                                                                            .white),
                                                          ),
                                                          SizedBox(
                                                            height: height * 0.01,
                                                          ),
                                                          Badge(
                                                            backgroundColor:
                                                                AppColors.grey,
                                                            label: Text('$slots'),
                                                            alignment:
                                                                Alignment.topRight,
                                                            textColor:
                                                                AppColors.black,
                                                            child: Container(
                                                              height:
                                                                  height * 0.065,
                                                              width: width * 0.4,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                  academyId.contains(
                                                                          _sessionMap[_weakList[_weekIndex].name]![
                                                                                  i]
                                                                              .sessionName)
                                                                      ? AppColors
                                                                          .appThemeColor
                                                                      :
                                                                  AppColors
                                                                          .grey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              12)),
                                                              child: Row(
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: width *
                                                                            0.015),
                                                                    child: Text(
                                                                      '${_sessionMap[_weakList[_weekIndex].name]![i].startTime.toString().substring(11, 16)} - ${_sessionMap[_weakList[_weekIndex].name]![i].endTime!.toString().substring(11, 16)}',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyMedium!
                                                                          .copyWith(
                                                                              color:
                                                                              academyId.contains(_sessionMap[_weakList[_weekIndex].name]![i].sessionName)
                                                                                  ? MyAppState.mode == ThemeMode.light
                                                                                      ? AppColors.white
                                                                                      : AppColors.grey :
                                                                              AppColors.black),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: width *
                                                                        0.05,
                                                                  ),
                                                                  CircleAvatar(
                                                                    radius: height *
                                                                        0.01,
                                                                    backgroundColor:
                                                                    academyId.contains(
                                                                            _sessionMap[_weakList[_weekIndex].name]![i]
                                                                                .sessionName)
                                                                        ? AppColors
                                                                            .red :
                                                                    AppColors
                                                                            .darkTheme,
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                })
                                              ]),
                                              SizedBox(
                                                height: height * 0.02,
                                              ),
                                              list.isEmpty?SizedBox.shrink():Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.01),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(context)!
                                                          .selectnumber,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium!
                                                          .copyWith(
                                                        color: MyAppState.mode ==
                                                            ThemeMode.light
                                                            ? AppColors.themeColor
                                                            : AppColors.white,
                                                      ),
                                                    ),
                                                    Container(
                                                      height: height * 0.055,
                                                      width: width * 0.45,
                                                      decoration: BoxDecoration(
                                                          color: MyAppState.mode == ThemeMode.light?AppColors.grey.withOpacity(0.4):AppColors.containerColorW12,
                                                          borderRadius:
                                                          BorderRadius.circular(12),
                                                          border: Border.fromBorderSide(
                                                              MyAppState.mode ==
                                                                  ThemeMode.light
                                                                  ? BorderSide.none
                                                                  : BorderSide(
                                                                  color: AppColors.white,
                                                                  width: 1))),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (indexItem != 1) {
                                                                indexItem = indexItem - 1;
                                                                slots < 22 ?slots = slots + 1:null;
                                                              }
                                                              playerController.text =
                                                                  indexItem.toString();
                                                              setState(() {});
                                                            },
                                                            child: const Icon(
                                                              FontAwesomeIcons.minus,
                                                              color: AppColors.appThemeColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          Text(
                                                            indexItem.toString(),
                                                            style: Theme.of(context)
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.01,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              if (list.isEmpty) {
                                                                showMessage(
                                                                    'please select your slot first');
                                                              } else {
                                                                indexItem < 22?indexItem = indexItem + 1:null;
                                                                slots != 0 ?slots = slots -1:null;
                                                                playerController.text =
                                                                    indexItem.toString();
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Icon(
                                                              Icons.add,
                                                              color: AppColors.appThemeColor,
                                                              size: height * 0.04,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    // TextFieldWidget(
                                                    //     enableBorder: OutlineInputBorder(
                                                    //         borderSide: MyAppState
                                                    //                     .mode ==
                                                    //                 ThemeMode
                                                    //                     .light
                                                    //             ? BorderSide
                                                    //                 .none
                                                    //             : BorderSide(
                                                    //                 color: AppColors
                                                    //                     .white,
                                                    //                 width: 1)),
                                                    //     border: OutlineInputBorder(
                                                    //         borderSide: MyAppState
                                                    //                     .mode ==
                                                    //                 ThemeMode
                                                    //                     .light
                                                    //             ? BorderSide
                                                    //                 .none
                                                    //             : BorderSide(
                                                    //                 color: AppColors
                                                    //                     .white,
                                                    //                 width: 1)),
                                                    //     focusBorder: OutlineInputBorder(
                                                    //         borderSide: MyAppState
                                                    //                     .mode ==
                                                    //                 ThemeMode
                                                    //                     .light
                                                    //             ? BorderSide.none
                                                    //             : BorderSide(color: AppColors.white, width: 1)),
                                                    //     prefix: null,
                                                    //     suffixIcon: Icons.add,
                                                    //     enable: false,
                                                    //     onTap: () {
                                                    //       indexItem =
                                                    //           indexItem + 1;
                                                    //       playerController
                                                    //               .text =
                                                    //           indexItem
                                                    //               .toString();
                                                    //       setState(() {
                                                    //
                                                    //       });
                                                    //     },
                                                    //     type: TextInputType.number,
                                                    //     onChanged: (value) {
                                                    //       if (value != null) {
                                                    //         if (value !=
                                                    //             indexItem - 1) {
                                                    //           setState(() {
                                                    //             indexItem =
                                                    //                 int.parse(
                                                    //                     value);
                                                    //           });
                                                    //           print(indexItem);
                                                    //         }
                                                    //       }
                                                    //       return null;
                                                    //     },
                                                    //     controller: playerController,
                                                    //     hintText: '00'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : SizedBox(
                                        height: height * 0.5,
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .noSlotsAvailable,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.black
                                                        : AppColors.white),
                                          ),
                                        ),
                                      ):SizedBox.shrink(),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                                ///Book Button
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: ButtonWidget(
                                      isLoading: false,
                                      onTaped: () {
                                        if (_auth) {
                                          if (_slotPrice
                                              .pricePerPlayer.isEmpty) {
                                            showMessage(
                                                "Please select your slot first");
                                          } else {
                                            // Map apiDetail = {
                                            //   "date": dataTime,
                                            //   "id":
                                            //       _specificAcademy[0].academyId
                                            // };
                                            // var detail = {
                                            //   "price": slotPriceCalculation(
                                            //           _slotPrice
                                            //               .pricePerPlayer) *
                                            //       indexItem,
                                            //   'academy_id':
                                            //       _specificAcademy[0].academyId,
                                            //   "apiDetail": apiDetail,
                                            //   "slotDetail": list,
                                            //   "academyName": _specificAcademy[0]
                                            //       .academyNameEnglish,
                                            //   "subPitch": _specificAcademy[0]
                                            //       .prices![0]
                                            //       .subAcademy,
                                            //   'location': _specificAcademy[0]
                                            //       .academyLocation,
                                            //   "player_count": indexItem,
                                            //   "slug": "price-per-player"
                                            // };
                                            list.forEach((element) {
                                              sessionIdList.add(element.id);
                                            });
                                            Map details = {
                                              "academy": _specificAcademy[0].academyId,
                                              "session": sessionIdList,
                                              "Sub_Academy": _specificAcademy[0]
                                                  .prices![0]
                                                  .subAcademy,
                                              "price": slotPriceCalculation(
                                                  _slotPrice
                                                      .pricePerPlayer) *
                                                  indexItem,
                                              "location": _specificAcademy[0]
                                                  .academyLocation,
                                              "booked_date": dataTime,
                                              "player_count":indexItem,
                                              'price_per_player': _specificAcademy[0].prices![0].price
                                            };
                                            print('AcademyDetail$details');
                                            // print(_sessionMap[
                                            //         _weakList[_weekIndex]
                                            //             .name]![0]
                                            //     .id);
                                            addToCart(details);
                                          }
                                        } else {
                                          onWillPop();
                                        }
                                      },
                                      title: Center(
                                        child: Text(
                                          _slotPrice.pricePerPlayer.isEmpty
                                              ? AppLocalizations.of(context)!
                                                  .bookNowS
                                              : "${AppLocalizations.of(context)!.addToCart}: ${(slotPriceCalculation(_slotPrice.pricePerPlayer) * indexItem).round().toString()} AED",
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
                        ),
                      ],
                    ),
                  ),
                )
              : Material(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: InternetLoss(
                      onChange: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          internet = msg;
                          if (msg == true) {}
                        });
                      },
                    ),
                  ),
                ),
    );
  }

  bool? availability(var value) {
    if (value.isBooked) {
      return false;
    } else if (!value.bookedPlayer && !value.bookedVenue) {
      return true;
    } else if (value.bookedPlayer && !value.bookedVenue) {
      return isPerPlayer ? true : false;
    }
    return null;
  }

  List ground = ['Main Academy', 'Futsal Academy', 'tennis Academy'];

  void navigateToLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => LoginScreen(message: 'message')));
    // Navigator.pushNamed(context, RouteNames.login);
  }

  double slotPriceCalculation(List<double> priceList) {
    double slotPrice = 0.0;
    for (var element in priceList) {
      slotPrice = slotPrice + element;
    }
    return slotPrice;
  }

  void navigateToHomeScreen(Map detail) {
    // Navigator.pushNamed(context, RouteNames.enterDetailAcademy,
    //     arguments: detail);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PlayerHomeScreen(index: 0),));
  }
  navigateToEditAcademyDetail(detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EnterDetailAcademyScreen(detail: detail),
        ));
  }
}
