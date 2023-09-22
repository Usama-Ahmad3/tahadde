import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/manageSlotScreens/edit_venue-screen_main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/document_screen_both.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../constant.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../network/network_calls.dart';

class MyPitches extends StatefulWidget {
  @override
  State<MyPitches> createState() => _MyPitchesState();
}

class _MyPitchesState extends State<MyPitches> {
  late bool _internet;
  bool _isLoading = true;
  String date = "name";
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  List<MyVenueModelClass> pitchDetail = [];
  loadMyPitch() async {
    await _networkCalls.myVenues(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            pitchDetail = event;
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
        loadMyPitch();
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
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: SpeedDial(
        elevation: 3,
        activeChild: Icon(
          Icons.close,
          color:
              MyAppState.mode == ThemeMode.light ? Colors.white : Colors.black,
          size: sizeHeight * 0.035,
        ),
        animationCurve: Curves.easeInOutCirc,
        spacing: sizeHeight * 0.02,
        animationDuration: const Duration(milliseconds: 300),
        mini: false,
        closeManually: true,
        isOpenOnStart: false,
        backgroundColor: MyAppState.mode == ThemeMode.light
            ? const Color(0xff686868)
            : Colors.tealAccent.shade100,
        renderOverlay: false,
        onPress: () {
          navigateToSports();
        },
        child: Icon(
          Icons.add,
          color:
              MyAppState.mode == ThemeMode.light ? Colors.white : Colors.black,
          size: sizeHeight * 0.04,
        ),
      ),
      appBar: PreferredSize(
          preferredSize: Size(sizeWidth, sizeHeight * 0.105),
          child: AppBar(
            title: Text(
              AppLocalizations.of(context)!.myAcademy,
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
            ),
          )),
      body: _isLoading
          ? Container(
              color: Colors.black54,
              child: Container(
                height: sizeHeight,
                width: sizeWidth,
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? const Color(0XFFD6D6D6)
                        : const Color(0xff686868),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: _buildBodySimmer(),
              ))
          : _internet
              ? Container(
                  color: Colors.black54,
                  child: Container(
                      height: sizeHeight,
                      width: sizeWidth,
                      decoration: BoxDecoration(
                          color: MyAppState.mode == ThemeMode.light
                              ? const Color(0XFFD6D6D6)
                              : const Color(0xff686868),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: _buildBody(sizeHeight, sizeWidth)))
              : InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (msg == true) {
                        loadMyPitch();
                      }
                    });
                  },
                ),
    );
  }

  Widget _buildBodySimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0, top: 5),
          child: _shimmerCard(),
        ),
        itemCount: 5,
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
                width: 70,
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
                    width: 200,
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
                    width: 200,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 5,
                        width: 40,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //

                              ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }

  void navigateToSports() {
    Navigator.pushNamed(context, RouteNames.selectSport, arguments: true);
  }

  Widget _buildBody(double sizeHeight, double sizeWidth) {
    return SizedBox(
      height: sizeHeight,
      width: sizeWidth,
      child: pitchDetail.isNotEmpty
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: pitchDetail.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: pitchDetail[index].isDecline! ||
                          pitchDetail[index].isVerified!
                      ? () {
                          Map detail = {
                            "id": pitchDetail[index].id,
                            "name": pitchDetail[index].venueName
                          };
                          navigateToEditVenues(detail);
                        }
                      : () => showMessage(
                          AppLocalizations.of(context)!.sorryYouEditReview),
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        _isLoading = true;
                      });
                      _networkCalls.deletePitch(
                          id: pitchDetail[index].id.toString(),
                          onSuccess: (detail) {
                            loadMyPitch();
                          },
                          onFailure: (detail) {
                            setState(() {
                              _isLoading = false;
                              showMessage(detail);
                            });
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          });
                    },
                    background: Container(
                      height: sizeHeight * 0.2,
                      color: const Color(0XFFFFE9E9),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          flaxibleGap(
                            10,
                          ),
                          Image.asset(
                            "assets/images/delete_icon.png",
                            color: Colors.red,
                            height: 20,
                            width: 20,
                          ),
                          flaxibleGap(
                            1,
                          ),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .05,
                          right: sizeWidth * .05,
                          top: sizeHeight * .02),
                      child: Container(
                        height: sizeHeight * .2,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                              //
                            ),
                            color: Colors.white),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            pitchDetail[index].isVerified!
                                ? Image.asset(
                                    "assets/images/approved_status.png",
                                    height: sizeHeight * .2,
                                    width: 20,
                                  )
                                : pitchDetail[index].isDecline!
                                    ? Image.asset(
                                        "assets/images/rejected_status.png",
                                        height: sizeHeight * .2,
                                        width: 20,
                                      )
                                    : Image.asset(
                                        "assets/images/inreview_status.png",
                                        height: sizeHeight * .2,
                                        width: 20,
                                      ),
                            flaxibleGap(
                              1,
                            ),
                            Column(
                              children: [
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: cachedNetworkImage(
                                          height: sizeHeight * .12,
                                          width: sizeHeight * .13,
                                          cuisineImageUrl:
                                              pitchDetail[index].pitchImage,
                                        ))),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: sizeHeight * .05,
                                  width: sizeHeight * .13,
                                  decoration: const BoxDecoration(
                                      color: appThemeColor,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: sizeHeight * .02,
                                      width: sizeHeight * .03,
                                      child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.circular(
                                            sizeHeight * .01),
                                        child: cachedNetworkImage(
                                            height: sizeHeight * .03,
                                            width: sizeHeight * .03,
                                            cuisineImageUrl:
                                                pitchDetail[index].sportImage,
                                            color: Colors.white,
                                            imageFit: BoxFit.fitHeight),
                                      ),
                                    ),
                                  ),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                              ],
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                flaxibleGap(
                                  1,
                                ),
                                SizedBox(
                                  width: sizeWidth * .5,
                                  child: Text("${pitchDetail[index].venueName}",
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Poppins",
                                          fontSize: 15)),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      child: Image.asset(
                                          "assets/images/location_pitch.png"),
                                    ),
                                    SizedBox(
                                      width: sizeWidth * .45,
                                      child: Text(
                                        "${pitchDetail[index].location}",
                                        style: const TextStyle(
                                            color: Color(0XFF646464),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins",
                                            fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                      ),
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Container(),
    );
  }

  void navigateToEditVenues(Map detail) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => EditVenuesScreen(detail: detail)));
    // Navigator.pushNamed(context, RouteNames.editVenues, arguments: detail);
  }
}
