import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../main.dart';
import '../../network/network_calls.dart';

class EnterDetailPitch extends StatefulWidget {
  final dynamic detail;

  const EnterDetailPitch({super.key, this.detail});

  @override
  State<EnterDetailPitch> createState() => _EnterDetailPitch();
}

class _EnterDetailPitch extends State<EnterDetailPitch> {
  final focus = FocusNode();
  late bool internet;
  final GlobalKey _textKey = GlobalKey();
  bool monVal = false;
  bool loading = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late Map profileDetail;

  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
          loading = false;
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

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
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
    List<String> session = widget.detail["slotDetail"].keys.toList();
    return Material(
        child: loading
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: appBarWidget(sizewidth, sizeheight, context,
                    AppLocalizations.of(context)!.bookingDetails, true),
                body: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : const Color(0xff686868),
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
                                    style: const TextStyle(
                                        color: Color(0XFF032040),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Container(
                                    height: sizeheight * .01,
                                  ),
                                  Text(
                                      "${AppLocalizations.of(context)!.pitch} (${widget.detail["venueName"]})",
                                      style: const TextStyle(
                                          color: Color(0XFF424242),
                                          fontWeight: FontWeight.w600)),
                                  Text("${widget.detail["pitchType"]}",
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
                                    children: <Widget>[
                                      Flexible(
                                        flex: 3,
                                        child: Container(),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .bookingUser,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Color(0XFF898989)),
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
                    appBar: appBarWidget(sizewidth, sizeheight, context,
                        AppLocalizations.of(context)!.bookingDetails, true),
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
                              : const Color(0xff686868),
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
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        height: sizeheight * .01,
                                      ),
                                      Text(
                                          "${AppLocalizations.of(context)!.pitch} (${widget.detail["venueName"]})",
                                          style: const TextStyle(
                                              color: Color(0XFF424242),
                                              fontWeight: FontWeight.w600)),
                                      Text(
                                        widget.detail["apiDetail"]["date"],
                                        style: const TextStyle(
                                            color: Color(0XFF25A163),
                                            fontSize: 13,
                                            fontFamily: "Poppins"),
                                      ),
                                      ListView.separated(
                                          separatorBuilder: (context, index) {
                                            return const Divider();
                                          },
                                          shrinkWrap: true,
                                          itemCount: session.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  " ${AppLocalizations.of(context)!.sessionName} ${session[index]}",
                                                  style: const TextStyle(
                                                      color: Color(0XFF25A163)),
                                                ),
                                                SizedBox(
                                                  height: 40,
                                                  width: sizewidth,
                                                  child: ListView.builder(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    itemCount: widget
                                                        .detail["slotDetail"]
                                                            [session[index]]
                                                        .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int childIdx) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: 30,
                                                          width: 80,
                                                          alignment:
                                                              Alignment.center,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade50)),
                                                          child: Text(
                                                            widget.detail[
                                                                        "slotDetail"]
                                                                        [
                                                                        session[
                                                                            index]]
                                                                        [
                                                                        childIdx]
                                                                    .substring(
                                                                        0, 5) ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
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
                                color: const Color(0XFFFFFFFF),
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
                                      children: <Widget>[
                                        Flexible(
                                          flex: 3,
                                          child: Container(),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                              .bookingUser,
                                          style: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                          profileDetail != null
                                              ? '${profileDetail['first_name']} ${profileDetail['last_name']}'
                                              : '',
                                          style: const TextStyle(
                                              color: Color(0XFF424242),
                                              fontWeight: FontWeight.w600),
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail['email']
                                                : '',
                                            style: const TextStyle(
                                                color: Color(0XFF898989))),
                                        Text(
                                            profileDetail != null
                                                ? profileDetail[
                                                        'contact_number'] ??
                                                    ""
                                                : '',
                                            style: const TextStyle(
                                                color: Color(0XFF898989))),
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
                                color: const Color(0XFFFFFFFF),
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
                                          style: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        flaxibleGap(2),
                                        Row(
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .subTotal,
                                              style: const TextStyle(
                                                  color: Color(0XFF424242),
                                                  fontWeight: FontWeight.w600),
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
                                          children: <Widget>[
                                            Text(
                                              AppLocalizations.of(context)!.tex,
                                              style: const TextStyle(
                                                  color: Color(0XFF424242),
                                                  fontWeight: FontWeight.w600),
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
                                    activeColor: Colors.green,
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
                                      key: _textKey,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .iAgree,
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFFADADAD)
                                                    : Colors.white,
                                                fontSize: 15),
                                          ),
                                          TextSpan(
                                            text:
                                                " ${AppLocalizations.of(context)!.term} ",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                privacyPolicy(
                                                    "terms_and_conditions_url");
                                              },
                                            style: const TextStyle(
                                              color: Color(0XFF25A163),
                                              fontSize: 15,
                                              // decoration: TextDecoration.underline
                                            ),
                                          ),
                                          TextSpan(
                                            text: AppLocalizations.of(context)!
                                                .ofCompany,
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFFADADAD)
                                                    : Colors.white,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  "Cancellations made within 24 hours will not receive a refund.",
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFFADADAD)
                                          : Colors.white,
                                      fontSize: 11),
                                ),
                              ),
                              fixedGap(
                                height: sizeheight * .01,
                              ),
                              monVal
                                  ? Container(
                                      height: sizeheight * 0.1,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizewidth * 0.03,
                                          vertical: sizeheight * 0.006),
                                      child: ButtonWidget(
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
                                                children: <Widget>[
                                                  Text(
                                                    '${AppLocalizations.of(context)!.currency} ${widget.detail["price"]}',
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0XFFFFFFFF),
                                                        fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  navigateToDetail();
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Color(0XFFFFFFFF),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                  ),
                                                  height: sizeheight * .04,
                                                  width: sizewidth * .3,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .proceed,
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          isLoading: loading),
                                    )
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
    if (widget.detail["price"].round() == 0) {
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
        "price": widget.detail["price"].round(),
        "name": widget.detail["venueName"],
        "detail": widget.detail["slotDetail"],
        "apidetail": widget.detail["apiDetail"],
        "pitchtype": widget.detail["pitchType"],
        "ids": widget.detail["ids"],
        "subPitchId": widget.detail["subPitchId"],
        "player_count": widget.detail["player_count"],
        "slug": widget.detail["slug"]
      };
      // Navigator.pushNamed(context, RouteNames.payment, arguments: detial);
    }
  }
}
