import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/pitchModelClass.dart';
import '../../../network/network_calls.dart';

class Pitch extends StatefulWidget {
  const Pitch({super.key});

  @override
  _PitchState createState() => _PitchState();
}

class _PitchState extends State<Pitch> {
  bool? internet;
  bool state = true;
  String date = "name";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  List<PitchHistory> pitch = [];

  loadEvent() async {
    await _networkCalls.bookingHistoryPitch(
      onSuccess: (event) {
        setState(() {
          state = false;
          pitch.clear();
          pitch = event;
        });
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  Future onWillPop(Map detail) {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: const Text("You are going to cancel your booking."),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      Navigator.pop(context);
                      _networkCalls.cancelBooking(
                        tarnsectiondetail: detail,
                        onSuccess: (msg) {
                          showSucess(msg, scaffoldkey);
                          loadEvent();
                        },
                        onFailure: (msg) {
                          showMessage(msg);
                        },
                        tokenExpire: () {
                          if (mounted) on401(context);
                        },
                      );
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                      }
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadEvent();
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
        backgroundColor: const Color(0XFFF0F0F0),
        body: state
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: appThemeColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0XFF25A163),
                  ),
                ),
              )
            : internet!
                ? pitch.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          flaxibleGap(
                            30,
                          ),
                          SizedBox(
                              height: sizeHeight * .15,
                              width: sizeHeight * .15,
                              child: Image.asset(
                                'assets/images/icon.png',
                                fit: BoxFit.fill,
                              )),
                          flaxibleGap(
                            4,
                          ),
                          Text(AppLocalizations.of(context)!.noBookingsFound,
                              style: const TextStyle(
                                  color: Color(0XFF424242),
                                  fontFamily: "Poppins",
                                  fontSize: 18)),
                          flaxibleGap(
                            32,
                          ),
                        ],
                      )
                    : ListView.separated(
                        scrollDirection: Axis.vertical,
                        itemCount: pitch.length,
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                            ),
                            child: Material(
                              elevation: 5,
                              color: const Color(0XFFFFFFFF),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: sizeHeight * .03,
                                  ),
                                  Container(
                                    color: const Color(0XFFFFFFFF),
                                    padding: EdgeInsets.only(
                                        left: sizeWidth * .05,
                                        right: sizeWidth * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: 200,
                                              child: Text(
                                                '${pitch[index].user!.first_name} ${pitch[index].user!.last_name}',
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontSize: 20,
                                                    height: 1.0,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            pitch[index].booking_cancelled!
                                                ? Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .canceled,
                                                    style: const TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      Map detail = {
                                                        "transaction_for":
                                                            "bookpitch",
                                                        "event_id": pitch[index]
                                                            .bookpitch!
                                                            .id,
                                                        "payment_id":
                                                            pitch[index]
                                                                .payment_id,
                                                        "booked_for_date":
                                                            pitch[index]
                                                                .slotDate
                                                      };
                                                      onWillPop(detail);
                                                    },
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .booked,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF25A163),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                        Text(
                                            "${AppLocalizations.of(context)!.venueName}: ${pitch[index].bookpitch!.name}",
                                            style: const TextStyle(
                                                color: Color(0XFF424242),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15)),
                                        Text(
                                            "${AppLocalizations.of(context)!.subVenueName}: ${pitch[index].pitchType!.name}",
                                            style: const TextStyle(
                                                color: Color(0XFF898989),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12)),
                                        Text(
                                            DateFormat.yMMMMd('en_US').format(
                                                DateTime.parse(pitch[index]
                                                    .slotDate
                                                    .toString())),
                                            style: const TextStyle(
                                                color: Color(0XFF25A163),
                                                fontSize: 15,
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w600)),
                                        SizedBox(
                                          height: 40,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const ClampingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              itemCount: pitch[index]
                                                  .slots!
                                                  .booked_slots!
                                                  .length,
                                              itemBuilder:
                                                  (context, indexInner) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 80,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: const Color(
                                                            0XFF25A163),
                                                        border: Border.all(
                                                            color: const Color(
                                                                0XFF25A163))),
                                                    child: Text(
                                                      pitch[index]
                                                          .slots!
                                                          .booked_slots![
                                                              indexInner]!
                                                          .startTime!
                                                          .substring(0, 5)
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                                // return Row(
                                                //   children: <Widget>[
                                                //     Text(
                                                //         "${pitch[index].slots.booked_slots[indexInner].startTime.substring(0, 5)}",
                                                //         style: TextStyle(
                                                //             color: Color(
                                                //                 0XFF25A163),
                                                //             fontSize: 15,
                                                //             fontFamily:
                                                //                 "Poppins",
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .w600)),
                                                //     Text(" - ",
                                                //         style: TextStyle(
                                                //             color: Color(
                                                //                 0XFF25A163),
                                                //             fontSize: 15,
                                                //             fontFamily:
                                                //                 "Poppins",
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .w600)),
                                                //     Text(
                                                //         "${pitch[index].slots.booked_slots[indexInner].endTime.substring(0, 5)}",
                                                //         style: TextStyle(
                                                //             color: Color(
                                                //                 0XFF25A163),
                                                //             fontSize: 15,
                                                //             fontFamily:
                                                //                 "Poppins",
                                                //             fontWeight:
                                                //                 FontWeight
                                                //                     .w600)),
                                                //   ],
                                                // );
                                              }),
                                        ),
                                        Text(
                                            "${AppLocalizations.of(context)!.tranjectionId}: ${pitch[index].payment_id}",
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: sizeHeight * .08,
                                    decoration: const BoxDecoration(
                                      color: Color(0XFF25A163),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: sizeWidth * .05,
                                          right: sizeWidth * .05),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            AppLocalizations.of(context)!
                                                .paidTotal,
                                            style: const TextStyle(
                                                color: Color(0XFFFFFFFF),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins"),
                                          ),
                                          Text(
                                            'د.إ${pitch[index].paidTotal}',
                                            style: const TextStyle(
                                                color: Color(0XFFFFFFFF),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: "Poppins"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })
                : InternetLoss(
                    onChange: () {
                      setState(() {
                        state = true;
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          internet = msg;
                          if (msg == true) {
                            loadEvent();
                          } else {
                            setState(() {
                              state = false;
                            });
                          }
                        });
                      });
                    },
                  ));
  }

  bool checkdate({int? index}) {
    if (date ==
        DateFormat.yMMMMd('en_US').format(
            DateTime.parse(pitch[index!].transactionMadeon.toString()))) {
      return true;
    } else {
      date = DateFormat.yMMMMd('en_US')
          .format(DateTime.parse(pitch[index].transactionMadeon.toString()));
      return false;
    }
  }

  String timing({String? y}) {
    int x = int.parse(y!.substring(0, 2));
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
