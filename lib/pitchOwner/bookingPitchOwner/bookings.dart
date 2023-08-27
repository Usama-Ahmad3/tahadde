import 'package:flutter/material.dart';

import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookingModelClass.dart';

class Bookings extends StatefulWidget {
  List<BookingModelClass>? bookingDetail;
  Bookings({this.bookingDetail});
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0XFFF7F7F7),
      body: widget.bookingDetail == null || widget.bookingDetail!.isEmpty
          ? Container(
              child: Column(
                children: <Widget>[
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
                      style: const TextStyle(
                          color: Color(0XFF424242),
                          fontFamily: "Poppins",
                          fontSize: 18)),
                  flaxibleGap(1),
                  Text(
                    AppLocalizations.of(context)!.youHaveBooked,
                    style: const TextStyle(
                        color: Color(0XFF7A7A7A),
                        fontFamily: "Poppins",
                        fontSize: 14),
                  ),
                  flaxibleGap(30),
                ],
              ),
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
                        left: sizeWidth * .05,
                        right: sizeWidth * .05,
                        top: sizeHeight * .02),
                    child: Container(
                      height: sizeHeight * .1,
                      width: sizeWidth * .8,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                          color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                                          ?.user
                                          ?.profile_pic
                                          ?.filePath,
                                      placeholder:
                                          'assets/images/profile.png'))),
                          flaxibleGap(1),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              flaxibleGap(1),
                              Text(
                                  widget.bookingDetail![index].user!.name
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color(0XFF032040),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Poppins",
                                      fontSize: 16)),
                              Text(
                                  "${widget.bookingDetail![index].pitchType!.area} ${widget.bookingDetail![index].pitchType!.name}",
                                  style: const TextStyle(
                                      color: Color(0XFF696969),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins",
                                      fontSize: 12)),
                              widget.bookingDetail![index].booking_cancelled!
                                  ? Text(AppLocalizations.of(context)!.canceled,
                                      style: const TextStyle(
                                          color: Color(0XFF25A163),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins",
                                          fontSize: 10))
                                  : Row(
                                      children: <Widget>[
                                        Text(
                                            "${AppLocalizations.of(context)!.slots}: ",
                                            style: const TextStyle(
                                                color: Color(0XFFADADAD),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins",
                                                fontSize: 10)),
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
                                                  style: const TextStyle(
                                                      color: Color(0XFF25A163),
                                                      fontSize: 10));
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
    var day;
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
