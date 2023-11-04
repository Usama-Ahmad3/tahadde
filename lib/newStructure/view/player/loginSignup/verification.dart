import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common_widgets/internet_loss.dart';
import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../network/network_calls.dart';
import '../../../app_colors/app_colors.dart';
import 'login.dart';

// ignore: must_be_immutable
class VerificationScreen extends StatefulWidget {
  SignUpSignInDetail detail;

  VerificationScreen({super.key, required this.detail});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  var controllerPin = TextEditingController();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool internet = true;
  int color1 = 0XFFAEAEAE;
  String pin = '';
  Position? position;
  bool loading = false;
  late Map details;
  late String phoneNo;
  String? smsOTP;
  String? verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";

  location() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void _signInWithPhoneNumber() async {
    try {
      verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
        await _auth.signInWithCredential(phoneAuthCredential);
        print("SSS$errorMessage");
        showMessage(AppLocalizations().verified);
      }

      verificationFailed(FirebaseAuthException authException) {
        showMessage("EEE${authException.message}");
      }

      codeSent(String verificationId, [int? forceResendingToken]) {
        setState(() {
          _verificationId = verificationId;
        });
      }

      codeAutoRetrievalTimeout(String verificationId) {
        // showMessage("Time${verificationId.toString()}");
      }

      print('on');
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      );
      print('off');
    } catch (e) {
      showMessage("$e");
      print('of$e');
    }
  }

  void _verifyPhoneNumberWithCode(String code) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: controllerPin.text,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (kDebugMode) {
        print(userCredential.additionalUserInfo);
      }
      final User? currentUser = userCredential.user;
      if (currentUser != null) {
        // print('SignUp Calling');
        signup();
        // print('SignUp Calling End');
        setState(() {
          loading = true;
        });
      }
    } catch (e) {
      setState(() {
        loading = false;
        showMessage(AppLocalizations.of(context)!.invalidOTPCode);
        if (kDebugMode) {
          print("catch$e");
        }
      });
      if (kDebugMode) {
        print('fail');
      }
    }
  }

  signup() {
    details = {
      "first_name": widget.detail.firstName,
      "last_name": widget.detail.lastName,
      "email": widget.detail.email,
      "contact_number": widget.detail.phoneNumber,
      "role":
          widget.detail.player == 'Owner' ? 'pitchowner' : widget.detail.player,
      "country": "UAE",
      "countryCode": widget.detail.countryCode,
      "password": base64.encode(utf8.encode(widget.detail.password.toString())),
      "deviceType": widget.detail.deviceType,
      "deviceToken": widget.detail.fcmToken,
      "gender": "male"
    };
    print(details);
    if (position != null) {
      details["longitude"] = position!.longitude;
      details["latitude"] = position!.latitude;
    }
    _networkCalls.signUp(
        signupDetail: details,
        onSuccess: (msg) {
          showSucess(msg, scaffoldkey);
          widget.detail.player == 'Owner'
              ? navigateToSports()
              : navigateToDetail();
          setState(() {
            loading = false;
          });
        },
        onFailure: (msg) {
          setState(() {
            loading = false;
          });
          showMessage(msg);
        });
  }

  @override
  void initState() {
    print(widget.detail.player);
    phoneNo = "${widget.detail.countryCode}${widget.detail.phoneNumber}";
    print(phoneNo);
    super.initState();
    // signup();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) async {
      internet = msg;
      if (msg == true) {
        _signInWithPhoneNumber();
        location();
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controllerPin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return internet
        ? Scaffold(
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.13),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.verifyOTP,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: AppColors.white),
                ),
                centerTitle: true,
                backgroundColor: AppColors.black,
                leadingWidth: width * 0.18,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: height * 0.004,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            shape: BoxShape.circle),
                        child: Icon(
                          AppLocalizations.of(context)!.locale == 'en'
                              ? Icons.keyboard_arrow_left_sharp
                              : Icons.keyboard_arrow_right,
                          color: AppColors.white,
                        )),
                  ),
                ),
              ),
            ),
            body: Container(
              color: AppColors.black,
              child: Container(
                width: width,
                height: height,
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.darkTheme,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * .55,
                        width: MediaQuery.of(context).size.width,
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.containerColorW,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * .08,
                            right: MediaQuery.of(context).size.width * .08,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.01,
                              ),
                              Text(
                                AppLocalizations.of(context)!.enterCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        backgroundColor: AppColors.transparent,
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
                                        fontSize: height * 0.03),
                              ),
                              flaxibleGap(
                                2,
                              ),
                              AppLocalizations.of(context)!.locale == "en"
                                  ? Text(
                                      '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode}${widget.detail.phoneNumber}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? const Color(0XFF595959)
                                                  : AppColors.white),
                                    )
                                  : Text(
                                      '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode!.substring(1)}${widget.detail.phoneNumber}${widget.detail.countryCode!.substring(0, 1)}',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? const Color(0XFF595959)
                                                  : AppColors.white),
                                    ),
                              flaxibleGap(
                                2,
                              ),
                              Text(
                                AppLocalizations.of(context)!.enterCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white),
                              ),
                              flaxibleGap(
                                1,
                              ),
                              PinCodeTextField(
                                appContext: context,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                length: 6,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  // Change the shape to box or underline
                                  borderRadius: BorderRadius.circular(5),
                                  fieldHeight: 50,
                                  fieldWidth: 40,
                                  inactiveColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.containerColorB
                                          : AppColors.white,
                                  activeColor: const Color(0xff1d7e55),
                                  selectedColor: AppColors.grey,
                                  borderWidth: 2,
                                ),
                                controller: controllerPin,
                                obscureText: false,
                                animationType: AnimationType.scale,
                                enablePinAutofill: true,
                                keyboardType: TextInputType.number,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                onChanged: (value) {
                                  setState(() {
                                    smsOTP = value;
                                    pin = value;
                                    smsOTP!.length < 6
                                        ? color1 = 0XFFAEAEAE
                                        : color1 = 0XFF25A163;
                                  });
                                },
                              ),
                              flaxibleGap(
                                1,
                              ),
                              InkWell(
                                splashColor: Colors.black,
                                onTap: () {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) async {
                                    internet = msg;
                                    if (msg == true) {
                                      _signInWithPhoneNumber();
                                    } else {
                                      if (mounted) {
                                        showMessage(
                                            AppLocalizations.of(context)!
                                                .noInternetConnection);
                                      }
                                    }
                                  });
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.resendOTP,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white),
                                ),
                              ),
                              flaxibleGap(
                                3,
                              ),
                              ButtonWidget(
                                  isLoading: loading,
                                  onTaped: () {
                                    setState(() {
                                      loading = true;
                                    });
                                    _networkCalls.checkInternetConnectivity(
                                        onSuccess: (msg) {
                                      if (msg == true) {
                                        if (pin.length < 6) {
                                          setState(() {
                                            loading = true;
                                          });
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                    title: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .pin),
                                                    content: Text(AppLocalizations
                                                            .of(context)!
                                                        .enterthedigitcodewhichsentonregisteredphonenumber),
                                                    actions: [
                                                      TextButton(
                                                        child: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .ok),
                                                        onPressed: () {
                                                          loading = false;
                                                          Navigator.of(context)
                                                              .pop(false);
                                                        },
                                                      ),
                                                    ]);
                                              });
                                        } else {
                                          setState(() {
                                            loading = true;
                                            _verifyPhoneNumberWithCode(
                                                controllerPin.text);
                                          });
                                        }
                                      } else {
                                        if (mounted) {
                                          showMessage(
                                              AppLocalizations.of(context)!
                                                  .noInternetConnection);
                                          setState(() {
                                            loading = true;
                                          });
                                        }
                                      }
                                    });
                                  },
                                  title: Text(
                                      AppLocalizations.of(context)!.done,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.white))),
                              flaxibleGap(
                                6,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ))
        : InternetLoss(
            onChange: () {
              _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                internet = msg;
                if (msg == true) {
                  setState(() {
                    loading = false;
                  });
                }
              });
            },
          );
  }

  void navigateToDetail() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.preferredSports, (Route<dynamic> route) => false);
  }

  void navigateToSports() {
    Navigator.pushReplacementNamed(context, RouteNames.selectSport,
        arguments: false);
  }
}
