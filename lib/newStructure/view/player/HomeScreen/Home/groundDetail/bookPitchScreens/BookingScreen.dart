import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../../../constant.dart';
import '../../../../../../../drop_down_file.dart';
import '../../../../../../../homeFile/routingConstant.dart';
import '../../../../../../../homeFile/utility.dart';
import '../../../../../../../localizations.dart';
import '../../../../../../../modelClass/venue_detail_model_class.dart';
import '../../../../../../../modelClass/venue_slot_model_class.dart';
import '../../../../../../../network/network_calls.dart';
import '../../../../../../../player/bookPitch/venueDetail.dart';
import '../groundDetail.dart';

class BookingScreenView extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  var detail;

  BookingScreenView({super.key, required this.detail});

  @override
  State<BookingScreenView> createState() => _BookingScreenViewState();
}

class _BookingScreenViewState extends State<BookingScreenView> {
  int? selectedIndex;
  final NetworkCalls _networkCalls = NetworkCalls();
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  bool? isSelected;
  bool _auth = false;
  List<int> listMaxPlayer = [];
  Map<String, List<String>> slotInformation = {};
  late SlotPrice _slotPrice =
      SlotPrice(isPlayer: false, pricePerPlayer: [], pricePerVenue: []);
  List<SlotModelClass> slotModelClass = [];
  late String dataTime;
  bool isPerPlayer = true;
  int indexItemSubPitch = 1;
  final List _slotTime = [];
  int indexItem = 1;
  int date = 0;

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context)!.toReserve),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.login),
                onPressed: () {
                  navigateToDetail1();
                },
              )
            ],
          );
        });
  }

  slotDetail() async {
    await _networkCalls.slotDetail(
        id: widget.detail["pitchId"].toString(),
        subPitchId: widget.detail["subPitchId"]["id"].toString(),
        date: dataTime,
        dateTime: "&today_datetime=${DateTime.now().toString()}",
        onSuccess: (detail) {
          setState(() {
            slotModelClass = detail;
            if (slotModelClass.isNotEmpty &&
                slotModelClass[0].slotDetail!.isNotEmpty) {
              listMaxPlayer = List<int>.generate(
                  slotModelClass[0].slotDetail![0]!.maximumPlayers!.toInt(),
                  (i) => i + 1);
            } else {
              listMaxPlayer.clear();
            }
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
                vertical: height * 0.07,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          shape: BoxShape.circle),
                      child: const Icon(
                        Icons.keyboard_arrow_left_sharp,
                        color: Colors.white,
                      )),
                  SizedBox(
                    width: width * 0.12,
                  ),
                  const Text(
                    'Booking a Ground',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: width * 0.022),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(14, (index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (date != index) {
                              _slotTime.clear();
                              _slotPrice.pricePerPlayer.clear();
                              _slotPrice.pricePerVenue.clear();
                              slotInformation = {};
                              date = index;
                              dataTime = apiFormatter.format(
                                  DateTime.now().add(Duration(days: index)));
                              slotDetail();
                              _slotPrice = SlotPrice(
                                  pricePerVenue: [], pricePerPlayer: []);
                            }
                          });
                        },
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.018),
                          child: Container(
                            width: width * 0.12,
                            height: height * 0.08,
                            decoration: BoxDecoration(
                                color: date == index
                                    ? Colors.yellow
                                    : Colors.white24,
                                borderRadius: BorderRadius.circular(20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  DateFormat('E').format(DateTime.now()
                                      .add(Duration(days: index))),
                                  style: TextStyle(
                                      color: date == index
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                                Text(
                                    DateTime.now()
                                        .add(Duration(days: index))
                                        .day
                                        .toString(),
                                    style: TextStyle(
                                        color: date == index
                                            ? Colors.black
                                            : Colors.grey))
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.032,
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(height * 0.03),
                      topRight: Radius.circular(height * 0.03))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.03, vertical: height * 0.02),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Ground List',
                        style: TextStyle(fontSize: height * 0.03)),
                    ...List.generate(
                        3,
                        (index) => Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.01,
                                  vertical: height * 0.01),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        offset: Offset(0, 1),
                                        blurStyle: BlurStyle.outer,
                                      )
                                    ]),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    Container(
                                      height: height * 0.05,
                                      width: width * 0.1,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: const DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  'https://tse1.mm.bing.net/th?id=OIP.Pi1ySxKBf7DyNStcLdOASwHaEo&pid=Api&rs=1&c=1&qlt=95&w=168&h=105'))),
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Text(ground[index]),
                                    SizedBox(
                                      width: width * 0.3,
                                    ),
                                    Checkbox(
                                        shape: const CircleBorder(),
                                        activeColor: Colors.greenAccent,
                                        value: selectedIndex == index
                                            ? true
                                            : false,
                                        onChanged: (onChanged) {
                                          selectedIndex = index;
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppLocalizations.of(context)!.locale == "en"
                              ? SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: isPerPlayer
                                            ? null
                                            : () {
                                                setState(() {
                                                  _slotTime.clear();
                                                  _slotPrice.pricePerPlayer
                                                      .clear();
                                                  _slotPrice.pricePerVenue
                                                      .clear();
                                                  slotInformation = {};
                                                  isPerPlayer = true;
                                                });
                                              },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: isPerPlayer
                                                ? Colors.grey
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: isPerPlayer
                                                  ? Colors.white24
                                                  : Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perPlayer),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      InkWell(
                                        onTap: !isPerPlayer
                                            ? null
                                            : () {
                                                if (GroundDetailState
                                                        .privateVenueDetail
                                                        .sports!
                                                        .sportSlug ==
                                                    "swimming") {
                                                  showMessage(
                                                      "${AppLocalizations.of(context)!.perVenue} ${AppLocalizations.of(context)!.unavailable} for ${GroundDetailState.privateVenueDetail.sports!.name}");
                                                } else {
                                                  setState(() {
                                                    _slotTime.clear();
                                                    _slotPrice.pricePerPlayer
                                                        .clear();
                                                    _slotPrice.pricePerVenue
                                                        .clear();
                                                    slotInformation = {};
                                                    isPerPlayer = false;
                                                  });
                                                }
                                              },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isPerPlayer
                                                ? Colors.white
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: isPerPlayer
                                                  ? Colors.blueGrey
                                                  : Colors.white24,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perVenue),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 40,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: isPerPlayer
                                            ? null
                                            : () {
                                                if (GroundDetailState
                                                        .privateVenueDetail
                                                        .sports!
                                                        .sportSlug ==
                                                    "swimming") {
                                                  showMessage(
                                                      "${AppLocalizations.of(context)!.perVenue} ${AppLocalizations.of(context)!.unavailable} for ${GroundDetailState.privateVenueDetail.sports!.name}");
                                                } else {
                                                  setState(() {
                                                    _slotTime.clear();
                                                    _slotPrice.pricePerPlayer
                                                        .clear();
                                                    _slotPrice.pricePerVenue
                                                        .clear();
                                                    slotInformation = {};
                                                    isPerPlayer = false;
                                                  });
                                                }
                                              },
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: isPerPlayer
                                                ? Colors.white
                                                : Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: isPerPlayer
                                                  ? Colors.blueGrey
                                                  : Colors.white24,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perVenue),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      InkWell(
                                        onTap: isPerPlayer
                                            ? null
                                            : () {
                                                setState(() {
                                                  _slotTime.clear();
                                                  _slotPrice.pricePerPlayer
                                                      .clear();
                                                  _slotPrice.pricePerVenue
                                                      .clear();
                                                  slotInformation = {};
                                                  isPerPlayer = true;
                                                });
                                              },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: isPerPlayer
                                                ? Colors.grey
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: isPerPlayer
                                                  ? Colors.white24
                                                  : Colors.blueGrey,
                                              style: BorderStyle.solid,
                                            ),
                                          ),
                                          child: Text(
                                              AppLocalizations.of(context)!
                                                  .perPlayer),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                          SizedBox(
                            width: width * .35,
                            child: CustomDropdown(
                              leadingIcon: false,
                              icon: Image.asset(
                                "assets/images/drop_down.png",
                                height: 6,
                                color: appThemeColor,
                              ),
                              onChange: (int value, int index) => setState(() {
                                indexItemSubPitch = index;
                              }),
                              dropdownButtonStyle: DropdownButtonStyle(
                                width: width * 0.03,
                                height: height * 0.05,
                                elevation: 1,
                                backgroundColor: Colors.white,
                              ),
                              dropdownStyle: DropdownStyle(
                                borderRadius: BorderRadius.circular(4),
                                elevation: 6,
                                padding: const EdgeInsets.all(5),
                              ),
                              items: GroundDetailState
                                  .privateVenueDetail.venueDetails!.pitchType!
                                  .asMap()
                                  .entries
                                  .map(
                                    (item) => DropdownItem(
                                      value: item.key + 1,
                                      child: SizedBox(
                                        height: height * 0.03,
                                        child: Text(item.value!.area.toString(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              color: appThemeColor,
                                            )),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              child: Text(
                                GroundDetailState.privateVenueDetail
                                    .venueDetails!.pitchType![0]!.area
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12, color: appThemeColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !isPerPlayer
                        ? const SizedBox.shrink()
                        : listMaxPlayer.isNotEmpty
                            ? IgnorePointer(
                                ignoring: !isPerPlayer,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * .04,
                                      vertical: height * 0.01),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .selectnumberofplayer,
                                        style: TextStyle(
                                            color: appThemeColor,
                                            fontSize: height * 0.017),
                                      ),
                                      SizedBox(
                                        width: width * .4,
                                        child: CustomDropdown(
                                          leadingIcon: false,
                                          icon: Image.asset(
                                            "assets/images/drop_down.png",
                                            height: 6,
                                            color: appThemeColor,
                                          ),
                                          onChange: (int value, int index) {
                                            if (index != indexItem - 1) {
                                              setState(() {
                                                indexItem = index + 1;
                                              });
                                            }
                                          },
                                          dropdownButtonStyle:
                                              DropdownButtonStyle(
                                            width: width * 0.03,
                                            height: height * 0.05,
                                            elevation: 1,
                                            backgroundColor: Colors.white,
                                          ),
                                          dropdownStyle: DropdownStyle(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            elevation: 6,
                                            padding: const EdgeInsets.all(5),
                                          ),
                                          items: listMaxPlayer
                                              .asMap()
                                              .entries
                                              .map(
                                                (item) => DropdownItem(
                                                  value: item.key,
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: isPerPlayer
                                                        ? Text(
                                                            item.value
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color:
                                                                    appThemeColor))
                                                        : Text(
                                                            listMaxPlayer[
                                                                    listMaxPlayer
                                                                            .length -
                                                                        1]
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color:
                                                                    appThemeColor)),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          child: !isPerPlayer
                                              ? Text(
                                                  listMaxPlayer[
                                                          listMaxPlayer.length -
                                                              1]
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: appThemeColor))
                                              : Text(
                                                  listMaxPlayer[0].toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: appThemeColor),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),

                    ///
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: Text(
                        'Select a Time',
                        style: TextStyle(fontSize: height * 0.03),
                      ),
                    ),
                    Wrap(
                      children: [
                        ...List.generate(
                            6,
                            (index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.02,
                                      vertical: height * 0.01),
                                  child: Container(
                                    height: height * 0.06,
                                    width: width * 0.43,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '08:00 - 11:00 AM',
                                          style: TextStyle(
                                              fontSize: height * 0.0155),
                                        ),
                                        Radio(
                                            value: null,
                                            groupValue: null,
                                            onChanged: (e) {})
                                      ],
                                    ),
                                  ),
                                ))
                      ],
                    ),
                    InkWell(
                      onTap: () {
                        if (_auth) {
                          if (_slotPrice.pricePerVenue.isEmpty &&
                              _slotPrice.pricePerPlayer.isEmpty) {
                            showMessage("Please select your slot first");
                          } else {
                            Map apiDetail = {"date": dataTime, "id": _slotTime};
                            var detail = {
                              "price": isPerPlayer
                                  ? slotPriceCalculation(
                                          _slotPrice.pricePerPlayer) *
                                      indexItem
                                  : slotPriceCalculation(
                                      _slotPrice.pricePerVenue),
                              "apiDetail": apiDetail,
                              "slotDetail": slotInformation,
                              "venueName": GroundDetailState
                                  .privateVenueDetail.venueDetails!.name,
                              "pitchType": GroundDetailState.privateVenueDetail
                                  .venueDetails!.pitchType![0]!.area,
                              "ids": widget.detail["pitchId"],
                              "subPitchId": widget.detail["subPitchId"]["id"],
                              "player_count": indexItem,
                              "slug": isPerPlayer
                                  ? "price-per-player"
                                  : "venue-price"
                            };
                            print('VanueDetail$detail');
                            navigateToDetail(detail);
                          }
                        } else {
                          onWillPop();
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Container(
                          height: height * 0.07,
                          width: width * 0.9,
                          decoration: BoxDecoration(
                              color: Colors.yellow,
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: [
                          slotModelClass.isEmpty
                              ? SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(AppLocalizations.of(context)!
                                        .thisDayHoliday),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Expanded(
                                    child: ListView.builder(
                                      itemCount: slotModelClass.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: ((context, index) {
                                        return slotModelClass[index]
                                                .slotDetail!
                                                .isEmpty
                                            ? SizedBox(
                                                height: 100,
                                                child: Center(
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .noSlotsAvailable),
                                                ),
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 8.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        print(
                                                          "${slotModelClass[index].sessionName} ( ${slotModelClass[index].slotDetail![0]!.sportSlotTime.toString()} mins Slot )",
                                                        );
                                                      },
                                                      child: Text(
                                                        "${slotModelClass[index].sessionName} ( ${slotModelClass[index].slotDetail![0]!.sportSlotTime.toString()} mins Slot )",
                                                        style: const TextStyle(
                                                            color:
                                                                appThemeColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    child: GridView.builder(
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            slotModelClass[
                                                                    index]
                                                                .slotDetail!
                                                                .length,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        gridDelegate:
                                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                                maxCrossAxisExtent:
                                                                    100,
                                                                childAspectRatio:
                                                                    4 / 2,
                                                                crossAxisSpacing:
                                                                    20,
                                                                mainAxisSpacing:
                                                                    20),
                                                        itemBuilder:
                                                            (context, indexx) {
                                                          return !slotModelClass[
                                                                          index]
                                                                      .slotDetail![
                                                                          indexx]!
                                                                      .isBooked! &&
                                                                  availability(
                                                                      slotModelClass[index]
                                                                              .slotDetail![
                                                                          indexx])!
                                                              ? GestureDetector(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (_slotTime.contains(slotModelClass[
                                                                              index]
                                                                          .slotDetail![
                                                                              indexx]!
                                                                          .id)) {
                                                                        _slotTime.remove(slotModelClass[index]
                                                                            .slotDetail![indexx]!
                                                                            .id);
                                                                        _slotPrice
                                                                            .pricePerPlayer
                                                                            .remove(slotModelClass[index].slotDetail![indexx]!.slotPlayerPrice);
                                                                        _slotPrice
                                                                            .pricePerVenue
                                                                            .remove(slotModelClass[index].slotDetail![indexx]!.slotPrice);
                                                                        if (slotInformation[slotModelClass[index].sessionName]!.length >
                                                                            1) {
                                                                          slotInformation[slotModelClass[index].sessionName]!.remove(slotModelClass[index]
                                                                              .slotDetail![indexx]!
                                                                              .startTime);
                                                                        } else {
                                                                          slotInformation
                                                                              .remove(slotModelClass[index].sessionName);
                                                                        }
                                                                      } else {
                                                                        _slotTime.add(slotModelClass[index]
                                                                            .slotDetail![indexx]!
                                                                            .id!
                                                                            .toInt());
                                                                        _slotPrice.pricePerPlayer.add(slotModelClass[index]
                                                                            .slotDetail![indexx]!
                                                                            .slotPlayerPrice!
                                                                            .toDouble());
                                                                        _slotPrice.pricePerVenue.add(slotModelClass[index]
                                                                            .slotDetail![indexx]!
                                                                            .slotPrice!
                                                                            .toDouble());
                                                                        if (slotInformation
                                                                            .containsKey(slotModelClass[index].sessionName)) {
                                                                          slotInformation[slotModelClass[index].sessionName]!.add(slotModelClass[index]
                                                                              .slotDetail![indexx]!
                                                                              .startTime
                                                                              .toString());
                                                                        } else {
                                                                          slotInformation[slotModelClass[index]
                                                                              .sessionName
                                                                              .toString()] = [
                                                                            slotModelClass[index].slotDetail![indexx]!.startTime.toString()
                                                                          ];
                                                                        }
                                                                      }
                                                                    });
                                                                  },
                                                                  child: _slotTime.contains(slotModelClass[
                                                                              index]
                                                                          .slotDetail![
                                                                              indexx]!
                                                                          .id)
                                                                      ?
                                                                      // Container()
                                                                      Container(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              140,
                                                                          alignment: Alignment
                                                                              .bottomLeft,
                                                                          child:
                                                                              Badge(
                                                                            label:
                                                                                Text(
                                                                              slotModelClass[index].slotDetail![indexx]!.maximumPlayers.toString(),
                                                                              // slotModelClass[index].slotDetail![indexx]!.bookedPlayersCount!.toInt()).toString(),
                                                                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                                                            ),
                                                                            isLabelVisible:
                                                                                isPerPlayer,
                                                                            backgroundColor:
                                                                                appThemeColor,
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 70,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(color: const Color(0XFF25A163), border: Border.all(color: const Color(0XFF25A163))),
                                                                              child: Text(
                                                                                slotModelClass[index].slotDetail![indexx]!.startTime!.substring(0, 5) ?? "",
                                                                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ))
                                                                      :
                                                                      // Container()
                                                                      Container(
                                                                          height:
                                                                              100,
                                                                          width:
                                                                              140,
                                                                          alignment:
                                                                              Alignment.bottomLeft,
                                                                          child:
                                                                              Badge(
                                                                            isLabelVisible:
                                                                                isPerPlayer,
                                                                            label:
                                                                                Text(
                                                                              (slotModelClass[index].slotDetail![indexx]!.maximumPlayers! - slotModelClass[index].slotDetail![indexx]!.bookedPlayersCount!.toInt()).toString(),
                                                                              style: const TextStyle(color: appThemeColor, fontWeight: FontWeight.w600),
                                                                            ),
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            alignment:
                                                                                Alignment.topRight,
                                                                            child:
                                                                                Container(
                                                                              height: 35,
                                                                              width: 70,
                                                                              alignment: Alignment.center,
                                                                              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                                                                              child: Text(
                                                                                slotModelClass[index].slotDetail![indexx]!.startTime!.substring(0, 5) ?? "",
                                                                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Colors.black),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                )
                                                              : !slotModelClass[
                                                                          index]
                                                                      .slotDetail![
                                                                          indexx]!
                                                                      .isAvailable!
                                                                  ? Container(
                                                                      height:
                                                                          40,
                                                                      width: 80,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      color:
                                                                          appThemeColor,
                                                                      child:
                                                                          Text(
                                                                        slotModelClass[index].slotDetail![indexx]!.startTime!.substring(0,
                                                                                5) ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          40,
                                                                      width: 80,
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .grey,
                                                                          border:
                                                                              Border.all(color: Colors.grey)),
                                                                      child:
                                                                          Text(
                                                                        slotModelClass[index].slotDetail![indexx]!.startTime!.substring(0,
                                                                                5) ??
                                                                            "",
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    );
                                                        }),
                                                  ),
                                                ],
                                              );
                                      }),
                                    ),
                                  ),
                                ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 10.0,
                          //     vertical: 10,
                          //   ),
                          //   child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.start,
                          //       children: [
                          //         Image.asset(
                          //           "images/unavailable_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Unavailable",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/available_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Available",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/selected_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Selected",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/selected_image.png",
                          //           height: 20,
                          //           width: 20,
                          //           color: appTheamColor,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Booked",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //       ]),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool? availability(var value) {
    if (value.isBooked) {
      return false;
    } else if (!value.bookedPlayer && !value.bookedVenue) {
      return true;
    } else if (value.bookedPlayer && !value.bookedVenue) {
      return isPerPlayer ? true : false;
    }
  }

  List ground = ['Main Ground', 'Futsal Ground', 'tennis Ground'];

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  double slotPriceCalculation(List<double> priceList) {
    double slotPrice = 0.0;
    priceList.forEach((element) {
      slotPrice = slotPrice + element;
    });
    return slotPrice;
  }

  void navigateToDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.enterDetailPitch,
        arguments: detail);
  }
}
