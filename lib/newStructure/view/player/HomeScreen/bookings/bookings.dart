import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/modelClass/player_bookings.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';

class PlayerBookingScreen extends StatefulWidget {
  bool bookingTag;
  PlayerBookingScreen({super.key, this.bookingTag = false});
  @override
  _PlayerBookingScreenState createState() => _PlayerBookingScreenState();
}

class _PlayerBookingScreenState extends State<PlayerBookingScreen> {
  bool? internet;
  bool state = true;
  final bool _auth = false;
  String date = "name";
  List<BookedSessions> bookedSessions = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  late PlayerBookings bookings;

  loadBookings() async {
    await _networkCalls.loadPlayerbookings(
      onSuccess: (event) {
        setState(() {
          bookings = event;
        });
        loadSpecificSession();
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) {
          on401(context);
          showMessage(AppLocalizations.of(context)!.loginRequired);
        }
      },
    );
  }

  loadSpecificSession() {
    if (bookings.bookings!.isNotEmpty) {
      bookings.bookings!.forEach((element) async {
        element.bookedSession!.forEach((sessionsId) async {
          await _networkCalls.specificSession(
            id: sessionsId.toString(),
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
      });
      state = false;
    }
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadBookings();
      } else {
        setState(() {
          state = false;
        });
      }
    });
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
          widget.bookingTag,
        ),
        body: state
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
                      ...List.generate(
                          bookings.bookings!.length,
                          (index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: sizeHeight * .02,
                                    horizontal: sizeWidth * .08),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10.0)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      flaxibleGap(1),
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
                                                        height:
                                                            sizeHeight * .08,
                                                        cuisineImageUrl: bookings
                                                                .bookings![
                                                                    index]
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
                                                  bookings.bookings![index]
                                                      .playerName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Color(0XFF032040)),
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
                                                      " ${bookings.bookings![index].playerPhoneno.toString()}",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color(
                                                              0XFF25A163)),
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
                                                      "  ${bookings.bookings![index].playerEmail}" ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Color(
                                                              0XFF25A163)),
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
                                          AppLocalizations.of(context)!
                                              .bookingDetails,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color(0XFFADADAD)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: sizeHeight * 0.01,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .03),
                                        child: Row(
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          'en'
                                                      ? bookings
                                                          .bookings![index]
                                                          .academyName
                                                          .toString()
                                                      : "specificAcademy![index].academyNameArabic",
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: Color(0XFF032040)),
                                                ),
                                                SizedBox(
                                                  width: sizeWidth * .65,
                                                  child: Text(
                                                    bookings.bookings![index]
                                                        .location
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color:
                                                            Color(0XFF9B9B9B)),
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
                                              bookings.bookings![index].currency
                                                  .toString(),
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
                                              AppLocalizations.of(context)!
                                                  .slots,
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
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .booked,
                                                style: const TextStyle(
                                                    color: Color(0XFF25A163),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins"))
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .03),
                                        child: Text(
                                          bookings.bookings![index].bookedDate
                                              .toString(),
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
                                            return SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              'en'
                                                          ? bookedSessions[
                                                                  blockindex]
                                                              .name
                                                              .toString()
                                                          : bookedSessions[
                                                                  blockindex]
                                                              .nameArabic
                                                              .toString(),
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0XFF25A163))),
                                                  Text(
                                                      "${bookedSessions[blockindex].startTime} To ${bookedSessions[blockindex].endTime}",
                                                      // '(${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0XFF25A163))),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      flaxibleGap(1),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .03),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .tranjectionId,
                                          style: const TextStyle(
                                              color: Color(0XFFADADAD)),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .03),
                                        child: Text(
                                          bookings
                                              .bookings![index].transactionId
                                              .toString(),
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Color(0XFF032040)),
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
                                                bookings.bookings![index].price
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
                              ))
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

