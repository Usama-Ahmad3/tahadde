import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/slot_model_class.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';
import 'createSession.dart';

class SlotChart extends StatefulWidget {
  final Map pitchDetail;

  ///
  const SlotChart({Key? key, required this.pitchDetail}) : super(key: key);

  @override
  _SlotChartState createState() => _SlotChartState();
}

class _SlotChartState extends State<SlotChart> {
  final _playerPriceController = TextEditingController(text: '');
  final _venuePriceController = TextEditingController(text: '');
  final focusName = FocusNode();
  // GoogleTranslator translator = GoogleTranslator();
  late int indexItem;
  final NetworkCalls _networkCalls = NetworkCalls();
  int _weakIndex = 0;
  int pitchTypeIndex = 1;
  String vanuePrice = "0";
  String pricePerPlayer = "0";
  var focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  List<SessionResponse> slotList = [];
  final List<WeekDays> _weakList = [];
  late OverlayEntry? overlayEntry;
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: const DoneButton(),
      );
    });
    overlayState.insert(overlayEntry!);
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      focusNode.addListener(() {
        bool hasFocus = focusNode.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
      focusName.addListener(() {
        bool hasFocus = focusName.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    loadSlot();
  }

  loadSlot() {
    _networkCalls.weekList(
        onSuccess: (detail) {
          detail.forEach((element) {
            _weakList
                .add(WeekDays(name: element["name"], slug: element["slug"]));
          });
          loadSlotList();
        },
        onFailure: (onFailure) {},
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  loadSlotList() {
    _networkCalls.slotList(
        id: widget.pitchDetail["id"],
        subPitchId: widget.pitchDetail["subPitchId"],
        weekDay: _weakList[_weakIndex].slug,
        onSuccess: (detail) {
          slotList.clear();
          detail.forEach((slot) {
            slotList.add(SessionResponse.fromJson(slot));
          });
          setState(() {
            _isLoading = false;
          });
        },
        onFailure: (onFailure) {},
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: appBar(
            title: AppLocalizations.of(context)!.slotChart,
            language: AppLocalizations.of(context)!.locale,
            onTap: () {
              Navigator.of(context).pop();
            },
            isBack: widget.pitchDetail["back"] ?? false),
        bottomNavigationBar: Material(
          color: const Color(0XFF25A163),
          child: InkWell(
            onTap: () {
              navigateToVenueCreated();
            },
            splashColor: Colors.black,
            child: Container(
                height: size.height * .104,
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.continueW,
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: Colors.white),
                )),
          ),
        ),
        body: Container(
          height: size.height,
          width: size.width,
          color: const Color(0XFFE5E5E5),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Container(
                    height: size.height * .005,
                    width: size.width * .19,
                    color: const Color(0XFF25A163),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  Container(
                    height: size.height * .005,
                    width: size.width * .19,
                    color: const Color(0XFF25A163),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  Container(
                    height: size.height * .005,
                    width: size.width * .19,
                    color: const Color(0XFF25A163),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  Container(
                    height: size.height * .005,
                    width: size.width * .19,
                    color: const Color(0XFF25A163),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  Container(
                    height: size.height * .005,
                    width: size.width * .19,
                    color: const Color(0XFF25A163),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Container(
                  color: Colors.white,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _weakList.length,
                      itemBuilder: (context, index) {
                        return _weakIndex == index
                            ? Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _weakIndex = index;
                                          _isLoading = true;
                                          loadSlotList();
                                        });
                                      },
                                      child: Container(
                                        width: 43,
                                        height: 43,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: slotList.isEmpty
                                                ? const AssetImage(
                                                    "assets/images/holiday.png")
                                                : const AssetImage(
                                                    "assets/images/book.png"),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        child: Text(
                                          _weakList[index].name.substring(0, 3),
                                          style: const TextStyle(
                                              color: Color(0XFFA3A3A3),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/bar_icon.png",
                                      width: 43,
                                    )
                                  ],
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _weakIndex = index;
                                    _isLoading = true;
                                    loadSlotList();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: 43,
                                    height: 43,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/un_book.png"),
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                    child: Text(
                                      _weakList[index].name.substring(0, 3),
                                      style: const TextStyle(
                                          color: Color(0XFFA3A3A3),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              );
                      }),
                ),
              ),
              _isLoading
                  ? const Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                      color: Color(0XFF25A163),
                    )))
                  : slotList.isNotEmpty
                      ? Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: ListView.builder(
                                  itemCount: slotList.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Text(
                                              "${slotList[index].session_name} ( ${slotList[index].slotDetail![0]!.sport_slot_time.toString()} mins Slot )",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: GridView.builder(
                                                shrinkWrap: true,
                                                itemCount: slotList[index]
                                                    .slotDetail!
                                                    .length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                gridDelegate:
                                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 200,
                                                        childAspectRatio: 4 / 2,
                                                        crossAxisSpacing: 20,
                                                        mainAxisSpacing: 20),
                                                itemBuilder: (context, ind) {
                                                  return GestureDetector(
                                                    onTap: () {
                                                      _venuePriceController
                                                              .text =
                                                          slotList[index]
                                                              .slotDetail![ind]!
                                                              .venuePrice!
                                                              .round()
                                                              .toString();
                                                      _playerPriceController
                                                              .text =
                                                          slotList[index]
                                                              .slotDetail![ind]!
                                                              .pricePerPlayer!
                                                              .round()
                                                              .toString();

                                                      bottomSheet(
                                                          onTap: () {
                                                            setState(() {
                                                              _isLoading = true;
                                                              loadSlotList();
                                                            });
                                                          },
                                                          id: slotList[index]
                                                              .slotDetail![ind]!
                                                              .id!
                                                              .toInt(),
                                                          slotTime: slotList[
                                                                  index]
                                                              .slotDetail![ind]!
                                                              .startTime!
                                                              .substring(0, 5));
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      width: 80,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:
                                                                  Colors.grey)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            slotList[index]
                                                                .slotDetail![
                                                                    ind]!
                                                                .startTime!
                                                                .substring(
                                                                    0, 5),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          slotList[0].sports ==
                                                                  "swimming"
                                                              ? Text(
                                                                  "${slotList[index].slotDetail![ind]!.pricePerPlayer.toString()} AED",
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0XFF25A163)),
                                                                )
                                                              : Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .multipleRates,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      fontSize:
                                                                          12,
                                                                      color: Color(
                                                                          0XFF25A163)),
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        )
                      : Expanded(
                          child: Center(
                          child: Text(
                              "Marked as holiday for ${_weakList[_weakIndex].name} "),
                        )),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToVenueCreated() {
    Navigator.pushNamed(context, RouteNames.venueCreated);
  }

  bottomSheet(
      {required Function onTap, required int id, required String slotTime}) {
    var size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
                heightFactor: .98,
                child: Scaffold(
                  key: _scaffoldKey,
                  appBar: appBar(
                      title: "Edit Slot Chart",
                      language: AppLocalizations.of(context)!.locale,
                      onTap: () {
                        Navigator.of(context).pop();
                      }),
                  bottomNavigationBar: Material(
                    color: const Color(0XFF25A163),
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Map detailValue = {
                            "id": id,
                            "slot_price_per_pitch": int.parse(vanuePrice),
                            "slot_price_per_player": int.parse(pricePerPlayer)
                          };
                          List<Map<dynamic, dynamic>> detail = [detailValue];
                          Map<dynamic, dynamic> updateValue = {
                            "slot_data": detail,
                          };
                          _networkCalls.updateSlot(
                              detail: updateValue,
                              onSuccess: (detail) {
                                showSucess(detail, _scaffoldKey);
                                Navigator.of(context).pop();
                                onTap();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {});
                        }
                      },
                      splashColor: Colors.black,
                      child: Container(
                          height: size.height * .104,
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.continueW,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Container(
                      color: const Color(0XFFE5E5E5),
                      height: size.height * .8,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                flaxibleGap(
                                  1,
                                ),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                              ],
                            ),
                            flaxibleGap(2),
                            Container(
                              height: size.height * .08,
                              width: size.height,
                              color: Colors.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Center(
                                child: Text(
                                  "Price for Slot $slotTime",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: appThemeColor,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                            ),
                            flaxibleGap(2),
                            slotList[0].sports == "swimming"
                                ? const SizedBox.shrink()
                                : Container(
                                    height: size.height * .05,
                                    width: size.height,
                                    color: Colors.white,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0),
                                    child: const Text(
                                      "Price Per Venue",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: appThemeColor),
                                    ),
                                  ),
                            flaxibleGap(1),
                            slotList[0].sports == "swimming"
                                ? const SizedBox.shrink()
                                : Container(
                                    height: size.height * .1,
                                    width: size.width,
                                    color: Colors.white,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      child: TextFormField(
                                        focusNode: focusName,
                                        controller: _venuePriceController,
                                        textAlign: TextAlign.right,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(0),
                                          labelText: "Price per venue",
                                          hintStyle: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10),
                                          labelStyle: const TextStyle(
                                              color: Color(0XFFADADAD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                          prefix: Text(
                                            "${AppLocalizations.of(context)!.amount}: ",
                                            style: const TextStyle(
                                                color: appThemeColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          suffix: const Text(
                                            " AED",
                                            style: TextStyle(
                                                color: appThemeColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                        keyboardType: TextInputType.number,
                                        onSaved: (value) {
                                          vanuePrice = value!;
                                        },
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Please enter amount";
                                          }
                                          return null;
                                        },
                                      ),
                                    )),
                            flaxibleGap(2),
                            Container(
                              height: size.height * .05,
                              width: size.height,
                              color: Colors.white,
                              alignment: Alignment.centerLeft,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: const Text(
                                "Price Per Person",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: appThemeColor),
                              ),
                            ),
                            flaxibleGap(1),
                            Container(
                                height: size.height * .1,
                                width: size.width,
                                color: Colors.white,
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: TextFormField(
                                    focusNode: focusNode,
                                    controller: _playerPriceController,
                                    textAlign: TextAlign.right,
                                    autofocus: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(0),
                                      labelText: "Price per player",
                                      hintStyle: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10),
                                      labelStyle: const TextStyle(
                                          color: Color(0XFFADADAD),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF9F9F9F)),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF9F9F9F)),
                                      ),
                                      prefix: Text(
                                        "${AppLocalizations.of(context)!.amount}: ",
                                        style: const TextStyle(
                                            color: appThemeColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      suffix: const Text(
                                        " AED",
                                        style: TextStyle(
                                            color: appThemeColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    style: const TextStyle(
                                        color: Color(0XFF032040),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                    keyboardType: TextInputType.number,
                                    onSaved: (value) {
                                      pricePerPlayer = value!;
                                    },
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter amount";
                                      }
                                      return null;
                                    },
                                  ),
                                )),
                            flaxibleGap(20),
                          ],
                        ),
                      ),
                    ),
                  ),
                )); //whatever you're returning, does not have to be a Container
          });
        });
  }

  // void trans(String Text, String language, TextEditingController controler) {
  //   if (Text == "") {
  //     setState(() {
  //       controler.text = "";
  //     });
  //   } else {
  //     translator.translate(Text, to: language).then((value) {
  //       setState(() {
  //         controler.text = value.toString();
  //       });
  //     });
  //   }
  // }
  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container();
        });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class SessionDetail {
  bool? isHoliday;
  String? sessionName;
  String? sessionNameAr;
  DateTime? slotDuration;
  DateTime? graceTime;
  DateTime? startTime;
  DateTime? endTime;
  SessionDetail(
      {this.sessionName,
      this.sessionNameAr,
      this.slotDuration,
      this.graceTime,
      this.startTime,
      this.endTime,
      this.isHoliday = false});
}
