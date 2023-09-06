import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common_widgets/internet_loss.dart';
import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../network/network_calls.dart';
import 'login.dart';

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

  location() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future verifyPhone() async {
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNo.toString(),
          verificationCompleted: (_) {
            setState(() {
              loading = false;
            });
          },
          verificationFailed: (e) {
            showMessage(e.toString());
          },
          codeSent: (String verrification, int? token) {
            verificationId = verrification;
          },
          codeAutoRetrievalTimeout: (e) {
            showMessage(e.toString());
          });
    } catch (e) {
      print('aaaa');
      print(e.toString());
    }
  }

  signup() {
    details = {
      "first_name": widget.detail.firstName,
      "last_name": widget.detail.lastName,
      "email": widget.detail.email,
      "contact_number": widget.detail.phoneNumber,
      "role": widget.detail.player,
      "country": "UAE",
      "countryCode": widget.detail.countryCode,
      "password": widget.detail.password,
      "deviceType": widget.detail.deviceType,
      "deviceToken": widget.detail.fcmToken,
      "gender": "_"
    };
    if (position != null) {
      details["longitude"] = position!.longitude;
      details["latitude"] = position!.latitude;
    }
    _networkCalls.signUp(
        signupDetail: details,
        onSuccess: (msg) {
          showSucess(msg, scaffoldkey);
          widget.detail.player == 'player'
              ? navigateToDetail()
              : navigateToSports();
        },
        onFailure: (msg) {
          setState(() {
            loading = false;
          });
          showMessage(msg);
        });
  }

  signin() async {
    final credentials = PhoneAuthProvider.credential(
        verificationId: verificationId.toString(),
        smsCode: controllerPin.text.toString());
    try {
      print("Credential$credentials");
      await _auth.signInWithCredential(credentials);
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        signup();
      }
    } catch (e) {
      setState(() {
        loading = false;
        showMessage(AppLocalizations.of(context)!.invalidOTPCode);
        print("WWWW${e.toString()}");
      });
      print('fail');
    }
  }

  @override
  void initState() {
    phoneNo = "${widget.detail.countryCode}${widget.detail.phoneNumber}";
    print(phoneNo);
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) async {
      internet = msg;
      if (msg == true) {
        await verifyPhone();
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
    // TODO: implement dispose
    super.dispose();
    controllerPin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return internet
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.13),
              child: AppBar(
                title: Text(AppLocalizations.of(context)!.verifyOTP),
                centerTitle: true,
                backgroundColor: Colors.black,
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
            body: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.white
                      : Colors.white30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .55,
                      width: MediaQuery.of(context).size.width,
                      color: MyAppState.mode == ThemeMode.light
                          ? Colors.white
                          : Colors.white30,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .08,
                          right: MediaQuery.of(context).size.width * .08,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.03,
                                  vertical: height * 0.01),
                              child: Text(
                                AppLocalizations.of(context)!.enterCode,
                                style: TextStyle(
                                    backgroundColor: Colors.transparent,
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: height * 0.03),
                              ),
                            ),
                            flaxibleGap(
                              2,
                            ),
                            AppLocalizations.of(context)!.locale == "en"
                                ? Text(
                                    '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode}${widget.detail.phoneNumber}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Color(0XFF595959)
                                                : Colors.white),
                                  )
                                : Text(
                                    '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode!.substring(1)}${widget.detail.phoneNumber}${widget.detail.countryCode!.substring(0, 1)}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? Color(0XFF595959)
                                                : Colors.white),
                                  ),
                            flaxibleGap(
                              2,
                            ),
                            InkWell(
                              onTap: () {
                                print(phoneNo);
                                print(controllerPin.text);
                                print(verificationId);
                              },
                              child: Text(
                                AppLocalizations.of(context)!.enterCode,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
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
                                        ? Colors.black12
                                        : Colors.white,
                                activeColor: Colors.green,
                                selectedColor: Colors.grey,
                                borderWidth: 2,
                              ),
                              controller: controllerPin,
                              obscureText: false,
                              animationType: AnimationType.scale,
                              enablePinAutofill: true,
                              // shape: PinCodeFieldShape.underline,
                              keyboardType: TextInputType.number,
                              animationDuration:
                                  const Duration(milliseconds: 300),
                              // borderRadius: BorderRadius.circular(5),
                              // fieldHeight: 50,
                              // fieldWidth: 40,
                              onChanged: (value) {
                                setState(() {
                                  // currentText = value;
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
                                    await verifyPhone();
                                    debugPrint('resend');
                                  } else {
                                    if (mounted) {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                    }
                                  }
                                });
                              },
                              child: Text(
                                AppLocalizations.of(context)!.resendOTP,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                            ),
                            flaxibleGap(
                              3,
                            ),
                            ButtonWidget(
                                onTaped: () {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    if (msg == true) {
                                      if (pin.length < 6) {
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
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                    ),
                                                  ]);
                                            });
                                      } else {
                                        setState(() {
                                          loading = true;
                                          print(controllerPin.text);
                                          signin();
                                        });
                                      }
                                    } else {
                                      if (mounted) {
                                        showMessage(
                                            AppLocalizations.of(context)!
                                                .noInternetConnection);
                                      }
                                    }
                                  });
                                },
                                title:
                                    Text(AppLocalizations.of(context)!.done)),
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
          )
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
