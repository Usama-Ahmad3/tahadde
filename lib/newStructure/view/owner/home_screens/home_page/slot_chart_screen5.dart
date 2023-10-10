import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/home_page/academy_created6.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar_for_creating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../constant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../modelClass/slot_model_class.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../pitchOwner/loginSignupPitchOwner/createSession.dart';
import '../../../../app_colors/app_colors.dart';
import '../../../player/HomeScreen/widgets/textFormField.dart';

class SlotChartScreen extends StatefulWidget {
  final Map pitchDetail;
  bool backTag;
  SlotChartScreen({Key? key, required this.pitchDetail, this.backTag = false})
      : super(key: key);

  @override
  State<SlotChartScreen> createState() => _SlotChartScreenState();
}

class _SlotChartScreenState extends State<SlotChartScreen> {
  final _playerPriceController = TextEditingController(text: '');
  final _venuePriceController = TextEditingController(text: '');
  final focusName = FocusNode();
  final NetworkCalls _networkCalls = NetworkCalls();
  int _weakIndex = 0;
  String vanuePrice = "0";
  String pricePerPlayer = "0";
  var focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  List<SessionResponse> slotList = [];
  final List<WeekDays> _weakList = [];
  late OverlayEntry? overlayEntry;

  @override
  void initState() {
    super.initState();
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
        backgroundColor: MyAppState.mode == ThemeMode.light
            ? AppColors.white
            : AppColors.darkTheme,
        appBar: appBarForCreatingAcademy(
            size,
            context,
            AppLocalizations.of(context)!.slotChart,
            false,
            AppColors.barLineColor,
            AppColors.barLineColor,),
        body: Container(
          color: AppColors.black,
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
            decoration: BoxDecoration(
                color: MyAppState.mode == ThemeMode.light
                    ? AppColors.white
                    : AppColors.darkTheme,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.02,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...List.generate(_weakList.length, (index) {
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
                                        width: size.width * 0.2,
                                        height: size.height * 0.05,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            color: slotList.isEmpty
                                                ? Colors.redAccent.shade200
                                                : AppColors.appThemeColor),
                                        child: Text(
                                          _weakList[index].name.substring(0, 3),
                                          style: TextStyle(
                                              color: AppColors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                    Image.asset(
                                      "assets/images/bar_icon.png",
                                      width: size.width * 0.22,
                                      height: size.height * 0.018,
                                      color: AppColors.grey,
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
                                    width: size.width * 0.2,
                                    height: size.height * 0.05,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: AppColors.grey200,
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
                      })
                    ],
                  ),
                ),
                _isLoading
                    ? const Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                        color: AppColors.barLineColor,
                      )))
                    : slotList.isNotEmpty
                        ? Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: ListView.builder(
                                  itemCount: slotList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Text(
                                            "${slotList[index].session_name} ( ${slotList[index].slotDetail![0]!.sport_slot_time.toString()} mins Slot )",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white),
                                          ),
                                        ),
                                        GridView.builder(
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
                                                  _venuePriceController.text =
                                                      slotList[index]
                                                          .slotDetail![ind]!
                                                          .venuePrice!
                                                          .round()
                                                          .toString();
                                                  _playerPriceController.text =
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
                                                      slotTime: slotList[index]
                                                          .slotDetail![ind]!
                                                          .startTime!
                                                          .substring(0, 5));
                                                },
                                                child: Container(
                                                  height: size.height * 0.08,
                                                  decoration: BoxDecoration(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.grey200
                                                          : AppColors.containerColorB,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      border: Border.all(
                                                          color: AppColors.grey)),
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
                                                            .slotDetail![ind]!
                                                            .startTime!
                                                            .substring(0, 5),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 16,
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors.black
                                                                : AppColors.white),
                                                      ),
                                                      slotList[0].sports ==
                                                              "swimming"
                                                          ? Text(
                                                              "${slotList[index].slotDetail![ind]!.pricePerPlayer.toString()} AED",
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 12,
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
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF25A163)),
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                      ],
                                    );
                                  }),
                            ),
                          )
                        : Expanded(
                            child: Center(
                            child: Text(
                              "Marked as holiday for ${_weakList[_weakIndex].name} ",
                              style: TextStyle(
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white),
                            ),
                          )),
                ButtonWidget(
                    onTaped: () {
                      navigateToVenueCreated();
                    },
                    title: Text(AppLocalizations.of(context)!.continu),
                    isLoading: _isLoading),
                SizedBox(
                  height: size.height * 0.01,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToVenueCreated() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const VenueCreatedScreen()));
    // Navigator.pushNamed(context, RouteNames.venueCreated);
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
                  backgroundColor: MyAppState.mode == ThemeMode.light
                      ? Colors.white
                      : const Color(0xff686868),
                  appBar: PreferredSize(
                      preferredSize: Size(size.width, size.height * 0.105),
                      child: AppBar(
                        title: Text(
                          AppLocalizations.of(context)!.slotChart,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Colors.white),
                        ),
                        centerTitle: true,
                        backgroundColor: Colors.black,
                        leadingWidth: size.width * 0.18,
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              MyAppState.mode = ThemeMode.light;
                              setState(() {});
                              bottomSheet(
                                  onTap: () {}, id: 396, slotTime: 'slotTime');
                              // Navigator.pop(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(size.height * 0.008),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    shape: BoxShape.circle),
                                child: const Center(
                                  child: FaIcon(
                                    FontAwesomeIcons.close,
                                    color: Colors.white,
                                  ),
                                )),
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: Size(size.width, 10),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.035),
                            child: Row(
                              children: [
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .17,
                                  color: AppColors.barLineColor,
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .17,
                                  color: AppColors.barLineColor,
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .17,
                                  color: AppColors.barLineColor,
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .17,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                flaxibleGap(1),
                                Container(
                                  height: size.height * .005,
                                  width: size.width * .17,
                                  color: const Color(0XFFCBCBCB),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )),
                  body: SingleChildScrollView(
                    child: Container(
                      color: AppColors.black,
                      child: Container(
                        height: size.height * 0.85,
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * 0.033),
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              flaxibleGap(2),
                              Center(
                                child: Text(
                                  "Price for Slot $slotTime",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.appThemeColor,
                                      fontFamily: "Poppins"),
                                ),
                              ),
                              flaxibleGap(2),
                              slotList[0].sports == "swimming"
                                  ? const SizedBox.shrink()
                                  : const Text(
                                      "Price Per Academy",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.appThemeColor),
                                    ),
                              flaxibleGap(1),
                              slotList[0].sports == "swimming"
                                  ? const SizedBox.shrink()
                                  : TextFieldWidget(
                                      controller: _venuePriceController,
                                      hintText: '',
                                      type: TextInputType.number,
                                      prefix: const Text(
                                        "Amount: ",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      suffix: const Text(
                                        " AED",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      onSubmitted: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(focusNode);
                                        return null;
                                      },
                                      onChanged: (value) {
                                        vanuePrice = value;
                                        return '';
                                      },
                                      onValidate: (value) {
                                        if (value!.isEmpty) {
                                          return "Please enter amount";
                                        }
                                        return null;
                                      },
                                      border: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: AppColors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      enableBorder: OutlineInputBorder(
                                          borderSide:  BorderSide(
                                              color: AppColors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      focusBorder: OutlineInputBorder(
                                          borderSide:   BorderSide(
                                              color: AppColors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12))),
                              flaxibleGap(2),
                              const Text(
                                "Price Per Person",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.appThemeColor),
                              ),
                              flaxibleGap(1),
                              TextFieldWidget(
                                  controller: _playerPriceController,
                                  hintText: '',
                                  focus: focusNode,
                                  type: TextInputType.number,
                                  prefix: const Text(
                                    "Amount: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  suffix: const Text(
                                    " AED",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onChanged: (value) {
                                    pricePerPlayer = value!;
                                    return '';
                                  },
                                  onValidate: (value) {
                                    if (value!.isEmpty) {
                                      return "Please enter amount";
                                    }
                                    return null;
                                  },
                                  border: OutlineInputBorder(
                                      borderSide:
                                           BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                            BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                            BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12))),
                              flaxibleGap(20),
                              ButtonWidget(
                                  onTaped: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      Map detailValue = {
                                        "id": id,
                                        "slot_price_per_pitch":
                                            int.parse(vanuePrice),
                                        "slot_price_per_player":
                                            int.parse(pricePerPlayer)
                                      };
                                      List<Map<dynamic, dynamic>> detail = [
                                        detailValue
                                      ];
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
                                  title: Text(
                                      AppLocalizations.of(context)!.continu),
                                  isLoading: _isLoading)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )); //whatever you're returning, does not have to be a Container
          });
        });
  }

  void showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container();
        });
  }
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
