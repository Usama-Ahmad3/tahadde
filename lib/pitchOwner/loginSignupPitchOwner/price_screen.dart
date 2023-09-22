import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../newStructure/view/owner/home_screens/home_page/select_sport0.dart';
import '../../player/loginSignup/signup.dart';

class PriceScreen extends StatefulWidget {
  SportsModel detail;

  PriceScreen({required this.detail});

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  bool _internet = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  bool _isVenueLoading = false;
  int pitchTypeIndex = 0;
  final _formKey = GlobalKey<FormState>();
  int indexItem = 1;
  String _venuePrice = "0";
  String _playerPrice = "0";
  String? _subVenue;
  String? area;
  final _vanueController = TextEditingController();
  final _priceController = TextEditingController();
  final _pricePerPlayer = TextEditingController();
  var focusNode = FocusNode();
  final List<AreaSlug> _pitchType = [];
  final List<String> _numberPlayerList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    "9",
    '10'
  ];
  late OverlayEntry? overlayEntry;
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: DoneButton(),
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
        if (hasFocus)
          showOverlay(context);
        else
          removeOverlay();
      });
    }
    _networkCalls.availablePitchType(
        sportTypeSlug: widget.detail.sportsType!,
        onSuccess: (detail) {
          for (int i = 0; i < detail.length; i++) {
            _pitchType.add(
                AreaSlug(name: detail[i]["name"], slug: detail[i]["slug"]));
          }
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
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: appThemeColor,
              ),
            )
          : _internet
              ? Scaffold(
                  appBar: appBar(
                      title: AppLocalizations.of(context)!.price,
                      language: AppLocalizations.of(context)!.locale,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      isBack: false),
                  bottomNavigationBar: pitchTypeIndex != null
                      ? _isVenueLoading
                          ? Container(
                              height: size.height * .104,
                              alignment: Alignment.center,
                              color: const Color(0XFF25A163),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ))
                          : Material(
                              color: const Color(0XFF25A163),
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    Map pitchTypeDetail = {
                                      "subpitchtypeName": _vanueController.text,
                                      "payment":
                                          int.parse(_priceController.text),
                                      "area": _pitchType[pitchTypeIndex].name,
                                      "pitchtypeSlug":
                                          _pitchType[pitchTypeIndex].slug,
                                      "price_per_player":
                                          int.parse(_pricePerPlayer.text),
                                      "max_no_of_players": widget
                                                  .detail.sportsType ==
                                              "swimming"
                                          ? int.parse(
                                              _numberPlayerList[indexItem])
                                          : maxPlayer(
                                              _pitchType[pitchTypeIndex].name)
                                    };
                                    Map detail = {
                                      "sport_slug": widget.detail.sportsType,
                                      "pitchName": widget
                                          .detail.pitchDetailModel!.pitchName,
                                      "pitchNamearabic": widget
                                          .detail.pitchDetailModel!.pitchNameAr,
                                      "pitchLocation":
                                          widget.detail.documentModel!.address,
                                      "pitchDescription": widget
                                          .detail.pitchDetailModel!.description,
                                      "pitchDescriptionarabic": widget.detail
                                          .pitchDetailModel!.descriptionAr,
                                      "gameplaySlug": widget
                                          .detail.pitchDetailModel!.gamePlay,
                                      "facilitiesSlug": widget
                                          .detail.pitchDetailModel!.facility,
                                      "pitchLatitude":
                                          widget.detail.documentModel!.lat,
                                      "pitchLongitude":
                                          widget.detail.documentModel!.long,
                                      "pitchimageId": widget.detail
                                          .pitchDetailModel!.pitchImageId,
                                      "pitchdocId": widget.detail.documentModel!
                                          .documentImageId,
                                      "document_code": widget
                                          .detail.documentModel!.licenceNumber,
                                      "pitchtypeDetails": [pitchTypeDetail],
                                      "document_name": widget
                                          .detail.documentModel!.documentName,
                                      "documents_expiry_date": widget
                                          .detail.documentModel!.expiryDate,
                                      "code":
                                          widget.detail.pitchDetailModel!.code,
                                      "country":
                                          widget.detail.documentModel!.country,
                                    };
                                    setState(() {
                                      _isVenueLoading = true;
                                    });
                                    _networkCalls.createVenue(
                                        detail: detail,
                                        onSuccess: (detail) {
                                          setState(() {
                                            navigateToSession(detail);
                                            _isVenueLoading = false;
                                          });
                                        },
                                        onFailure: (onFailure) {},
                                        tokenExpire: () {});
                                  }
                                },
                                splashColor: Colors.black,
                                child: Container(
                                    height: size.height * .104,
                                    alignment: Alignment.center,
                                    child: _isVenueLoading
                                        ? const CircularProgressIndicator(
                                            color: Colors.white,
                                          )
                                        : Text(
                                            AppLocalizations.of(context)!
                                                .continueW,
                                            style: const TextStyle(
                                                fontFamily: "Poppins",
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20,
                                                color: Colors.white),
                                          )),
                              ),
                            )
                      : Container(
                          height: size.height * .104,
                          color: const Color(0XFFBCBCBC),
                          alignment: Alignment.center,
                          child: Text(
                            AppLocalizations.of(context)!.continueW,
                            style: const TextStyle(
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.white),
                          )),
                  body: LayoutBuilder(
                    builder: (context, constraint) {
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: constraint.maxHeight),
                          child: Container(
                            height: size.height * .1,
                            width: size.width,
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: size.height * .005,
                                            width: size.width * .19,
                                            color: const Color(0XFF25A163),
                                          ),
                                          flaxibleGap(1),
                                          Container(
                                            height: size.height * .005,
                                            width: size.width * .19,
                                            color: const Color(0XFF25A163),
                                          ),
                                          flaxibleGap(1),
                                          Container(
                                            height: size.height * .005,
                                            width: size.width * .19,
                                            color: const Color(0XFF25A163),
                                          ),
                                          flaxibleGap(1),
                                          Container(
                                            height: size.height * .005,
                                            width: size.width * .19,
                                            color: const Color(0XFFCBCBCB),
                                          ),
                                          flaxibleGap(1),
                                          Container(
                                            height: size.height * .005,
                                            width: size.width * .19,
                                            color: const Color(0XFFCBCBCB),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Material(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color(0XFF25A163)
                                              .withOpacity(.18),
                                          borderRadius: const BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            topLeft: Radius.circular(15),
                                          ),
                                          //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                                        ),
                                        constraints: BoxConstraints(
                                            maxHeight: size.height * .06),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              cachedNetworkImage(
                                                  cuisineImageUrl:
                                                      widget.detail.sportsImage,
                                                  height: 20,
                                                  width: 20,
                                                  imageFit: BoxFit.fill),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(widget.detail.sportsName!,
                                                  style: const TextStyle(
                                                      color: Color(0XFF032040),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: "Poppins")),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                        height: size.height * .1,
                                        color: Colors.white,
                                        padding: const EdgeInsets.only(top: 20),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: textField(
                                              controller: _vanueController,
                                              name: "Sub-Venue name",
                                              // controller: _nameControllerArabic,
                                              text: false,
                                              text1: false,
                                              focusAuto: true,
                                              // submit: (value) =>
                                              //     FocusScope.of(context).requestFocus(codeFocus),
                                              onSaved: (value) =>
                                                  _subVenue = value!),
                                        )),
                                    widget.detail.sportsType == "swimming"
                                        ? const SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15.0, vertical: 10),
                                            child: SizedBox(
                                              width: size.width,
                                              height: size.height * .08,
                                              child: CustomDropdown(
                                                leadingIcon: false,
                                                icon: Image.asset(
                                                  "assets/images/drop_down.png",
                                                  height: 8,
                                                ),
                                                onChange:
                                                    (int value, int index) =>
                                                        setState(() {
                                                  pitchTypeIndex = index;
                                                }),
                                                dropdownButtonStyle:
                                                    const DropdownButtonStyle(
                                                  width: 170,
                                                  height: 45,
                                                  elevation: 1,
                                                  backgroundColor: Colors.white,
                                                  primaryColor: Colors.black87,
                                                ),
                                                dropdownStyle: DropdownStyle(
                                                  borderRadius:
                                                      BorderRadius.circular(0),
                                                  elevation: 6,
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                ),
                                                items: _pitchType
                                                    .asMap()
                                                    .entries
                                                    .map(
                                                      (item) => DropdownItem(
                                                        value: item.key + 1,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 8.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(item
                                                                      .value
                                                                      .name),
                                                                ],
                                                              ),
                                                              const Divider()
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                    .toList(),
                                                child: Text(
                                                  _pitchType[pitchTypeIndex]
                                                      .name,
                                                ),
                                              ),
                                            ),
                                          ),
                                    widget.detail.sportsType == "swimming"
                                        ? Container(
                                            width: size.width,
                                            padding: const EdgeInsets.only(
                                                top: 10, left: 15, right: 15),
                                            child: CustomDropdown(
                                              leadingIcon: false,
                                              icon: Image.asset(
                                                "assets/images/drop_down.png",
                                                height: 6,
                                              ),
                                              onChange:
                                                  (int value, int index) =>
                                                      setState(() {
                                                indexItem = index;
                                              }),
                                              dropdownButtonStyle:
                                                  const DropdownButtonStyle(
                                                width: 170,
                                                height: 45,
                                                elevation: 1,
                                                backgroundColor: Colors.white,
                                                primaryColor: Colors.black87,
                                              ),
                                              dropdownStyle: DropdownStyle(
                                                borderRadius:
                                                    BorderRadius.circular(0),
                                                elevation: 6,
                                                padding:
                                                    const EdgeInsets.all(5),
                                              ),
                                              items: _numberPlayerList
                                                  .asMap()
                                                  .entries
                                                  .map(
                                                    (item) => DropdownItem(
                                                      value: item.key + 1,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 8.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                    item.value),
                                                              ],
                                                            ),
                                                            const Divider()
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                              child: const Text(
                                                'Max No. of Players',
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                    widget.detail.sportsType == "swimming"
                                        ? const SizedBox.shrink()
                                        : Container(
                                            height: size.height * .1,
                                            width: size.width,
                                            color: Colors.white,
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 15.0),
                                              child: TextFormField(
                                                textAlign: TextAlign.right,
                                                controller: _priceController,
                                                autofocus: true,
                                                decoration:
                                                    const InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  labelText: "Venue price",
                                                  hintStyle: TextStyle(
                                                      color: Color(0XFF032040),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 10),
                                                  labelStyle: TextStyle(
                                                      color: Color(0XFFADADAD),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0XFF9F9F9F)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0XFF9F9F9F)),
                                                  ),
                                                  prefix: Text(
                                                    "Amount: ",
                                                    style: TextStyle(
                                                        color: appThemeColor,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  suffix: Text(
                                                    " AED",
                                                    style: TextStyle(
                                                        color: appThemeColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                style: const TextStyle(
                                                    color: Color(0XFF032040),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14),
                                                keyboardType:
                                                    TextInputType.number,
                                                onSaved: (value) {
                                                  _venuePrice = value!;
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Please enter amount";
                                                  }
                                                  return null;
                                                },
                                              ),
                                            )),
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
                                            controller: _pricePerPlayer,
                                            textAlign: TextAlign.right,
                                            autofocus: true,
                                            decoration: const InputDecoration(
                                              contentPadding: EdgeInsets.all(0),
                                              labelText: "Price per player",
                                              hintStyle: TextStyle(
                                                  color: Color(0XFF032040),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 10),
                                              labelStyle: TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color(0XFF9F9F9F)),
                                              ),
                                              prefix: Text(
                                                "Amount: ",
                                                style: TextStyle(
                                                    color: appThemeColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              suffix: Text(
                                                " AED",
                                                style: TextStyle(
                                                    color: appThemeColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              _playerPrice = value!;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return "Please enter amount";
                                              }
                                              return null;
                                            },
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ), // This trailing comma makes auto-formatting nicer for build methods.
                )
              : Column(
                  children: [
                    buildAppBar(
                        language: AppLocalizations.of(context)!.locale,
                        title: AppLocalizations.of(context)!.pitchBookings,
                        height: size.height,
                        width: size.width),
                    Expanded(
                      child: InternetLoss(
                        onChange: () {
                          _networkCalls.checkInternetConnectivity(
                              onSuccess: (msg) {
                            _internet = msg;
                          });
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  _buildShimmer(sizeWidth, sizeHeight) {
    return SizedBox(
      width: sizeWidth,
      height: sizeHeight,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            height: sizeHeight,
            width: sizeWidth,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildAppBar(
                    language: AppLocalizations.of(context)!.locale,
                    title: AppLocalizations.of(context)!.pitchBookings,
                    height: sizeHeight,
                    width: sizeWidth),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeWidth * .05, vertical: sizeHeight * .01),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .4,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              width: sizeWidth * .2,
                              height: 5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      flaxibleGap(4),
                      Container(
                        height: sizeHeight * .06,
                        width: sizeHeight * .07,
                        decoration: const BoxDecoration(
                          color: Color(0XFF032040),
                          borderRadius: BorderRadius.all(Radius.circular(5.0) //
                              ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/images/closed.png',
                              fit: BoxFit.cover,
                              height: sizeHeight * .03,
                            ),
                            Text(
                              AppLocalizations.of(context)!.closed,
                              style: const TextStyle(
                                  fontSize: 8, color: Color(0XFF9B9B9B)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0XFF25A163).withOpacity(.18),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                      ),
                      //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
                    ),
                    constraints: BoxConstraints(maxHeight: sizeHeight * .06),
                    child: TabBar(
                      labelColor: const Color(0XFF032040),
                      //controller: tabController,
                      labelStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Poppins"),
                      unselectedLabelColor: const Color(0XFFADADAD),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: const EdgeInsets.only(),
                      indicatorColor: const Color(0XFF032040),
                      indicatorWeight: 4,

                      tabs: [
                        Tab(
                            child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: sizeWidth * .4,
                            alignment: Alignment.bottomCenter,
                            child: Text(AppLocalizations.of(context)!.booking,
                                style: const TextStyle(
                                    //color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                          ),
                        )),
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Container(
                              width: sizeWidth * .4,
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                AppLocalizations.of(context)!.manageSlots,
                                style: const TextStyle(
                                    // color: Color(0XFF032040),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins"),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [_buildBodySimmer(), _buildBodySimmer()],
                  ),
                ),
              ],
            ),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }

  Widget _buildBodySimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: _shimmerCard(),
        ),
        itemCount: 5,
      ),
    );
  }

  Widget _shimmerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        height: 80,
        decoration: const BoxDecoration(
          color: Color(0XFFF7F7F7),
          borderRadius: BorderRadius.all(Radius.circular(5.0) //

              ),
        ),
        child: Row(
          children: <Widget>[
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                height: 60,
                width: 60,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  // image: Image.network(profileDetail.profile_pic),
                ),
              ),
            ),
            flaxibleGap(2),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 250,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    height: 5,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5.0) //

                          ),
                    ),
                  ),
                ),
              ],
            ),
            flaxibleGap(14),
          ],
        ),
      ),
    );
  }

  int maxPlayer(String area) {
    String s = area.toLowerCase();
    int idx = s.indexOf("x");
    String areaValue = s.substring(0, idx).trim();
    int areaInt = int.parse(areaValue);
    print((areaInt * 2).toString());
    return areaInt * 2;
  }

  void navigateToSession(Map data) {
    Navigator.pushNamed(context, RouteNames.createSession, arguments: data);
  }
}

