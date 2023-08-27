import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchModelClass.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class VerifiedPitchDetail extends StatefulWidget {
  Map pitchDetail;
  VerifiedPitchDetail({required this.pitchDetail});
  @override
  _VerifiedPitchDetailState createState() => _VerifiedPitchDetailState();
}

class _VerifiedPitchDetailState extends State<VerifiedPitchDetail> {
  bool addPitch = false;
  final _formKey = GlobalKey<FormState>();
  final focus = FocusNode();
  late String pitchName;
  late String pitchTypeSlug;
  late int count;
  late String pitchType;
  var price;
  late bool _internet;
  final NetworkCalls _networkCalls = NetworkCalls();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late BookPitchDetail pitchDetail;
  bool _isLoading = true;
  final _pitchType = [
    "5x5",
    "7x7",
    "11x11",
  ];
  final _pitchTypeSlug = [
    "5-aside",
    "7-aside",
    "11-aside",
  ];
  loadVerifiedPitch() async {
    await _networkCalls.verifiedPitchInfoDetail(
      detail: widget.pitchDetail,
      onSuccess: (event) {
        setState(() {
          _isLoading = false;
          pitchDetail = event;
        });
      },
      onFailure: (msg) {
        setState(() {
          _isLoading = false;
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

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
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  Future onWillPop(String id) {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(
              AppLocalizations.of(context)!.areYouSureYouWant,
              style: const TextStyle(
                  color: Color(0XFF032040),
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
            actions: <Widget>[
              TextButton(
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0XFFA3A3A3)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("  ${AppLocalizations.of(context)!.no}  ",
                          style: const TextStyle(color: Color(0XFF696969))),
                    )),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0XFF25A163),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text("  ${AppLocalizations.of(context)!.yes}  ",
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
                onPressed: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      setState(() {
                        _isLoading = true;
                        Navigator.of(context).pop(false);
                        _networkCalls.deleteSubPitch(
                          id: widget.pitchDetail["id"],
                          pitchTypeId: id,
                          onSuccess: (msg) {
                            loadVerifiedPitch();
                          },
                          onFailure: (b){

                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      });
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                      }
                    }
                  });
                },
              )
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focus.addListener(() {
        bool hasFocus = focus.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      msg
          ? loadVerifiedPitch()
          : setState(() {
              _isLoading = false;
            });
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              backgroundColor: appThemeColor,
              valueColor: AlwaysStoppedAnimation<Color>(
                Color(0XFF25A163),
              ),
            ),
          )
        : _internet
            ? Scaffold(
                key: _scaffoldKey,
                body: Stack(
                  children: <Widget>[
                    Scaffold(
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
                          backgroundColor: const Color(0XFF032040),
                          automaticallyImplyLeading: false,
                          title: pitchDetail.is_verified!
                              ? Text(
                                  AppLocalizations.of(context)!.verifiedPitch,
                                  style: const TextStyle(
                                      fontSize: appHeaderFont,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins"),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.inReview,
                                  style: TextStyle(
                                      fontSize: appHeaderFont,
                                      color: const Color(0XFFFFFFFF),
                                      fontFamily:
                                          AppLocalizations.of(context)!.locale ==
                                                  "en"
                                              ? "Poppins"
                                              : "VIP",
                                      fontWeight:
                                          AppLocalizations.of(context)!.locale ==
                                                  "en"
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                ),
                        ),
                        body: ListView(
                          children: <Widget>[
                            cachedNetworkImage(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              cuisineImageUrl: pitchDetail.bookpitchfiles!.files![0]!.filePath ?? '',
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: sizeWidth * .05,
                                  right: sizeWidth * .05,
                                  top: sizeWidth * .03),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    pitchDetail.name ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0XFF032040),
                                        decoration: TextDecoration.none),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  pitchDetail.is_verified!
                                      ? GestureDetector(
                                          onTap: () {
                                            navigateToEditPitch();
                                          },
                                          child: const Icon(
                                            Icons.edit,
                                            size: 16,
                                            color: Color(0XFFBCBCBC),
                                          ),
                                        )
                                      : Container()
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .05),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: SizedBox(
                                      width: sizeWidth * .3,
                                      child: Text(
                                        pitchDetail.location ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF646464),
                                            decoration: TextDecoration.none),
                                        maxLines: 4,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 5),
                                    child: Container(
                                      height: 20,
                                      width: 1,
                                      color: const Color(0XFF646464),
                                    ),
                                  ),
                                  pitchDetail.gamePlay == null
                                      ? Container()
                                      : Text(
                                          "${pitchDetail.gamePlay!.name} ${AppLocalizations.of(context)!.pitch}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0XFF25A163),
                                              decoration: TextDecoration.none),
                                        ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .05,
                                  vertical: sizeHeight * .02),
                              child: Text(
                                pitchDetail.description ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF9B9B9B),
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Container(
                              color: const Color(0XFFF2F2F2),
                              height: sizeHeight * .4,
                              width: sizeWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .05,
                                          vertical: sizeHeight * .02),
                                      child: Text(
                                        AppLocalizations.of(context)!.myPitches,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF9B9B9B),
                                            decoration: TextDecoration.none),
                                      )),
                                  pitchDetail.is_verified!
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                            left: sizeWidth * .05,
                                            right: sizeWidth * .05,
                                          ),
                                          child: Container(
                                            height: sizeHeight * .08,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: const Color(0XFF032040)),
                                              borderRadius: const BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: sizeWidth * .04,
                                                  vertical: sizeHeight * .01),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  GestureDetector(
                                                    child: Container(
                                                      height: sizeHeight * .06,
                                                      width: sizeHeight * .06,
                                                      decoration: BoxDecoration(
                                                        color: const Color(0XFF25A163)
                                                            .withOpacity(.3),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                      ),
                                                      child: Image.asset(
                                                        'images/addnew.png',
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        addPitch = true;
                                                      });
                                                    },
                                                  ),
                                                  Container(
                                                    width: sizeWidth * .03,
                                                  ),
                                                  Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .addNewPitch,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF032040),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily:
                                                              "Poppins")),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: sizeHeight * .25,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: pitchDetail.pitchType!.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.only(
                                                left: sizeWidth * .05,
                                                right: sizeWidth * .05,
                                                top: sizeHeight * .01),
                                            child: Container(
                                              height: sizeHeight * .08,
                                              width: sizeWidth * .8,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                  color: Color(0XFF032040)),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .04),
                                                    child: Text(
                                                        "${pitchDetail.pitchType![index]!.area}",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF25A163),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 18)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .02),
                                                    child: Container(
                                                      height: sizeHeight * .05,
                                                      width: 2,
                                                      color: const Color(0XFF979797),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .02),
                                                    child: Container(
                                                      width: sizeWidth * .3,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                          "${pitchDetail.pitchType![index]!.name}",
                                                          style: const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontFamily:
                                                                  "Poppins",
                                                              fontSize: 14)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    .05),
                                                    child: Text(
                                                        "${AppLocalizations.of(context)!.currency} ${pitchDetail.pitchType![index]!.paymentSummary!.grandTotal.round()}",
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF9B9B9B),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontFamily:
                                                                "Poppins",
                                                            fontSize: 14)),
                                                  ),
                                                  pitchDetail.is_verified!
                                                      ? GestureDetector(
                                                          onTap: () {
                                                            onWillPop(pitchDetail
                                                                .pitchType![
                                                                    index]!
                                                                .id
                                                                .toString());
                                                          },
                                                          child: Image.asset(
                                                            'images/delete.png',
                                                            height: 15,
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10, top: 10),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: sizeHeight * .27,
                                  color: const Color(0XFFF2F2F2),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20, bottom: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 20),
                                          child: Text(
                                              AppLocalizations.of(context)
                                                  !.facilityProvided,
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 12,
                                                color: Color(0XFF9B9B9B),
                                              )),
                                        ),
                                        SizedBox(
                                          height: sizeHeight * .15,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  pitchDetail.facilities!.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int blockIdx) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    width: sizeWidth * .28,
                                                    height: sizeWidth * .07,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(0XFF25A163)
                                                          .withOpacity(.3),
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        flaxibleGap(
                                                          2,
                                                        ),
                                                        cachedNetworkImage(
                                                            height: sizeHeight *
                                                                .08,
                                                            width:
                                                                sizeWidth * .18,
                                                            cuisineImageUrl:
                                                                pitchDetail
                                                                    ?.facilities![
                                                                        blockIdx]
                                                                    ?.image
                                                                    ?.filePath,
                                                            imageFit:
                                                                BoxFit.fill),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                        Text(
                                                            pitchDetail
                                                                .facilities![
                                                                    blockIdx]!
                                                                .name.toString(),
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0XFF424242),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none)),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                            Container(
                              color: const Color(0XFFF2F2F2),
                              height: sizeHeight * .3,
                              width: sizeWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: sizeWidth * .05,
                                          vertical: sizeHeight * .02),
                                      child: Text(
                                        AppLocalizations.of(context)!.documents,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF9B9B9B),
                                            decoration: TextDecoration.none),
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: sizeWidth * .05,
                                      right: sizeWidth * .05,
                                    ),
                                    child: cachedNetworkImage(
                                      height: sizeHeight * .22,
                                      width: MediaQuery.of(context).size.width,
                                      cuisineImageUrl: pitchDetail
                                              .bookpitchfiles!.document!.filePath ?? '',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    addPitch
                        ? BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              color: Colors.black.withOpacity(0),
                            ),
                          )
                        : Container(),
                    addPitch
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .05),
                              child: Form(
                                key: _formKey,
                                child: Container(
                                  height: sizeHeight * .5,
                                  width: sizeWidth,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(
                                        1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .addnewpitchdetails,
                                                style: const TextStyle(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Color(0XFFADADAD),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins")),
                                            flaxibleGap(
                                              1,
                                            ),
                                            SizedBox(
                                              height: sizeHeight * .03,
                                              child: FloatingActionButton(
                                                onPressed: () {
                                                  setState(() {
                                                    addPitch = false;
                                                  });
                                                },
                                                backgroundColor:
                                                    const Color(0XFFD8D8D8),
                                                splashColor: Colors.black,
                                                child: Icon(
                                                  Icons.clear,
                                                  color: const Color(0XFF4A4A4A),
                                                  size: sizeHeight * .02,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Material(
                                        color: Colors.transparent,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05),
                                          child: TextFormField(
                                            textInputAction:
                                                TextInputAction.next,
                                            onFieldSubmitted: (value) {
                                              FocusScope.of(context)
                                                  .requestFocus(focus);
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseentername;
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.text,
                                            onSaved: (value) {
                                              pitchName = value!;
                                            },
                                            autofocus: false,
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.all(0),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .name, //\uD83D\uDD12
                                              labelStyle: const TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12),
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        1,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05),
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .selectPitchType,
                                            style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Color(0XFFADADAD),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins")),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: sizeWidth * .05,
                                            vertical: sizeHeight * .005),
                                        child: SizedBox(
                                          height: sizeHeight * .11,
                                          child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: _pitchType.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int blockIdx) {
                                                return Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (count == blockIdx) {
                                                          count = 0;
                                                          pitchType = '';
                                                        } else {
                                                          count = blockIdx;
                                                          pitchType =
                                                              _pitchType[
                                                                  blockIdx];
                                                          pitchTypeSlug =
                                                              _pitchTypeSlug[
                                                                  blockIdx];
                                                          //pitchType=_pitchType[blockIdx][0].substring(0 + _pitchType[blockIdx][0].length, 1).trim();
                                                        }
                                                      });
                                                    },
                                                    child: count == blockIdx
                                                        ? Container(
                                                            height: sizeHeight *
                                                                .11,
                                                            width: sizeHeight *
                                                                .13,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                  0XFF032040),
                                                              border: Border.all(
                                                                  color: const Color(
                                                                      0XFF979797)),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          10.0) //                 <--- border radius here
                                                                      ),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              _pitchType[blockIdx],
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Color(
                                                                      0XFF25A163),
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: sizeHeight *
                                                                .11,
                                                            width: sizeHeight *
                                                                .13,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: const Color(
                                                                      0XFF25A163)
                                                                  .withOpacity(
                                                                      .25),
                                                              borderRadius:
                                                                  const BorderRadius.all(
                                                                      Radius.circular(
                                                                          10.0) //                 <--- border radius here
                                                                      ),
                                                            ),
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              _pitchType[blockIdx],
                                                              style: const TextStyle(
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none,
                                                                  color: Color(
                                                                      0XFF646464),
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 32,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                          ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      Material(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * .05,
                                              vertical: sizeHeight * .005),
                                          child: TextFormField(
                                            focusNode: focus,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return AppLocalizations.of(
                                                        context)!
                                                    .pleaseenterprice;
                                              }
                                              return null;
                                            },
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              price = value;
                                            },
                                            autofocus: false,
                                            style: const TextStyle(
                                                color: Color(0XFF032040),
                                                fontWeight: FontWeight.w500),
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.all(0),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .price, //\uD83D\uDD12
                                              labelStyle: const TextStyle(
                                                  color: Color(0XFFADADAD),
                                                  fontSize: 12),
                                              suffixText:
                                                  AppLocalizations.of(context)!
                                                      .currency,
                                              suffixStyle: const TextStyle(
                                                  color: Color(0XFF858585),
                                                  fontSize: 12),
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
                                            ),
                                          ),
                                        ),
                                      ),
                                      flaxibleGap(
                                        3,
                                      ),
                                      pitchType != null
                                          ? GestureDetector(
                                              onTap: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  _formKey.currentState!.save();
                                                  _networkCalls
                                                      .checkInternetConnectivity(
                                                          onSuccess: (msg) {
                                                    if (msg == true) {
                                                      setState(() {
                                                        //saveData.add(SaveData(price: price,pitchType: pitchType,pitchName: pitchName,pitchTypeSlug: pitchTypeSlug));
                                                        addPitch = false;
                                                        _isLoading = true;
                                                        Map detai = {
                                                          "subpitchtypeName":
                                                              pitchName,
                                                          "payment": price,
                                                          "pitchtypeSlug":
                                                              pitchTypeSlug,
                                                          "area": pitchType
                                                        };
                                                        _networkCalls
                                                            .createSubPitch(
                                                          bodydata: detai,
                                                          id: widget
                                                                  .pitchDetail[
                                                              "id"],
                                                          onSuccess: (msg) {
                                                            loadVerifiedPitch();
                                                          },
                                                          onFailure: (msg) {
                                                            showMessage(msg);
                                                          },
                                                          tokenExpire: () {
                                                            if (mounted) {
                                                              on401(context);
                                                            }
                                                          },
                                                        );
                                                      });
                                                    } else {
                                                      if (mounted) {
                                                        showMessage(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .noInternetConnection);
                                                      }
                                                    }
                                                  });
                                                }
                                              },
                                              child: Container(
                                                  color: const Color(0XFF25A163),
                                                  height: sizeHeight * .08,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    AppLocalizations.of(context)!
                                                        .save,
                                                    style: const TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: "Poppins",
                                                    ),
                                                  )),
                                            )
                                          : Container(
                                              color: const Color(0XFFBCBCBC),
                                              height: sizeHeight * .08,
                                              alignment: Alignment.center,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .save,
                                                style: const TextStyle(
                                                  decoration:
                                                      TextDecoration.none,
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
                            ),
                          )
                        : Container(),
                  ],
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadVerifiedPitch();
                    }
                  });
                },
              );
  }

  void navigateToEditPitch() {
    Navigator.pushNamed(context, RouteNames.editPitch, arguments: widget.pitchDetail);
  }
}
