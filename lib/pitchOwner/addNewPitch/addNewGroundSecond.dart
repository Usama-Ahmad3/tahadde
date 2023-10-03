import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class AddNewGroundSecond extends StatefulWidget {
  Map? detail;
  AddNewGroundSecond({super.key, this.detail});
  @override
  _AddNewGroundSecondState createState() => _AddNewGroundSecondState();
}

class _AddNewGroundSecondState extends State<AddNewGroundSecond> {
  final NetworkCalls _networkCalls = NetworkCalls();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final focus = FocusNode();
  final bool _isLoading = false;
  bool _isImageLoading = false;
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  var _expiryDate;
  late String _pitchName;
  bool _addPitch = false;
  late String pitchType;
  late String pitchTypeSlug;
  var price;
  final _formKey = GlobalKey<FormState>();
  List<SaveData> saveData = [];
  List pitchDetailList = [];
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

  late File myFile;
  bool internet = true;
  late File image;
  var doc_Id;
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.uploadprofilepicture),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.choosefromlibrary),
                    onTap: () async {
                      var status = await Permission.photos.status;
                      if (status.isGranted) {
                        _openGallery(context);
                      } else if (status.isDenied) {
                        _openGallery(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .galleryPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisGalleryPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text(AppLocalizations.of(context)!.takephoto),
                    onTap: () async {
                      var status = await Permission.camera.status;
                      if (status.isGranted) {
                        // ignore: use_build_context_synchronously
                        _openCamera(context);
                      } else if (status.isDenied) {
                        _openCamera(context);
                      } else {
                        // ignore: use_build_context_synchronously
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .cameraPermission),
                                  content: Text(AppLocalizations.of(context)!
                                      .thisPicturesUploadImage),
                                  actions: <Widget>[
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.deny),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                          AppLocalizations.of(context)!.setting),
                                      onPressed: () => openAppSettings(),
                                    ),
                                  ],
                                ));
                      }
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<DateTime?> slecteDtateTime(BuildContext context) => showDatePicker(
        context: context,
        initialDate: DateTime.now().add(const Duration(seconds: 1)),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050),
        locale: Locale(AppLocalizations.of(context)!.locale),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(primary: Color(0XFF032040)),
              buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child!,
          );
        },
      );
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
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            body: SizedBox(
              width: sizeWidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 60.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: sizeHeight * .6,
                                      color: Colors.white,
                                      padding:
                                          const EdgeInsets.only(left: 16, right: 16),
                                    ),
                                    Container(
                                      height: sizeHeight * .15,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Stack(
            children: <Widget>[
              Scaffold(
                key: _scaffoldKey,
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
                  automaticallyImplyLeading: false,
                  title: Text(
                    AppLocalizations.of(context)!.addNewGroundPitch,
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
                bottomNavigationBar: doc_Id != null &&
                        saveData.isNotEmpty &&
                        _expiryDate != null
                    ? Material(
                        color: const Color(0XFF25A163),
                        child: InkWell(
                          onTap: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              if (msg) {
                                pitchDetailList.clear();
                                for (int i = 0; i < saveData.length; i++) {
                                  Map pitchDetail = {
                                    "subpitchtypeName": saveData[i].pitchName,
                                    "payment": saveData[i].price,
                                    "area": saveData[i].pitchType,
                                    "pitchtypeSlug": saveData[i].pitchTypeSlug,
                                  };
                                  pitchDetailList.add(pitchDetail);
                                }
                                print(pitchDetailList);
                                widget.detail!["pitchdocId"] = doc_Id;
                                widget.detail!["pitchtypeDetails"] =
                                    pitchDetailList;
                                widget.detail!["documents_expiry_date"] =
                                    _expiryDate;
                                _networkCalls.addNewGround(
                                  body: widget.detail as Map,
                                  onSuccess: (msg) {
                                    navigateToOwnerHome();
                                  },
                                  onFailure: (msg) {
                                    if (mounted) showMessage(msg);
                                  },
                                  tokenExpire: () {
                                    if (mounted) on401(context);
                                  },
                                );
                              } else {
                                if (mounted) {
                                  showMessage(
                                      AppLocalizations.of(context)!
                                          .noInternetConnection);
                                }
                              }
                            });
                          },
                          splashColor: Colors.black,
                          child: Container(
                              height: sizeHeight * .104,
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
                      )
                    : Container(
                        height: sizeHeight * .1,
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
                body: SizedBox(
                  width: sizeWidth,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * .07,
                            vertical: sizeHeight * .02),
                        child: GestureDetector(
                          onTap: () {
                            _showChoiceDialog(context);
                          },
                          child: _isImageLoading
                              ? Container(
                                  color: const Color(0XFF032040),
                                  height: sizeHeight * .2,
                                  width: sizeWidth,
                                  child: Lottie.asset(
                                    'lottiefiles/profile.json',
                                  ),
                                )
                              : Container(
                                  color: const Color(0XFF032040),
                                  height: sizeHeight * .2,
                                  width: sizeWidth,
                                  child: image == null
                                      ? Column(
                                          children: <Widget>[
                                            flaxibleGap(1),
                                            const Icon(
                                              Icons.add_circle,
                                              color: Colors.white,
                                              size: 50,
                                            ),
                                            flaxibleGap(1),
                                            Text(
                                                AppLocalizations.of(context)!
                                                    .uploadDocument,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Poppins")),
                                            flaxibleGap(1),
                                          ],
                                        )
                                      : _decideImageview(),
                                ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: sizeHeight * .015,
                          horizontal: sizeWidth * .07,
                        ),
                        child: GestureDetector(
                          onTap: () async {
                            final selectDate = await slecteDtateTime(context);
                            if (selectDate != null) {
                              setState(() {
                                _expiryDate =
                                    formatter.format((selectDate)).toString();
                              });
                            }
                            print(_expiryDate);
                          },
                          child: Row(
                            children: [
                              Text(
                                _expiryDate ?? "Expiry Document Date",
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    decoration: TextDecoration.none,
                                    color: Color(0XFF032040),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              ),
                              flaxibleGap(1),
                              const Icon(Icons.calendar_today)
                            ],
                          ),
                        ),
                      ),
                      Text(AppLocalizations.of(context)!.weNeedAccount,
                          style: TextStyle(
                              color: const Color(0XFF9B9B9B).withOpacity(.5),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Poppins")),
                      Padding(
                        padding: EdgeInsets.only(top: sizeHeight * .02),
                        child: Text(
                            AppLocalizations.of(context)!.addAsideCamesPitch,
                            style: const TextStyle(
                                color: Color(0XFF25A163),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins")),
                      ),
                      _addPitch
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: sizeWidth * .07,
                                  vertical: sizeHeight * .01),
                              child: Row(
                                children: <Widget>[
                                  GestureDetector(
                                    child: Container(
                                      height: sizeHeight * .05,
                                      width: sizeHeight * .05,
                                      decoration: BoxDecoration(
                                        color:
                                            const Color(0XFF25A163).withOpacity(.3),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Image.asset(
                                        'images/addnew.png',
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        _addPitch = true;
                                        count = 0;
                                        pitchType = '';
                                      });
                                    },
                                  ),
                                  Container(
                                    width: sizeWidth * .03,
                                  ),
                                  Text(AppLocalizations.of(context)!.addNewPitch,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Poppins")),
                                ],
                              ),
                            ),
                      saveData.isEmpty
                          ? Container()
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: saveData.length,
                                  itemBuilder:
                                      (BuildContext context, int blockIdx) {
                                    return Container(
                                      padding: EdgeInsets.only(
                                          left: sizeWidth * .07,
                                          right: sizeWidth * .07,
                                          bottom: sizeHeight * .01),
                                      alignment: Alignment.topCenter,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      height: sizeHeight * .08,
                                      child: Material(
                                        elevation: 10,
                                        child: Row(
                                          children: <Widget>[
                                            flaxibleGap(1),
                                            Text(
                                              "${saveData[blockIdx].pitchType}",
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF032040),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            flaxibleGap(1),
                                            Container(
                                              height: sizeHeight * .05,
                                              width: 2,
                                              color: const Color(0XFF979797),
                                            ),
                                            flaxibleGap(1),
                                            Text(
                                              saveData[blockIdx].pitchName,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF696969),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            flaxibleGap(2),
                                            Text(
                                              "${saveData[blockIdx].price} ${AppLocalizations.of(context)!.currency}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF25A163),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                    ],
                  ),
                ),
              ),
              _addPitch
                  ? BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                      child: Container(
                        color: Colors.black.withOpacity(0),
                      ),
                    )
                  : Container(),
              _addPitch
                  ? Center(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                        child: Form(
                          key: _formKey,
                          child: Material(
                            elevation: 10,
                            child: Container(
                              height: sizeHeight * .5,
                              width: sizeWidth,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  flaxibleGap(1),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizeWidth * .05),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                            AppLocalizations.of(context)!
                                                .addPitchDetails,
                                            style: const TextStyle(
                                                decoration: TextDecoration.none,
                                                color: Color(0XFFADADAD),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins")),
                                        flaxibleGap(1),
                                        SizedBox(
                                          height: sizeHeight * .03,
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              setState(() {
                                                _addPitch = false;
                                              });
                                            },
                                            backgroundColor: const Color(0XFFD8D8D8),
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
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseentername;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.text,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(focus);
                                        },
                                        onSaved: (value) {
                                          _pitchName = value!;
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
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(1),
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
                                          itemBuilder: (BuildContext context,
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
                                                          _pitchType[blockIdx];
                                                      pitchTypeSlug =
                                                          _pitchTypeSlug[
                                                              blockIdx];
                                                      //pitchType=_pitchType[blockIdx][0].substring(0 + _pitchType[blockIdx][0].length, 1).trim();
                                                    }
                                                  });
                                                },
                                                child: count == blockIdx
                                                    ? Container(
                                                        height:
                                                            sizeHeight * .11,
                                                        width: sizeHeight * .13,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              const Color(0XFF032040),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0XFF979797)),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0) //                 <--- border radius here
                                                                  ),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
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
                                                        height:
                                                            sizeHeight * .11,
                                                        width: sizeHeight * .13,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: const Color(
                                                                  0XFF25A163)
                                                              .withOpacity(.25),
                                                          borderRadius:
                                                              const BorderRadius.all(
                                                                  Radius.circular(
                                                                      10.0) //                 <--- border radius here
                                                                  ),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
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
                                            return AppLocalizations.of(context)!
                                                .pleaseenterprice;
                                          }
                                          return null;
                                        },
                                        keyboardType: TextInputType.number,
                                        textInputAction: TextInputAction.done,
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
                                          enabledBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                          focusedBorder: const UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0XFF9F9F9F)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(3),
                                  pitchType != null
                                      ? GestureDetector(
                                          onTap: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              setState(() {
                                                saveData.add(SaveData(
                                                    price: price,
                                                    pitchType: pitchType,
                                                    pitchName: _pitchName,
                                                    pitchTypeSlug:
                                                        pitchTypeSlug));
                                                _addPitch = false;
                                                print(saveData);
                                                //count=blockIdx;
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
                                            AppLocalizations.of(context)!.save,
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
                        ),
                      ),
                    )
                  : Container(),
            ],
          );
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _isImageLoading = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(
            () {
              doc_Id = msg;
              print(msg);
              _isImageLoading = false;
            },
          );
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      _isImageLoading = true;
      image = File(picture!.path);
      var detail = {"profile_image": image, "type": "bookpitch"};
      _networkCalls.helperProfile(
        profileDetail: detail,
        onSuccess: (msg) {
          setState(() {
            doc_Id = msg;
            print(msg);

            _isImageLoading = false;
          });
        },
        onFailure: (msg) {},
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
      // }
    });
    Navigator.of(context).pop();
  }

  Widget _decideImageview() {
    return Image.file(
      image,
      fit: BoxFit.cover,
    );
  }

  void navigateToOwnerHome() {
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.homePitchOwner, (r) => false);
  }
}

class SaveData {
  var pitchType;
  var price;
  var pitchName;
  var pitchTypeSlug;
  SaveData({this.pitchType, this.price, this.pitchName, this.pitchTypeSlug});
}
