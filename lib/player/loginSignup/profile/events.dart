import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../modelClass/eventModelClass.dart';
import '../../../network/network_calls.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool? internet;
  bool state = true;
  String date = "name";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  late List<Event> events;

  loadEvent() async {
    await _networkCalls.bookingHistory(
      onSuccess: (event) {
        setState(() {
          state = false;
          events = event;
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
    var sizeHeight = MediaQuery
        .of(context)
        .size
        .height;
    var sizeWidth = MediaQuery
        .of(context)
        .size
        .width;
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
            ? events.isEmpty
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
            : ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: events.length,
            itemBuilder: (context, index) {
              return checkdate(index: index)
                  ? Padding(
                padding: EdgeInsets.only(
                    left: sizeWidth * .05,
                    right: sizeWidth * .05),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: sizeHeight * .03,
                    ),
                    Container(
                      height: sizeHeight * .28,
                      color: const Color(0XFFFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            flaxibleGap(
                              2,
                            ),
                            Text(
                              '${events[index].user!.first_name}${events[index]
                                  .user!.last_name}',
                              style: const TextStyle(
                                  color: Color(0XFF032040),
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w500),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                                "${events[index].event!.name}",
                                style: const TextStyle(
                                    color: Color(0XFF424242),
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 15)),
                            Text(
                                DateFormat.yMMMMd('en_US')
                                    .format(DateTime.parse(
                                    events[index]
                                        .event!
                                        .startDate
                                        .toString())),
                                style: const TextStyle(
                                    color: Color(0XFF25A163),
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                    fontWeight:
                                    FontWeight.w600)),
                            flaxibleGap(
                              2,
                            ),
                            Text(
                                "${AppLocalizations.of(context)!
                                    .tranjectionId} : ${events[index]
                                    .transactionId}",
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 15)),
                            flaxibleGap(
                              2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: sizeHeight * .08,
                      color: const Color(0XFF25A163),
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
                              'د.إ${events[index].paidTotal}',
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
              )
                  : Padding(
                padding: EdgeInsets.only(
                    left: sizeWidth * .05,
                    right: sizeWidth * .05),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: sizeHeight * .03,
                    ),
                    Text(
                      DateFormat.yMMMMd('en_US').format(
                          DateTime.parse(events[index]
                              .transactionMadeon
                              .toString())),
                      style: const TextStyle(
                          fontFamily: "Poppins",
                          color: Color(0XFF032040),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: sizeHeight * .01,
                    ),
                    Container(
                      height: sizeHeight * .28,
                      color: const Color(0XFFFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            flaxibleGap(
                              2,
                            ),
                            Text(
                              '${events[index].user!.first_name} ${events[index]
                                  .user!.last_name}',
                              style: const TextStyle(
                                  color: Color(0XFF032040),
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.w500),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                                "${events[index].event!.name}",
                                style: const TextStyle(
                                    color: Color(0XFF424242),
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 15)),
                            Text(
                                DateFormat.yMMMMd('en_US')
                                    .format(DateTime.parse(
                                    events[index]
                                        .event!
                                        .startDate
                                        .toString())),
                                style: const TextStyle(
                                    color: Color(0XFF25A163),
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                    fontWeight:
                                    FontWeight.w600)),
                            flaxibleGap(
                              2,
                            ),
                            Text(
                                "${AppLocalizations.of(context)!
                                    .tranjectionId} : ${events[index]
                                    .transactionId}",
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontWeight:
                                    FontWeight.w600,
                                    fontSize: 15)),
                            flaxibleGap(
                              2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: sizeHeight * .08,
                      color: const Color(0XFF25A163),
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
                              'د.إ${events[index].paidTotal}',
                              style: const TextStyle(
                                  color: Color(0XFFFFFFFF),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Poppins"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
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
            DateTime.parse(events[index!].transactionMadeon.toString()))) {
      return true;
    } else {
      date = DateFormat.yMMMMd('en_US')
          .format(DateTime.parse(events[index].transactionMadeon.toString()));
      return false;
    }
  }
}
