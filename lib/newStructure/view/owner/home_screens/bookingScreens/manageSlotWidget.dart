import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/manageSlotScreens/edit_academy-screen_main.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/bookPitchModelClass.dart';
import '../../../../../network/network_calls.dart';

class ManageSlotsWidget extends StatefulWidget {
  const ManageSlotsWidget({super.key});

  @override
  State<ManageSlotsWidget> createState() => _ManageSlotsWidgetState();
}

class _ManageSlotsWidgetState extends State<ManageSlotsWidget> {
  final NetworkCalls _networkCalls = NetworkCalls();
  List<AcademyModel> academyDetail = [];
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  late bool _internet;
  loadAllAcademies() async {
    await _networkCalls.allAcademies(
      onSuccess: (event) {
        setState(() {
          _isLoading = false;
          academyDetail = event;
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
        loadAllAcademies();
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
          : AppColors.darkTheme,
      body: _isLoading
          ? SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  _buildbodySimmer(),
                ],
              ),
            )
          : _internet
              ? academyDetail.isEmpty
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
                          style:
                              Theme.of(context).textTheme.titleSmall!.copyWith(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF7A7A7A)
                                        : Colors.white38,
                                    fontFamily: "Poppins",
                                  ),
                        ),
                        flaxibleGap(30),
                      ],
                    )
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: academyDetail.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (academyDetail[index].status != 'In Review') {
                              Map detail = {
                                "id": academyDetail[index].academyId,
                                "name": academyDetail[index].academyNameEnglish
                              };
                              navigateToEditAcademies(detail);
                            } else {
                              showMessage(AppLocalizations.of(context)!
                                  .pendingApproval);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .059,
                                right: sizeWidth * .059,
                                top: sizeHeight * .02),
                            child: Container(
                              height: sizeHeight * .1,
                              width: sizeWidth,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                color: MyAppState.mode == ThemeMode.light
                                    ? AppColors.grey200
                                    : AppColors.containerColorW12,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(sizeHeight * .007),
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
                                                    academyDetail[index]
                                                            .academyImage!
                                                            .isNotEmpty
                                                        ? academyDetail[index]
                                                            .academyImage![0]
                                                        : ''))),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(1),
                                      SizedBox(
                                        width: sizeWidth * 0.65,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? "${academyDetail[index].academyNameEnglish!.length > 15 ? academyDetail[index].academyNameEnglish!.substring(0, 15) : academyDetail[index].academyNameEnglish}"
                                                    : "${academyDetail[index].academyNameArabic!.length > 15 ? academyDetail[index].academyNameArabic!.substring(0, 15) : academyDetail[index].academyNameArabic}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.themeColor
                                                          : AppColors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontFamily: "Poppins",
                                                    )),
                                            academyDetail[index].status ==
                                                    "Verified"
                                                ? const Icon(
                                                    Icons.gpp_good_outlined,
                                                    color:
                                                        AppColors.appThemeColor,
                                                  )
                                                : Text(
                                                    academyDetail[index]
                                                        .status
                                                        .toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium!
                                                        .copyWith(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors.red
                                                              : AppColors.red,
                                                          fontFamily: "Poppins",
                                                        )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: sizeWidth * .7,
                                        child: Text(
                                            "${academyDetail[index].academyLocation}",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? const Color(0XFF646464)
                                                      : AppColors.grey,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                )),
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
                        loadAllAcademies();
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

  void navigateToEditAcademies(Map detail) {
    print(detail);
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => EditAcademyScreen(detail: detail)));
    // Navigator.pushNamed(context, RouteNames.editVenues, arguments: detail);
  }
}
