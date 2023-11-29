import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/common_widgets/internet_loss.dart';
import 'package:flutter_tahaddi/homeFile/routingConstant.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../../pitchOwner/loginSignupPitchOwner/createSession.dart';

class EnterDetailAcademyScreen extends StatefulWidget {
  final dynamic detail;
  const EnterDetailAcademyScreen({super.key, this.detail});

  @override
  State<EnterDetailAcademyScreen> createState() => _EnterDetailPitchScreen();
}

class _EnterDetailPitchScreen extends State<EnterDetailAcademyScreen> {
  final focus = FocusNode();
  late bool internet;
  final GlobalKey _textKey = GlobalKey();
  bool monVal = false;
  bool loading = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late Map profileDetail;
  List<int> sessionList = [];
  List<BookedSessions> bookedSessions = [];

  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
        });
      },
      onFailure: (msg) {},
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  privacyPolicy(String text) async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  loadSpecificSession() {
    list.forEach((id) async {
      await _networkCalls.specificSession(
        id: id.toString(),
        onSuccess: (event) async {
          BookedSessions session = BookedSessions.fromJson(event);
          bookedSessions.add(session);
          if (mounted) {
            setState(() {
              loading = false;
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
    });
  }

  var list = [];
  @override
  void initState() {
    super.initState();
    print(widget.detail);
    list = widget.detail['session'];
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
        loadSpecificSession();
        // for (int i = 0; i < list.length; i++) {
        //   sessionList.add(list[i].id!.toInt());
        //   print(sessionList);
        // }
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return Material(
        child: loading
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: appBarWidget(
                    sizeWidth: sizewidth,
                    sizeHeight: sizeheight,
                    context: context,
                    title: AppLocalizations.of(context)!.bookingDetails,
                    back: true),
                body: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: sizewidth * .05, right: sizewidth * .05),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: sizeheight * .02,
                          ),
                          Material(
                            elevation: 5,
                            color: const Color(0XFFFFFFFF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizewidth * .05,
                                  right: sizewidth * .05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: sizeheight * .01,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.slotDetails,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: const Color(0XFF032040),
                                        ),
                                  ),
                                  Container(
                                    height: sizeheight * .01,
                                  ),
                                  Text(
                                      "${AppLocalizations.of(context)!.academy} (${widget.detail["academy"]})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            color: const Color(0XFF424242),
                                          )),
                                  Text('',
                                      style: const TextStyle(
                                          color: Color(0XFF898989))),
                                  Container(
                                    height: sizeheight * .005,
                                  ),
                                  // Container(
                                  //   height: sizeheight * .15,
                                  //   child: ListView.builder(
                                  //       itemCount: keys.length,
                                  //       itemBuilder: (context, index) {
                                  //         return Column(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.start,
                                  //           children: <Widget>[
                                  //             Container(
                                  //               height: sizeheight * .005,
                                  //             ),
                                  //             Row(
                                  //               children: <Widget>[
                                  //                 dayConv(x: keys[index]),
                                  //                 Text(
                                  //                   ", ${AppLocalizations.of(context).locale == "en" ? monthFindRevers(index: widget.detail["slotdetail"]["month"]) : monthFindReversAr(index: widget.detail["slotdetail"]["month"])} ${keys[index]}, ${widget.detail["slotdetail"]["year"]}",
                                  //                   style: TextStyle(
                                  //                       color: Color(0XFF25A163)),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //             ListView.builder(
                                  //               shrinkWrap: true,
                                  //               physics: ClampingScrollPhysics(),
                                  //               itemCount: widget
                                  //                   .detail["slotdetail"]["days"]
                                  //                       [keys[index]]
                                  //                   .length,
                                  //               itemBuilder:
                                  //                   (BuildContext context,
                                  //                       int childIdx) {
                                  //                 return widget.detail["slotdetail"]
                                  //                                 ["days"]
                                  //                                 [keys[index]]
                                  //                                 [childIdx]
                                  //                             .toString()
                                  //                             .length <
                                  //                         3
                                  //                     ? Row(
                                  //                         children: <Widget>[
                                  //                           Text(
                                  //                               '${AppLocalizations.of(context).slot} : ${timing(x: widget.detail["slotdetail"]["days"][keys[index]][childIdx])}',
                                  //                               style: TextStyle(
                                  //                                   color: Color(
                                  //                                       0XFF898989))),
                                  //                           Flexible(
                                  //                             child: Container(),
                                  //                             flex: 1,
                                  //                           ),
                                  //                           // Text("${AppLocalizations.of(context).currency} ${widget.detail["detail"].grandTotal.round()}",style: TextStyle(
                                  //                           //     color: Color(
                                  //                           //         0XFF898989)))
                                  //                         ],
                                  //                       )
                                  //                     : widget.detail["slotdetail"]
                                  //                                     ["days"]
                                  //                                     [keys[index]]
                                  //                                     [childIdx]
                                  //                                 .toString()
                                  //                                 .length ==
                                  //                             5
                                  //                         ? Row(
                                  //                             children: <Widget>[
                                  //                               Text(
                                  //                                   '${AppLocalizations.of(context).slot} : ${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString()[0]))}',
                                  //                                   style: TextStyle(
                                  //                                       color: Color(
                                  //                                           0XFF898989))),
                                  //                               Text(" - "),
                                  //                               Text(
                                  //                                   '${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().length - 1)))}',
                                  //                                   style: TextStyle(
                                  //                                       color: Color(
                                  //                                           0XFF898989))),
                                  //                               Flexible(
                                  //                                 child:
                                  //                                     Container(),
                                  //                                 flex: 1,
                                  //                               ),
                                  //                               Text(
                                  //                                   '${AppLocalizations.of(context).currency} ${(int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().length - 1)) - int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString()[0])) * widget.detail["detail"].grandTotal.round()}',
                                  //                                   style: TextStyle(
                                  //                                       color: Color(
                                  //                                           0XFF898989)))
                                  //                             ],
                                  //                           )
                                  //                         : widget.detail["slotdetail"]
                                  //                                         ["days"]
                                  //                                         [keys[index]]
                                  //                                         [childIdx]
                                  //                                     .toString()
                                  //                                     .length ==
                                  //                                 6
                                  //                             ? Row(
                                  //                                 children: <
                                  //                                     Widget>[
                                  //                                   Text(
                                  //                                       '${AppLocalizations.of(context).slot} : ${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString()[0]))}',
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               Color(0XFF898989))),
                                  //                                   Text(" - "),
                                  //                                   Text(
                                  //                                       '${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(4, 6)))}',
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               Color(0XFF898989))),
                                  //                                   Flexible(
                                  //                                     child:
                                  //                                         Container(),
                                  //                                     flex: 1,
                                  //                                   ),
                                  //                                   Text(
                                  //                                       '${AppLocalizations.of(context).currency} ${(int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(4, 6)) - int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString()[0])) * widget.detail["detail"].grandTotal.round()}',
                                  //                                       style: TextStyle(
                                  //                                           color:
                                  //                                               Color(0XFF898989)))
                                  //                                 ],
                                  //                               )
                                  //                             : widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().length == 8
                                  //                                 ? Row(
                                  //                                     children: <
                                  //                                         Widget>[
                                  //                                       Text(
                                  //                                           '${AppLocalizations.of(context).slot} : ${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(0, 2)))}',
                                  //                                           style:
                                  //                                               TextStyle(color: Color(0XFF898989))),
                                  //                                       Text(
                                  //                                           " - "),
                                  //                                       Text(
                                  //                                           '${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().length - 1)))}',
                                  //                                           style:
                                  //                                               TextStyle(color: Color(0XFF898989))),
                                  //                                       Flexible(
                                  //                                         child:
                                  //                                             Container(),
                                  //                                         flex: 1,
                                  //                                       ),
                                  //                                       Text(
                                  //                                           '${AppLocalizations.of(context).currency} ${(int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString()[7])) * widget.detail["detail"].grandTotal.round()}',
                                  //                                           style:
                                  //                                               TextStyle(color: Color(0XFF898989)))
                                  //                                     ],
                                  //                                   )
                                  //                                 : widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().length == 9
                                  //                                     ? Row(
                                  //                                         children: <
                                  //                                             Widget>[
                                  //                                           Text(
                                  //                                               '${AppLocalizations.of(context).slot} : ${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(0, 2)))}',
                                  //                                               style: TextStyle(color: Color(0XFF898989))),
                                  //                                           Text(
                                  //                                               " - "),
                                  //                                           Text(
                                  //                                               '${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(7, 9)))}',
                                  //                                               style: TextStyle(color: Color(0XFF898989))),
                                  //                                           Flexible(
                                  //                                             child:
                                  //                                                 Container(),
                                  //                                             flex:
                                  //                                                 1,
                                  //                                           ),
                                  //                                           Text(
                                  //                                               '${AppLocalizations.of(context).currency} ${(int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(7, 9))) * widget.detail["detail"].grandTotal.round()}',
                                  //                                               style: TextStyle(color: Color(0XFF898989)))
                                  //                                         ],
                                  //                                       )
                                  //                                     : Row(
                                  //                                         children: <
                                  //                                             Widget>[
                                  //                                           Text(
                                  //                                               '${AppLocalizations.of(context).slot} : ${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(0, 2)))}',
                                  //                                               style: TextStyle(color: Color(0XFF898989))),
                                  //                                           Text(
                                  //                                               " - "),
                                  //                                           Text(
                                  //                                               '${timing(x: int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(5, 7)))}',
                                  //                                               style: TextStyle(color: Color(0XFF898989))),
                                  //                                           Flexible(
                                  //                                             child:
                                  //                                                 Container(),
                                  //                                             flex:
                                  //                                                 1,
                                  //                                           ),
                                  //                                           Text(
                                  //                                               '${AppLocalizations.of(context).currency} ${(int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(5, 7)) - int.parse(widget.detail["slotdetail"]["days"][keys[index]][childIdx].toString().substring(0, 2))) * widget.detail["detail"].grandTotal.round()}',
                                  //                                               style: TextStyle(color: Color(0XFF898989)))
                                  //                                         ],
                                  //                                       );
                                  //               },
                                  //             ),
                                  //             Container(
                                  //               height: sizeheight * .01,
                                  //             ),
                                  //             Container(
                                  //               height: 1,
                                  //               color: Color(0XFFD6D6D6),
                                  //             )
                                  //           ],
                                  //         );
                                  //       }),
                                  // ),
                                  Container(
                                    height: sizeheight * .01,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: sizeheight * .01,
                          ),
                          Material(
                            elevation: 5,
                            color: const Color(0XFFFFFFFF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: SizedBox(
                              child: SizedBox(
                                height: sizeheight * .2,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        flex: 3,
                                        child: Container(),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .bookingUser,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: const Color(0XFF898989)),
                                      ),
                                      flaxibleGap(1),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: 30,
                                          width: sizewidth * .5,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0) //

                                                ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(2),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: 20,
                                          width: sizewidth * .5,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0) //

                                                ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(1),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: 20,
                                          width: sizewidth * .5,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5.0) //

                                                ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(6),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: sizeheight * .01,
                          ),
                          Material(
                            elevation: 5,
                            color: const Color(0XFFFFFFFF),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: SizedBox(
                              height: sizeheight * .16,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: sizewidth * .05,
                                    right: sizewidth * .05),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    flaxibleGap(4),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .paymentSummary,
                                      style: const TextStyle(
                                          color: Color(0XFF424242)),
                                    ),
                                    flaxibleGap(2),
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!
                                              .subTotal,
                                          style: const TextStyle(
                                              color: Color(0XFF7A7A7A)),
                                        ),
                                        flaxibleGap(18),
                                        Text(
                                          '${AppLocalizations.of(context)!.currency} ${widget.detail["price"].toString()} ',
                                          style: const TextStyle(
                                              color: Color(0XFF7A7A7A)),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.tex,
                                          style: const TextStyle(
                                              color: Color(0XFF7A7A7A)),
                                        ),
                                        flaxibleGap(18),
                                        // widget.detail["detail"].tax != null
                                        //     ? Text(
                                        //         "${AppLocalizations.of(context).currency} ${widget.detail["count"] * widget.detail["detail"].tax.round()}",
                                        //         style: TextStyle(
                                        //             color: Color(0XFF7A7A7A)),
                                        //       )
                                        //     :
                                        Text(
                                          "${AppLocalizations.of(context)!.currency} 00 ",
                                          style: const TextStyle(
                                              color: Color(0XFF7A7A7A)),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                    flaxibleGap(1),
                                    Container(
                                      height: 1,
                                      color: const Color(0XFFD6D6D6),
                                    ),
                                    flaxibleGap(1),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .grandTotal,
                                          style: const TextStyle(
                                              color: Color(0XFF424242),
                                              fontWeight: FontWeight.bold),
                                        ),
                                        flaxibleGap(18),
                                        Text(
                                          '${AppLocalizations.of(context)!.currency} ${widget.detail["price"].toString()}',
                                          style: const TextStyle(
                                              color: Color(0XFF424242)),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                    flaxibleGap(3),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          fixedGap(
                            height: sizeheight * .02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Checkbox(
                                focusNode: focus,
                                autofocus: true,
                                value: monVal,
                                onChanged: (bool? value) {
                                  setState(() {
                                    monVal = value!;
                                  });
                                },
                              ),
                              SizedBox(
                                width: sizewidth * .76,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .iAgree,
                                        style: const TextStyle(
                                            color: Color(0XFFADADAD),
                                            fontSize: 15),
                                      ),
                                      TextSpan(
                                        text:
                                            " ${AppLocalizations.of(context)!.term} ",
                                        style: const TextStyle(
                                          color: Color(0XFF25A163),
                                          fontSize: 15,
                                          // decoration: TextDecoration.underline
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .ofCompany,
                                        style: const TextStyle(
                                            color: Color(0XFFADADAD),
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          fixedGap(
                            height: sizeheight * .01,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              AppLocalizations.of(context)!
                                  .cancellationsMadeWithin,
                              style: const TextStyle(
                                  color: Color(0XFFADADAD), fontSize: 11),
                            ),
                          ),
                          fixedGap(
                            height: sizeheight * .01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : internet
                ? Scaffold(
                    backgroundColor: Colors.black,
                    appBar: appBarWidget(
                        sizeWidth: sizewidth,
                        sizeHeight: sizeheight,
                        context: context,
                        title: AppLocalizations.of(context)!.bookingDetails,
                        back: true),
                    // bottomNavigationBar: monVal
                    //     ? Container(
                    //         height: sizeheight * 0.1,
                    //         padding: EdgeInsets.symmetric(
                    //             horizontal: sizewidth * 0.03,
                    //             vertical: sizeheight * 0.006),
                    //         child: ButtonWidget(
                    //             onTaped: () {},
                    //             title: Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               crossAxisAlignment: CrossAxisAlignment.center,
                    //               children: [
                    //                 Column(
                    //                   mainAxisAlignment:
                    //                       MainAxisAlignment.center,
                    //                   crossAxisAlignment:
                    //                       CrossAxisAlignment.start,
                    //                   children: <Widget>[
                    //                     Text(
                    //                       '${AppLocalizations.of(context)!.currency} ${widget.detail["price"]}',
                    //                       style: const TextStyle(
                    //                           color: Color(0XFFFFFFFF),
                    //                           fontSize: 16),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 GestureDetector(
                    //                   onTap: () {
                    //                     navigateToDetail();
                    //                   },
                    //                   child: Container(
                    //                     decoration: const BoxDecoration(
                    //                       color: Color(0XFFFFFFFF),
                    //                       borderRadius: BorderRadius.all(
                    //                         Radius.circular(5.0),
                    //                       ),
                    //                     ),
                    //                     height: sizeheight * .05,
                    //                     width: sizewidth * .3,
                    //                     alignment: Alignment.center,
                    //                     child: Text(
                    //                       AppLocalizations.of(context)!.proceed,
                    //                       style: TextStyle(
                    //                         color: Colors.black,
                    //                         fontSize:
                    //                             AppLocalizations.of(context)!
                    //                                         .locale ==
                    //                                     "en"
                    //                                 ? 17
                    //                                 : 20,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 )
                    //               ],
                    //             ),
                    //             isLoading: loading),
                    //       )
                    //     : const SizedBox.shrink(),
                    body: Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: MyAppState.mode == ThemeMode.light
                              ? Colors.white
                              : AppColors.darkTheme,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizewidth * .059),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: sizeheight * .02,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left: sizewidth * .05,
                                      right: sizewidth * .05),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .slotDetails,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : AppColors.white,
                                            ),
                                      ),
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                      Text(
                                          "${AppLocalizations.of(context)!.academyOnly} (${AppLocalizations.of(context)!.locale == 'en' ? widget.detail["academyNameEnglish"] : widget.detail["academyNameArabic"]})",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF424242)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600)),
                                      Text(
                                        widget.detail["booked_date"],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.appThemeColor
                                                    : AppColors.white,
                                                fontFamily: "Poppins"),
                                      ),
                                      ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          shrinkWrap: true,
                                          itemCount: bookedSessions.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          'en'
                                                      ? "${AppLocalizations.of(context)!.sessionName} ${bookedSessions[index].name}"
                                                      : "${AppLocalizations.of(context)!.sessionName} ${bookedSessions[index].nameArabic}",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors
                                                                  .appThemeColor
                                                              : AppColors
                                                                  .white),
                                                ),
                                                SizedBox(
                                                  height: sizeheight * 0.0054,
                                                ),
                                                SizedBox(
                                                    height: 35,
                                                    width: sizewidth * 0.5,
                                                    child: Container(
                                                      height: 30,
                                                      width: 110,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .appThemeColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: Colors.grey
                                                                  .shade50)),
                                                      child: Text(
                                                        '${bookedSessions[index].startTime.toString()} - ${bookedSessions[index].endTime.toString()}' ??
                                                            "",
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                    )),
                                              ],
                                            );
                                          }),
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: sizeheight * .01,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: SizedBox(
                                  height: sizeheight * .2,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizewidth * .05,
                                        right: sizewidth * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bookingUser,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF032040)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w500),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                          profileDetail != null
                                              ? '${profileDetail['first_name']} ${profileDetail['last_name']}'
                                              : '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF424242)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail['email']
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF898989)
                                                        : AppColors.white)),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail[
                                                        'contact_number'] ??
                                                    ""
                                                : '',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF898989)
                                                        : AppColors.white)),
                                        flaxibleGap(6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: sizeheight * .01,
                              ),
                              Material(
                                elevation: 5,
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFFFFFFFF)
                                    : AppColors.containerColorW12,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20.0)),
                                child: SizedBox(
                                  height: sizeheight * .16,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: sizewidth * .05,
                                        right: sizewidth * .05),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        flaxibleGap(4),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .paymentSummary,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF032040)
                                                      : AppColors.white,
                                                  fontWeight: FontWeight.w600),
                                        ),
                                        flaxibleGap(2),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .subTotal,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            flaxibleGap(18),
                                            Text(
                                              '${AppLocalizations.of(context)!.currency} ${widget.detail["price"].toString()} ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF7A7A7A)
                                                          : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!.tex,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                            ),
                                            flaxibleGap(18),
                                            // widget.detail["detail"].tax != null
                                            //     ? Text(
                                            //         "${AppLocalizations.of(context).currency} ${widget.detail["count"] * widget.detail["detail"].tax.round()}",
                                            //         style: TextStyle(
                                            //             color: Color(0XFF7A7A7A)),
                                            //       )
                                            //     :
                                            Text(
                                              "${AppLocalizations.of(context)!.currency} 00 ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF7A7A7A)
                                                          : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        flaxibleGap(1),
                                        Container(
                                          height: 1,
                                          color: const Color(0XFFD6D6D6),
                                        ),
                                        flaxibleGap(1),
                                        Row(
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .grandTotal,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                            flaxibleGap(18),
                                            Text(
                                              '${AppLocalizations.of(context)!.currency} ${widget.detail["price"].toString()}',
                                              style: TextStyle(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? Color(0XFF424242)
                                                      : AppColors.white),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                        flaxibleGap(3),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              fixedGap(
                                height: sizeheight * .02,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    focusNode: focus,
                                    autofocus: true,
                                    activeColor: AppColors.appThemeColor,
                                    value: monVal,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        monVal = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    width: sizewidth * .7,
                                    child: RichText(
                                      key: _textKey,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .iAgree,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFFADADAD)
                                                      : Colors.white,
                                                ),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${AppLocalizations.of(context)!.term} ",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                privacyPolicy(
                                                    "terms_and_conditions_url");
                                              },
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color:
                                                      AppColors.appThemeColor,
                                                  // decoration: TextDecoration.underline
                                                ),
                                          ),
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .ofCompany,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall!
                                                .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFFADADAD)
                                                      : Colors.white,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              fixedGap(
                                height: sizeheight * .01,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Cancellations made within 24 hours will not receive a refund.",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? const Color(0XFFADADAD)
                                                  : Colors.white,
                                          fontSize: 11),
                                ),
                              ),
                              fixedGap(
                                height: sizeheight * .01,
                              ),
                              monVal
                                  ? ButtonWidget(
                                      onTaped: () {},
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${AppLocalizations.of(context)!.currency} ${widget.detail["price"]}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: const Color(
                                                          0XFFFFFFFF),
                                                    ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: sizewidth * 0.03,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              navigateToDetail();
                                            },
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                color: Color(0XFFFFFFFF),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                              ),
                                              height: sizeheight * .04,
                                              width: sizewidth * .32,
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .proceed,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Colors.black,
                                                    ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      isLoading: loading)
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        internet = msg;
                        if (msg == true) {
                          loadProfile();
                        }
                      });
                    },
                  ));
  }

  void navigateTosucessscreen(String status) {
    var detail = {
      "price": widget.detail["price"],
      "status": status,
      "tranjectionId": "-",
      "name": widget.detail["detail"].name,
      "startingDate": widget.detail["slotdetail"],
      "pitchtype": widget.detail["pitchtype"],
      "email": widget.detail["email"],
      "apidetail": widget.detail["apidetail"],
    };
    //Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: PaymentProceed()));
    Navigator.pushNamed(
      context,
      RouteNames.paymentSuccess,
      arguments: detail,
    );
  }

  void navigateToDetail() {
    // Navigator.push(context,
    //     PageTransition(type: PageTransitionType.rightToLeft, child: Payment()));
    if (widget.detail["price"] == 0) {
      Map detailTranjection = {
        "transactionId": "default",
        "transactionMadeon": "default",
        "payment_id": "default",
      };
      var day = "0";
      var id = "0";
      widget.detail["apidetail"]["dayId"].forEach((key, value) {
        // ignore: prefer_interpolation_to_compose_strings
        day = "$day,$key";
        value.forEach((element) {
          id = "$id,$element";
        });
      });
      var detail = {
        "year": widget.detail["apidetail"]["year"],
        "month": widget.detail["apidetail"]["month"],
        "id": widget.detail["apidetail"]["id"]["id"],
        "day": day.substring(2),
        "ids": id.substring(2),
        "idsPitch": widget.detail["ids"]
      };
      String pitchDetail =
          "bookpitch&id=${detail['id']}&year=${detail['year']}&month=${detail['month']}&day=${detail['day']}&slot_ids=${detail['ids']}&pitchtype_id=${widget.detail["ids"]}";
      _networkCalls.transection(
        id: pitchDetail,
        tarnsectiondetail: detailTranjection,
        onSuccess: (msg) {
          _networkCalls.bookpitchSlotConferm(
            urlDetail: detail,
            slug: "hds",
            onSuccess: (value) {
              navigateTosucessscreen("succeeded");
            },
            onFailure: (msg) {
              showMessage(msg);
            },
            tokenExpire: () {
              if (mounted) on401(context);
            },
          );
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
        bookingPer: '',
      );
    } else {
      var detial = {
        'cart_id': widget.detail['cart_id'],
        "price": widget.detail["price"],
        "name": widget.detail["academyNameEnglish"],
        'academy_id': widget.detail['academy'],
        "detail": bookedSessions,
        "apidetail": widget.detail["booked_date"],
        "id": profileDetail['id'],
        'sessionId': list,
        'location': widget.detail['location'],
        "player_count": widget.detail["player_count"],
      };
      print(detial);
      Navigator.pushNamed(context, RouteNames.payment, arguments: detial);
    }
  }
}
