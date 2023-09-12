import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/vanueList.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../utils.dart';

class ViewMoreBookPitchScreen extends StatefulWidget {
  Map pitchType;

  ViewMoreBookPitchScreen({required this.pitchType});

  @override
  _ViewMoreBookPitchScreenState createState() =>
      _ViewMoreBookPitchScreenState();
}

class _ViewMoreBookPitchScreenState extends State<ViewMoreBookPitchScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  var bookPitchData;
  bool _isLoading = true;
  bool _internet = true;

  loadBookPitch() async {
    await _networkCalls.bookpitch(
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            bookPitchData = pitchInfo;
            _isLoading = false;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
      urldetail: '',
    );
  }

  loadBookPitchFilter() async {
    await _networkCalls.bookpitchFilter(
      detail: widget.pitchType,
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            bookPitchData = pitchInfo;
            _isLoading = false;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) showMessage(msg);
        Timer(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
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
      _internet = msg;
      if (msg == true) {
        if (mounted) {
          widget.pitchType["bool"] ? loadBookPitchFilter() : loadBookPitch();
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    var sizeHeight = MediaQuery.of(context).size.height;
    return _isLoading
        ? _buildShimmer(sizeWidth, sizeHeight)
        : _internet
            ? Scaffold(
                backgroundColor: Colors.black,
                appBar: PreferredSize(
                  preferredSize: Size(sizeWidth, sizeHeight * 0.13),
                  child: AppBar(
                    title: Text(
                      AppLocalizations.of(context)!.bookPitch,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.white),
                    ),
                    centerTitle: true,
                    backgroundColor: Colors.black,
                    leadingWidth: sizeWidth * 0.18,
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: sizeHeight * 0.004,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                shape: BoxShape.circle),
                            child: Icon(
                              AppLocalizations.of(context)!.locale == 'en'
                                  ? Icons.keyboard_arrow_left_sharp
                                  : Icons.keyboard_arrow_right,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  height: sizeHeight,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : const Color(0xff5A5C60),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        VanueList(
                          bookPitchData: bookPitchData,
                          tagForView: false,
                        ),
                      ],
                    ),
                  ),
                ))
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadBookPitch();
                    }
                  });
                },
              );
  }

  void navigateToDetail3(dynamic bookPitchData) {
    Navigator.pushNamed(context, RouteNames.bookPitch,
        arguments: bookPitchData);
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Material(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(sizeWidth, sizeHeight * 0.13),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.bookPitch,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
            centerTitle: true,
            backgroundColor: Colors.black,
            leadingWidth: sizeWidth * 0.18,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                    height: sizeHeight * 0.004,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        shape: BoxShape.circle),
                    child: Icon(
                      AppLocalizations.of(context)!.locale == 'en'
                          ? Icons.keyboard_arrow_left_sharp
                          : Icons.keyboard_arrow_right,
                      color: Colors.white,
                    )),
              ),
            ),
          ),
        ),
        body: Container(
          height: sizeHeight,
          decoration: BoxDecoration(
              color: MyAppState.mode == ThemeMode.light
                  ? Colors.white
                  : const Color(0xff5A5C60),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.only(
                left: sizeWidth * .04,
                right: sizeWidth * .04,
                top: sizeHeight * .03),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade100,
              highlightColor: Colors.grey.shade300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                      5,
                      (index) => Padding(
                        padding: EdgeInsets.only(bottom: sizeHeight * 0.03),
                        child: Container(
                          padding: EdgeInsets.only(bottom: sizeHeight * 0.03),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xffffffff),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              const BoxShadow(
                                color: Color(0x0f050818),
                                offset: Offset(10, 40),
                                blurRadius: 30,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin:
                                    EdgeInsets.only(bottom: sizeHeight * 0.02),
                                width: sizeWidth,
                                height: sizeHeight * 0.1,
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15),
                                    ),
                                    child: Image.asset('assets/images/T.png')),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: sizeHeight * 0.001,
                                    bottom: sizeHeight * 0.001),
                                child: Text(
                                  'name',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.25,
                                    color: const Color(0xffffffff),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: sizeHeight * 0.017,
                                        left: sizeHeight * 0.017),
                                    width: 24,
                                    height: 24,
                                    child: Image.asset(
                                      'assets/light-design/images/icon-bus.png',
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .showDirections,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846,
                                      color: const Color(0xff686868),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
