import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookingModelClass.dart';

class PitchBookingDetails extends StatefulWidget {
  BookingModelClass bookindDetail;
  PitchBookingDetails({required this.bookindDetail});
  @override
  _PitchBookingDetailsState createState() => _PitchBookingDetailsState();
}

class _PitchBookingDetailsState extends State<PitchBookingDetails> {
  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0XFFF7F7F7),
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
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalizations.of(context)!.pitchBookings,
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
          padding: EdgeInsets.symmetric(
              vertical: sizeHeight * .02, horizontal: sizeWidth * .08),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white,
            ),
            height: sizeHeight * .5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                flaxibleGap(1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Row(
                    children: <Widget>[
                      Container(
                          height: sizeHeight * .08,
                          width: sizeHeight * .08,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0XFF4F5C6A),
                          ),
                          child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(sizeHeight * .1),
                              child: cachedNetworkImage(
                                  height: sizeHeight * .08,
                                  cuisineImageUrl: widget.bookindDetail?.user
                                      ?.profile_pic?.filePath,
                                  placeholder: 'images/profile.png'))),
                      flaxibleGap(2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.bookindDetail.user!.name.toString(),
                            style: const TextStyle(
                                fontSize: 16, color: Color(0XFF032040)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.call,
                                color: Colors.green,
                                size: sizeHeight * .025,
                              ),
                              Text(
                                widget.bookindDetail.user!.contact_number ?? "",
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0XFF25A163)),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(
                                Icons.mail,
                                color: Colors.green,
                                size: sizeHeight * .025,
                              ),
                              Text(
                                "  ${widget.bookindDetail.user!.email}" ?? "",
                                style: const TextStyle(
                                    fontSize: 10, color: Color(0XFF25A163)),
                              )
                            ],
                          )
                        ],
                      ),
                      flaxibleGap(10),
                    ],
                  ),
                ),
                flaxibleGap(1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Text(
                    AppLocalizations.of(context)!.bookingDetails,
                    style: const TextStyle(fontSize: 10, color: Color(0XFFADADAD)),
                  ),
                ),
                flaxibleGap(1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.bookindDetail.pitchType!.area.toString(),
                        style:
                            const TextStyle(fontSize: 16, color: Color(0XFF032040)),
                      ),
                      flaxibleGap(1),
                      Container(
                        width: 2,
                        height: sizeHeight * .05,
                        color: const Color(0XFF979797),
                      ),
                      flaxibleGap(1),
                      Column(
                        children: <Widget>[
                          Text(
                            widget.bookindDetail.pitchType!.name.toString(),
                            style: const TextStyle(
                                fontSize: 12, color: Color(0XFF032040)),
                          ),
                          SizedBox(
                            width: sizeWidth * .5,
                            child: Text(
                              widget.bookindDetail.location.toString(),
                              style: const TextStyle(
                                  fontSize: 10, color: Color(0XFF9B9B9B)),
                            ),
                          ),
                        ],
                      ),
                      flaxibleGap(1),
                      Container(
                        width: 2,
                        height: sizeHeight * .05,
                        color: const Color(0XFF979797),
                      ),
                      flaxibleGap(1),
                      Text(
                        "${AppLocalizations.of(context)!.currency} ${widget.bookindDetail.pitchType!.paymentSummary!.grandTotal!.round()}",
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0XFF25A163),
                            fontWeight: FontWeight.w500,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
                flaxibleGap(1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.slots,
                        style: const TextStyle(fontSize: 8, color: Color(0XFFADADAD)),
                      ),
                      widget.bookindDetail.booking_cancelled!?Text(AppLocalizations.of(context)!.canceled,
                          style: const TextStyle(
                              color: Color(0XFF25A163),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 10)):Text(AppLocalizations.of(context)!.booked,
                          style: const TextStyle(
                              color: Color(0XFF25A163),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins",
                              fontSize: 10))
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Text(
                    (DateFormat.yMMMEd('en_US').format(DateTime.parse(widget.bookindDetail.slotDate!))),
                    style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 10,
                        color: Color(0XFF032040),
                        decoration: TextDecoration.none),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Container(
                    height: 15,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: widget.bookindDetail.slots!.booked_slots!.length,
                      itemBuilder: (context, blockindex) {
                        return Text(
                            '(${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.startTime!.substring(0, 2)))} - ${timing(x: int.parse(widget.bookindDetail.slots!.booked_slots![blockindex]!.endTime!.substring(0, 2)))}),',
                            style: const TextStyle(
                                color: Color(0XFF25A163), fontSize: 10));
                      },
                    ),
                  ),
                ),
                flaxibleGap(1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Text(
                    AppLocalizations.of(context)!.tranjectionId,
                    style: const TextStyle(fontSize: 8, color: Color(0XFFADADAD)),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .03),
                  child: Text(
                    widget.bookindDetail.transactionId!,
                    style: const TextStyle(fontSize: 13, color: Color(0XFF032040)),
                  ),
                ),
                flaxibleGap(1),
                Container(
                  color: const Color(0XFFD8D8D8),
                  alignment: Alignment.center,
                  height: sizeHeight * .06,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.paidTotal,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0XFF25A163),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                        flaxibleGap(1),
                        Text(
                          "${AppLocalizations.of(context)!.currency} ${widget.bookindDetail.paidTotal!.round()}",
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0XFF25A163),
                              fontWeight: FontWeight.w500,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
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
