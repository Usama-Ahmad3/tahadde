import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/routingConstant.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/modelClass/booked_model.dart';
import 'package:flutter_tahaddi/modelClass/booked_sessions.dart';
import 'package:flutter_tahaddi/modelClass/bookingModelClass.dart';
import 'package:flutter_tahaddi/modelClass/specific_academy.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/pitchOwner/bookingPitchOwner/pitchBookingDetails.dart';

// ignore: must_be_immutable
class BookingDetailScreen extends StatefulWidget {
  Map detail;
  BookingDetailScreen({super.key, required this.detail});
  @override
  State<BookingDetailScreen> createState() => _BookingDetailScreenState();
}

class _BookingDetailScreenState extends State<BookingDetailScreen> {
  NetworkCalls _networkCalls = NetworkCalls();
  List<BookedModel> bookedModel = [];
  bool loading = true;
  loadBooked() async {
    print('okay');
    await _networkCalls.totalBooking(
      id: widget.detail['id'].toString(),
      onSuccess: (academies) {
        if (mounted) {
          setState(() {
            bookedModel = academies;
            loading = false;
            // loadProfile();
            // _isLoading = false;
            // print('hi');
            // academyDetail = academies;
            // print(academyDetail);
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
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
    loadBooked();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: appBarWidget(
        sizeWidth,
        sizeHeight,
        context,
        AppLocalizations.of(context)!.bookingSummary,
        true,
      ),
      body: loading
          ? Container(
              height: sizeHeight,
              width: sizeWidth,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.appThemeColor,
                ),
              ),
            )
          : bookedModel == null || bookedModel.isEmpty
              ? Container(
                  height: sizeHeight,
                  width: sizeWidth,
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.033),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF424242)
                                        : AppColors.white,
                                    fontFamily: "Poppins",
                                  )),
                      flaxibleGap(1),
                      Text(
                        AppLocalizations.of(context)!.youHaveBooked,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: MyAppState.mode == ThemeMode.light
                                  ? const Color(0XFF7A7A7A)
                                  : Colors.white38,
                              fontFamily: "Poppins",
                            ),
                      ),
                      flaxibleGap(30),
                    ],
                  ),
                )
              : Container(
                  height: sizeHeight,
                  width: sizeWidth,
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.00),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: bookedModel.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            navigateToPitchBookingDetails(bookedModel[index],
                                bookedModel[index].bookedSession as List);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .059,
                                right: sizeWidth * .059,
                                top: sizeHeight * .02),
                            child: Container(
                              height: sizeHeight * .1,
                              width: sizeWidth * .8,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                                color: MyAppState.mode == ThemeMode.light
                                    ? AppColors.grey200
                                    : AppColors.containerColorB,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  flaxibleGap(1),
                                  SizedBox(
                                      height: sizeHeight * .08,
                                      width: sizeHeight * .08,
                                      child: ClipRRect(
                                          clipBehavior: Clip.hardEdge,
                                          borderRadius:
                                              BorderRadius.circular(200.0),
                                          child: cachedNetworkImage(
                                              height: sizeHeight * .08,
                                              cuisineImageUrl:
                                                  bookedModel[index]
                                                          .playerPicture ??
                                                      '',
                                              placeholder:
                                                  'assets/images/profile.png'))),
                                  flaxibleGap(1),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      flaxibleGap(1),
                                      Text(
                                          bookedModel[index]
                                              .playerName
                                              .toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.themeColor
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "Poppins",
                                              )),
                                      Text(
                                          "Booked For: ${bookedModel[index].bookingDate}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFF696969)
                                                    : AppColors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                              )),
                                      // widget.bookingDetail![index].booking_cancelled!
                                      //     ? Text(AppLocalizations.of(context)!.canceled,
                                      //         style: Theme.of(context)
                                      //             .textTheme
                                      //             .bodySmall!
                                      //             .copyWith(
                                      //               color: AppColors.barLineColor,
                                      //               fontWeight: FontWeight.w600,
                                      //               fontFamily: "Poppins",
                                      //             )) :
                                      Row(
                                        children: [
                                          Text("booked For ",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: Color(0XFFADADAD),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins",
                                                  )),
                                          Text(
                                              "${bookedModel[index].playerCount.toString()} player",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.barLineColor
                                                        : AppColors.white,
                                                  )),
                                        ],
                                      ),
                                      flaxibleGap(1),
                                    ],
                                  ),
                                  flaxibleGap(8),
                                  Icon(Icons.keyboard_arrow_right)
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
    );
  }

  void navigateToPitchBookingDetails(BookedModel detail, List sessionIds) {
    // Navigator.pushNamed(context, RouteNames.pitchBookingDetails,
    //     arguments: detail);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PitchBookingDetails(
              bookedSessionIds: sessionIds, bookindDetail: detail),
        ));
  }

  String timing({required int x}) {
    String day;
    switch (x) {
      case 0:
        day = "12 AM";
        break;
      case 1:
        day = "1 AM";
        break;
      case 2:
        day = "2 AM";
        break;
      case 3:
        day = "3 AM";
        break;
      case 4:
        day = "4 AM";
        break;
      case 5:
        day = "5 AM";
        break;
      case 6:
        day = "6 AM";
        break;
      case 7:
        day = "7 AM";
        break;
      case 8:
        day = "8 AM";
        break;
      case 9:
        day = "9 AM";
        break;
      case 10:
        day = "10 AM";
        break;
      case 11:
        day = "11 AM";
        break;
      case 12:
        day = "12 PM";
        break;
      case 13:
        day = "1 PM";
        break;
      case 14:
        day = "2 PM";
        break;
      case 15:
        day = "3 PM";
        break;
      case 16:
        day = "4 PM";
        break;
      case 17:
        day = "5 PM";
        break;
      case 18:
        day = "6 PM";
        break;
      case 19:
        day = "7 PM";
        break;
      case 20:
        day = "8 PM";
        break;
      case 21:
        day = "9 PM";
        break;
      case 22:
        day = "10 PM";
        break;
      default:
        day = "11 PM";
        break;
    }
    return day;
  }
}
