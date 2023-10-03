import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class VarifyMoblie extends StatefulWidget {
  final SignUpDetail detail;
  const VarifyMoblie({super.key, required this.detail});
  @override
  _VarifyMoblieState createState() => _VarifyMoblieState();
}

class _VarifyMoblieState extends State<VarifyMoblie> {
  final NetworkCalls _networkCalls = NetworkCalls();
  bool internet = true;
  int color1 = 0XFFAEAEAE;
  String pin = '';
  bool _loading = false;
  final _controllerPin = TextEditingController();
  late String phoneNo;
  late String smsOTP;
  late String verificationId;
  String errorMessage = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhone() async {
    smsOTPSent(String verId, [int? forceCodeResend]) {
      verificationId = verId;
    }

    try {
      await _auth.verifyPhoneNumber(
          phoneNumber: phoneNo,
          // PHONE NUMBER TO SEND OTP
          codeAutoRetrievalTimeout: (String verId) {
            // verificationId = verId;
          },
          codeSent: (String verification, int? token) {
            verificationId = verification;
          },
          // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
          timeout: const Duration(seconds: 120),
          verificationCompleted: (AuthCredential phoneAuthCredential) async {
            print(phoneAuthCredential);
            final User? user =
                (await _auth.signInWithCredential(phoneAuthCredential)).user;
            final User? currentUser = _auth.currentUser;
            assert(user!.uid == currentUser!.uid);
            if (user != null) {
              Map detail = {
                "first_name": widget.detail.firstName,
                "last_name": widget.detail.lastName,
                "email": widget.detail.email,
                "contact_number": widget.detail.phoneNumber,
                "password": widget.detail.password,
                "role": "pitchowner",
                "deviceType": widget.detail.deviceType,
                "deviceToken": widget.detail.fcmToken,
                "country": "india",
                "countryCode": widget.detail.countryCode,
                "gender": widget.detail.gender
              };
              _networkCalls.signUp(
                  signupDetail: detail,
                  onSuccess: (detail) {
                    navigateToSports();
                    showMessage(detail);
                  },
                  onFailure: (detail) {
                    showMessage(detail);
                  });
            } else {
              if (mounted) {
                setState(() {
                  _loading = false;
                });
              }
              print("failed");
            }
          },
          verificationFailed: (FirebaseAuthException exceptio) {
            print('${exceptio.message}');
          });
    } catch (e) {
      handleError(e as PlatformException);
    }
  }

  signIn() async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _controllerPin.text,
      );
      final User? user = (await _auth.signInWithCredential(credential)).user;
      final User? currentUser = _auth.currentUser;
      assert(user!.uid == currentUser!.uid);
      if (user != null) {
        Map detail = {
          "first_name": widget.detail.firstName,
          "last_name": widget.detail.lastName,
          "email": widget.detail.email,
          "contact_number": widget.detail.phoneNumber,
          "password": widget.detail.password,
          "role": "pitchowner",
          "deviceType": widget.detail.deviceType,
          "deviceToken": widget.detail.fcmToken,
          "country": "india",
          "countryCode": widget.detail.countryCode,
          "gender": widget.detail.gender
        };
        _networkCalls.signUp(
            signupDetail: detail,
            onSuccess: (detail) {
              navigateToSports();
              showMessage(detail);
            },
            onFailure: (detail) {
              showMessage(detail);
            });
      } else {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
        print("failed");
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          showMessage(AppLocalizations.of(context)!.invalidOTPCode);
        });
      }

      // handleError(e as PlatformException);
    }
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_INVALID_VERIFICATION_CODE':
        FocusScope.of(context).requestFocus(FocusNode());
        if (mounted) {
          setState(() {
            errorMessage = AppLocalizations.of(context)!.invalidCode;
          });
        }
        // Navigator.of(context).pop();
        break;
      default:
        if (mounted) {
          setState(() {
            errorMessage = error.message!;
          });
        }
        break;
    }
  }

  @override
  void initState() {
    phoneNo = "${widget.detail.countryCode}${widget.detail.phoneNumber}";
    print(phoneNo);
    verifyPhone();
    super.initState();
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
                  bottomNavigationBar: _loading
                      ? Container(
                          height: sizeHeight * .09,
                          color: const Color(0XFF25A163),
                          alignment: Alignment.center,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ))
                      : GestureDetector(
                          onTap: () {
                            // navigateToPitchDetail(widget.detail);

                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              if (msg == true) {
                                if (pin.length < 6) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            title: Text(
                                                AppLocalizations.of(context)!
                                                    .pin),
                                            content: Text(AppLocalizations.of(
                                                    context)!
                                                .enterthedigitcodewhichsentonregisteredphonenumber),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(AppLocalizations.of(
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
                                  if (mounted) {
                                    setState(() {
                                      signIn();
                                      _loading = true;
                                    });
                                  }
                                }
                              } else {
                                if (mounted) {
                                  showMessage(AppLocalizations.of(context)!
                                      .noInternetConnection);
                                }
                              }
                            });
                          },
                          child: Container(
                            height: sizeHeight * .09,
                            color: const Color(0XFF25A163),
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.verifyOTP,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: <Widget>[
                        buildAppBar(
                            language: AppLocalizations.of(context)!.locale,
                            title: AppLocalizations.of(context)!.verifyMobile,
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
                            flaxibleGap(
                              1,
                            ),
                            Container(
                              height: sizeHeight * .005,
                              width: sizeWidth * .19,
                              color: const Color(0XFF25A163),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Container(
                              height: sizeHeight * .005,
                              width: sizeWidth * .19,
                              color: const Color(0XFFCBCBCB),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Container(
                              height: sizeHeight * .005,
                              width: sizeWidth * .19,
                              color: const Color(0XFFCBCBCB),
                            ),
                            flaxibleGap(
                              1,
                            ),
                            Container(
                              height: sizeHeight * .005,
                              width: sizeWidth * .19,
                              color: const Color(0XFFCBCBCB),
                            ),
                          ],
                        ),
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
                                children: <Widget>[
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
                                  PinCodeTextField(
                                    appContext: context,
                                    controller: _controllerPin,
                                    length: 6,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    enablePinAutofill: false,
                                    obscureText: false,
                                    keyboardType: TextInputType.number,
                                    animationType: AnimationType.scale,
                                    //shape: PinCodeFieldShape.underline,
                                    animationDuration:
                                        const Duration(milliseconds: 300),
                                    // borderRadius: BorderRadius.circular(5),
                                    //  fieldHeight: 50,
                                    //  fieldWidth: 40,
                                    onChanged: (value) {
                                      if (mounted) {
                                        setState(() {
                                          smsOTP = value;
                                          pin = value;
                                          smsOTP.length < 6
                                              ? color1 = 0XFFAEAEAE
                                              : color1 = 0XFF25A163;
                                        });
                                      }
                                    },
                                  ),
                                  Material(
                                    color: Colors.white,
                                    child: InkWell(
                                      splashColor: Colors.black,
                                      onTap: () {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          if (msg == true) {
                                            verifyPhone();
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
                                            color: Color(0XFF25A163)),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(
                                    9,
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
                      if (mounted) {
                        setState(() {
                          _loading = false;
                        });
                      }
                    }
                  });
                },
              ));
  }

  void navigateToSports() {
    Navigator.pushReplacementNamed(context, RouteNames.selectSport,
        arguments: false);
  }
}
