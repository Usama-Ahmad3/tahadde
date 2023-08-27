import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchModelClass.dart';
import '../../network/network_calls.dart';
import '../../pitchOwner/homePitchOwner/viewMoreOwner.dart';

class ViewMoreBookPitch extends StatefulWidget {
  Map pitchType;
  ViewMoreBookPitch({required this.pitchType});
  @override
  _ViewMoreBookPitchState createState() => _ViewMoreBookPitchState();
}

class _ViewMoreBookPitchState extends State<ViewMoreBookPitch> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  late List<BookPitchDetail> bookPitchData;
  bool _isLoading = true;
  late bool _internet;
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
                key: scaffoldkey,
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  //centerTitle: true,
                  automaticallyImplyLeading: false,
                  title: Text(
                    AppLocalizations.of(context)!.bookPitch,
                    style: TextStyle(
                        fontSize: appHeaderFont,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.bold
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                body: Padding(
                  padding: EdgeInsets.only(
                      left: sizeWidth * .04, right: sizeWidth * .04),
                  child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(0),
                      children:
                          List.generate(bookPitchData?.length ?? 0, (index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToDetail3(bookPitchData[index].id);
                          },
                          child: Stack(
                            alignment:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? Alignment.bottomLeft
                                    : Alignment.bottomRight,
                            children: <Widget>[
                              LeagueListItem(
                                file: bookPitchData[index]
                                    .bookpitchfiles!
                                    .files![0]!
                                    .filePath,
                              ),
                              Padding(
                                padding:
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? const EdgeInsets.only(left: 20.0)
                                        : const EdgeInsets.only(right: 20.0),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 145,
                                      //minWidth: 50,
                                      maxHeight: 50,
                                      minHeight: 10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${bookPitchData[index].name}' ?? '',
                                        style: const TextStyle(
                                            height: 1,
                                            // letterSpacing: 1.0
                                            fontFamily: 'Poppins',
                                            fontSize: 13,
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        (bookPitchData[index].country ?? ""),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 10,
                                            color: Color(0XFF2F2F2F)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      })),
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
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0XFFFFFFFF),
            ),
          ),
          //centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.bookPitch,
            style: TextStyle(
                fontSize: appHeaderFont,
                color: const Color(0XFFFFFFFF),
                fontFamily: AppLocalizations.of(context)!.locale == "en"
                    ? "Poppins"
                    : "VIP",
                fontWeight: AppLocalizations.of(context)!.locale == "en"
                    ? FontWeight.bold
                    : FontWeight.normal),
          ),
          backgroundColor: const Color(0XFF032040),
        ),
        body: SizedBox(
          height: sizeHeight,
          child: Padding(
            padding: EdgeInsets.only(
                left: sizeWidth * .04,
                right: sizeWidth * .04,
                top: sizeHeight * .03),
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(10, (index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 130,
                        width: 160,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                      ),
                    ),
                  );
                })),
          ),
        ),
      ),
    );
  }
}
