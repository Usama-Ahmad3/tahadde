import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/manageSlotScreens/edit_venue-screen_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/bookPitchModelClass.dart';
import '../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../network/network_calls.dart';

class ManageSlotsWidget extends StatefulWidget {
  const ManageSlotsWidget({super.key});

  @override
  State<ManageSlotsWidget> createState() => _ManageSlotsWidgetState();
}

class _ManageSlotsWidgetState extends State<ManageSlotsWidget> {
  final NetworkCalls _networkCalls = NetworkCalls();
  List<MyVenueModelClass> pitchDetail = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  late bool _internet;
  loadVerifiedPitch() async {
    await _networkCalls.myVenues(
      onSuccess: (event) {
        setState(() {
          _isLoading = false;
          pitchDetail = event;
        });
      },
      onFailure: (msg) {
        setState(() {
          _isLoading = false;
        });
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
      _internet = msg;
      if (msg == true) {
        loadVerifiedPitch();
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
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? const Color(0XFFF7F7F7)
          : const Color(0xff686868),
      body: _isLoading
          ? SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  _buildbodySimmer(),
                ],
              ),
            )
          : _internet
              ? pitchDetail.isEmpty
                  ? Column(
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
                            style: TextStyle(
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF424242)
                                    : Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 18)),
                        flaxibleGap(1),
                        Text(
                          AppLocalizations.of(context)!.youHaveBooked,
                          style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF7A7A7A)
                                  : Colors.white38,
                              fontFamily: "Poppins",
                              fontSize: 14),
                        ),
                        flaxibleGap(30),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: pitchDetail.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: pitchDetail[index].isDecline!
                              ? () {
                                  Map detail = {
                                    "id": pitchDetail[index].id,
                                    "name": pitchDetail[index].venueName
                                  };
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => EditVenuesScreen(
                                              detail: detail)));
                                  // navigateToEditVenues(detail);
                                  // navigateToManageSlotsDetail(pitchDetail[index]);
                                }
                              : () => showMessage(
                                  "Sorry, you can not edit verified and in-review venue"),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .04,
                                right: sizeWidth * .04,
                                top: sizeHeight * .02),
                            child: Container(
                              height: sizeHeight * .1,
                              width: sizeWidth,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                color: MyAppState.mode == ThemeMode.light
                                    ? Colors.grey.shade200
                                    : Colors.black12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(sizeHeight * .01),
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0) //
                                              ),
                                        ),
                                        child: ClipRRect(
                                            clipBehavior: Clip.hardEdge,
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5.0)),
                                            child: cachedNetworkImage(
                                                height: sizeHeight * .08,
                                                width: sizeWidth * .15,
                                                cuisineImageUrl:
                                                    pitchDetail[index]
                                                        .pitchImage))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(1),
                                      Text("${pitchDetail[index].venueName}",
                                          style: TextStyle(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "Poppins",
                                              fontSize: 16)),
                                      SizedBox(
                                        width: sizeWidth * .7,
                                        child: Text(
                                            " ${pitchDetail[index].location}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFF646464)
                                                    : Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                fontSize: 12)),
                                      ),
                                      flaxibleGap(1),
                                    ],
                                  ),
                                  flaxibleGap(4),
                                ],
                              ),
                            ),
                          ),
                        );
                      })
              : InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (msg == true) {
                        loadVerifiedPitch();
                      }
                    });
                  },
                ),
    );
  }

  Widget _buildbodySimmer() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: ListView.builder(
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0, top: 5),
            child: _shimmerCard(),
          ),
          itemCount: 5,
        ),
      ),
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

  void navigateToManageSlotsDetail(BookPitchDetail detail) {
    Navigator.pushNamed(context, RouteNames.manageSlotsDetail,
        arguments: detail);
  }

  void navigateToEditVenues(Map detail) {
    Navigator.pushNamed(context, RouteNames.editVenues, arguments: detail);
  }
}
