import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../modelClass/eventModelClass.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../main.dart';

class EventsScreen extends StatefulWidget {
  bool bookingTag;

  EventsScreen({super.key, this.bookingTag = false});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
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
        backgroundColor: Colors.black54,
        appBar: PreferredSize(
          preferredSize: Size(sizeWidth, sizeHeight * 0.1),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.booking,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black45,
            leadingWidth: sizeWidth * 0.18,
            leading: widget.bookingTag
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.all(sizeHeight * 0.008),
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
                  )
                : Container(),
          ),
        ),
        body: state
            ? Container(
                color: Colors.black54,
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : const Color(0xff686868),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: const Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            : internet!
                ? events.isEmpty
                    ? Container(
                        color: Colors.black54,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: MyAppState.mode == ThemeMode.light
                                  ? Colors.white
                                  : const Color(0xff686868),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                2,
                              ),
                              Text(
                                  AppLocalizations.of(context)!.noBookingsFound,
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFF424242)
                                          : Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 18)),
                              flaxibleGap(
                                32,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.black54,
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: MyAppState.mode == ThemeMode.light
                                  ? Colors.white
                                  : const Color(0xff686868),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20))),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
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
                                                    decoration: BoxDecoration(
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Colors
                                                                .grey.shade200
                                                            : const Color(
                                                                0XFFFFFFFF),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                topRight: Radius
                                                                    .circular(
                                                                        12))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: sizeWidth * .05,
                                                          right:
                                                              sizeWidth * .05),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                          Text(
                                                            '${events[index].user!.first_name}${events[index].user!.last_name}',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF032040),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          flaxibleGap(
                                                            1,
                                                          ),
                                                          Text(
                                                              "${events[index].event!.name}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF424242),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      15)),
                                                          Text(
                                                              DateFormat
                                                                      .yMMMMd(
                                                                          'en_US')
                                                                  .format(DateTime.parse(events[
                                                                          index]
                                                                      .event!
                                                                      .startDate
                                                                      .toString())),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF25A163),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                          Text(
                                                              "${AppLocalizations.of(context)!.tranjectionId} : ${events[index].transactionId}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF032040),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      15)),
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: sizeHeight * .08,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xffffc300),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        12),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        12))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: sizeWidth * .05,
                                                          right:
                                                              sizeWidth * .05),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .paidTotal,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFFFFFFFF),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                          Text(
                                                            'د.إ${events[index].paidTotal}',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFFFFFFFF),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
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
                                                    DateFormat.yMMMMd('en_US')
                                                        .format(DateTime.parse(
                                                            events[index]
                                                                .transactionMadeon
                                                                .toString())),
                                                    style: TextStyle(
                                                        fontFamily: "Poppins",
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? const Color(
                                                                0XFF032040)
                                                            : Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Container(
                                                    height: sizeHeight * .01,
                                                  ),
                                                  Container(
                                                    height: sizeHeight * .28,
                                                    decoration: BoxDecoration(
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Colors
                                                                .grey.shade200
                                                            : const Color(
                                                                0XFFFFFFFF),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        12),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        12))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: sizeWidth * .05,
                                                          right:
                                                              sizeWidth * .05),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                          Text(
                                                            '${events[index].user!.first_name} ${events[index].user!.last_name}',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF032040),
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                          flaxibleGap(
                                                            1,
                                                          ),
                                                          Text(
                                                              "${events[index].event!.name}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF424242),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      15)),
                                                          Text(
                                                              DateFormat
                                                                      .yMMMMd(
                                                                          'en_US')
                                                                  .format(DateTime.parse(events[
                                                                          index]
                                                                      .event!
                                                                      .startDate
                                                                      .toString())),
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF25A163),
                                                                  fontSize: 15,
                                                                  fontFamily:
                                                                      "Poppins",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                          Text(
                                                              "${AppLocalizations.of(context)!.tranjectionId} : ${events[index].transactionId}",
                                                              style: const TextStyle(
                                                                  color: Color(
                                                                      0XFF032040),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      15)),
                                                          flaxibleGap(
                                                            2,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: sizeHeight * .08,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xffffc300),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            12),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        12))),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: sizeWidth * .05,
                                                          right:
                                                              sizeWidth * .05),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .paidTotal,
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFFFFFFFF),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                          Text(
                                                            'د.إ${events[index].paidTotal}',
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFFFFFFFF),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    "Poppins"),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      )
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
