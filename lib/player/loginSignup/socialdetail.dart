import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
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
    if (Platform.isIOS) {
      focuss.addListener(() {
        bool hasFocus = focuss.hasFocus;
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
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
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
            appBar: PreferredSize(
              preferredSize: Size(sizewidth, sizeheight * 0.13),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.socialTitle,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
                leadingWidth: sizewidth * 0.18,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: sizeheight * 0.004,
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
                ),
              ),
            ),
            // appBar: AppBar(
            //   leading: IconButton(
            //     onPressed: () {
            //       Navigator.of(context).pop();
            //     },
            //     icon: const Icon(
            //       Icons.arrow_back_ios,
            //       color: Color(0XFFFFFFFF),
            //     ),
            //   ),
            //   centerTitle: true,
            //   automaticallyImplyLeading: false,
            //   title: Text(
            //     AppLocalizations.of(context)!.socialTitle,
            //     style: TextStyle(
            //         fontSize: appHeaderFont,
            //         color: const Color(0XFFFFFFFF),
            //         fontFamily: AppLocalizations.of(context)!.locale == "en"
            //             ? "Poppins"
            //             : "VIP",
            //         fontWeight: AppLocalizations.of(context)!.locale == "en"
            //             ? FontWeight.bold
            //             : FontWeight.normal),
            //   ),
            //   backgroundColor: const Color(0XFF032040),
            // ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: Container(
                  height: sizeheight * .8,
                  width: sizewidth,
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
                        textFieldWidget(
                          controller: _emailController,
                          hintText: '',
                          enable: false,
                          enableBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                        SizedBox(
                          height: sizeheight * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppLocalizations.of(context)!.locale == "en"
                                ? Container(
                                    alignment: Alignment.bottomCenter,
                                    child: CountryCodePicker(
                                      padding: const EdgeInsets.only(top: 5),
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
                                        'ITU',
                                      ],
                                      // optional. Shows only country name and flag
                                      showCountryOnly: false,
                                      // optional. Shows only country name and flag when popup is closed.
                                      showOnlyCountryWhenClosed: false,
                                      // optional. aligns the flag and the Text left
                                      alignLeft: false,
                                      searchStyle: const TextStyle(
                                          color: Colors.black, fontSize: 13),
                                      textStyle: TextStyle(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Colors.black
                                                : Colors.white,
                                      ),
                                    ),
                                  )
                                : Container(),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(bottom: 10),
                                width: sizewidth * .4,
                                alignment: Alignment.topCenter,
                                child: textField(
                                  name:
                                      AppLocalizations.of(context)!.phoneNumber,
                                  testAlignment:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? true
                                          : false,
                                  hint:
                                      AppLocalizations.of(context)!.phoneNumber,
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
                                      padding: const EdgeInsets.only(top: 5),
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
                                          color: Colors.black, fontSize: 13),
                                      textStyle: TextStyle(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Colors.black
                                                : Colors.white,
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                        // Padding(
                        //   padding: EdgeInsets.only(
                        //       top: sizeheight * .015, bottom: sizeheight * .01),
                        //   child: GestureDetector(
                        //     onTap: () async {
                        //       final selectDate = await slecteDtateTime(context);
                        //       if (selectDate != null) {
                        //         setState(() {
                        //           lastBookingDateApi =
                        //               formatter.format((selectDate)).toString();
                        //         });
                        //       }
                        //       print(selectDate);
                        //     },
                        //     child: Row(
                        //       children: [
                        //         Text(
                        //           lastBookingDateApi ??
                        //               AppLocalizations.of(context)
                        //                   .choosedateofbirth,
                        //           style: TextStyle(
                        //               fontFamily: 'Poppins',
                        //               decoration: TextDecoration.none,
                        //               color: lastBookingDateApi == null
                        //                   ? Color(0XFF9F9F9F)
                        //                   : Color(0XFF032040),
                        //               fontWeight: lastBookingDateApi == null
                        //                   ? FontWeight.w500
                        //                   : FontWeight.w600,
                        //               fontSize: 16),
                        //         ),
                        //         flaxibleGap(
                        //           1,
                        //         ),
                        //         Icon(Icons.calendar_today)
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Container(
                        //   height: 1,
                        //   width: sizewidth,
                        //   color: Colors.grey,
                        // ),
                        // AppLocalizations.of(context).locale == "en"
                        //     ? Container(
                        //         height: sizeheight * .07,
                        //         width: sizewidth,
                        //         child: Center(
                        //           child: DropdownButton<String>(
                        //             underline: Container(
                        //               height: 1,
                        //               color: Color(0XFF9F9F9F),
                        //             ),
                        //             iconEnabledColor: Color(0XFF9B9B9B),
                        //             focusColor: Color(0XFF9B9B9B),
                        //             isExpanded: true,
                        //             value: _gender,
                        //             hint: Text(
                        //               AppLocalizations.of(context).gender,
                        //               style: TextStyle(
                        //                   color: Color(0XFFADADAD),
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //             items: genderEn
                        //                 .map((value) => DropdownMenuItem(
                        //                       child: Text(
                        //                         value,
                        //                         style: TextStyle(
                        //                             color: Color(0XFF032040),
                        //                             fontWeight:
                        //                                 FontWeight.w600),
                        //                       ),
                        //                       value: value,
                        //                     ))
                        //                 .toList(),
                        //             onChanged: (String value) {
                        //               setState(() {
                        //                 _gender = value;
                        //                 _detail.gender = _gender;
                        //                 print(_detail.gender);
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       )
                        //     : Container(
                        //         height: sizeheight * .07,
                        //         width: sizewidth,
                        //         child: Center(
                        //           child: DropdownButton<String>(
                        //             underline: Container(
                        //               height: 1,
                        //               color: Color(0XFF9F9F9F),
                        //             ),
                        //             iconEnabledColor: Color(0XFF9B9B9B),
                        //             focusColor: Color(0XFF9B9B9B),
                        //             isExpanded: true,
                        //             value: _gender,
                        //             hint: Text(
                        //               AppLocalizations.of(context).gender,
                        //               style: TextStyle(
                        //                   color: Color(0XFFADADAD),
                        //                   fontWeight: FontWeight.w500),
                        //             ),
                        //             items: genderAr
                        //                 .map((value) => DropdownMenuItem(
                        //                       child: Text(
                        //                         value,
                        //                         style: TextStyle(
                        //                             color: Color(0XFF032040),
                        //                             fontWeight:
                        //                                 FontWeight.w600),
                        //                       ),
                        //                       value: value,
                        //                     ))
                        //                 .toList(),
                        //             onChanged: (String value) {
                        //               setState(() {
                        //                 _gender = value;
                        //                 _detail.gender = _gender;
                        //                 print(_detail.gender);
                        //               });
                        //             },
                        //           ),
                        //         ),
                        //       ),
                        flaxibleGap(
                          3,
                        ),
                        ButtonWidget(
                            onTaped: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                FocusScope.of(context).unfocus();
                                _detail.password =
                                    base64.encode(utf8.encode("None"));
                                _detail.firstName =
                                    widget.detail["detail"]["first_name"];
                                _detail.lastName =
                                    widget.detail["detail"]["last_name"];
                                _detail.dob = lastBookingDateApi;
                                if (widget.detail["detail"]["email"] != null &&
                                    widget.detail["detail"]["email"].length >
                                        100) {
                                  _detail.email = widget.detail["detail"]
                                              ["email"]
                                          .substring(widget
                                                  .detail["detail"]["email"]
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
                                      _networkCalls.checkAvailabilityOfEmail(
                                          email: _detail.email.toString(),
                                          onSuccess: (msg) {
                                            _networkCalls
                                                .checkAvailabilityOfPhoneNumber(
                                                    phone: _detail.phoneNumber
                                                        .toString(),
                                                    onSuccess: (msg) {
                                                      Map<String, dynamic>
                                                          details = {
                                                        "first_name":
                                                            _detail.firstName,
                                                        "last_name":
                                                            _detail.lastName,
                                                        "email": _detail.email,
                                                        "contact_number":
                                                            _detail.phoneNumber,
                                                        "countryCode":
                                                            _detail.countryCode,
                                                        "password":
                                                            _detail.password,
                                                        "deviceType":
                                                            _detail.deviceType,
                                                        "deviceToken":
                                                            _detail.fcmToken,
                                                        "role": "player",
                                                        "gender": _detail.gender
                                                      };
                                                      if (widget.detail[
                                                              "google"] ==
                                                          true) {
                                                        details["is_google_user"] =
                                                            true;
                                                      } else if (widget.detail[
                                                              "apple"] ==
                                                          true) {
                                                        details["is_apple_user"] =
                                                            true;
                                                        details["appleId"] =
                                                            widget
                                                                .detail['user'];
                                                      } else if (widget.detail[
                                                              "facebook"] ==
                                                          true) {
                                                        details["is_facebook_user"] =
                                                            true;
                                                        details["appleId"] =
                                                            widget.detail[
                                                                "appleId"];
                                                      }
                                                      _networkCalls.signUp(
                                                          signupDetail: details,
                                                          onSuccess: (msg) {
                                                            navigateToDetail();
                                                          },
                                                          onFailure: (msg) {
                                                            if (mounted) {
                                                              setState(() {
                                                                loading = true;
                                                              });
                                                            }
                                                            showMessage(msg);
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
                                                      if (mounted) {
                                                        on401(context);
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
                                            if (mounted) on401(context);
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
                                    showMessage(AppLocalizations.of(context)!
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
                                    AppLocalizations.of(context)!.continu)),
                            isLoading: !loading),
                        // AppButton(
                        //   isLoading: !loading,
                        //   child: Text(
                        //     AppLocalizations.of(context)!.continueS,
                        //     style: const TextStyle(
                        //       fontSize: 20,
                        //       color: Colors.white,
                        //     ),
                        //     textAlign: TextAlign.right,
                        //   ),
                        //   onPressed: () {
                        //     if (_formKey.currentState!.validate()) {
                        //       _formKey.currentState!.save();
                        //       FocusScope.of(context).unfocus();
                        //       _detail.password =
                        //           base64.encode(utf8.encode("None"));
                        //       _detail.firstName =
                        //           widget.detail["detail"]["first_name"];
                        //       _detail.lastName =
                        //           widget.detail["detail"]["last_name"];
                        //       _detail.dob = lastBookingDateApi;
                        //       if (widget.detail["detail"]["email"] != null &&
                        //           widget.detail["detail"]["email"].length >
                        //               100) {
                        //         _detail.email = widget.detail["detail"]["email"]
                        //                 .substring(widget
                        //                         .detail["detail"]["email"]
                        //                         .length -
                        //                     25) ??
                        //             "";
                        //       } else {
                        //         _detail.email =
                        //             widget.detail["detail"]["email"];
                        //       }
                        //
                        //       // if (_detail.dob != null) {
                        //       if (_detail.gender != null) {
                        //         _networkCalls.checkInternetConnectivity(
                        //             onSuccess: (msg) {
                        //           if (msg == true) {
                        //             setState(() {
                        //               loading = false;
                        //             });
                        //             _networkCalls.checkAvailabilityOfEmail(
                        //                 email: _detail.email.toString(),
                        //                 onSuccess: (msg) {
                        //                   _networkCalls
                        //                       .checkAvailabilityOfPhoneNumber(
                        //                           phone: _detail.phoneNumber
                        //                               .toString(),
                        //                           onSuccess: (msg) {
                        //                             Map<String, dynamic>
                        //                                 details = {
                        //                               "first_name":
                        //                                   _detail.firstName,
                        //                               "last_name":
                        //                                   _detail.lastName,
                        //                               "email": _detail.email,
                        //                               "contact_number":
                        //                                   _detail.phoneNumber,
                        //                               "countryCode":
                        //                                   _detail.countryCode,
                        //                               "password":
                        //                                   _detail.password,
                        //                               "deviceType":
                        //                                   _detail.deviceType,
                        //                               "deviceToken":
                        //                                   _detail.fcmToken,
                        //                               "role": "player",
                        //                               "gender": _detail.gender
                        //                             };
                        //                             if (widget
                        //                                     .detail["google"] ==
                        //                                 true) {
                        //                               details["is_google_user"] =
                        //                                   true;
                        //                             } else if (widget
                        //                                     .detail["apple"] ==
                        //                                 true) {
                        //                               details["is_apple_user"] =
                        //                                   true;
                        //                               details["appleId"] =
                        //                                   widget.detail['user'];
                        //                             } else if (widget.detail[
                        //                                     "facebook"] ==
                        //                                 true) {
                        //                               details["is_facebook_user"] =
                        //                                   true;
                        //                               details["appleId"] =
                        //                                   widget.detail[
                        //                                       "appleId"];
                        //                             }
                        //                             _networkCalls.signUp(
                        //                                 signupDetail: details,
                        //                                 onSuccess: (msg) {
                        //                                   navigateToDetail();
                        //                                 },
                        //                                 onFailure: (msg) {
                        //                                   if (mounted) {
                        //                                     setState(() {
                        //                                       loading = true;
                        //                                     });
                        //                                   }
                        //                                   showMessage(msg);
                        //                                 });
                        //                           },
                        //                           onFailure: (msg) {
                        //                             if (mounted) {
                        //                               setState(() {
                        //                                 loading = true;
                        //                               });
                        //                             }
                        //                             showMessage(msg);
                        //                           },
                        //                           tokenExpire: () {
                        //                             if (mounted) {
                        //                               on401(context);
                        //                             }
                        //                           });
                        //                 },
                        //                 onFailure: (msg) {
                        //                   if (mounted) {
                        //                     setState(() {
                        //                       loading = true;
                        //                     });
                        //                   }
                        //                   showMessage(msg);
                        //                 },
                        //                 tokenExpire: () {
                        //                   if (mounted) on401(context);
                        //                 });
                        //           } else {
                        //             if (mounted) {
                        //               showMessage(AppLocalizations.of(context)!
                        //                   .noInternetConnection);
                        //             }
                        //           }
                        //         });
                        //       } else {
                        //         if (mounted) {
                        //           showMessage(AppLocalizations.of(context)!
                        //               .pleaseselectgender);
                        //         }
                        //       }
                        //       // } else {
                        //       //   if (mounted)
                        //       //     showMessage(
                        //       //         AppLocalizations.of(context)
                        //       //             .pleaseselectDateofBirth,
                        //       //         scaffoldkey);
                        //       // }
                        //     }
                        //   },
                        // ),
                        // TextButton(
                        //   style: TextButton.styleFrom(
                        //     primary: Colors.black,
                        //     backgroundColor: Color(0XFF25A163)
                        //   ),
                        //
                        //   onPressed: () {
                        //     if (_formKey.currentState.validate()) {
                        //       _formKey.currentState.save();
                        //       FocusScope.of(context).unfocus();
                        //       _detail.password = base64.encode(utf8.encode("None"));
                        //       _detail.firstName =
                        //           widget.detail["detail"]["first_name"];
                        //       _detail.lastName =
                        //           widget.detail["detail"]["last_name"];
                        //       _detail.dob = lastBookingDateApi;
                        //       if (widget.detail["apple"] == null) {
                        //         if (widget.detail["detail"]["email"] !=
                        //             null) {
                        //           _detail.email =
                        //               widget.detail["detail"]["email"];
                        //         }
                        //       }
                        //       if (_detail.playerPosition != null) {
                        //         if (_detail.dob != null) {
                        //           if (_detail.gender != null) {
                        //             _networkCalls
                        //                 .checkInternetConnectivity(
                        //                     onSuccess: (msg) {
                        //               if (msg == true) {
                        //                 setState(() {
                        //                   loading = false;
                        //                 });
                        //                 _networkCalls
                        //                     .checkAvailabilityOfEmail(
                        //                         email: _detail.email,
                        //                         onSuccess: (msg) {
                        //                           _networkCalls
                        //                               .checkAvailabilityOfPhoneNumber(
                        //                                   phone: _detail
                        //                                       .phoneNumber,
                        //                                   onSuccess:
                        //                                       (msg) {
                        //                                     var details =
                        //                                         {
                        //                                       "first_name": _detail.firstName,
                        //                                       "last_name": _detail.lastName,
                        //                                       "email": _detail.email,
                        //                                       "contact_number": _detail.phoneNumber,
                        //                                       "countryCode": _detail.countryCode,
                        //                                       "playerpositionSlug": _detail.playerPosition,
                        //                                       "password": _detail.password,
                        //                                       "deviceType": _detail.deviceType,
                        //                                       "dob": lastBookingDateApi,
                        //                                       "deviceToken": _detail.fcmToken,
                        //                                       "role": "player",
                        //                                       "gender": _detail.gender
                        //                                     };
                        //                                     if (widget.detail[
                        //                                             "google"] == true) {
                        //                                       details["is_google_user"] = true;
                        //                                     } else if (widget.detail["apple"] == true) {
                        //                                       details["is_apple_user"] = true;
                        //                                       details["appleId"] = widget.detail['user'];
                        //                                     } else if (widget.detail["facebook"] == true) {
                        //                                       details["is_facebook_user"] = true;
                        //                                       details["appleId"] = widget.detail["appleId"];
                        //                                     }
                        //                                     _networkCalls
                        //                                         .signUp(
                        //                                             signupDetail:
                        //                                                 details,
                        //                                             onSuccess:
                        //                                                 (msg) {
                        //                                               navigateToDetail();
                        //                                             },
                        //                                             onFailure:
                        //                                                 (msg) {
                        //                                               if (mounted)
                        //                                                 setState(() {
                        //                                                   loading = true;
                        //                                                 });
                        //                                               showMessage(msg,
                        //                                                   scaffoldkey);
                        //                                             });
                        //                                   },
                        //                                   onFailure:
                        //                                       (msg) {
                        //                                     if (mounted)
                        //                                       setState(
                        //                                           () {
                        //                                         loading =
                        //                                             true;
                        //                                       });
                        //                                     showMessage(
                        //                                         msg,
                        //                                         scaffoldkey);
                        //                                   },
                        //                                   tokenExpire:
                        //                                       () {
                        //                                     if (mounted)
                        //                                       on401(
                        //                                           context);
                        //                                   });
                        //                         },
                        //                         onFailure: (msg) {
                        //                           if (mounted)
                        //                             setState(() {
                        //                               loading = true;
                        //                             });
                        //                           showMessage(
                        //                               msg, scaffoldkey);
                        //                         },
                        //                         tokenExpire: () {
                        //                           if (mounted)
                        //                             on401(context);
                        //                         });
                        //               } else {
                        //                 if(mounted){
                        //                   showMessage(
                        //                       AppLocalizations.of(context).noInternetConnection,
                        //                       scaffoldkey);
                        //                  }
                        //               }
                        //             });
                        //           } else {
                        //             if (mounted)
                        //               showMessage(
                        //                   AppLocalizations.of(context)
                        //                       .pleaseselectgender,
                        //                   scaffoldkey);
                        //           }
                        //         } else {
                        //           if (mounted)
                        //             showMessage(
                        //                 AppLocalizations.of(context)
                        //                     .pleaseselectDateofBirth,
                        //                 scaffoldkey);
                        //         }
                        //       } else {
                        //         if (mounted)
                        //           showMessage(
                        //               AppLocalizations.of(context)
                        //                   .selectPlayerPosition,
                        //               scaffoldkey);
                        //       }
                        //     }
                        //   },
                        //   child: Center(
                        //     child: Text(
                        //       AppLocalizations.of(context).continueS,
                        //       style: TextStyle(
                        //         fontSize: 20,
                        //         color: Colors.white,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        flaxibleGap(
                          1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
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
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }
}
