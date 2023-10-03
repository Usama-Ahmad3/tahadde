import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart' hide openAppSettings;
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import 'signup.dart';

class Verification extends StatefulWidget {
  SignUpDetail detail;
  Verification({super.key, required this.detail});

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
    // final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
    //   verificationId = verId;
    // };
    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            // verificationId = verId;
          },
          codeSent: (String verifiId, int? smsOTP) {
            verificationId = verifiId;
          },
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 120),
          verificationCompleted: (phoneAuthCredential) async {
            // final User? user =
            //     (await _auth.signInWithCredential(phoneAuthCredential)).user;
            // final User? currentUser = _auth.currentUser;
            // assert(user!.uid == currentUser!.uid);
            // if (user != null) {
            //   player_signup();
            // } else {
            setState(() {
              loading = false;
            });
            //   // print("failed");
            // }
          },
          verificationFailed: (FirebaseAuthException exception) {
            showMessage(exception.message.toString());
            print('eeee${exception.message}');
          });
    } catch (e) {
      print('aaaa');
      print(e.toString());
      // handleError(e as PlatformException);
    }
  }

  player_signup() {
    details = {
      "first_name": widget.detail.firstName,
      "last_name": widget.detail.lastName,
      "email": widget.detail.email,
      "contact_number": widget.detail.phoneNumber,
      "role": "player",
      "country": "UAE",
      "countryCode": widget.detail.countryCode,
      "password": widget.detail.password,
      "deviceType": widget.detail.deviceType,
      "deviceToken": widget.detail.fcmToken,
      "gender": widget.detail.gender
    };
    if (position != null) {
      details["longitude"] = position!.longitude;
      details["latitude"] = position!.latitude;
    }
    _networkCalls.signUp(
        signupDetail: details,
        onSuccess: (msg) {
          showSucess(msg, scaffoldkey);
          navigateToDetail();
        },
        onFailure: (msg) {
          setState(() {
            loading = false;
          });
          showMessage(msg);
        });
  }

  signin() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.toString(),
        smsCode: controllerPin.text,
      );

      await _auth.signInWithCredential(credential).then((value) {
        final User? currentUser = _auth.currentUser;
        if (currentUser != null) {
          player_signup();
        }
      });
    } catch (e) {
      setState(() {
        loading = false;
        showMessage(AppLocalizations.of(context)!.invalidOTPCode);
        print("WWWW${e.toString()}");
      });
      print('fail');
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          errorMessage = AppLocalizations.of(context)!.invalidCode;
        });
        // Navigator.of(context).pop();
        break;
      default:
        setState(() {
          errorMessage = error.message.toString();
        });
        break;
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
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Material(
        child: internet
            ? GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: Scaffold(
                  appBar: appBar(
                    language: AppLocalizations.of(context)!.locale,
                    title: AppLocalizations.of(context)!.verifyMobile,
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  body: SizedBox(
                    height: sizeHeight,
                    width: sizeWidth,
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: MediaQuery.of(context).size.height * .55,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFFFFFFF),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * .08,
                                right: MediaQuery.of(context).size.width * .08,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  flaxibleGap(
                                    2,
                                  ),
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? Text(
                                          '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode}${widget.detail.phoneNumber}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0XFF595959)),
                                        )
                                      : Text(
                                          '${AppLocalizations.of(context)!.pleaseEnter}${widget.detail.countryCode!.substring(1)}${widget.detail.phoneNumber}${widget.detail.countryCode!.substring(0, 1)}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color(0XFF595959)),
                                        ),
                                  flaxibleGap(
                                    2,
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!.enterCode,
                                    style: const TextStyle(
                                        color: Color(0XFF595959)),
                                  ),
                                  flaxibleGap(
                                    1,
                                  ),
                                  PinCodeTextField(
                                    appContext: context,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    length: 6,
                                    controller: controllerPin,
                                    obscureText: false,
                                    animationType: AnimationType.scale,
                                    enablePinAutofill: false,
                                    // shape: PinCodeFieldShape.underline,
                                    keyboardType: TextInputType.number,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    //borderRadius: BorderRadius.circular(5),
                                    //fieldHeight: 50,
                                    //fieldWidth: 40,
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
                                  Material(
                                    color: Colors.white,
                                    child: InkWell(
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
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        });
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.resendOTP,
                                        style: const TextStyle(
                                            color: Color(0XFF595959)),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(
                                    3,
                                  ),
                                  // AppButton(
                                  //   isLoading: loading,
                                  //   child: Text(
                                  //     AppLocalizations.of(context)!.verifyOTP,
                                  //     style: const TextStyle(
                                  //       fontSize: 20,
                                  //       color: Colors.white,
                                  //     ),
                                  //     textAlign: TextAlign.right,
                                  //   ),
                                  //   onPressed: () {
                                  //     _networkCalls.checkInternetConnectivity(
                                  //         onSuccess: (msg) {
                                  //       if (msg == true) {
                                  //         if (pin.length < 6) {
                                  //           showDialog(
                                  //               context: context,
                                  //               builder: (context) {
                                  //                 return AlertDialog(
                                  //                     title: Text(
                                  //                         AppLocalizations.of(
                                  //                                 context)!
                                  //                             .pin),
                                  //                     content: Text(
                                  //                         AppLocalizations.of(
                                  //                                 context)!
                                  //                             .enterthedigitcodewhichsentonregisteredphonenumber),
                                  //                     actions: <Widget>[
                                  //                       TextButton(
                                  //                         child: Text(
                                  //                             AppLocalizations.of(
                                  //                                     context)!
                                  //                                 .ok),
                                  //                         onPressed: () {
                                  //                           Navigator.of(
                                  //                                   context)
                                  //                               .pop(false);
                                  //                         },
                                  //                       ),
                                  //                     ]);
                                  //               });
                                  //         } else {
                                  //           setState(() {
                                  //             loading = true;
                                  //             signIn();
                                  //           });
                                  //         }
                                  //       } else {
                                  //         if (mounted) {
                                  //           showMessage(
                                  //               AppLocalizations.of(context)!
                                  //                   .noInternetConnection);
                                  //         }
                                  //       }
                                  //     });
                                  //   },
                                  // ),
                                  Material(
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: const Color(0XFF25A163),
                                      ),
                                      child: InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            _networkCalls
                                                .checkInternetConnectivity(
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
                                                            content: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .enterthedigitcodewhichsentonregisteredphonenumber),
                                                            actions: [
                                                              TextButton(
                                                                child: Text(
                                                                    AppLocalizations.of(
                                                                            context)!
                                                                        .ok),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(
                                                                          false);
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
                                                  showMessage(AppLocalizations
                                                          .of(context)!
                                                      .noInternetConnection);
                                                }
                                              }
                                            });
                                          },
                                          child: button(
                                            name: AppLocalizations.of(context)!
                                                .verifyOTP,
                                          )),
                                    ),
                                  ),
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
              ));
  }

  void navigateToDetail() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.preferredSports, (Route<dynamic> route) => false);
  }
}