// import 'package:flutter/material.dart';
// import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
// import 'package:flutter_tahaddi/modelClass/player_bookings.dart';
// import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
// import 'package:intl/intl.dart';
//
// import '../../../../../common_widgets/internet_loss.dart';
// import '../../../../../homeFile/utility.dart';
// import '../../../../../localizations.dart';
// import '../../../../../modelClass/eventModelClass.dart';
// import '../../../../../network/network_calls.dart';
// import '../../../../../main.dart';
// import '../../../../app_colors/app_colors.dart';
//
// class EventsScreen extends StatefulWidget {
//   bool bookingTag;
//
//   EventsScreen({super.key, this.bookingTag = false});
//
//   @override
//   State<EventsScreen> createState() => _EventsScreenState();
// }
//
// class _EventsScreenState extends State<EventsScreen> {
//   bool? internet;
//   bool state = true;
//   final bool _auth = false;
//   String date = "name";
//   List<BookedSessions> bookedSessions = [];
//   final NetworkCalls _networkCalls = NetworkCalls();
//   late PlayerBookings bookings;
//
//   loadBookings() async {
//     await _networkCalls.loadPlayerbookings(
//       onSuccess: (event) {
//         setState(() {
//           state = false;
//           bookings = event;
//         });
//         loadSpecificSession();
//       },
//       onFailure: (msg) {
//         showMessage(msg);
//       },
//       tokenExpire: () {
//         if (mounted) {
//           on401(context);
//           showMessage(AppLocalizations.of(context)!.loginRequired);
//         }
//       },
//     );
//   }
//
//   loadSpecificSession() {
//     if (bookings.bookings!.isNotEmpty) {
//       bookings.bookings!.forEach((element) async {
//         element.bookedSession!.forEach((sessionsId) async {
//           await _networkCalls.specificSession(
//             id: sessionsId.toString(),
//             onSuccess: (event) async {
//               BookedSessions session = BookedSessions.fromJson(event);
//               bookedSessions.add(session);
//               if (mounted) {
//                 setState(() {});
//               }
//             },
//             onFailure: (msg) {
//               if (mounted) {
//                 showMessage(msg);
//               }
//             },
//             tokenExpire: () {
//               if (mounted) on401(context);
//             },
//           );
//         });
//       });
//       // loadSpecific();
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
//       internet = msg;
//       if (msg == true) {
//         loadBookings();
//       } else {
//         setState(() {
//           state = false;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var sizeHeight = MediaQuery.of(context).size.height;
//     var sizeWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//         backgroundColor: Colors.black54,
//         appBar: appBarWidget(
//             sizeWidth,
//             sizeHeight,
//             context,
//             AppLocalizations.of(context)!.booking,
//             widget.bookingTag ? true : false),
//         body: state
//             ? Container(
//                 color: Colors.black54,
//                 child: Container(
//                   height: double.infinity,
//                   decoration: BoxDecoration(
//                       color: MyAppState.mode == ThemeMode.light
//                           ? AppColors.white
//                           : AppColors.darkTheme,
//                       borderRadius: const BorderRadius.only(
//                           topRight: Radius.circular(20),
//                           topLeft: Radius.circular(20))),
//                   child: Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: AppColors.appThemeColor,
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                         AppColors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//             : internet!
//                 ? bookings == null
//                     ? Container(
//                         color: AppColors.containerColorB54,
//                         child: Container(
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                               color: MyAppState.mode == ThemeMode.light
//                                   ? AppColors.white
//                                   : AppColors.darkTheme,
//                               borderRadius: const BorderRadius.only(
//                                   topRight: Radius.circular(20),
//                                   topLeft: Radius.circular(20))),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               flaxibleGap(
//                                 30,
//                               ),
//                               SizedBox(
//                                   height: sizeHeight * .15,
//                                   width: sizeHeight * .15,
//                                   child: Image.asset(
//                                     'assets/images/icon.png',
//                                     fit: BoxFit.fill,
//                                   )),
//                               flaxibleGap(
//                                 2,
//                               ),
//                               Text(
//                                   AppLocalizations.of(context)!.noBookingsFound,
//                                   style: Theme.of(context)
//                                       .textTheme
//                                       .bodyMedium!
//                                       .copyWith(
//                                         color:
//                                             MyAppState.mode == ThemeMode.light
//                                                 ? const Color(0XFF424242)
//                                                 : AppColors.white,
//                                         fontFamily: "Poppins",
//                                       )),
//                               flaxibleGap(
//                                 32,
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                     : Container(
//                         color: AppColors.containerColorB54,
//                         child: Container(
//                           height: double.infinity,
//                           decoration: BoxDecoration(
//                               color: MyAppState.mode == ThemeMode.light
//                                   ? AppColors.white
//                                   : AppColors.darkTheme,
//                               borderRadius: const BorderRadius.only(
//                                   topRight: Radius.circular(20),
//                                   topLeft: Radius.circular(20))),
//                           child: Column(
//                             children: [
//                               Expanded(
//                                 child: ListView.builder(
//                                     scrollDirection: Axis.vertical,
//                                     itemCount: bookings.bookings!.length,
//                                     itemBuilder: (context, index) {
//                                       return
//                                           // checkdate(index: index)
//                                           //   ? Padding(
//                                           //       padding: EdgeInsets.only(
//                                           //           left: sizeWidth * .05,
//                                           //           right: sizeWidth * .05),
//                                           //       child: Column(
//                                           //         crossAxisAlignment:
//                                           //             CrossAxisAlignment.start,
//                                           //         children: [
//                                           //           Container(
//                                           //             height: sizeHeight * .03,
//                                           //           ),
//                                           //           Container(
//                                           //             height: sizeHeight * .28,
//                                           //             decoration: BoxDecoration(
//                                           //                 color: MyAppState
//                                           //                             .mode ==
//                                           //                         ThemeMode.light
//                                           //                     ? AppColors.grey200
//                                           //                     : const Color(
//                                           //                         0XFFFFFFFF),
//                                           //                 borderRadius:
//                                           //                     const BorderRadius
//                                           //                         .only(
//                                           //                         topLeft: Radius
//                                           //                             .circular(
//                                           //                                 12),
//                                           //                         topRight: Radius
//                                           //                             .circular(
//                                           //                                 12))),
//                                           //             child: Padding(
//                                           //               padding: EdgeInsets.only(
//                                           //                   left: sizeWidth * .05,
//                                           //                   right:
//                                           //                       sizeWidth * .05),
//                                           //               child: Column(
//                                           //                 crossAxisAlignment:
//                                           //                     CrossAxisAlignment
//                                           //                         .start,
//                                           //                 children: [
//                                           //                   flaxibleGap(
//                                           //                     2,
//                                           //                   ),
//                                           //                   Text(
//                                           //                     'userName:',
//                                           //                     // '${bookings[index].user!.first_name}${bookings[index].user!.last_name}',
//                                           //                     style: Theme.of(
//                                           //                             context)
//                                           //                         .textTheme
//                                           //                         .titleMedium!
//                                           //                         .copyWith(
//                                           //                             color: AppColors
//                                           //                                 .appThemeColor,
//                                           //                             fontWeight:
//                                           //                                 FontWeight
//                                           //                                     .w500),
//                                           //                   ),
//                                           //                   flaxibleGap(
//                                           //                     1,
//                                           //                   ),
//                                           //                   Text('booking Name',
//                                           //                       // "${bookings[index].event!.name}",
//                                           //                       style: Theme.of(
//                                           //                               context)
//                                           //                           .textTheme
//                                           //                           .bodyMedium!
//                                           //                           .copyWith(
//                                           //                               color: Color(
//                                           //                                   0XFF424242),
//                                           //                               fontWeight:
//                                           //                                   FontWeight
//                                           //                                       .w600)),
//                                           //                   Text('Date',
//                                           //                       // DateFormat.yMMMMd(
//                                           //                       //         'en_US')
//                                           //                       //     .format(DateTime.parse(bookings[
//                                           //                       //             index]
//                                           //                       //         .event!
//                                           //                       //         .startDate
//                                           //                       //         .toString())),
//                                           //                       style: Theme.of(
//                                           //                               context)
//                                           //                           .textTheme
//                                           //                           .bodyMedium!
//                                           //                           .copyWith(
//                                           //                               color: Color(
//                                           //                                   0XFF25A163),
//                                           //                               fontFamily:
//                                           //                                   "Poppins",
//                                           //                               fontWeight:
//                                           //                                   FontWeight
//                                           //                                       .w600)),
//                                           //                   flaxibleGap(
//                                           //                     2,
//                                           //                   ),
//                                           //                   Text('transactionId',
//                                           //                       // "${AppLocalizations.of(context)!.tranjectionId} : ${bookings[index].transactionId}",
//                                           //                       style: Theme.of(
//                                           //                               context)
//                                           //                           .textTheme
//                                           //                           .bodyMedium!
//                                           //                           .copyWith(
//                                           //                             color: AppColors
//                                           //                                 .appThemeColor,
//                                           //                             fontWeight:
//                                           //                                 FontWeight
//                                           //                                     .w600,
//                                           //                           )),
//                                           //                   flaxibleGap(
//                                           //                     2,
//                                           //                   ),
//                                           //                 ],
//                                           //               ),
//                                           //             ),
//                                           //           ),
//                                           //           Container(
//                                           //             height: sizeHeight * .08,
//                                           //             decoration: const BoxDecoration(
//                                           //                 color: AppColors
//                                           //                     .appThemeColor,
//                                           //                 borderRadius:
//                                           //                     BorderRadius.only(
//                                           //                         bottomLeft: Radius
//                                           //                             .circular(
//                                           //                                 12),
//                                           //                         bottomRight: Radius
//                                           //                             .circular(
//                                           //                                 12))),
//                                           //             child: Padding(
//                                           //               padding: EdgeInsets.only(
//                                           //                   left: sizeWidth * .05,
//                                           //                   right:
//                                           //                       sizeWidth * .05),
//                                           //               child: Row(
//                                           //                 mainAxisAlignment:
//                                           //                     MainAxisAlignment
//                                           //                         .spaceBetween,
//                                           //                 children: [
//                                           //                   Text(
//                                           //                     AppLocalizations.of(
//                                           //                             context)!
//                                           //                         .paidTotal,
//                                           //                     style: Theme.of(
//                                           //                             context)
//                                           //                         .textTheme
//                                           //                         .bodyMedium!
//                                           //                         .copyWith(
//                                           //                             color: Color(
//                                           //                                 0XFFFFFFFF),
//                                           //                             fontWeight:
//                                           //                                 FontWeight
//                                           //                                     .w600,
//                                           //                             fontFamily:
//                                           //                                 "Poppins"),
//                                           //                   ),
//                                           //                   Text(
//                                           //                     'paidTotal',
//                                           //                     // 'د.إ${bookings[index].paidTotal}',
//                                           //                     style: Theme.of(
//                                           //                             context)
//                                           //                         .textTheme
//                                           //                         .bodyMedium!
//                                           //                         .copyWith(
//                                           //                             color: Color(
//                                           //                                 0XFFFFFFFF),
//                                           //                             fontWeight:
//                                           //                                 FontWeight
//                                           //                                     .w600,
//                                           //                             fontFamily:
//                                           //                                 "Poppins"),
//                                           //                   ),
//                                           //                 ],
//                                           //               ),
//                                           //             ),
//                                           //           )
//                                           //         ],
//                                           //       ),
//                                           //     ) :
//                                           Padding(
//                                         padding: EdgeInsets.only(
//                                             left: sizeWidth * .05,
//                                             right: sizeWidth * .05),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Container(
//                                               height: sizeHeight * .03,
//                                             ),
//                                             Text(
//                                               bookings
//                                                   .bookings![index].bookingDate
//                                                   .toString(),
//                                               // DateFormat.yMMMMd('en_US')
//                                               //     .format(DateTime.parse(
//                                               //         bookings[index]
//                                               //             .transactionMadeon
//                                               //             .toString())),
//                                               style: Theme.of(context)
//                                                   .textTheme
//                                                   .bodyMedium!
//                                                   .copyWith(
//                                                       fontFamily: "Poppins",
//                                                       color: MyAppState.mode ==
//                                                               ThemeMode.light
//                                                           ? AppColors.themeColor
//                                                           : AppColors.white,
//                                                       fontWeight:
//                                                           FontWeight.w600),
//                                             ),
//                                             Container(
//                                               height: sizeHeight * .01,
//                                             ),
//                                             Container(
//                                               height: sizeHeight * .28,
//                                               decoration: BoxDecoration(
//                                                   color: MyAppState.mode ==
//                                                           ThemeMode.light
//                                                       ? AppColors.grey200
//                                                       : const Color(0XFFFFFFFF),
//                                                   borderRadius:
//                                                       const BorderRadius.only(
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   12),
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   12))),
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: sizeWidth * .05,
//                                                     right: sizeWidth * .05),
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     flaxibleGap(
//                                                       2,
//                                                     ),
//                                                     Text(
//                                                       bookings.bookings![index]
//                                                           .playerName
//                                                           .toString(),
//                                                       // '${bookings[index].user!.first_name} ${bookings[index].user!.last_name}',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyMedium!
//                                                           .copyWith(
//                                                               color: AppColors
//                                                                   .themeColor,
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w500),
//                                                     ),
//                                                     flaxibleGap(
//                                                       1,
//                                                     ),
//                                                     Text('sessionName',
//                                                         // "${bookings[index].event!.name}",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyMedium!
//                                                             .copyWith(
//                                                                 color: Color(
//                                                                     0XFF424242),
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600)),
//                                                     Text('dateTime',
//                                                         // DateFormat.yMMMMd(
//                                                         //         'en_US')
//                                                         //     .format(DateTime.parse(bookings[
//                                                         //             index]
//                                                         //         .event!
//                                                         //         .startDate
//                                                         //         .toString())),
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyMedium!
//                                                             .copyWith(
//                                                                 color: Color(
//                                                                     0XFF25A163),
//                                                                 fontFamily:
//                                                                     "Poppins",
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600)),
//                                                     flaxibleGap(
//                                                       2,
//                                                     ),
//                                                     Text(
//                                                         "${AppLocalizations.of(context)!.tranjectionId} : ",
//                                                         style: Theme.of(context)
//                                                             .textTheme
//                                                             .bodyMedium!
//                                                             .copyWith(
//                                                                 color: AppColors
//                                                                     .appThemeColor,
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .w600)),
//                                                     flaxibleGap(
//                                                       2,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                             Container(
//                                               height: sizeHeight * .08,
//                                               decoration: const BoxDecoration(
//                                                   color:
//                                                       AppColors.appThemeColor,
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   12),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   12))),
//                                               child: Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: sizeWidth * .05,
//                                                     right: sizeWidth * .05),
//                                                 child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment
//                                                           .spaceBetween,
//                                                   children: [
//                                                     Text(
//                                                       AppLocalizations.of(
//                                                               context)!
//                                                           .paidTotal,
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyMedium!
//                                                           .copyWith(
//                                                               color: Color(
//                                                                   0XFFFFFFFF),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontFamily:
//                                                                   "Poppins"),
//                                                     ),
//                                                     Text(
//                                                       'paid',
//                                                       // 'د.إ${bookings[index].paidTotal}',
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .bodyMedium!
//                                                           .copyWith(
//                                                               color: Color(
//                                                                   0XFFFFFFFF),
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600,
//                                                               fontFamily:
//                                                                   "Poppins"),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       );
//                                     }),
//                               ),
//                             ],
//                           ),
//                         ),
//                       )
//                 : InternetLoss(
//                     onChange: () {
//                       setState(() {
//                         state = true;
//                         _networkCalls.checkInternetConnectivity(
//                             onSuccess: (msg) {
//                           internet = msg;
//                           if (msg == true) {
//                             loadBookings();
//                           } else {
//                             setState(() {
//                               state = false;
//                             });
//                           }
//                         });
//                       });
//                     },
//                   ));
//   }
//
//   bool checkdate({int? index}) {
//     if (date ==
//         DateFormat.yMMMMd('en_US')
//             .format(DateTime.parse(DateTime.now().timeZoneName
//                 // bookings[index!].transactionMadeon.toString()
//                 ))) {
//       return true;
//     } else {
//       date = DateFormat.yMMMMd('en_US')
//           .format(DateTime.parse(DateTime.now().timeZoneName
//               // bookings[index].transactionMadeon.toString()
//               ));
//       return false;
//     }
//   }
// }
