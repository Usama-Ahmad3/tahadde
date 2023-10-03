import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../constant.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';
import '../signup.dart';

class CreateTeam extends StatefulWidget {
  const CreateTeam({super.key});

  @override
  _CreateTeamState createState() => _CreateTeamState();
}

class _CreateTeamState extends State<CreateTeam> {
  final _formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final _teamController = TextEditingController();
  final _numberController = TextEditingController(text: "");
  final _emailController = TextEditingController(text: "");
  final TeamDetail _detail = TeamDetail();
  final focuss = FocusNode();
  final focusss = FocusNode();
  bool? _auth;
  final NetworkCalls _networkCalls = NetworkCalls();
  Map? profileDetail;
  bool isImageLoade = false;
  File? image;
  var logoId;
  bool? internet;
  bool loading = true;
  SharedPreferences? pref;
  OverlayEntry? overlayEntry;

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
                    child:
                        Text(AppLocalizations.of(context)!.choosefromlibrary),
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
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
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
                                      child: Text(AppLocalizations.of(context)!
                                          .setting),
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

  loadProfile() async {
    _auth = await checkAuthorizaton();
    if (_auth!) {
      _networkCalls.getProfile(
        onSuccess: (msg) {
          setState(() {
            profileDetail = msg;
            _emailController.text = msg['email'] ?? '';
            loading = false;
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return loading
        ? Scaffold(
            key: scaffoldkey,
            backgroundColor: const Color(0XFFF0F0F0),
            bottomNavigationBar: Material(
              color: const Color(0XFF25A163),
              child: Container(
                  height: sizeHeight * .09,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  )),
            ),
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
                AppLocalizations.of(context)!.team,
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
            body: SingleChildScrollView(
              child: SizedBox(
                height: sizeHeight * .78,
                width: sizeWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Flexible(flex: 2, child: Container()),
                    Padding(
                      padding: AppLocalizations.of(context)!.locale == "en"
                          ? EdgeInsets.only(left: sizeWidth * .1)
                          : EdgeInsets.only(right: sizeWidth * .1),
                      child: Text(
                        AppLocalizations.of(context)!.createTeam,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Color(0XFF032040),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    flaxibleGap(1),
                    Padding(
                      padding: EdgeInsets.only(
                          left: sizeWidth * .05, right: sizeWidth * .05),
                      child: SingleChildScrollView(
                        child: Container(
                          height: sizeHeight * .7,
                          color: const Color(0XFFFFFFFF),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .05, right: sizeWidth * .05),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(2),
                                Text(
                                  AppLocalizations.of(context)!
                                      .youarecaptianoftheteamyoucreate,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0XFFADADAD)),
                                ),
                                flaxibleGap(1),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: AppLocalizations.of(context)!
                                                  .locale ==
                                              "en"
                                          ? EdgeInsets.only(
                                              right: sizeWidth * .04)
                                          : EdgeInsets.only(
                                              left: sizeWidth * .04),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: sizeHeight * .1,
                                          width: sizeHeight * .1,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            // image: Image.network(profileDetail.profile_pic),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: sizeWidth * .4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          shimmer(width: sizeWidth * .4),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .captainC,
                                                style: const TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 14,
                                                    color: Color(0XFF25A163),
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Container(
                                                  height: 14,
                                                  width: 1,
                                                  color:
                                                      const Color(0XFFADADAD)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              shimmer(width: sizeWidth * .2),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                flaxibleGap(1),
                                Container(
                                    height: 1,
                                    width: sizeWidth,
                                    color: const Color(0XFFADADAD)),
                                flaxibleGap(1),
                                Text(
                                  AppLocalizations.of(context)!.logo,
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0XFFADADAD)),
                                ),
                                flaxibleGap(1),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: Container(
                                    height: sizeHeight * .13,
                                    width: sizeHeight * .13,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(16),
                                      color: const Color(0XFF032040),
                                    ),
                                  ),
                                ),
                                flaxibleGap(1),
                                const SizedBox(
                                  height: 10,
                                ),
                                shimmer(width: sizeWidth),
                                const SizedBox(
                                  height: 10,
                                ),
                                shimmer(width: sizeWidth),
                                const SizedBox(
                                  height: 10,
                                ),
                                shimmer(width: sizeWidth),
                                Text(
                                  AppLocalizations.of(context)!
                                      .numberplayerscompleteteam,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0XFFADADAD)),
                                ),
                                const Text(
                                  "18",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0XFF032040)),
                                ),
                                flaxibleGap(4),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : internet!
            ? Scaffold(
                key: scaffoldkey,
                backgroundColor: const Color(0XFFF0F0F0),
                bottomNavigationBar: Material(
                  color: const Color(0XFF25A163),
                  child: InkWell(
                    onTap: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        internet = msg;
                        if (msg == true) {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            Map detail = {
                              "teamName": _detail.teamName,
                              "contactNumber": _detail.phoneNumber,
                              "email": _detail.email,
                              "countryCode": _detail.countryCode,
                            };
                            if (logoId != null) {
                              detail["teamlogoId"] = logoId;
                            }
                            if (_detail.playerNumber != null) {
                              detail["numberofPlayers"] = _detail.playerNumber;
                            }

                            _networkCalls.creatTeam(
                              teamType: "?team_type=internal",
                              detail: detail,
                              onSuccess: (msg) {
                                navigateToHome();
                              },
                              onFailure: (msg) {
                                showMessage(msg);
                              },
                              tokenExpire: () {
                                if (mounted) on401(context);
                              },
                            );
                          } else {
                            setState(() {});
                          }
                        } else {
                          if (mounted) {
                            showMessage(AppLocalizations.of(context)!
                                .noInternetConnection);
                          }
                        }
                      });
                    },
                    splashColor: Colors.black,
                    child: Container(
                        height: sizeHeight * .09,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.submit,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                  ),
                ),
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
                    AppLocalizations.of(context)!.team,
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
                body: SingleChildScrollView(
                  child: SizedBox(
                    height: sizeHeight * .78,
                    width: sizeWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(flex: 2, child: Container()),
                        Padding(
                          padding: AppLocalizations.of(context)!.locale == "en"
                              ? EdgeInsets.only(left: sizeWidth * .1)
                              : EdgeInsets.only(right: sizeWidth * .1),
                          child: Text(
                            AppLocalizations.of(context)!.createTeam,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                color: Color(0XFF032040),
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        flaxibleGap(1),
                        Padding(
                          padding: EdgeInsets.only(
                              left: sizeWidth * .05, right: sizeWidth * .05),
                          child: SingleChildScrollView(
                            child: Container(
                              height: sizeHeight * .7,
                              color: const Color(0XFFFFFFFF),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: sizeWidth * .05,
                                    right: sizeWidth * .05),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      flaxibleGap(2),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .youarecaptianoftheteamyoucreate,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFFADADAD)),
                                      ),
                                      flaxibleGap(1),
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? EdgeInsets.only(
                                                        right: sizeWidth * .04)
                                                    : EdgeInsets.only(
                                                        left: sizeWidth * .04),
                                            child: Container(
                                                height: sizeHeight * .1,
                                                width: sizeHeight * .1,
                                                decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0XFF4F5C6A),
                                                  // image: Image.network(profileDetail.profile_pic),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          sizeHeight * .1),
                                                  child: profileDetail![
                                                              'profile_pic'] !=
                                                          null
                                                      ? Image.network(
                                                          profileDetail![
                                                                  'profile_pic']
                                                              ['filePath'],
                                                          fit: BoxFit.cover,
                                                        )
                                                      : Image.asset(
                                                          "images/profile.png",
                                                          fit: BoxFit.cover,
                                                        ),
                                                )),
                                          ),
                                          SizedBox(
                                            width: sizeWidth * .4,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                                  style: const TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 16,
                                                      color: Color(0XFF032040),
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .captainC,
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 14,
                                                          color:
                                                              Color(0XFF25A163),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Container(
                                                        height: 14,
                                                        width: 1,
                                                        color: const Color(
                                                            0XFFADADAD)),
                                                    Text(
                                                      profileDetail!["playerPosition"]
                                                                  .length !=
                                                              0
                                                          ? profileDetail![
                                                                  "playerPosition"]
                                                              ["name"]
                                                          : " ",
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 14,
                                                          color:
                                                              Color(0XFFADADAD),
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      flaxibleGap(1),
                                      Container(
                                          height: 1,
                                          width: sizeWidth,
                                          color: const Color(0XFFADADAD)),
                                      flaxibleGap(1),
                                      Text(
                                        AppLocalizations.of(context)!.logo,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: Color(0XFFADADAD)),
                                      ),
                                      flaxibleGap(1),
                                      isImageLoade
                                          ? Container(
                                              height: sizeHeight * .13,
                                              width: sizeHeight * .13,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: const Color(
                                                        0XFF032040)),
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: const Color(0XFF032040),
                                              ),
                                              child: Lottie.asset(
                                                'lottiefiles/image.json',
                                              ),
                                            )
                                          : GestureDetector(
                                              onTap: () {
                                                _showChoiceDialog(context);
                                              },
                                              child: Container(
                                                height: sizeHeight * .13,
                                                width: sizeHeight * .13,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: const Color(
                                                          0XFF032040)),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color:
                                                      const Color(0XFF032040),
                                                ),
                                                child: image == null
                                                    ? const Icon(
                                                        Icons.camera,
                                                        color:
                                                            Color(0XFF25A163),
                                                      )
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        child: Image.file(
                                                          image!,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                      flaxibleGap(1),
                                      textField(
                                          controller: _teamController,
                                          onSaved: (value) {
                                            _detail.teamName = value!;
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .pleaseenterTeamName;
                                            }
                                            return '';
                                          },
                                          submit: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(focuss);
                                          },
                                          name: AppLocalizations.of(context)!
                                              .teamName,
                                          hint: AppLocalizations.of(context)!
                                              .teamName,
                                          text: true),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? CountryCodePicker(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _detail.countryCode =
                                                          value.toString();
                                                    });
                                                  },
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: '+971',
                                                  favorite: const [
                                                    '+971',
                                                    'ITU'
                                                  ],
                                                  // optional. Shows only country name and flag
                                                  showCountryOnly: false,
                                                  // optional. Shows only country name and flag when popup is closed.
                                                  showOnlyCountryWhenClosed:
                                                      false,
                                                  // optional. aligns the flag and the Text left
                                                  alignLeft: false,
                                                )
                                              : Container(),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: textField(
                                                  testAlignment:
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              "en"
                                                          ? true
                                                          : false,
                                                  controller: _numberController,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return AppLocalizations
                                                              .of(context)!
                                                          .pleaseenterPhoneNumber;
                                                    }
                                                    return '';
                                                  },
                                                  onSaved: (value) {
                                                    _detail.phoneNumber =
                                                        value!;
                                                  },
                                                  node: focuss,
                                                  submit: (value) {
                                                    FocusScope.of(context)
                                                        .requestFocus(focusss);
                                                  },
                                                  name: AppLocalizations.of(
                                                          context)!
                                                      .contactNumber,
                                                  hint: AppLocalizations.of(
                                                          context)!
                                                      .contactNumber,
                                                  text: false),
                                            ),
                                          ),
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  "ar"
                                              ? CountryCodePicker(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _detail.countryCode =
                                                          value.toString();
                                                    });
                                                  },
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection: '+971',
                                                  favorite: const [
                                                    '+971',
                                                    'ITU'
                                                  ],
                                                  // optional. Shows only country name and flag
                                                  showCountryOnly: false,
                                                  // optional. Shows only country name and flag when popup is closed.
                                                  showOnlyCountryWhenClosed:
                                                      false,
                                                  // optional. aligns the flag and the Text left
                                                  alignLeft: false,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      textField(
                                          controller: _emailController,
                                          onSaved: (value) {
                                            _detail.email = value!;
                                          },
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .pleaseenterEmail;
                                            }
                                            return '';
                                          },
                                          node: focusss,
                                          name: AppLocalizations.of(context)!
                                              .email,
                                          hint: AppLocalizations.of(context)!
                                              .email,
                                          text: false,
                                          text1: false,
                                          keybordType: false),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .numberplayerscompleteteam,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0XFFADADAD)),
                                      ),
                                      const Text(
                                        "18",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF032040)),
                                      ),
                                      Flexible(
                                        flex: 4,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
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
                    AppLocalizations.of(context)!.team,
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
                body: InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      internet = msg;
                      if (msg == true) {
                        loadProfile();
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    });
                  },
                ),
              );
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }

  _openGallery(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);

        var detail = {"profile_image": image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              logoId = msg;
              isImageLoade = false;
            });
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          },
        );
      }
    });
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (picture != null) {
        isImageLoade = true;
        image = File(picture.path);
        print(picture);

        var detail = {"profile_image": image, "type": "user"};
        _networkCalls.helperProfile(
          profileDetail: detail,
          onSuccess: (msg) {
            setState(() {
              logoId = msg;
              print(msg);
              isImageLoade = false;
            });
          },
          onFailure: (msg) {
            showMessage(msg);
          },
          tokenExpire: () {
            if (mounted) on401(context);
          },
        );
      }
    });
    Navigator.of(context).pop();
  }
}

class TeamDetail {
  String? email;
  String? teamName;
  String? phoneNumber;
  int? playerNumber;
  String countryCode;
  TeamDetail(
      {this.email,
      this.playerNumber,
      this.teamName,
      this.phoneNumber,
      this.countryCode = "+971"});
}
