import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/bookPitchScreens/bookingShimmer.dart';
import 'package:intl/intl.dart';

import '../../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../../constant.dart';
import '../../../../../../../drop_down_file.dart';
import '../../../../../../../homeFile/routingConstant.dart';
import '../../../../../../../homeFile/utility.dart';
import '../../../../../../../localizations.dart';
import '../../../../../../../main.dart';
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
  bool internet = true;
  bool isStateLoading = true;
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
            isStateLoading = false;
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

  checkAuth() async {
    _auth = (await checkAuthorizaton())!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataTime = apiFormatter.format(DateTime.now());
    checkAuth();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        slotDetail();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: isStateLoading
          ? BookingShimmer.bookingShimmer(width, height, context)
          : internet
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      ///Top Widget
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.1,
                          vertical: height * 0.07,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      shape: BoxShape.circle),
                                  child: Icon(
                                    AppLocalizations.of(context)!.locale == 'en'
                                        ? Icons.keyboard_arrow_left_sharp
                                        : Icons.keyboard_arrow_right,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              width: width * 0.12,
                            ),
                            Text(
                              AppLocalizations.of(context)!.bookingGround,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),

                      ///Date Widget
                      Padding(
                        padding: AppLocalizations.of(context)!.locale == 'en'
                            ? EdgeInsets.only(left: width * 0.022)
                            : EdgeInsets.only(right: width * 0.022),
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
                                            DateTime.now()
                                                .add(Duration(days: index)));
                                        slotDetail();
                                        _slotPrice = SlotPrice(
                                            pricePerVenue: [],
                                            pricePerPlayer: []);
                                      }
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.018),
                                    child: Container(
                                      width: width * 0.12,
                                      height: AppLocalizations.of(context)!
                                                  .locale ==
                                              'en'
                                          ? height * 0.08
                                          : height * 0.1,
                                      decoration: BoxDecoration(
                                          color: date == index
                                              ? Colors.yellow
                                              : Colors.white24,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                              DateTime.now()
                                                  .add(Duration(days: index))
                                                  .day
                                                  .toString(),
                                              style: TextStyle(
                                                  color: date == index
                                                      ? Colors.black
                                                      : Colors.grey)),
                                          Text(
                                            DateFormat('E').format(
                                                DateTime.now().add(
                                                    Duration(days: index))),
                                            style: TextStyle(
                                                color: date == index
                                                    ? Colors.black
                                                    : Colors.grey),
                                          ),
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

                      ///down white Container
                      Container(
                        width: width,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? Colors.white
                                : Colors.white10,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(height * 0.03),
                                topRight: Radius.circular(height * 0.03))),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.03,
                              vertical: height * 0.02),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///ground List
                              Text(AppLocalizations.of(context)!.groundList,
                                  style: TextStyle(
                                    fontSize: height * 0.03,
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                  )),
                              ...List.generate(
                                  3,
                                  (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.01,
                                            vertical: height * 0.01),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white70,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1,
                                                  offset: Offset(0, 1),
                                                  blurStyle: BlurStyle.outer,
                                                )
                                              ]),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
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
                                                        BorderRadius.circular(
                                                            10),
                                                    image: const DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image: NetworkImage(
                                                            'https://tse1.mm.bing.net/th?id=OIP.Pi1ySxKBf7DyNStcLdOASwHaEo&pid=Api&rs=1&c=1&qlt=95&w=168&h=105'))),
                                              ),
                                              SizedBox(
                                                width: width * 0.03,
                                              ),
                                              Text(
                                                ground[index],
                                                style: TextStyle(
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? Colors.black
                                                        : Colors.white),
                                              ),
                                              SizedBox(
                                                width: width * 0.3,
                                              ),
                                              Checkbox(
                                                  shape: const CircleBorder(),
                                                  activeColor:
                                                      Colors.greenAccent,
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

                              ///select area,player
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: isPerPlayer
                                                      ? null
                                                      : () {
                                                          setState(() {
                                                            _slotTime.clear();
                                                            _slotPrice
                                                                .pricePerPlayer
                                                                .clear();
                                                            _slotPrice
                                                                .pricePerVenue
                                                                .clear();
                                                            slotInformation =
                                                                {};
                                                            isPerPlayer = true;
                                                          });
                                                        },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                      color: isPerPlayer
                                                          ? MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? Colors.grey
                                                              : Colors
                                                                  .indigoAccent
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: isPerPlayer
                                                            ? Colors.white24
                                                            : Colors.blueGrey,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .perPlayer,
                                                      style: TextStyle(
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Colors.black
                                                            : Colors.grey,
                                                      ),
                                                    ),
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
                                                              _slotPrice
                                                                  .pricePerPlayer
                                                                  .clear();
                                                              _slotPrice
                                                                  .pricePerVenue
                                                                  .clear();
                                                              slotInformation =
                                                                  {};
                                                              isPerPlayer =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: isPerPlayer
                                                          ? Colors.white
                                                          : MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? Colors.grey
                                                              : Colors
                                                                  .indigoAccent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: isPerPlayer
                                                            ? Colors.blueGrey
                                                            : Colors.white24,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .perVenue,
                                                      style: TextStyle(
                                                        color: MyAppState
                                                                    .mode ==
                                                                ThemeMode.light
                                                            ? Colors.black
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : SizedBox(
                                            height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
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
                                                              _slotPrice
                                                                  .pricePerPlayer
                                                                  .clear();
                                                              _slotPrice
                                                                  .pricePerVenue
                                                                  .clear();
                                                              slotInformation =
                                                                  {};
                                                              isPerPlayer =
                                                                  false;
                                                            });
                                                          }
                                                        },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: isPerPlayer
                                                          ? Colors.white
                                                          : Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: isPerPlayer
                                                            ? Colors.blueGrey
                                                            : Colors.white24,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
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
                                                            _slotPrice
                                                                .pricePerPlayer
                                                                .clear();
                                                            _slotPrice
                                                                .pricePerVenue
                                                                .clear();
                                                            slotInformation =
                                                                {};
                                                            isPerPlayer = true;
                                                          });
                                                        },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    decoration: BoxDecoration(
                                                      color: isPerPlayer
                                                          ? Colors.grey
                                                          : Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                        color: isPerPlayer
                                                            ? Colors.white24
                                                            : Colors.blueGrey,
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: Text(
                                                        AppLocalizations.of(
                                                                context)!
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
                                        onChange: (int value, int index) =>
                                            setState(() {
                                          indexItemSubPitch = index;
                                        }),
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
                                        items: GroundDetailState
                                            .privateVenueDetail
                                            .venueDetails!
                                            .pitchType!
                                            .asMap()
                                            .entries
                                            .map(
                                              (item) => DropdownItem(
                                                value: item.key + 1,
                                                child: SizedBox(
                                                  height: height * 0.03,
                                                  child: Text(
                                                      item.value!.area
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.center,
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
                                              fontSize: 12,
                                              color: appThemeColor),
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  AppLocalizations.of(context)!
                                                      .selectnumberofplayer,
                                                  style: TextStyle(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? appThemeColor
                                                          : Colors.white,
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
                                                    onChange:
                                                        (int value, int index) {
                                                      if (index !=
                                                          indexItem - 1) {
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
                                                      backgroundColor:
                                                          Colors.white,
                                                    ),
                                                    dropdownStyle:
                                                        DropdownStyle(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      elevation: 6,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                    ),
                                                    items: listMaxPlayer
                                                        .asMap()
                                                        .entries
                                                        .map(
                                                          (item) =>
                                                              DropdownItem(
                                                            value: item.key,
                                                            child: SizedBox(
                                                              height: 30,
                                                              child: isPerPlayer
                                                                  ? Text(
                                                                      item.value
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: const TextStyle(
                                                                          color:
                                                                              appThemeColor))
                                                                  : Text(
                                                                      listMaxPlayer[listMaxPlayer.length -
                                                                              1]
                                                                          .toString(),
                                                                      textAlign:
                                                                          TextAlign
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
                                                                    listMaxPlayer
                                                                            .length -
                                                                        1]
                                                                .toString(),
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: const TextStyle(
                                                                color:
                                                                    appThemeColor))
                                                        : Text(
                                                            listMaxPlayer[0]
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 12,
                                                                color:
                                                                    appThemeColor),
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),

                              /// slot Selecting
                              slotModelClass.isEmpty
                                  ? SizedBox(
                                      height: height * 0.28,
                                      child: Center(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .thisDayHoliday,
                                          style: TextStyle(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.black
                                                  : Colors.white),
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        ...List.generate(slotModelClass.length,
                                            (index) {
                                          return slotModelClass[index]
                                                  .slotDetail!
                                                  .isEmpty
                                              ? SizedBox(
                                                  height: 100,
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .noSlotsAvailable,
                                                      style: TextStyle(
                                                          color: MyAppState
                                                                      .mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? Colors.black
                                                              : Colors.white),
                                                    ),
                                                  ),
                                                )
                                              : Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: height *
                                                                  0.02),
                                                      child: Text(
                                                        "${AppLocalizations.of(context)!.select} ${slotModelClass[index].sessionName} ( ${slotModelClass[index].slotDetail![0]!.sportSlotTime.toString()} mins Slot )",
                                                        style: TextStyle(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? Colors.black
                                                                : Colors.white,
                                                            fontSize:
                                                                height * 0.02),
                                                      ),
                                                    ),
                                                    Wrap(
                                                      children: [
                                                        ...List.generate(
                                                            slotModelClass[
                                                                    index]
                                                                .slotDetail!
                                                                .length,
                                                            (slotIndex) {
                                                          return !slotModelClass[
                                                                          index]
                                                                      .slotDetail![
                                                                          slotIndex]!
                                                                      .isBooked! &&
                                                                  availability(slotModelClass[
                                                                              index]
                                                                          .slotDetail![
                                                                      slotIndex])!
                                                              ? InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      if (_slotTime.contains(slotModelClass[
                                                                              index]
                                                                          .slotDetail![
                                                                              slotIndex]!
                                                                          .id)) {
                                                                        _slotTime.remove(slotModelClass[index]
                                                                            .slotDetail![slotIndex]!
                                                                            .id);
                                                                        _slotPrice
                                                                            .pricePerPlayer
                                                                            .remove(slotModelClass[index].slotDetail![slotIndex]!.slotPlayerPrice);
                                                                        _slotPrice
                                                                            .pricePerVenue
                                                                            .remove(slotModelClass[index].slotDetail![slotIndex]!.slotPrice);
                                                                        if (slotInformation[slotModelClass[index].sessionName]!.length >
                                                                            1) {
                                                                          slotInformation[slotModelClass[index].sessionName]!.remove(slotModelClass[index]
                                                                              .slotDetail![slotIndex]!
                                                                              .startTime);
                                                                        } else {
                                                                          slotInformation
                                                                              .remove(slotModelClass[index].sessionName);
                                                                        }
                                                                      } else {
                                                                        _slotTime.add(slotModelClass[index]
                                                                            .slotDetail![slotIndex]!
                                                                            .id!
                                                                            .toInt());
                                                                        _slotPrice.pricePerPlayer.add(slotModelClass[index]
                                                                            .slotDetail![slotIndex]!
                                                                            .slotPlayerPrice!
                                                                            .toDouble());
                                                                        _slotPrice.pricePerVenue.add(slotModelClass[index]
                                                                            .slotDetail![slotIndex]!
                                                                            .slotPrice!
                                                                            .toDouble());
                                                                        if (slotInformation
                                                                            .containsKey(slotModelClass[index].sessionName)) {
                                                                          slotInformation[slotModelClass[index].sessionName]!.add(slotModelClass[index]
                                                                              .slotDetail![slotIndex]!
                                                                              .startTime
                                                                              .toString());
                                                                        } else {
                                                                          slotInformation[slotModelClass[index]
                                                                              .sessionName
                                                                              .toString()] = [
                                                                            slotModelClass[index].slotDetail![slotIndex]!.startTime.toString()
                                                                          ];
                                                                        }
                                                                      }
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsets.symmetric(
                                                                        horizontal:
                                                                            width *
                                                                                0.02,
                                                                        vertical:
                                                                            height *
                                                                                0.01),
                                                                    child:
                                                                        Badge(
                                                                      label:
                                                                          Text(
                                                                        _slotTime.contains(slotModelClass[index].slotDetail![slotIndex]!.id)
                                                                            ? slotModelClass[index].slotDetail![slotIndex]!.maximumPlayers.toString()
                                                                            : (slotModelClass[index].slotDetail![slotIndex]!.maximumPlayers! - slotModelClass[index].slotDetail![slotIndex]!.bookedPlayersCount!.toInt()).toString(),
                                                                        style: const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      alignment:
                                                                          Alignment
                                                                              .topRight,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .blueGrey,
                                                                      isLabelVisible:
                                                                          isPerPlayer,
                                                                      child:
                                                                          Container(
                                                                        height: height *
                                                                            0.06,
                                                                        width: width *
                                                                            0.43,
                                                                        decoration: BoxDecoration(
                                                                            color: _slotTime.contains(slotModelClass[index].slotDetail![slotIndex]!.id)
                                                                                ? Colors.indigoAccent
                                                                                : MyAppState.mode == ThemeMode.light
                                                                                    ? Colors.blueGrey
                                                                                    : Colors.white10,
                                                                            borderRadius: BorderRadius.circular(10)),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceAround,
                                                                          children: [
                                                                            Text(
                                                                              _slotTime.contains(slotModelClass[index].slotDetail![slotIndex]!.id) ? slotModelClass[index].slotDetail![slotIndex]!.startTime!.substring(0, 5) ?? "" : slotModelClass[index].slotDetail![slotIndex]!.startTime!.substring(0, 5) ?? "",
                                                                              style: TextStyle(fontSize: height * 0.02, color: MyAppState.mode == ThemeMode.light ? Colors.black : Colors.grey),
                                                                            ),
                                                                            Container(
                                                                              height: height * 0.022,
                                                                              width: width * 0.042,
                                                                              decoration: BoxDecoration(border: Border.all(color: _slotTime.contains(slotModelClass[index].slotDetail![slotIndex]!.id) ? Colors.transparent : Colors.blueGrey, style: BorderStyle.solid, width: 1), color: _slotTime.contains(slotModelClass[index].slotDetail![slotIndex]!.id) ? Colors.green : Colors.transparent, shape: BoxShape.circle),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ))
                                                              : Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              0.02,
                                                                      vertical:
                                                                          height *
                                                                              0.01),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        height *
                                                                            0.06,
                                                                    width:
                                                                        width *
                                                                            0.43,
                                                                    decoration: BoxDecoration(
                                                                        color: !slotModelClass[index].slotDetail![slotIndex]!.isAvailable!
                                                                            ? appThemeColor
                                                                            : Colors
                                                                                .grey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10)),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        Text(
                                                                          !slotModelClass[index].slotDetail![slotIndex]!.isAvailable!
                                                                              ? slotModelClass[index].slotDetail![slotIndex]!.startTime!.substring(0, 5) ?? ""
                                                                              : slotModelClass[index].slotDetail![slotIndex]!.startTime!.substring(0, 5) ?? "",
                                                                          style: TextStyle(
                                                                              fontSize: height * 0.02,
                                                                              color: !slotModelClass[index].slotDetail![slotIndex]!.isAvailable! ? Colors.grey : Colors.black),
                                                                        ),
                                                                        Radio(
                                                                            value:
                                                                                null,
                                                                            groupValue:
                                                                                null,
                                                                            onChanged:
                                                                                (e) {})
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                        })
                                                      ],
                                                    )
                                                  ],
                                                );
                                        })
                                      ],
                                    ),

                              ///Book Button
                              InkWell(
                                onTap: () {
                                  if (_auth) {
                                    if (_slotPrice.pricePerVenue.isEmpty &&
                                        _slotPrice.pricePerPlayer.isEmpty) {
                                      showMessage(
                                          "Please select your slot first");
                                    } else {
                                      Map apiDetail = {
                                        "date": dataTime,
                                        "id": _slotTime
                                      };
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
                                            .privateVenueDetail
                                            .venueDetails!
                                            .name,
                                        "pitchType": GroundDetailState
                                            .privateVenueDetail
                                            .venueDetails!
                                            .pitchType![0]!
                                            .area,
                                        "ids": widget.detail["pitchId"],
                                        "subPitchId":
                                            widget.detail["subPitchId"]["id"],
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
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  child: Container(
                                      height: height * 0.07,
                                      width: width * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: isPerPlayer
                                          ? Center(
                                              child: Text(
                                                _slotPrice
                                                        .pricePerPlayer.isEmpty
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .bookNowS
                                                    : "${AppLocalizations.of(context)!.slotPrice}: ${(slotPriceCalculation(_slotPrice.pricePerPlayer) * indexItem).round().toString()} AED",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                "en"
                                                            ? 18
                                                            : 22,
                                                    color: Colors.black),
                                              ),
                                            )
                                          : Center(
                                              child: Text(
                                                _slotPrice.pricePerVenue.isEmpty
                                                    ? AppLocalizations.of(
                                                            context)!
                                                        .bookNowS
                                                    : "${AppLocalizations.of(context)!.slotPrice}: ${slotPriceCalculation(_slotPrice.pricePerVenue).round().toString()} AED",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                "en"
                                                            ? 18
                                                            : 22,
                                                    color: Colors.black),
                                              ),
                                            )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Material(
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: InternetLoss(
                      onChange: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          internet = msg;
                          if (msg == true) {}
                        });
                      },
                    ),
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
