import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/booked_model.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/booking_screen/academy_booking_details.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class BookingSummaryList extends StatefulWidget {
  Map detail;
  BookingSummaryList({super.key, required this.detail});
  @override
  State<BookingSummaryList> createState() => _BookingSummaryListState();
}

class _BookingSummaryListState extends State<BookingSummaryList> {
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
    separateListbefore();
    separateListAfter();
  }

  List<dynamic> reversedItemAfter = [];
  List<dynamic> reversedItemAfterCurrent = [];
  List<dynamic> reversedItemBefore = [];
  separateListbefore() {
    final reversed = bookedModel.reversed.toList();
    reversedItemBefore = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.isBefore(currentDateWithoutTime);
    }).toList();

    print(reversedItemBefore.length);
  }

  separateListAfter() {
    final reversed = bookedModel.reversed.toList();
    reversedItemAfterCurrent = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.day == DateTime.now().day;
    }).toList();
    print('shdgdg');
    print(reversedItemAfter.length);
    reversedItemAfter = reversed.where((element) {
      DateTime bookedDate = DateTime.parse(element.bookedDate ?? '2023-11-28');
      DateTime currentDate = DateTime.now();
      DateTime currentDateWithoutTime = DateTime(
        currentDate.year,
        currentDate.month,
        currentDate.day,
      );
      return bookedDate.isAfter(currentDateWithoutTime);
    }).toList();
    reversedItemAfter.addAll(reversedItemAfterCurrent);
    print(reversedItemAfter.length);
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)!.bookingSummary,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: AppColors.white),
            ),
            centerTitle: true,
            backgroundColor: AppColors.black,
            leadingWidth: sizeWidth * 0.13,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                  height: sizeHeight * 0.03,
                  child: Image.asset(
                    'assets/images/back.png',
                    color: AppColors.white,
                  )),
            ),
            bottom: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              unselectedLabelColor: AppColors.grey,
              dividerColor: AppColors.black,
              indicatorColor: AppColors.appThemeColor,
              isScrollable: true,
              physics: const AlwaysScrollableScrollPhysics(),
              // indicator: BoxDecoration(
              //   color: Color(0xff1d7e55),
              //   borderRadius: BorderRadius.circular(8),
              // ),
              padding: EdgeInsets.symmetric(vertical: sizeHeight * 0.003),
              tabs: [
                SizedBox(
                  width: sizeWidth * 0.34,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(sizeHeight * 0.01),
                    child: Text(
                      AppLocalizations.of(context)!.onGoing,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  )),
                ),
                SizedBox(
                  width: sizeWidth * 0.34,
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(sizeHeight * 0.012),
                    child: Text(
                      AppLocalizations.of(context)!.complete,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  )),
                ),
              ],
            ),
          ),
          body: loading
              ? Container(
                  height: sizeHeight * 0.9,
                  width: sizeWidth,
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.2),
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
              : Container(
                  height: sizeHeight,
                  width: sizeWidth,
                  // padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: LayoutBuilder(builder: (context, constraints) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxHeight: constraints.maxHeight),
                              child: TabBarView(
                                children: [
                                  reversedItemAfter.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .noBookingsFound,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontFamily: "Poppins",
                                                    )),
                                            flaxibleGap(1),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .youHaveBooked,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF7A7A7A)
                                                        : Colors.white38,
                                                    fontFamily: "Poppins",
                                                  ),
                                            ),
                                            flaxibleGap(30),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                              itemCount:
                                                  reversedItemAfter.length,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    reversedItemAfter[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    navigateToAcademyBookingDetails(
                                                        item,
                                                        item.bookedSession
                                                            as List);
                                                  },
                                                  child: bookingList(sizeWidth,
                                                      sizeHeight, item),
                                                );
                                              }),
                                        ),
                                  reversedItemBefore.isEmpty
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .noBookingsFound,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? const Color(
                                                              0XFF424242)
                                                          : AppColors.white,
                                                      fontFamily: "Poppins",
                                                    )),
                                            flaxibleGap(1),
                                            Text(
                                              AppLocalizations.of(context)!
                                                  .youHaveBooked,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0XFF7A7A7A)
                                                        : Colors.white38,
                                                    fontFamily: "Poppins",
                                                  ),
                                            ),
                                            flaxibleGap(30),
                                          ],
                                        )
                                      : Align(
                                          alignment: Alignment.topCenter,
                                          child: ListView.builder(
                                              itemCount:
                                                  reversedItemBefore.length,
                                              physics:
                                                  const AlwaysScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                final item =
                                                    reversedItemBefore[index];
                                                return GestureDetector(
                                                  onTap: () {
                                                    navigateToAcademyBookingDetails(
                                                        item,
                                                        item.bookedSession
                                                            as List);
                                                  },
                                                  child: bookingList(sizeWidth,
                                                      sizeHeight, item),
                                                );
                                              }),
                                        ),
                                ],
                              )),
                        ],
                      ),
                    );
                  }),
                )),
    );
  }

  void navigateToAcademyBookingDetails(BookedModel detail, List sessionIds) {
    // Navigator.pushNamed(context, RouteNames.pitchBookingDetails,
    //     arguments: detail);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AcademyBookingDetails(
              bookedSessionIds: sessionIds, bookindDetail: detail),
        ));
  }

  ///whole widget of booking detail list
  Widget bookingList(sizeWidth, sizeHeight, bookedModel) {
    return Padding(
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
              : AppColors.containerColorW12,
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
                    borderRadius: BorderRadius.circular(200.0),
                    child: cachedNetworkImage(
                        height: sizeHeight * .08,
                        cuisineImageUrl: bookedModel.playerPicture ?? '',
                        placeholder: 'assets/images/profile.png'))),
            flaxibleGap(1),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                flaxibleGap(1),
                Text(bookedModel.playerName.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: MyAppState.mode == ThemeMode.light
                              ? AppColors.themeColor
                              : AppColors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins",
                        )),
                Text(
                    "${AppLocalizations.of(context)!.bookedFor}: ${bookedModel.bookedDate}",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: MyAppState.mode == ThemeMode.light
                              ? const Color(0XFF696969)
                              : AppColors.grey,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins",
                        )),
                Row(
                  children: [
                    Text(AppLocalizations.of(context)!.bookedFor,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: const Color(0XFFADADAD),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins",
                            )),
                    Text(
                        " ${bookedModel.playerCount.toString()} ${bookedModel.playerCount!.toInt() == 1 ? AppLocalizations.of(context)!.player : AppLocalizations.of(context)!.players}",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.barLineColor
                                  : AppColors.white,
                            )),
                  ],
                ),
                flaxibleGap(1),
              ],
            ),
            flaxibleGap(8),
            AppLocalizations.of(context)!.locale == 'en'
                ? const Icon(Icons.keyboard_arrow_right)
                : const Icon(Icons.keyboard_arrow_left),
            SizedBox(
              width: sizeWidth * 0.01,
            )
          ],
        ),
      ),
    );
  }
}
