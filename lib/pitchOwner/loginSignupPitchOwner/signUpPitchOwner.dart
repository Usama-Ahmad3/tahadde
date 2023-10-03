import 'dart:convert';
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _focus = FocusNode();
  final _focuss = FocusNode();
  final _focusss = FocusNode();
  final _focussss = FocusNode();
  final _focusssss = FocusNode();
  late String _gender;
  bool _checkBoxSelect = false;
  final GlobalKey _textKey = GlobalKey();
  bool _internet = true;
  bool _isLoading = false;
  String _initialCountry = '+971';
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: '');
  final _password = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final SignUpDetail _detail = SignUpDetail();
  final NetworkCalls _networkCalls = NetworkCalls();
  bool passwordHide = true;
  bool passwordHide1 = true;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) {
      _detail.deviceType = "IOS";
    } else {
      _detail.deviceType = "ANDROID";
    }
    _firebaseMessaging.getToken().then((token) {
      _detail.fcmToken = token!;

      print(token);
    });
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
        child: const DoneButton(),
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

  void _showCupertinoDialog(double height, double width) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.only(left: 20, right: 20),
            title: Center(
                child: Text(AppLocalizations.of(context)!.informationText)),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: SizedBox(
              height: height,
              width: width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.locationText,
                      style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.locationDes,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.responsibilities,
                      style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.responsibilitiesDes,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.commissionPayment,
                      style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.commissionPaymentDes,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.termTermination,
                      style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.termTerminationDes,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.cancellationPolicy,
                      style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppLocalizations.of(context)!.cancellationPolicyDes,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.20,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0XFF25A163),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppLocalizations.of(context)!.ok,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          );
        });
  }

  privacyPolicy(String text) async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
    if (Platform.isIOS) {
      _focusssss.addListener(() {
        bool hasFocus = _focusssss.hasFocus;
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
    return Material(
        child: _internet
            ? GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  backgroundColor: const Color(0XFFFFFFFF),
                  bottomNavigationBar: _checkBoxSelect
                      ? Material(
                          color: const Color(0XFF25A163),
                          child: _isLoading
                              ? Container(
                                  height: sizeHeight * .09,
                                  alignment: Alignment.center,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                  ))
                              : InkWell(
                                  onTap: () {
                                    _formKey.currentState!.save();
                                    FocusScope.of(context).unfocus();
                                    if (_detail.gender != null) {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          _networkCalls
                                              .checkAvailabilityOfEmail(
                                                  email:
                                                      _detail.email.toString(),
                                                  onSuccess: (msg) {
                                                    navigateToPitchDetail(
                                                        _detail);
                                                    _networkCalls
                                                        .checkAvailabilityOfPhoneNumber(
                                                            phone: _detail
                                                                .phoneNumber
                                                                .toString(),
                                                            onSuccess: (msg) {
                                                              navigateToPitchDetail(
                                                                  _detail);
                                                            },
                                                            onFailure: (msg) {
                                                              setState(() {
                                                                _isLoading =
                                                                    false;
                                                              });
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
                                                        _isLoading = false;
                                                      });
                                                    }
                                                    showMessage(msg);
                                                  },
                                                  tokenExpire: () {
                                                    if (mounted) {
                                                      on401(context);
                                                    }
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
                                  },
                                  splashColor: Colors.black,
                                  child: Container(
                                      height: sizeHeight * .09,
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
                          height: sizeHeight * .09,
                        ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: sizeHeight * .205,
                        child: Column(
                          children: [
                            buildAppBar(
                                language: AppLocalizations.of(context)!.locale,
                                title: AppLocalizations.of(context)!
                                    .pitchOwnerDetails,
                                backButton: true,
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                height: sizeHeight,
                                width: sizeWidth),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFF25A163),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Container(
                                  height: sizeHeight * .005,
                                  width: sizeWidth * .19,
                                  color: const Color(0XFFCBCBCB),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      fixedGap(height: 10.0),
                                      textField(
                                          focusAuto: true,
                                          submit: (value) {
                                            FocusScope.of(context)
                                                .requestFocus(_focus);
                                          },
                                          controller: _emailController,
                                          name: AppLocalizations.of(context)!
                                              .email,
                                          hint: AppLocalizations.of(context)!
                                              .email,
                                          text: false,
                                          onSaved: (value) {
                                            _detail.email = value!;
                                          },
                                          text1: false,
                                          validator: (value) {
                                            String msg;
                                            if (!isMail(value!.trim())) {
                                              msg =
                                                  AppLocalizations.of(context)!
                                                          .invalidEmail ??
                                                      '';
                                            }
                                            return '';
                                          }),
                                      textField(
                                        node: _focus,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterFirstName;
                                          }
                                          return '';
                                        },
                                        submit: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(_focuss);
                                        },
                                        controller: _nameController,
                                        name: AppLocalizations.of(context)!
                                            .firstName,
                                        hint: AppLocalizations.of(context)!
                                            .firstName,
                                        onSaved: (value) {
                                          _detail.firstName = value!;
                                        },
                                      ),
                                      textField(
                                        node: _focuss,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return AppLocalizations.of(context)!
                                                .pleaseenterLastName;
                                          }
                                          return '';
                                        },
                                        submit: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusss);
                                        },
                                        controller: _lastController,
                                        name: AppLocalizations.of(context)!
                                            .lastName,
                                        hint: AppLocalizations.of(context)!
                                            .lastName,
                                        onSaved: (value) {
                                          _detail.lastName = value!;
                                        },
                                      ),
                                      TextFormField(
                                        focusNode: _focusss,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(_focussss);
                                        },
                                        controller: _passwordController,
                                        validator: (e) {
                                          validatePassword(e.toString());
                                          return null;
                                        },
                                        onSaved: (value) {
                                          String encoded = base64
                                              .encode(utf8.encode(value!));
                                          _detail.password = encoded;
                                        },
                                        autofocus: false,
                                        obscureText: passwordHide,
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontWeight: FontWeight.w500),
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .password,
                                          //\uD83D\uDD12
                                          labelStyle: const TextStyle(
                                              color: Color(0XFFADADAD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                          suffixIcon: GestureDetector(
                                            child: passwordHide
                                                ? const Icon(
                                                    Icons.visibility,
                                                    color: Color(0XFFADADAD),
                                                  )
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    color: Color(0XFFADADAD),
                                                  ),
                                            onTap: () {
                                              if (mounted) {
                                                setState(() {
                                                  passwordHide = !passwordHide;
                                                });
                                              }
                                            },
                                          ),
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
                                      TextFormField(
                                        focusNode: _focussss,
                                        textInputAction: TextInputAction.next,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context)
                                              .requestFocus(_focusssss);
                                        },
                                        controller: _password,
                                        validator: (e) {
                                          validateConfirmPassword;
                                          return null;
                                        },
                                        autofocus: false,
                                        obscureText: passwordHide1,
                                        style: const TextStyle(
                                            color: Color(0XFF032040),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                        decoration: InputDecoration(
                                          hintStyle: const TextStyle(
                                              color: Color(0XFF032040),
                                              fontWeight: FontWeight.w500),
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .confermpassword,
                                          //\uD83D\uDD12
                                          labelStyle: const TextStyle(
                                              color: Color(0XFFADADAD),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                          suffixIcon: GestureDetector(
                                            child: passwordHide1
                                                ? const Icon(
                                                    Icons.visibility,
                                                    color: Color(0XFFADADAD),
                                                  )
                                                : const Icon(
                                                    Icons.visibility_off,
                                                    color: Color(0XFFADADAD),
                                                  ),
                                            onTap: () {
                                              setState(() {
                                                passwordHide1 = !passwordHide1;
                                              });
                                            },
                                          ),
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
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .phoneNumber,
                                          style: const TextStyle(
                                              color: Color(0XFF9F9F9F),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? CountryCodePicker(
                                                  textStyle: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  onChanged: (value) {
                                                    if (mounted) {
                                                      setState(() {
                                                        _detail.countryCode =
                                                            value.toString();
                                                        _initialCountry =
                                                            value.toString();
                                                      });
                                                    }
                                                  },
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection:
                                                      _initialCountry,
                                                  favorite: const ['+971', 'ITU'],
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
                                                node: _focusssss,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return AppLocalizations.of(
                                                            context)!
                                                        .pleaseenterPhoneNumber;
                                                  }
                                                  return '';
                                                },
                                                controller: _numberController,
                                                text: false,
                                                keybordType: false,
                                                name: "",
                                                onSaved: (value) {
                                                  _detail.phoneNumber = value!;
                                                },
                                              ),
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
                                                    if (mounted) {
                                                      setState(() {
                                                        _detail.countryCode =
                                                            value.toString();
                                                        _initialCountry =
                                                            value.toString();
                                                      });
                                                    }
                                                  },
                                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                  initialSelection:
                                                      _initialCountry,
                                                  favorite: const ['+971', 'ITU'],
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
                                      // AppLocalizations.of(context).locale ==
                                      //         "en"
                                      //     ? Container(
                                      //         height: sizeHeight * .07,
                                      //         width: sizeWidth,
                                      //         child: Center(
                                      //           child: DropdownButton<String>(
                                      //             underline: Container(
                                      //               height: 1,
                                      //               color: Color(0XFF9F9F9F),
                                      //             ),
                                      //             iconEnabledColor:
                                      //                 Color(0XFF9B9B9B),
                                      //             focusColor: Color(0XFF9B9B9B),
                                      //             isExpanded: true,
                                      //             value: _gender,
                                      //             hint: Text(
                                      //               AppLocalizations.of(context)
                                      //                   .gender,
                                      //               style: TextStyle(
                                      //                   color:
                                      //                       Color(0XFFADADAD),
                                      //                   fontWeight:
                                      //                       FontWeight.w500,fontSize: 12),
                                      //             ),
                                      //             items: genderEn
                                      //                 .map((value) =>
                                      //                     DropdownMenuItem(
                                      //                       child: Text(
                                      //                         value,
                                      //                         style: TextStyle(
                                      //                             color: Color(
                                      //                                 0XFF032040),
                                      //                             fontWeight:
                                      //                                 FontWeight
                                      //                                     .w600),
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
                                      //         height: sizeHeight * .07,
                                      //         width: sizeWidth,
                                      //         child: Center(
                                      //           child: DropdownButton<String>(
                                      //             underline: Container(
                                      //               height: 1,
                                      //               color: Color(0XFF9F9F9F),
                                      //             ),
                                      //             iconEnabledColor:
                                      //                 Color(0XFF9B9B9B),
                                      //             focusColor: Color(0XFF9B9B9B),
                                      //             isExpanded: true,
                                      //             value: _gender,
                                      //             hint: Text(
                                      //               AppLocalizations.of(context)
                                      //                   .gender,
                                      //               style: TextStyle(
                                      //                   color:
                                      //                       Color(0XFFADADAD),
                                      //                   fontWeight:
                                      //                       FontWeight.w500),
                                      //             ),
                                      //             items: genderAr
                                      //                 .map((value) =>
                                      //                     DropdownMenuItem(
                                      //                       child: Text(
                                      //                         value,
                                      //                         style: TextStyle(
                                      //                             color: Color(
                                      //                                 0XFF032040),
                                      //                             fontWeight:
                                      //                                 FontWeight
                                      //                                     .w600),
                                      //                       ),
                                      //                       value: value,
                                      //                     ))
                                      //                 .toList(),
                                      //             onChanged: (String value) {
                                      //               if (mounted)
                                      //                 setState(() {
                                      //                   _gender = value;
                                      //                   _detail.gender =
                                      //                       _gender;
                                      //                   print(_detail.gender);
                                      //                 });
                                      //             },
                                      //           ),
                                      //         ),
                                      //       ),
                                      fixedGap(height: 10.0),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _checkBoxSelect,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          _checkBoxSelect = value as bool;
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: sizeWidth * .8,
                                      child: RichText(
                                        key: _textKey,
                                        text: TextSpan(
                                          text:
                                              '${AppLocalizations.of(context)!.clickHereIndicate} ',
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF7A7A7A)),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .tahaddeAgreement,
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  privacyPolicy(
                                                      "venue_owner_term_condition");
                                                  // _showCupertinoDialog(
                                                  //     sizeHeight * .6, sizeWidth);
                                                },
                                              style: const TextStyle(
                                                color: Color(0XFF25A163),
                                                fontWeight: FontWeight.bold,
//                                                  decoration:
//                                                      TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      if (mounted) {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    }
                  });
                },
              ));
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return AppLocalizations.of(context)!.passwordMismatch;
    }
    return '';
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return AppLocalizations.of(context)!.minimumMaximum14Characters;
    }
    return '';
  }

  void navigateToPitchDetail(SignUpDetail detail) {
    Navigator.pushNamed(context, RouteNames.varifyMoblie, arguments: detail)
        .then((onValue) {
      setState(() {
        _isLoading = false;
      });
    });
  }
}
