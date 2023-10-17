import 'dart:convert';
import 'dart:io';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../common_widgets/internet_loss.dart';
import '../../common_widgets/loginButoon.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final focus = FocusNode();
  final focuss = FocusNode();
  final focusss = FocusNode();
  final focussss = FocusNode();
  final focusssss = FocusNode();
  bool _internet = true;
  bool isLoading = true;
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController(text: '');
  final _password = TextEditingController();
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _lastController = TextEditingController();
  final _emailController = TextEditingController();
  final SignUpDetail _detail = SignUpDetail();
  late OverlayEntry? overlayEntry;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool passwordHide = true;
  final GlobalKey _textKey = GlobalKey();
  bool confermPasswordHide = true;
  bool appbar = false;
  String _initialCountry = '+92';
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<String> playerPostion = [];
  String? _gender;
  List<String> playerPostionSlug = [];
  late String playerSlug;

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) {
      _detail.deviceType = "IOS";
    } else {
      _detail.deviceType = "Android";
    }

    _firebaseMessaging.getToken().then((token) {
      _detail.fcmToken = token!;

      // print(token);
      // print(_detail.deviceType);
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
      focusssss.addListener(() {
        bool hasFocus = focusssss.hasFocus;
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
                appBar: appBar(
                  language: AppLocalizations.of(context)!.locale,
                  title: AppLocalizations.of(context)!.register,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          fixedGap(height: 10.0),
                          textField(
                              focusAuto: true,
                              submit: (value) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              controller: _emailController,
                              name: AppLocalizations.of(context)!.email,
                              hint: AppLocalizations.of(context)!.email,
                              onSaved: (value) {
                                _detail.email = value;
                              },
                              text: false,
                              text1: false,
                              validator: (value) {
                                var msg;
                                if (!isMail(value!.trim())) {
                                  msg = AppLocalizations.of(context)!
                                      .invalidEmail;
                                }
                                return msg;
                              }),
                          textField(
                            node: focus,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenterFirstName;
                              }
                              return '';
                            },
                            submit: (value) {
                              FocusScope.of(context).requestFocus(focuss);
                            },
                            controller: _nameController,
                            name: AppLocalizations.of(context)!.firstName,
                            hint: AppLocalizations.of(context)!.firstName,
                            onSaved: (value) {
                              _detail.firstName = value!;
                            },
                          ),
                          textField(
                            node: focuss,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenterLastName;
                              }
                              return '';
                            },
                            submit: (value) {
                              FocusScope.of(context).requestFocus(focusss);
                            },
                            controller: _lastController,
                            name: AppLocalizations.of(context)!.lastName,
                            hint: AppLocalizations.of(context)!.lastName,
                            onSaved: (value) {
                              _detail.lastName = value;
                            },
                          ),
                          TextFormField(
                            focusNode: focusss,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(focussss);
                            },
                            controller: _passwordController,
                            validator: (e) {
                              return validatePassword(e.toString());
                            },
                            onSaved: (value) {
                              String encoded =
                                  base64.encode(utf8.encode(value!));
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
                              labelText: AppLocalizations.of(context)!.password,
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
                                  setState(() {
                                    passwordHide = !passwordHide;
                                  });
                                },
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFF9F9F9F)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFF9F9F9F)),
                              ),
                            ),
                          ),
                          TextFormField(
                            focusNode: focussss,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(focusssss);
                            },
                            controller: _password,
                            validator: (e) {
                              validateConfirmPassword;
                              return null;
                            },
                            autofocus: false,
                            obscureText: confermPasswordHide,
                            style: const TextStyle(
                                color: Color(0XFF032040),
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            decoration: InputDecoration(
                              hintStyle: const TextStyle(
                                  color: Color(0XFF032040),
                                  fontWeight: FontWeight.w500),
                              labelText:
                                  AppLocalizations.of(context)!.confermpassword,
                              //\uD83D\uDD12
                              labelStyle: const TextStyle(
                                  color: Color(0XFFADADAD),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                              suffixIcon: GestureDetector(
                                child: confermPasswordHide
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
                                    confermPasswordHide = !confermPasswordHide;
                                  });
                                },
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFF9F9F9F)),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFF9F9F9F)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              AppLocalizations.of(context)!.phoneNumber,
                              style: const TextStyle(
                                  color: Color(0XFF9F9F9F),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              AppLocalizations.of(context)!.locale == "en"
                                  ? CountryCodePicker(
                                      padding: const EdgeInsets.only(top: 5),
                                      textStyle: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                      onChanged: (value) {
                                        setState(() {
                                          _detail.countryCode =
                                              value.toString();
                                          _initialCountry = value.toString();
                                          print(_detail.countryCode);
                                        });
                                      },
                                      initialSelection: _initialCountry,
                                      favorite: const [
                                        '+92',
                                        'pk',
                                      ],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                    )
                                  : Container(),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  width: sizeWidth * .5,
                                  alignment: Alignment.topCenter,
                                  child: textField(
                                    testAlignment:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? true
                                            : false,
                                    node: focusssss,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return AppLocalizations.of(context)!
                                            .pleaseenterPhoneNumber;
                                      }
                                      return '';
                                    },
                                    controller: _numberController,
                                    text: false,
                                    text1: true,
                                    keybordType: false,
                                    name: "",
                                    onchange: (value) {
                                      _detail.phoneNumber = value;
                                    },
                                    onSaved: (value) {},
                                  ),
                                ),
                              ),
                              AppLocalizations.of(context)!.locale == "ar"
                                  ? CountryCodePicker(
                                      padding: const EdgeInsets.only(top: 5),
                                      textStyle: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                      onChanged: (value) {
                                        if (mounted) {
                                          setState(() {
                                            _detail.countryCode =
                                                value.toString();
                                            _initialCountry = value.toString();
                                          });
                                        }
                                      },
                                      initialSelection: _initialCountry,
                                      favorite: const [
                                        '+92',
                                        'pk',
                                      ],
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      alignLeft: false,
                                    )
                                  : Container(),
                            ],
                          ),
                          AppLocalizations.of(context)!.locale == "en"
                              ? SizedBox(
                                  height: sizeHeight * .07,
                                  width: sizeWidth,
                                  child: Center(
                                    child: DropdownButton<String>(
                                      underline: Container(
                                        height: 1,
                                        color: const Color(0XFF9F9F9F),
                                      ),
                                      iconEnabledColor: const Color(0XFF9B9B9B),
                                      focusColor: const Color(0XFF9B9B9B),
                                      isExpanded: true,
                                      value: _gender,
                                      hint: Text(
                                        AppLocalizations.of(context)!.gender,
                                        style: const TextStyle(
                                            color: Color(0XFFADADAD),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      items: genderEn
                                          .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Color(0XFF032040),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _gender = value!;
                                          _detail.gender = _gender;
                                          print(_detail.gender);
                                        });
                                      },
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: sizeHeight * .07,
                                  width: sizeWidth,
                                  child: Center(
                                    child: DropdownButton<String>(
                                      underline: Container(
                                        height: 1,
                                        color: const Color(0XFF9F9F9F),
                                      ),
                                      iconEnabledColor: const Color(0XFF9B9B9B),
                                      focusColor: const Color(0XFF9B9B9B),
                                      isExpanded: true,
                                      value: _gender,
                                      hint: Text(
                                        AppLocalizations.of(context)!.gender,
                                        style: const TextStyle(
                                            color: Color(0XFFADADAD),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12),
                                      ),
                                      items: genderAr
                                          .map((value) => DropdownMenuItem(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      color: Color(0XFF032040),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _gender = value!;
                                          _detail.gender = _gender;
                                          print(_detail.gender);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                          fixedGap(height: 30.0),
                          AppButton(
                            isLoading: !isLoading,
                            child: Text(
                              AppLocalizations.of(context)!.login,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.right,
                            ),
                            onPressed: () async {
                              _formKey.currentState!.save();
                              FocusScope.of(context).unfocus();
                              if (_detail.gender != null) {
                                _networkCalls.checkInternetConnectivity(
                                    onSuccess: (msg) {
                                  if (mounted) _internet = msg;
                                  if (msg == true) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    _networkCalls.checkAvailabilityOfEmail(
                                        email: _detail.email.toString(),
                                        onSuccess: (msg) async {
                                          navigateToDetail(_detail);
                                          _networkCalls
                                              .checkAvailabilityOfPhoneNumber(
                                                  phone: _detail.phoneNumber
                                                      .toString(),
                                                  onSuccess: (msg) {
                                                    navigateToDetail(_detail);
                                                  },
                                                  onFailure: (msg) {
                                                    if (mounted) {
                                                      setState(() {
                                                        isLoading = true;
                                                      });
                                                    }
                                                    showMessage(
                                                      msg,
                                                    );
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
                                              isLoading = true;
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
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });
                              }
                            },
                          ),
                          fixedGap(height: 10.0),
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: RichText(
                                key: _textKey,
                                text: TextSpan(
                                  text:
                                      '${AppLocalizations.of(context)!.bysigningupTahaddi} ',
                                  style: const TextStyle(
                                      fontSize: 12, color: Color(0XFF7A7A7A)),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppLocalizations.of(context)!
                                          .termsofUse,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          privacyPolicy(
                                              "terms_and_conditions_url");
                                        },
                                      style: const TextStyle(
                                        color: Color(0XFF25A163),
                                        fontWeight: FontWeight.bold,
//                                                  decoration:
//                                                      TextDecoration.underline,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          ' ${AppLocalizations.of(context)!.and} ',
                                    ),
                                    TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .privacyPolicy,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            privacyPolicy("privacy_policy_url");
                                          },
                                        style: const TextStyle(
                                          color: Color(0XFF25A163),
                                          fontWeight: FontWeight.bold,
//                                                    decoration: TextDecoration
//                                                        .underline,
                                        )),
                                  ],
                                ),
                              )),
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
                  _internet = msg;
                  if (msg == true) {
                    if (mounted) {
                      setState(() {
                        isLoading = true;
                      });
                    }
                  }
                });
              },
            ),
    );
  }

  void navigateToDetail(SignUpDetail detail) {
    Navigator.pushNamed(context, RouteNames.varification, arguments: detail)
        .then((onValue) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
    });
  }

  void navigateToDetail1() {
    Navigator.of(context).pop();
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

  Map<String, String> signup() {
    Map<String, String> details;
    details = {
      "first_name": _detail.firstName.toString(),
      "last_name": _detail.lastName.toString(),
      "email": _detail.email.toString(),
      "contact_numbe": _detail.phoneNumber.toString(),
      "password": _detail.password.toString()
    };
    return details;
  }
}

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey)),
        color: Color(0XFFF0F0F0),
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
          child: CupertinoButton(
              padding: const EdgeInsets.only(right: 24, top: 8, bottom: 8),
              child: Text(
                AppLocalizations.of(context)!.done,
                style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              ),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
              }),
        ),
      ),
    );
  }
}

class SignUpDetail {
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  String? fcmToken;
  String? countryCode;
  String? deviceType;
  String? dob;
  String? gender;
  String? id;

  SignUpDetail(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.deviceType,
      this.fcmToken,
      this.dob,
      this.id,
      this.gender = "Male",
      this.countryCode = "+971"});
}
