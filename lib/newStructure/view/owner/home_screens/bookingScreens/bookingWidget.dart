import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/booking_screen/booking_widget_widget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';

class BookingWidget extends StatefulWidget {
  bool fromDrawer;
  BookingWidget({super.key, this.fromDrawer = false});

  @override
  State<BookingWidget> createState() => _BookingWidgetState();
}

class _BookingWidgetState extends State<BookingWidget> {
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  var academyDetail = [];
  late bool _internet;
  loadAcademies() async {
    await _networkCalls.loadVerifiedAcademies(
      sport: '',
      onSuccess: (academies) {
        if (mounted) {
          setState(() {
            print('hi');
            academyDetail = academies;
            _isLoading = false;
            print(academyDetail);
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) {
          print('loadVenues');
          on401(context);
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadAcademies();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: widget.fromDrawer
          ? AppColors.black
          : MyAppState.mode == ThemeMode.light
              ? const Color(0XFFF7F7F7)
              : AppColors.darkTheme,
      appBar: widget.fromDrawer
          ? appBarWidget(
              sizeWidth,
              sizeHeight,
              context,
              AppLocalizations.of(context)!.myBooking,
              true,
            )
          : null,
      body: _isLoading
          ? SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildbodySimmer(widget.fromDrawer),
                ],
              ),
            )
          : _internet
              ? academyDetail.isEmpty
                  ? Container(
                      color: Colors.black54,
                      child: Container(
                        height: sizeHeight,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: widget.fromDrawer
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))
                                : BorderRadius.zero),
                        child: Column(
                          children: [
                            flaxibleGap(30),
                            SizedBox(
                                height: sizeHeight * .15,
                                width: sizeHeight * .15,
                                child: Image.asset(
                                  'assets/images/icon.png',
                                  fit: BoxFit.fill,
                                )),
                            flaxibleGap(4),
                            Text(AppLocalizations.of(context)!.noBookingsFound,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFF424242)
                                          : AppColors.white,
                                      fontFamily: "Poppins",
                                    )),
                            flaxibleGap(1),
                            Text(
                              AppLocalizations.of(context)!.youHaveBooked,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF7A7A7A)
                                        : Colors.white38,
                                    fontFamily: "Poppins",
                                  ),
                            ),
                            flaxibleGap(30),
                          ],
                        ),
                      ))
                  : Container(
                      color: Colors.black54,
                      child: Container(
                        height: sizeHeight,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: widget.fromDrawer
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))
                                : BorderRadius.zero),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: academyDetail.length,
                            itemBuilder: (context, index) {
                              return BookingWidgetWidget(
                                academyDetail: academyDetail[index],
                              );
                            }),
                      ))
              : InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (msg == true) {
                        loadAcademies();
                      }
                    });
                  },
                ),
    );
  }

  Widget _buildbodySimmer(bool drawer) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      color: Colors.black54,
      child: Container(
          height: drawer ? height * 0.85 : 0.8,
          decoration: BoxDecoration(
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.white
                  : AppColors.darkTheme,
              borderRadius: widget.fromDrawer
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))
                  : BorderRadius.zero),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: ListView.builder(
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 8.0, top: 5),
                child: _shimmerCard(),
              ),
              itemCount: 5,
            ),
          )),
    );
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0) //

                      ),
                ),
              ),
            ),
            flaxibleGap(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }
}
