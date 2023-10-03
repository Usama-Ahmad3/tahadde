import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class BookingSummary extends StatefulWidget {
  var price;
  BookingSummary({super.key, this.price});
  @override
  _BookingSummary createState() => _BookingSummary();
}

class _BookingSummary extends State<BookingSummary> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  Map? profileDetail;
  bool loading = true;
  var keys;
  var now;
  bool? internet;
  final NetworkCalls _networkCalls = NetworkCalls();

  loadProfile() {
    _networkCalls.getProfile(
      onSuccess: (msg) {
        setState(() {
          profileDetail = msg;
          loading = false;
          now = DateTime.now();
        });
      },
      onFailure: (msg) {},
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
    List<String> session = widget.price["name"].keys.toList();
    return WillPopScope(
        onWillPop: () async => false,
        child: loading
            ? Scaffold(
                key: scaffoldkey,
                bottomNavigationBar: Container(
                  height: sizeheight * .1,
                  width: sizewidth,
                  color: const Color(0XFF25A163),
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.gotoHomepage,
                    style: const TextStyle(
                        color: Color(0XFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins"),
                  ),
                ),
                backgroundColor: const Color(0XFFF0F0F0),
                appBar: AppBar(
                  //centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      AppLocalizations.of(context)!.bookingSummary,
                      style: TextStyle(
                          fontSize: appHeaderFont,
                          color: const Color(0XFFFFFFFF),
                          fontFamily:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? "Poppins"
                                  : "VIP",
                          fontWeight:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                    ),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                body: SizedBox(
                  width: sizewidth,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                            itemBuilder: (_, __) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 10),
                                          child: Container(
                                            width: double.infinity,
                                            height: 300.0,
                                            color: Colors.white,
                                            padding: const EdgeInsets.only(
                                                left: 16, right: 16),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            itemCount: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : internet!
                ? Scaffold(
                    bottomNavigationBar: GestureDetector(
                      onTap: () {
                        navigateToDetail();
                      },
                      child: Container(
                        height: sizeheight * .1,
                        width: sizewidth,
                        color: const Color(0XFF25A163),
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.gotoHomepage,
                          style: const TextStyle(
                              color: Color(0XFFFFFFFF),
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins"),
                        ),
                      ),
                    ),
                    backgroundColor: const Color(0XFFF0F0F0),
                    appBar: AppBar(
                      //centerTitle: true,
                      automaticallyImplyLeading: false,
                      title: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          AppLocalizations.of(context)!.bookingSummary,
                          style: TextStyle(
                              fontSize:
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? 20
                                      : 30,
                              color: const Color(0XFFFFFFFF),
                              fontFamily:
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? "Poppins"
                                      : "VIP",
                              fontWeight:
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                        ),
                      ),
                      backgroundColor: const Color(0XFF032040),
                    ),
                    body: Column(
                      children: <Widget>[
                        Flexible(
                          flex: 2,
                          child: Container(),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizewidth * .05, right: sizewidth * .05),
                          child: Material(
                            elevation: 5,
                            color: const Color(0XFFFFFFFF),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                topRight: Radius.circular(10.0)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizewidth * .05,
                                  right: sizewidth * .05),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                    style: const TextStyle(
                                        color: Color(0XFF032040),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.venueName}: ${widget.price["venueName"]}',
                                    style: const TextStyle(
                                        color: Color(0XFF032040),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: session.length,
                                      itemBuilder: (context, index) {
                                        return Material(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                " Session Name: ${session[index]}",
                                                style: const TextStyle(
                                                    color: Color(0XFF25A163)),
                                              ),
                                              const Text(
                                                " Slots Timing Information",
                                                style: TextStyle(
                                                    color: Color(0XFF25A163)),
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: sizewidth,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: widget
                                                      .price["name"]
                                                          [session[index]]
                                                      .length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int childIdx) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        height: 30,
                                                        width: 80,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: BoxDecoration(
                                                            color: const Color(
                                                                0XFF25A163),
                                                            border: Border.all(
                                                                color: const Color(
                                                                    0XFF25A163))),
                                                        child: Text(
                                                          widget.price["name"][
                                                                      session[
                                                                          index]]
                                                                      [childIdx]
                                                                  .substring(
                                                                      0, 5) ??
                                                              "",
                                                          style:
                                                              const TextStyle(
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
                                              Container(
                                                height: sizeheight * .01,
                                              ),
                                              Container(
                                                height: 1,
                                                color: const Color(0XFFD6D6D6),
                                              )
                                            ],
                                          ),
                                        );
                                      }),
                                  Text(
                                      "${AppLocalizations.of(context)!.tranjectionId} : ${widget.price["tranjectionId"]}",
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizewidth * .05, right: sizewidth * .05),
                          child: Container(
                            height: sizeheight * .08,
                            decoration: const BoxDecoration(
                              color: Color(0XFF25A163),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(10.0),
                                  bottomLeft: Radius.circular(10.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: sizewidth * .05,
                                  right: sizewidth * .05),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context)!.paidTotal,
                                    style: const TextStyle(
                                        color: Color(0XFFFFFFFF),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Poppins"),
                                  ),
                                  Text(
                                    '${AppLocalizations.of(context)!.currency} ${widget.price["price"]} ',
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
                        ),
                        flaxibleGap(
                          18,
                        ),
                      ],
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

  void navigateToDetail() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.playerHome, (Route<dynamic> route) => false);
  }
}
