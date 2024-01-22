import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:intl/intl.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import 'signup.dart';

class SocialDetail extends StatefulWidget {
  var detail;

  SocialDetail({super.key, this.detail});

  @override
  _SocialDetailState createState() => _SocialDetailState();
}

class _SocialDetailState extends State<SocialDetail> {
  final focuss = FocusNode();
  final DateFormat formatter = DateFormat('yyyy-MM-dd', 'en_US');
  var lastBookingDateApi;
  bool internet = true;
  bool loading = false;
  late OverlayEntry? overlayEntry;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final SignUpDetail _detail = SignUpDetail();
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List<String> playerPostion = [];
  List<String> playerPostionSlug = [];
  late String playerSlug;

  palyerPosition() async {
    await _networkCalls.playerPosition(
      onSuccess: (msg) {
        if (mounted) {
          print('jjjj');
          print(msg);
          setState(() {
            for (int i = 0; i < msg.length; i++) {
              playerPostion.add(msg[i]["name"]);
              playerPostionSlug.add(msg[i]["slug"]);
            }
            loading = true;
          });
        }
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  Future onWillPop(String description) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.darkTheme,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              "${AppLocalizations.of(context)!.password}: $description",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            actions: [
              InkWell(
                onTap: () {
                  navigateToDetail();
                  Navigator.pop(context);
                },
                child: Center(
                  child: Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
                      border: Border.all(width: 1, color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.gotoHomepage,
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) {
      _detail.deviceType = "IOS";
    } else {
      _detail.deviceType = "Android";
    }

    _firebaseMessaging.getToken().then((token) {
      _detail.fcmToken = token;
    });
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      _emailController.text = widget.detail["apple"] != null &&
              widget.detail["detail"]["email"].length > 100
          ? widget.detail["detail"]["email"]
                  .substring(widget.detail["detail"]["email"].length - 25) ??
              ""
          : widget.detail["detail"]["email"] ?? "";
      if (msg == true) {
        palyerPosition();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
    firebaseCloudMessaging_Listeners();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    // Future<DateTime> slecteDtateTime(BuildContext context) => showDatePicker(
    //       context: context,
    //       initialDate: DateTime.now().add(Duration(seconds: 1)),
    //       firstDate: DateTime(1950),
    //       lastDate: DateTime.now(),
    //       locale: Locale(AppLocalizations.of(context).locale),
    //       builder: (BuildContext context, Widget child) {
    //         return Theme(
    //           data: ThemeData.light().copyWith(
    //             colorScheme:
    //                 ColorScheme.light(primary: const Color(0XFF032040)),
    //             buttonTheme:
    //                 ButtonThemeData(textTheme: ButtonTextTheme.primary),
    //           ),
    //           child: child,
    //         );
    //       },
    //     );
    return internet
        ? Scaffold(
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? Colors.white
                : const Color(0xff686868),
            appBar: appBarWidget(
                sizeWidth: width,
                sizeHeight: height,
                context: context,
                title: AppLocalizations.of(context)!.socialTitle,
                back: true),
            body: Container(
                color: Colors.black,
                child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.059, vertical: height * 0.02),
                    child: SingleChildScrollView(
                      child: Container(
                        height: height * .8,
                        width: width,
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              flaxibleGap(
                                1,
                              ),
                              Text(
                                AppLocalizations.of(context)!.email,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? const Color(0XFF9F9F9F)
                                        : Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                              TextFieldWidget(
                                controller: _emailController,
                                hintText: '',
                                enable: false,
                                enableBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                focusBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? Container(
                                          alignment: Alignment.bottomCenter,
                                          child: CountryCodePicker(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            backgroundColor: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.white
                                                : AppColors.darkTheme,
                                            dialogTextStyle: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFF032040)
                                                    : AppColors.black),
                                            searchStyle: TextStyle(
                                              color: AppColors.black,
                                            ),
                                            textStyle: TextStyle(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? const Color(0XFF032040)
                                                    : AppColors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10),
                                            onChanged: (value) {
                                              setState(() {
                                                _detail.countryCode =
                                                    value.toString();
                                              });
                                            },
                                            initialSelection: '+971',
                                            favorite: const [
                                              '+971',
                                              'ae',
                                            ],
                                            closeIcon: Icon(
                                              Icons.close,
                                              color: AppColors.black,
                                            ),
                                            hideSearch: false,
                                            searchDecoration: InputDecoration(
                                                constraints: BoxConstraints(
                                                    maxHeight: height * 0.065),
                                                fillColor:
                                                    MyAppState.mode == ThemeMode.light
                                                        ? AppColors.grey200
                                                        : AppColors.grey200,
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: const BorderSide(
                                                        color: Colors.grey)),
                                                focusedBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                    borderSide: const BorderSide(
                                                        color: Colors.grey)),
                                                disabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(12),
                                                    borderSide: const BorderSide(color: Colors.grey)),
                                                prefixIcon: Icon(Icons.search, color: Colors.grey)),
                                            showCountryOnly: false,
                                            showOnlyCountryWhenClosed: false,
                                            alignLeft: false,
                                          ))
                                      : Container(),
                                  Expanded(
                                    child: Container(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      width: width * .4,
                                      alignment: Alignment.topCenter,
                                      child: textField(
                                        name: '',
                                        // AppLocalizations.of(context)!.phoneNumber,
                                        testAlignment:
                                            AppLocalizations.of(context)!
                                                        .locale ==
                                                    "en"
                                                ? true
                                                : false,
                                        hint: AppLocalizations.of(context)!
                                            .phoneNumber,
                                        node: focuss,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterPhoneNumber;
                                          }
                                          return null;
                                        },
                                        text: false,
                                        text1: true,
                                        keybordType: false,
                                        onSaved: (value) {
                                          _detail.phoneNumber = value;
                                        },
                                      ),
                                    ),
                                  ),
                                  AppLocalizations.of(context)!.locale == "ar"
                                      ? Container(
                                          alignment: Alignment.bottomCenter,
                                          child: CountryCodePicker(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            onChanged: (value) {
                                              setState(() {
                                                _detail.countryCode =
                                                    value.toString();
                                                // print(country+"ratnesh");
                                              });
                                            },
                                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                            initialSelection: '+971',
                                            favorite: const [
                                              '+971',
                                              'ITU',
                                            ],
                                            // optional. Shows only country name and flag
                                            showCountryOnly: false,
                                            // optional. Shows only country name and flag when popup is closed.
                                            showOnlyCountryWhenClosed: false,
                                            // optional. aligns the flag and the Text left
                                            alignLeft: false,
                                            searchStyle: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 13),
                                            textStyle: TextStyle(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                              flaxibleGap(
                                3,
                              ),
                              ButtonWidget(
                                  onTaped: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      FocusScope.of(context).unfocus();
                                      _detail.password =
                                          base64.encode(utf8.encode("123456"));
                                      _detail.firstName =
                                          widget.detail["detail"]["first_name"];
                                      _detail.lastName =
                                          widget.detail["detail"]["last_name"];
                                      _detail.dob = lastBookingDateApi;
                                      if (widget.detail["detail"]["email"] !=
                                              null &&
                                          widget.detail["detail"]["email"]
                                                  .length >
                                              100) {
                                        _detail.email = widget.detail["detail"]
                                                    ["email"]
                                                .substring(widget
                                                        .detail["detail"]
                                                            ["email"]
                                                        .length -
                                                    25) ??
                                            "";
                                      } else {
                                        _detail.email =
                                            widget.detail["detail"]["email"];
                                      }

                                      // if (_detail.dob != null) {
                                      if (_detail.gender != null) {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          if (msg == true) {
                                            setState(() {
                                              loading = false;
                                            });
                                            _networkCalls
                                                .checkAvailabilityOfEmail(
                                                    email: _detail.email
                                                        .toString(),
                                                    onSuccess: (msg) {
                                                      _networkCalls
                                                          .checkAvailabilityOfPhoneNumber(
                                                              phone: _detail
                                                                  .phoneNumber
                                                                  .toString(),
                                                              onSuccess: (msg) {
                                                                Map<String,
                                                                        dynamic>
                                                                    details = {
                                                                  "first_name": _detail
                                                                          .firstName,
                                                                  "last_name":
                                                                      _detail
                                                                          .lastName,
                                                                  "email":
                                                                      _detail
                                                                          .email,
                                                                  "contact_number":
                                                                      _detail
                                                                          .phoneNumber,
                                                                  "countryCode":
                                                                      _detail
                                                                          .countryCode,
                                                                  "password":
                                                                      _detail
                                                                          .password,
                                                                  "deviceType":
                                                                      _detail
                                                                          .deviceType,
                                                                  "deviceToken":
                                                                      _detail
                                                                          .fcmToken,
                                                                  "role":
                                                                      "player",
                                                                  "gender":
                                                                      _detail
                                                                          .gender
                                                                };
                                                                if (widget.detail[
                                                                        "google"] ==
                                                                    true) {
                                                                  details["is_google_user"] =
                                                                      true;
                                                                } else if (widget
                                                                            .detail[
                                                                        "apple"] ==
                                                                    true) {
                                                                  details["is_apple_user"] =
                                                                      true;
                                                                  details[
                                                                      "appleId"] = widget
                                                                          .detail[
                                                                      'user'];
                                                                } else if (widget
                                                                            .detail[
                                                                        "facebook"] ==
                                                                    true) {
                                                                  details["is_facebook_user"] =
                                                                      true;
                                                                  details[
                                                                      "appleId"] = widget
                                                                          .detail[
                                                                      "appleId"];
                                                                }
                                                                print(details);
                                                                _networkCalls
                                                                    .signUp(
                                                                        signupDetail:
                                                                            details,
                                                                        onSuccess:
                                                                            (msg) {
                                                                              setState(
                                                                                      () {
                                                                                    loading =
                                                                                    false;
                                                                                  });
                                                                              showMessage("Password: 123456");
                                                                              navigateToDetail();
                                                                          // onWillPop(
                                                                          //     '123456');
                                                                        },
                                                                        onFailure:
                                                                            (msg) {
                                                                          if (mounted) {
                                                                            setState(() {
                                                                              loading = true;
                                                                            });
                                                                          }
                                                                          showMessage(
                                                                              msg);
                                                                        });
                                                              },
                                                              onFailure: (msg) {
                                                                if (mounted) {
                                                                  setState(() {
                                                                    loading =
                                                                        true;
                                                                  });
                                                                }
                                                                showMessage(
                                                                    msg);
                                                              },
                                                              tokenExpire: () {
                                                                if (mounted) {
                                                                  on401(
                                                                      context);
                                                                }
                                                              });
                                                    },
                                                    onFailure: (msg) {
                                                      if (mounted) {
                                                        setState(() {
                                                          loading = true;
                                                        });
                                                      }
                                                      showMessage(msg);
                                                    },
                                                    tokenExpire: () {
                                                      if (mounted)
                                                        on401(context);
                                                    });
                                          } else {
                                            if (mounted) {
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        });
                                      } else {
                                        if (mounted) {
                                          showMessage(
                                              AppLocalizations.of(context)!
                                                  .pleaseselectgender);
                                        }
                                      }
                                      // } else {
                                      //   if (mounted)
                                      //     showMessage(
                                      //         AppLocalizations.of(context)
                                      //             .pleaseselectDateofBirth,
                                      //         scaffoldkey);
                                      // }
                                    }
                                  },
                                  title: Center(
                                      child: Text(
                                    AppLocalizations.of(context)!.continu,
                                    style: TextStyle(color: AppColors.white),
                                  )),
                                  isLoading: !loading),
                              flaxibleGap(
                                1,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )))
        : InternetLoss(
            onChange: () {
              _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                internet = msg;
                if (msg == true) {
                  if (mounted) {
                    setState(() {
                      loading = true;
                    });
                  }
                }
              });
            },
          );
  }

  void navigateToDetail() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerHomeScreen(index: 0),
        ));
    // Navigator.pushNamedAndRemoveUntil(
    //     context, RouteNames.playerHome, (r) => false);
  }
}
// {first_name: Usama,
// last_name: Ahmad,
// email: usama.ahmad435750@gmail.com,
// contact_number: 3131616379,
// countryCode: +92,
// password: Tm9uZQ==,
// deviceType: Android,
// deviceToken: cNF1qfiQTqaUr2CcFd5zr7:APA91bG6ZcvTgARG8QbvHwwi-6oTrtLvgsZJEWOgv5Rsjr3jxWC7jT-ZWmB5Pyc77yCCm3ArLrXLDmwnajrWZeOFLnfuMTKntwUV5vGHABmbcUuZttuiUPJHwRejB7kBP7TUI67eSnsq,
// role: player,
// gender: Male,
// is_google_user: true}
