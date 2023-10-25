import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../modelClass/bookingModelClass.dart';
import '../../../../app_colors/app_colors.dart';

// ignore: must_be_immutable
class BookingsWidget extends StatefulWidget {
  List<BookingModelClass>? bookingDetail;
  BookingsWidget({super.key, this.bookingDetail});
  @override
  State<BookingsWidget> createState() => _BookingsWidgetState();
}

class _BookingsWidgetState extends State<BookingsWidget> {
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? const Color(0XFFF7F7F7)
          : AppColors.darkTheme,
      body: widget.bookingDetail == null || widget.bookingDetail!.isEmpty
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
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.bookingDetail!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    navigateToPitchBookingDetails(widget.bookingDetail![index]);
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
                                  borderRadius: BorderRadius.circular(200.0),
                                  child: cachedNetworkImage(
                                      height: sizeHeight * .08,
                                      cuisineImageUrl: widget
                                          .bookingDetail![index]
                                          .user
                                          ?.profile_pic
                                          ?.filePath,
                                      placeholder:
                                          'assets/images/profile.png'))),
                          flaxibleGap(1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              flaxibleGap(1),
                              Text(
                                  widget.bookingDetail![index].user!.name
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.themeColor
                                                : AppColors.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: "Poppins",
                                      )),
                              Text(
                                  "${widget.bookingDetail![index].pitchType!.area} ${widget.bookingDetail![index].pitchType!.name}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? const Color(0XFF696969)
                                                : AppColors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                      )),
                              widget.bookingDetail![index].booking_cancelled!
                                  ? Text(AppLocalizations.of(context)!.canceled,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: AppColors.barLineColor,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins",
                                          ))
                                  : Row(
                                      children: [
                                        Text(
                                            "${AppLocalizations.of(context)!.slots}: ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  color: Color(0XFFADADAD),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Poppins",
                                                )),
                                        SizedBox(
                                          height: 15,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: widget
                                                .bookingDetail![index]
                                                .slots!
                                                .booked_slots!
                                                .length,
                                            itemBuilder: (context, blockindex) {
                                              return Text(
                                                  '(${timing(x: int.parse(widget.bookingDetail![index].slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookingDetail![index].slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? AppColors
                                                                .barLineColor
                                                            : AppColors.white,
                                                      ));
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                              flaxibleGap(1),
                            ],
                          ),
                          flaxibleGap(8),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }

  void navigateToPitchBookingDetails(BookingModelClass detail) {
    Navigator.pushNamed(context, RouteNames.pitchBookingDetails,
        arguments: detail);
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
