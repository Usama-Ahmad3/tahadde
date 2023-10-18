import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchModelClass.dart';
import '../../modelClass/manageSlotModelClass.dart';
import '../../network/network_calls.dart';

// ignore: must_be_immutable
class ManageSlotsDetail extends StatefulWidget {
  BookPitchDetail pitchDetail;
  ManageSlotsDetail({super.key, required this.pitchDetail});
  @override
  _ManageSlotsDetailState createState() => _ManageSlotsDetailState();
}

class _ManageSlotsDetailState extends State<ManageSlotsDetail> {
  var bookingDate;
  bool saveSlot = false;
  bool varifyPitch = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  late String subPitchId;
  late String slotIds;
  late int count;
  List<int> indexListAM = [];
  List<int> slotIdAM = [];
  List<int> indexListPM = [];
  List<int> slotIdPM = [];
  bool _isLoading = true;
  var date;
  late ManageSlotModelClass slotDetail;
  final NetworkCalls _networkCalls = NetworkCalls();
  slotDetails() async {
    Map detail = {
      "id": "${widget.pitchDetail.id}",
      "year": DateFormat.y('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "month": DateFormat.M('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "day": DateFormat.d('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "pitchId": subPitchId,
    };
    await _networkCalls.manageSlot(
      date: detail,
      onSuccess: (detailslot) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            slotDetail = detailslot;
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

  findDate(String datevalue) async {
    await _networkCalls.currentDate(
        date: datevalue,
        onSuccess: (dateValue) {
          date = dateValue;
          slotDetails();
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
        });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    Future<DateTime?> slecteDtateTime(BuildContext context) => showDatePicker(
          context: context,
          initialDate: DateTime.now().add(const Duration(seconds: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
          locale: Locale(AppLocalizations.of(context)!.locale),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                colorScheme:
                    const ColorScheme.light(primary: Color(0XFF032040)),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
        );

    return Stack(
      children: <Widget>[
        Scaffold(
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
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context)!.manageSlots,
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
            body: _isLoading
                ? Container(
                    color: Colors.white,
                    width: sizeWidth,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          color: const Color(0XFFBCBCBC).withOpacity(.2),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .05,
                                vertical: sizeHeight * .01),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Shimmer.fromColors(
                                      baseColor: Colors.grey.shade300,
                                      highlightColor: Colors.grey.shade300,
                                      enabled: true,
                                      child: Container(
                                        height: 5,
                                        width: 200,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5.0) //

                                              ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " ${AppLocalizations.of(context)!.booking}",
                                      style: const TextStyle(
                                          color: Color(0XFF858585),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  4,
                                ),
                                Container(
                                  height: sizeHeight * .06,
                                  width: sizeHeight * .07,
                                  decoration: const BoxDecoration(
                                    color: Color(0XFF032040),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //
                                            ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/closed.png',
                                        fit: BoxFit.cover,
                                        height: sizeHeight * .03,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.closed,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: Color(0XFF9B9B9B)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .05,
                                right: sizeWidth * .05,
                                top: sizeHeight * .03,
                                bottom: sizeHeight * .005),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade300,
                              enabled: true,
                              child: Container(
                                height: 5,
                                width: 100,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0) //

                                          ),
                                ),
                              ),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * .05,
                          ),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade300,
                            enabled: true,
                            child: Container(
                              height: 5,
                              width: 80,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                              vertical: sizeHeight * .03),
                          child: Row(
                            children: <Widget>[
                              Image.asset(
                                'images/booked.png',
                                fit: BoxFit.cover,
                                height: 15,
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Text(
                                AppLocalizations.of(context)!.bookedSlots,
                                style: const TextStyle(
                                    color: Color(0XFF696969),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                              Flexible(
                                flex: 4,
                                child: Container(),
                              ),
                              Image.asset(
                                'images/available.png',
                                fit: BoxFit.cover,
                                height: 15,
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Text(
                                AppLocalizations.of(context)!.availableSlots,
                                style: const TextStyle(
                                    color: Color(0XFF696969),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                              flaxibleGap(
                                4,
                              ),
                              Image.asset(
                                'images/unavailable.png',
                                fit: BoxFit.cover,
                                height: 15,
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Text(
                                AppLocalizations.of(context)!.unavailableSlots,
                                style: const TextStyle(
                                    color: Color(0XFF696969),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                              vertical: sizeHeight * .01),
                          child: Text(
                            AppLocalizations.of(context)!.am,
                            style: const TextStyle(
                                color: Color(0XFF595959),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: SizedBox(
                            height: sizeHeight * .08,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 24,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: sizeWidth * .02,
                                    ),
                                    child: Container(
                                      width: sizeHeight * .08,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFF032040)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          color: const Color(0XFFFFFFFF)),
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(sizeWidth * .01),
                                        child: Text(
                                          timing(x: index),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05,
                              right: sizeWidth * .05,
                              top: sizeHeight * .03,
                              bottom: sizeHeight * .01),
                          child: Text(
                            AppLocalizations.of(context)!.pm,
                            style: const TextStyle(
                                color: Color(0XFF595959),
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: SizedBox(
                            height: sizeHeight * .08,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 24,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                      right: sizeWidth * .02,
                                    ),
                                    child: Container(
                                      width: sizeHeight * .08,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0XFF032040)),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          color: const Color(0XFFFFFFFF)),
                                      alignment: Alignment.bottomLeft,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.all(sizeWidth * .01),
                                        child: Text(
                                          timing(x: index),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                              vertical: sizeHeight * .01),
                          child: Text(
                            AppLocalizations.of(context)!
                                .amongstAvailableSlotUnavailable,
                            style: const TextStyle(
                                color: Color(0XFFADADAD),
                                fontSize: 10,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: const Color(0XFFBCBCBC).withOpacity(.2),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: sizeWidth * .05,
                              vertical: sizeHeight * .01),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final selectDate =
                                      await slecteDtateTime(context);
                                  if (selectDate != null) {
                                    if (mounted) {
                                      setState(() {
                                        _isLoading = true;
                                        bookingDate = selectDate.toString();
                                        String datevalue = formatter
                                            .format(selectDate)
                                            .toString();
                                        findDate("?slotDate=$datevalue");
                                      });
                                    }
                                  }
                                  print(selectDate);
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            DateFormat.yMMMMEEEEd('en_US')
                                                .format(bookingDate != null
                                                    ? DateTime.parse(
                                                        bookingDate)
                                                    : DateTime.now()),
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          )
                                        : Text(
                                            DateFormat.yMMMMEEEEd('AR_SA')
                                                .format(bookingDate != null
                                                    ? DateTime.parse(
                                                        bookingDate)
                                                    : DateTime.now()),
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                    Text(
                                      "${date["bookings"]} ${AppLocalizations.of(context)!.booking}",
                                      style: const TextStyle(
                                          color: Color(0XFF858585),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ),
                              flaxibleGap(
                                4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  navigateToClosingHour();
                                },
                                child: Container(
                                  height: sizeHeight * .06,
                                  width: sizeHeight * .07,
                                  decoration: const BoxDecoration(
                                    color: Color(0XFF032040),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0) //
                                            ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset(
                                        'images/closed.png',
                                        fit: BoxFit.cover,
                                        height: sizeHeight * .03,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.closed,
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: Color(0XFF9B9B9B)),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05,
                            top: sizeHeight * .03),
                        child: Text(
                          slotDetail.bookpitch!.name.toString(),
                          style: const TextStyle(
                              color: Color(0XFF032040),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: sizeWidth * .05,
                        ),
                        child: Text(
                          "${slotDetail.pitchType!.area} ${slotDetail.pitchType!.name}",
                          style: const TextStyle(
                              color: Color(0XFF25A163),
                              fontSize: 12,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * .05,
                            vertical: sizeHeight * .03),
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/booked.png',
                              fit: BoxFit.cover,
                              height: 15,
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                              AppLocalizations.of(context)!.bookedSlots,
                              style: const TextStyle(
                                  color: Color(0XFF696969),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                            Flexible(
                              flex: 4,
                              child: Container(),
                            ),
                            Image.asset(
                              'images/available.png',
                              fit: BoxFit.cover,
                              height: 15,
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                              AppLocalizations.of(context)!.availableSlots,
                              style: const TextStyle(
                                  color: Color(0XFF696969),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                            flaxibleGap(
                              4,
                            ),
                            Image.asset(
                              'images/unavailable.png',
                              fit: BoxFit.cover,
                              height: 15,
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Text(
                              AppLocalizations.of(context)!.unavailableSlots,
                              style: const TextStyle(
                                  color: Color(0XFF696969),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * .05,
                            vertical: sizeHeight * .01),
                        child: Text(
                          AppLocalizations.of(context)!.am,
                          style: const TextStyle(
                              color: Color(0XFF595959),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                        child: SizedBox(
                          height: sizeHeight * .08,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: slotDetail.slots!.length - 12,
                              itemBuilder: (context, index) {
                                return slotDetail.slots![index]!.is_booked ==
                                        true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          right: sizeWidth * .02,
                                        ),
                                        child: Container(
                                          width: sizeHeight * .08,
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0XFF032040)),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                              color: const Color(0XFF25A163)),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(sizeWidth * .01),
                                            child: Text(
                                              timing(
                                                  x: int.parse(slotDetail
                                                      .slots![index]!.startTime!
                                                      .substring(0, 2))),
                                              style: const TextStyle(
                                                  color: Color(0XFF032040),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      )
                                    : slotDetail.slots![index]!
                                                .slot_not_available ==
                                            true
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (indexListAM
                                                    .contains(index)) {
                                                  indexListAM.remove(index);
                                                } else {
                                                  indexListAM.add(index);
                                                }
                                                if (slotIdAM.contains(slotDetail
                                                    .slots![index]!.id)) {
                                                  slotIdAM.remove(slotDetail
                                                      .slots![index]!.id);
                                                } else {
                                                  slotIdAM.add(slotDetail
                                                      .slots![index]!.id!
                                                      .toInt());
                                                }
                                                //count=blockIdx;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: sizeWidth * .02,
                                              ),
                                              child: Container(
                                                width: sizeHeight * .08,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0XFF032040)),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: const Color(
                                                        0XFFE0E0E0)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      sizeWidth * .01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      indexListAM
                                                              .contains(index)
                                                          ? Image.asset(
                                                              'images/checkM.png',
                                                              height: 15,
                                                            )
                                                          : Container(),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                        timing(
                                                            x: int.parse(
                                                                slotDetail
                                                                    .slots![
                                                                        index]!
                                                                    .startTime!
                                                                    .substring(
                                                                        0, 2))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (indexListAM
                                                    .contains(index)) {
                                                  indexListAM.remove(index);
                                                } else {
                                                  indexListAM.add(index);
                                                }
                                                if (slotIdAM.contains(slotDetail
                                                    .slots![index]!.id)) {
                                                  slotIdAM.remove(slotDetail
                                                      .slots![index]!.id);
                                                } else {
                                                  slotIdAM.add(slotDetail
                                                      .slots![index]!.id!
                                                      .toInt());
                                                }
                                                //count=blockIdx;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: sizeWidth * .02,
                                              ),
                                              child: Container(
                                                width: sizeHeight * .08,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0XFF032040)),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: const Color(
                                                        0XFFFFFFFF)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      sizeWidth * .01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      indexListAM
                                                              .contains(index)
                                                          ? Image.asset(
                                                              'images/checkM.png',
                                                              height: 15,
                                                            )
                                                          : Container(),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                        timing(
                                                            x: int.parse(
                                                                slotDetail
                                                                    .slots![
                                                                        index]!
                                                                    .startTime!
                                                                    .substring(
                                                                        0, 2))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05,
                            top: sizeHeight * .03,
                            bottom: sizeHeight * .01),
                        child: Text(
                          AppLocalizations.of(context)!.pm,
                          style: const TextStyle(
                              color: Color(0XFF595959),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                        child: SizedBox(
                          height: sizeHeight * .08,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: slotDetail.slots!.length - 12,
                              itemBuilder: (context, index) {
                                return slotDetail
                                            .slots![index + 12]!.is_booked ==
                                        true
                                    ? Padding(
                                        padding: EdgeInsets.only(
                                          right: sizeWidth * .02,
                                        ),
                                        child: Container(
                                          width: sizeHeight * .08,
                                          alignment: Alignment.bottomCenter,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0XFF032040)),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                              color: const Color(0XFF25A163)),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.all(sizeWidth * .01),
                                            child: Text(
                                              timing(
                                                  x: int.parse(slotDetail
                                                      .slots![(index + 12)]!
                                                      .startTime!
                                                      .substring(0, 2))),
                                              style: const TextStyle(
                                                  color: Color(0XFF032040),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ),
                                      )
                                    : slotDetail.slots![index + 12]!
                                                .slot_not_available ==
                                            true
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (indexListPM
                                                    .contains(index)) {
                                                  indexListPM.remove(index);
                                                } else {
                                                  indexListPM.add(index);
                                                }
                                                if (slotIdPM.contains(slotDetail
                                                    .slots![(index + 12)]!
                                                    .id)) {
                                                  slotIdPM.remove(slotDetail
                                                      .slots![(index + 12)]!
                                                      .id);
                                                } else {
                                                  slotIdPM.add(slotDetail
                                                      .slots![(index + 12)]!.id!
                                                      .toInt());
                                                }
                                                //count=blockIdx;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: sizeWidth * .02,
                                              ),
                                              child: Container(
                                                width: sizeHeight * .08,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0XFF032040)),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: const Color(
                                                        0XFFE0E0E0)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      sizeWidth * .01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      indexListPM
                                                              .contains(index)
                                                          ? Image.asset(
                                                              'images/checkM.png',
                                                              height: 15,
                                                            )
                                                          : Container(),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                        timing(
                                                            x: int.parse(
                                                                slotDetail
                                                                    .slots![
                                                                        index +
                                                                            12]!
                                                                    .startTime!
                                                                    .substring(
                                                                        0, 2))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (indexListPM
                                                    .contains(index)) {
                                                  indexListPM.remove(index);
                                                } else {
                                                  indexListPM.add(index);
                                                }
                                                if (slotIdPM.contains(slotDetail
                                                    .slots![(index + 12)]!
                                                    .id)) {
                                                  slotIdPM.remove(slotDetail
                                                      .slots![(index + 12)]!
                                                      .id);
                                                } else {
                                                  slotIdPM.add(slotDetail
                                                      .slots![(index + 12)]!.id!
                                                      .toInt());
                                                }
                                                //count=blockIdx;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: sizeWidth * .02,
                                              ),
                                              child: Container(
                                                width: sizeHeight * .08,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0XFF032040)),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    color: const Color(
                                                        0XFFFFFFFF)),
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      sizeWidth * .01),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      indexListPM
                                                              .contains(index)
                                                          ? Image.asset(
                                                              'images/checkM.png',
                                                              height: 15,
                                                            )
                                                          : Container(),
                                                      flaxibleGap(
                                                        1,
                                                      ),
                                                      Text(
                                                        timing(
                                                            x: int.parse(
                                                                slotDetail
                                                                    .slots![
                                                                        (index +
                                                                            12)]!
                                                                    .startTime!
                                                                    .substring(
                                                                        0, 2))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                              }),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: sizeWidth * .05,
                            right: sizeWidth * .05,
                            top: sizeHeight * .05),
                        child: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    if (msg == true) {
                                      setState(() {
                                        _isLoading = true;
                                        slotIds = ",";
                                        if (slotIdAM.isNotEmpty) {
                                          for (int i = 0;
                                              i < slotIdAM.length;
                                              i++) {
                                            slotIds = "$slotIds${slotIdAM[i]},";
                                          }
                                        }
                                        if (slotIdPM.isNotEmpty) {
                                          for (int i = 0;
                                              i < slotIdPM.length;
                                              i++) {
                                            slotIds = "$slotIds${slotIdPM[i]},";
                                          }
                                        }
                                        slotIds = slotIds.substring(1);
                                        slotIds = slotIds.substring(
                                            0, slotIds.length - 1);

                                        Map detail = {
                                          "id": "${widget.pitchDetail.id}",
                                          "year": DateFormat.y('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "month": DateFormat.M('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "day": DateFormat.d('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "pitchId": subPitchId,
                                          "status": "available",
                                          "slotIds": slotIds
                                        };
                                        indexListPM.clear();
                                        indexListAM.clear();
                                        slotIdAM.clear();
                                        slotIdPM.clear();
                                        _networkCalls.manageSlotSend(
                                          date: detail,
                                          onSuccess: (msg) {
                                            String datevalue =
                                                bookingDate != null
                                                    ? formatter
                                                        .format(DateTime.parse(
                                                            bookingDate))
                                                        .toString()
                                                    : date["currentDate"];
                                            findDate("?slotDate=$datevalue");
                                          },
                                          onFailure: (msg) {
                                            //showMessage(msg, scaffoldkey);
                                          },
                                          tokenExpire: () {
                                            if (mounted) on401(context);
                                          },
                                        );

                                        //saveSlot=true;
                                      });
                                    } else {
                                      if (mounted) {
                                        showMessage(
                                            AppLocalizations.of(context)!
                                                .noInternetConnection);
                                      }
                                    }
                                  });
                                }
                              },
                              child: indexListAM.isNotEmpty ||
                                      indexListPM.isNotEmpty
                                  ? Container(
                                      height: sizeHeight * .05,
                                      width: sizeWidth * .4,
                                      color: const Color(0XFF25A163),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!.available,
                                        style: const TextStyle(
                                            color: Color(0XFFFFFFFF),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Container(),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (mounted) {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    if (msg == true) {
                                      setState(() {
                                        _isLoading = true;
                                        slotIds = ",";
                                        if (slotIdAM.isNotEmpty) {
                                          for (int i = 0;
                                              i < slotIdAM.length;
                                              i++) {
                                            slotIds = "$slotIds${slotIdAM[i]},";
                                          }
                                        }
                                        if (slotIdPM.isNotEmpty) {
                                          for (int i = 0;
                                              i < slotIdPM.length;
                                              i++) {
                                            slotIds = "$slotIds${slotIdPM[i]},";
                                          }
                                        }
                                        slotIds = slotIds.substring(1);
                                        slotIds = slotIds.substring(
                                            0, slotIds.length - 1);
                                        Map detail = {
                                          "id": "${widget.pitchDetail.id}",
                                          "year": DateFormat.y('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "month": DateFormat.M('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "day": DateFormat.d('en_US').format(
                                              DateTime.parse(bookingDate ??
                                                  date["currentDate"])),
                                          "pitchId": subPitchId,
                                          "status": "unavailable",
                                          "slotIds": slotIds
                                        };
                                        indexListPM.clear();
                                        indexListAM.clear();
                                        slotIdAM.clear();
                                        slotIdPM.clear();
                                        _networkCalls.manageSlotSend(
                                          date: detail,
                                          onSuccess: (msg) {
                                            String datevalue =
                                                bookingDate != null
                                                    ? formatter
                                                        .format(DateTime.parse(
                                                            bookingDate))
                                                        .toString()
                                                    : date["currentDate"];
                                            findDate("?slotDate=$datevalue");
                                          },
                                          onFailure: (msg) {
                                            //showMessage(msg, scaffoldkey);
                                          },
                                          tokenExpire: () {
                                            if (mounted) on401(context);
                                          },
                                        );

                                        //saveSlot=true;
                                      });
                                    } else {
                                      if (mounted) {
                                        showMessage(
                                          AppLocalizations.of(context)!
                                              .noInternetConnection,
                                        );
                                      }
                                    }
                                  });
                                }
                              },
                              child: indexListAM.isNotEmpty ||
                                      indexListPM.isNotEmpty
                                  ? Container(
                                      height: sizeHeight * .05,
                                      width: sizeWidth * .4,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0XFF979797)),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .unavailable,
                                        style: const TextStyle(
                                            color: Color(0XFF595959),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  : Container(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * .05,
                            vertical: sizeHeight * .01),
                        child: Text(
                          AppLocalizations.of(context)!
                              .amongstAvailableSlotUnavailable,
                          style: const TextStyle(
                              color: Color(0XFFADADAD),
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  )),
        varifyPitch
            ? BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Colors.black.withOpacity(.2),
                ),
              )
            : Container(),
        varifyPitch
            ? Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * .07),
                  child: Container(
                    height: sizeHeight * .5,
                    width: sizeWidth,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        flaxibleGap(
                          1,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: Row(
                            children: <Widget>[
                              Text(
                                  AppLocalizations.of(context)!
                                      .selectAsidePitchManageSlots,
                                  style: const TextStyle(
                                      decoration: TextDecoration.none,
                                      color: Color(0XFFADADAD),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Poppins")),
                              flaxibleGap(
                                1,
                              ),
                              SizedBox(
                                height: sizeHeight * .035,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  backgroundColor: const Color(0XFFD8D8D8),
                                  splashColor: Colors.black,
                                  child: Image.asset(
                                    "images/deletImage.png",
                                    height: sizeHeight * .03,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flaxibleGap(
                          1,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                          child: SizedBox(
                            height: sizeHeight * .3,
                            child: ListView.builder(
                                itemCount: widget.pitchDetail.pitchType!.length,
                                itemBuilder:
                                    (BuildContext context, int blockIdx) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 4.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Material(
                                        color: Colors.white,
                                        elevation: 5,
                                        child: Container(
                                          height: sizeHeight * .08,
                                          width: sizeHeight * .6,
                                          alignment: Alignment.center,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (count == blockIdx) {
                                                      count = 0;
                                                      subPitchId = '';
                                                    } else {
                                                      count = blockIdx;
                                                    }
                                                    subPitchId = widget
                                                        .pitchDetail
                                                        .pitchType![blockIdx]!
                                                        .id
                                                        .toString();
                                                  });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: SizedBox(
                                                    height: sizeHeight * .03,
                                                    width: sizeHeight * .03,
                                                    child: count == blockIdx
                                                        //checks.contains(blockIdx)
                                                        ? Image.asset(
                                                            "images/checks.png",
                                                            height: sizeHeight *
                                                                .03,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.asset(
                                                            "images/unchecks.png",
                                                            height: sizeHeight *
                                                                .03,
                                                            fit: BoxFit.fill,
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: sizeWidth * .2,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  widget
                                                      .pitchDetail
                                                      .pitchType![blockIdx]!
                                                      .area
                                                      .toString(),
                                                  style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Color(0XFF032040),
                                                      fontFamily: 'Poppins',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Container(
                                                height: sizeHeight * .04,
                                                color: const Color(0XFF979797),
                                                width: 2,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    widget
                                                        .pitchDetail
                                                        .pitchType![blockIdx]!
                                                        .name
                                                        .toString(),
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color:
                                                            Color(0XFF696969),
                                                        fontFamily: 'Poppins',
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        flaxibleGap(
                          3,
                        ),
                        count != null
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    varifyPitch = false;
                                    findDate("");
                                  });
                                },
                                child: Container(
                                    color: const Color(0XFF25A163),
                                    height: sizeHeight * .08,
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.manageSlots,
                                      style: const TextStyle(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Poppins",
                                      ),
                                    )),
                              )
                            : Container(
                                color: const Color(0XFFBCBCBC),
                                height: sizeHeight * .08,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.manageSlots,
                                  style: const TextStyle(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins",
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  void navigateToClosingHour() {
    Map detail = {
      "id": "${widget.pitchDetail.id}",
      "year": DateFormat.y('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "month": DateFormat.M('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "day": DateFormat.d('en_US')
          .format(DateTime.parse(bookingDate ?? date["currentDate"])),
      "pitchId": subPitchId,
      "status": "available",
    };
    Navigator.pushNamed(context, RouteNames.closingHour, arguments: detail);
  }

  String timing({required int x}) {
    String day;
    switch (x) {
      case 0:
        day = "12:00";
        break;
      case 1:
        day = "01:00";
        break;
      case 2:
        day = "02:00";
        break;
      case 3:
        day = "03:00";
        break;
      case 4:
        day = "04:00";
        break;
      case 5:
        day = "05:00";
        break;
      case 6:
        day = "06:00";
        break;
      case 7:
        day = "07:00";
        break;
      case 8:
        day = "08:00";
        break;
      case 9:
        day = "09:00";
        break;
      case 10:
        day = "10:00";
        break;
      case 11:
        day = "11:00";
        break;
      case 12:
        day = "12:00";
        break;
      case 13:
        day = "01:00";
        break;
      case 14:
        day = "02:00";
        break;
      case 15:
        day = "03:00";
        break;
      case 16:
        day = "04:00";
        break;
      case 17:
        day = "05:00";
        break;
      case 18:
        day = "06:00";
        break;
      case 19:
        day = "07:00";
        break;
      case 20:
        day = "08:00";
        break;
      case 21:
        day = "09:00";
        break;
      case 22:
        day = "10:00";
        break;
      default:
        day = "11:00";
        break;
    }
    return day;
  }
}