class AreaSlug {
  String name;
  String slug;
  AreaSlug({required this.name, required this.slug});
}
// DefaultTabController(
// length: 2,
// child: Scaffold(
// appBar:   appBar(title:AppLocalizations.of(context).price,language: AppLocalizations.of(context).locale,onTap: (){
// Navigator.of(context).pop();
// } ),
// body: LayoutBuilder(
// builder: (context, constraint) {
// return SingleChildScrollView(
// physics: AlwaysScrollableScrollPhysics(),
// child: ConstrainedBox(
// constraints: BoxConstraints(
// minHeight: constraint.maxHeight),
// child: Container(
// height: sizeHeight * .1,
// width: sizeWidth,
// color: Colors.white,
// child: Column(
// crossAxisAlignment:
// CrossAxisAlignment.center,
// children: <Widget>[
// Padding(
// padding: const EdgeInsets.only(bottom: 10.0),
// child: Row(
// children: <Widget>[
// Container(
// height: sizeHeight * .005,
// width: sizeWidth * .19,
// color: Color(0XFF25A163),
// ),
// flaxibleGap(
// 1,
// ),
// Container(
// height: sizeHeight * .005,
// width: sizeWidth * .19,
// color: Color(0XFF25A163),
// ),
// flaxibleGap(
// 1,
// ),
// Container(
// height: sizeHeight * .005,
// width: sizeWidth * .19,
// color: Color(0XFF25A163),
// ),
// flaxibleGap(
// 1,
// ),
// Container(
// height: sizeHeight * .005,
// width: sizeWidth * .19,
// color: Color(0XFFCBCBCB),
// ),
// flaxibleGap(
// 1,
// ),
// Container(
// height: sizeHeight * .005,
// width: sizeWidth * .19,
// color: Color(0XFFCBCBCB),
// ),
// ],
// ),
// ),
// Material(
// child: Container(
// decoration: BoxDecoration(
// color: Color(0XFF25A163)
//     .withOpacity(.18),
// borderRadius: BorderRadius.only(
// topRight: Radius.circular(15),
// topLeft: Radius.circular(15),
// ),
// //border: Border.all(width: 3,color: Color(0XFFE0E0E0),style: BorderStyle.solid)
// ),
// constraints: BoxConstraints(
// maxHeight: sizeHeight * .06),
// child: TabBar(
// labelColor: Color(0XFF032040),
// //controller: tabController,
// labelStyle: TextStyle(
// fontSize: 18,
// fontWeight: FontWeight.w600,
// fontFamily: "Poppins"),
// unselectedLabelColor:
// Color(0XFFADADAD),
// indicatorSize:
// TabBarIndicatorSize.label,
// indicatorPadding: EdgeInsets.only(),
// indicatorColor: Colors.green,
// indicatorWeight: 4,
//
// tabs: [
// Tab(
// child: Padding(
// padding: const EdgeInsets.only(
// bottom: 6.0),
// child: Container(
// width: sizeWidth * .4,
// alignment:
// Alignment.bottomCenter,
// child: Text(
// "Price per player",
// style: TextStyle(
// //color: Color(0XFF032040),
// fontSize: 14,
// fontWeight:
// FontWeight.w600,
// fontFamily:
// "Poppins")),
// ),
// )),
// Tab(
// child: Padding(
// padding:
// const EdgeInsets.only(
// bottom: 6.0),
// child: Container(
// width: sizeWidth * .4,
// alignment:
// Alignment.bottomCenter,
// child: Text(
// "Venue price",
// style: TextStyle(
// // color: Color(0XFF032040),
// fontSize: 14,
// fontWeight:
// FontWeight.w600,
// fontFamily:
// "Poppins"),
// ),
// ),
// ),
// ),
// ],
// ),
// ),
// ),
// Expanded(
// child: TabBarView(
// children: [
// PlayerPrice(),
// VenuePrice(),
// ],
// ),
// ),
// ],
// ),
// ),
// ),
// );
// },
// ), // This trailing comma makes auto-formatting nicer for build methods.
// ),
// )
