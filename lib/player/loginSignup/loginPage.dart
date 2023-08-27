import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart' as fMessaging;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../common_widgets/internet_loss.dart';
import '../../common_widgets/loginButoon.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class Loginpage extends StatefulWidget {
  String message;

  Loginpage({required this.message});

  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  final FacebookAuth facebookSignIn = FacebookAuth.instance;
  var _signingIntoFirebase = false;
  var _error;
  bool _internet = true;
  bool _appLoading = false;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final LoginDetail _detail = LoginDetail();
  var _isAppleSigninAvailable = false;
  bool password_hide = true;
  final fMessaging.FirebaseMessaging _firebaseMessaging =
      fMessaging.FirebaseMessaging.instance;
  final _formKey = GlobalKey<FormState>();
  final _focus = FocusNode();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );
  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) {
      _detail.deviceType = "IOS";
    } else {
      _detail.deviceType = "Android";
    }

    _firebaseMessaging.getToken().then((token) {
      _detail.fcmToken = token!;
      // print(token);
    });
  }

  ////apple login //////
  _getAppleSigninAvailability() {
    SignInWithApple.isAvailable().then((isAvailable) => setState(() {
          _isAppleSigninAvailable = isAvailable;
        }));
  }

  Future<void> signInWithApple() async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      // webAuthenticationOptions: WebAuthenticationOptions(
      //   clientId: 'com.shopez.root',
      //   redirectUri: Uri.parse(
      //     'https://peridot-spectacled-papyrus.glitch.me/callbacks/sign_in_with_apple',
      //   ),
      // ),
    );

    final appleIdCredential = result;
//        final oAuthProvider = OAuthProvider(providerId: 'apple.com');
//        final credential = oAuthProvider.getCredential(
//          idToken: String.fromCharCodes(appleIdCredential.identityToken),
//          accessToken:
//              String.fromCharCodes(appleIdCredential.authorizationCode),);
    Map detail = {
      "first_name": appleIdCredential.givenName,
      "last_name": appleIdCredential.familyName,
      "email": appleIdCredential.email,
      "deviceType": _detail.deviceType,
      "deviceToken": _detail.fcmToken,
      "appleId": appleIdCredential.identityToken,
    };
    debugPrint(
      _detail.fcmToken,
    );
    _networkCalls.loginApple(
        loginDetail: detail,
        onSuccess: (msg) {
          if (msg["token"] != null) {
            _networkCalls.saveToken(msg["token"]);
            _networkCalls.saveRole(msg["role"]);
            _networkCalls.authorizationSave(true);
            navigateToDetail();
          } else {
            var detail1 = {
              "detail": msg,
              "apple": true,
              "user": detail["appleId"]
            };
            navigateToSocialDetail(detail1);
          }
        },
        onFailure: (msg) {
          showMessage(msg);
        });
  }

  void _startSignIn() {
    setState(() {
      _error = null;
      _signingIntoFirebase = false;
    });
  }

  void _finishSignIn() {
    setState(() {
      _signingIntoFirebase = false;
      _error = null;
    });
  }

  void _finishSignInWithError(err) {
    setState(() {
      _signingIntoFirebase = false;
      _error = err;
    });
  }

  Future<void> _signInWithApple(BuildContext context) async {
    _startSignIn();
    try {
      await signInWithApple();
    } on PlatformException catch (err) {
      if (err.code.compareTo("ERROR_ABORTED_BY_USER") == 0) {
        _finishSignIn();
      } else {
        _finishSignInWithError(err.message);
      }
    } catch (err) {
      _finishSignInWithError(err);
    }
  }

  //////////
  _loginFacebook() async {
    FacebookAuth.getInstance();
    facebookSignIn.isWebSdkInitialized;
    final LoginResult result = await facebookSignIn.login();
    switch (result.status) {
      case LoginStatus.success:
        final AccessToken? accessToken = result.accessToken;
        var details = {
          "fbUserToken": accessToken!.token,
          "deviceType": _detail.deviceType,
          "deviceToken": _detail.fcmToken
        };
        _networkCalls.loginFacebook(
            loginDetail: details,
            onSuccess: (msg) {
              if (msg["token"] != null) {
                _networkCalls.saveToken(msg["token"]);
                _networkCalls.saveRole(msg["role"]);
                _networkCalls.authorizationSave(true);
                navigateToDetail();
              } else {
                var detail = {"detail": msg, "facebook": true};
                navigateToSocialDetail(detail);
              }
            },
            onFailure: (msg) {
              showMessage(msg);
            });

        break;
      case LoginStatus.cancelled:
        // ignore: use_build_context_synchronously
        showMessage(AppLocalizations.of(context)!.logincancelledbytheuser);
        break;
      case LoginStatus.failed:
        showMessage('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.message}');
        print(result.message);
        break;
      default:
    }
  }

  Future _logOut() async {
    await facebookSignIn.logOut();
  }

  Future _loginGoogle() async {
    try {
      await _googleSignIn.signIn().then((result) {
        result!.authentication.then((googleKey) {
          var details = {
            "accessToken": googleKey.accessToken,
            "deviceType": _detail.deviceType,
            "deviceToken": _detail.fcmToken
          };
          // print(googleKey.accessToken);
          _networkCalls.loginGoogle(
              loginDetail: details,
              onSuccess: (msg) {
                if (msg["token"] != null) {
                  _networkCalls.saveToken(msg["token"]);
                  _networkCalls.saveRole(msg["role"]);
                  _networkCalls.authorizationSave(true);
                  _googleSignIn.disconnect();
                  navigateToDetail();
                } else {
                  _googleSignIn.disconnect();
                  var detail = {"detail": msg, "google": true};
                  navigateToSocialDetail(detail);
                }
              },
              onFailure: (msg) {
                _googleSignIn.disconnect();
                showMessage(msg);
              });
        });
      }).catchError((err) {});
    } catch (err) {}
  }

  @override
  void initState() {
    super.initState();
    _logOut();
    _getAppleSigninAvailability();
    firebaseCloudMessaging_Listeners();
    // ignore: avoid_types_as_parameter_names
    WidgetsBinding.instance.addPostFrameCallback((Duration) {
      if (widget.message == 'email has been sent') {
        showSucess(AppLocalizations.of(context)!.emailhasbeensent, scaffoldkey);
      } else if (widget.message == 'Password has been reset') {
        showMessage(AppLocalizations.of(context)!.passwordhasbeenreset);
      } else if (widget.message == 'Token has been Expired') {
        showMessage(AppLocalizations.of(context)!.tokenhasbeenExpired);
      }
    });
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return Material(
        child: _internet
            ? Scaffold(
                resizeToAvoidBottomInset: true,
                backgroundColor: const Color(0XFFFFFFFF),
                appBar: appBar(
                  language: AppLocalizations.of(context)!.locale,
                  title: AppLocalizations.of(context)!.login,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 50,
                          right: 50,
                        ),
                        child: SizedBox(
                          height: sizeheight * .8,
                          width: sizewidth,
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(8),
                                textField(
                                  focusAuto: true,
                                  name: AppLocalizations.of(context)!.email,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterEmail;
                                    }
                                    return '';
                                  },
                                  text: false,
                                  text1: false,
                                  submit: (value) {
                                    FocusScope.of(context).requestFocus(_focus);
                                  },
                                  onSaved: (value) {
                                    _detail.email = value!;
                                  },
                                ),
                                TextFormField(
                                  focusNode: _focus,
                                  onFieldSubmitted: (value) {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      String encoded = base64.encode(
                                          utf8.encode(_detail.password!));
                                      print(encoded);
                                      var details = {
                                        "email": _detail.email,
                                        "password": encoded,
                                        "deviceType": _detail.deviceType,
                                        "deviceToken": _detail.fcmToken
                                      };
                                      _networkCalls.login(
                                          loginDetail: details,
                                          onSuccess: (msg) {
                                            if (msg == "pitchowner") {
                                              navigateToOwnerHome();
                                            } else {
                                              navigateToDetail();
                                            }
                                          },
                                          onFailure: (msg) {
                                            showMessage(msg);
                                          });
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterPassword;
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _detail.password = value!;
                                  },
                                  autofocus: false,
                                  obscureText: password_hide,
                                  style: const TextStyle(
                                      color: Color(0XFF032040),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  decoration: InputDecoration(
                                    labelText:
                                        AppLocalizations.of(context)!.password,
                                    labelStyle: const TextStyle(
                                        color: Color(0XFFADADAD), fontSize: 12),
                                    suffixIcon: GestureDetector(
                                      child: password_hide
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
                                          password_hide = !password_hide;
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
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(),
                                    InkWell(
                                        splashColor: Colors.black,
                                        onTap: () {
                                          navigateForgotPassword();
                                        },
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .forgotPassword))
                                  ],
                                ),
                                flaxibleGap(8),
                                AppButton(
                                  isLoading: _appLoading,
                                  child: Text(
                                    AppLocalizations.of(context)!.login,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                  onPressed: () {
                                    // if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    _networkCalls.checkInternetConnectivity(
                                        onSuccess: (msg) {
                                      if (msg == true) {
                                        if (mounted) {
                                          setState(() {
                                            _appLoading = true;
                                          });
                                        }
                                        String encoded = base64.encode(
                                            utf8.encode(_detail.password!));
                                        var details = {
                                          "email": _detail.email,
                                          "password": encoded,
                                          "deviceType": _detail.deviceType,
                                          "deviceToken": _detail.fcmToken
                                        };
                                        FocusScope.of(context).unfocus();
                                        _networkCalls.login(
                                            loginDetail: details,
                                            onSuccess: (msg) {
                                              if (msg == "pitchowner") {
                                                navigateToOwnerHome();
                                              } else {
                                                navigateToDetail();
                                              }
                                            },
                                            onFailure: (msg) {
                                              if (mounted) {
                                                setState(() {
                                                  if (mounted) {
                                                    _appLoading = false;
                                                  }
                                                  showMessage(msg);
                                                });
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
                                    // }
                                  },
                                ),
                                // Ink(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(4),
                                //     color: Color(0XFF25A163),
                                //   ),
                                //   child: InkWell(
                                //     splashColor: Colors.black,
                                //     onTap: () {
                                //       if (_formKey.currentState.validate()) {
                                //         _formKey.currentState.save();
                                //         _networkCalls
                                //             .checkInternetConnectivity(
                                //                 onSuccess: (msg) {
                                //           _internet = msg;
                                //           if (msg == true) {
                                //             if (mounted)
                                //               setState(() {
                                //                 _isLoading = false;
                                //               });
                                //             String encoded = base64.encode(utf8.encode(_detail.password));
                                //             var details = {
                                //               "email": _detail.email,
                                //               "password": encoded,
                                //               "deviceType":
                                //                   _detail.deviceType,
                                //               "deviceToken": _detail.fcmToken
                                //             };
                                //             FocusScope.of(context).unfocus();
                                //             _networkCalls.login(
                                //                 loginDetail: details,
                                //                 onSuccess: (msg) {
                                //                   if (msg == "pitchowner") {
                                //                     navigateToOwnerHome();
                                //                   } else {
                                //                     navigateToDetail();
                                //                   }
                                //                 },
                                //                 onFailure: (msg) {
                                //                   if (mounted)
                                //                   showMessage(
                                //                       msg, scaffoldkey);
                                //                 });
                                //             setState(() {
                                //               if (mounted) _isLoading = true;
                                //             });
                                //           } else {
                                //             if(mounted)
                                //             showMessage(
                                //                 local.AppLocalizations.of(context).noInternetConnection,
                                //                 scaffoldkey);
                                //           }
                                //         });
                                //       }
                                //     },
                                //     child: Container(
                                //       width:
                                //           MediaQuery.of(context).size.width /
                                //               1.2,
                                //       height: 45,
                                //       alignment: Alignment.center,
                                //       child: Text(
                                //         local.AppLocalizations.of(context).login,
                                //         style: TextStyle(
                                //           fontSize: 20,
                                //           color: Colors.white,
                                //         ),
                                //         textAlign: TextAlign.right,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                flaxibleGap(1),
                                GestureDetector(
                                  onTap: () {
                                    navigateToDetail3();
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      flaxibleGap(4),
                                      Text(
                                        AppLocalizations.of(context)!
                                            .profileDecsecond,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0XFF9B9B9B),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.signUp,
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.green),
                                      ),
                                      flaxibleGap(4),
                                    ],
                                  ),
                                ),
                                flaxibleGap(4),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!.orSignUpWith,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Color(0XFF9B9B9B),
                                    ),
                                  ),
                                ),
                                flaxibleGap(1),
                                Row(
                                  children: <Widget>[
                                    flaxibleGap(4),
                                    GestureDetector(
                                      child: Image.asset(
                                        'assets/images/facebook.png',
                                        height: sizeheight * .04,
                                        fit: BoxFit.fill,
                                      ),
                                      onTap: () {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          _internet = msg;
                                          if (msg == true) {
                                            _loginFacebook();
                                          } else {
                                            if (mounted) {
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    Platform.isIOS
                                        ? flaxibleGap(1)
                                        : Container(),
                                    Visibility(
                                      visible: Platform.isIOS ? true : false,
                                      // _isAppleSigninAvailable,
                                      child: GestureDetector(
                                        onTap: () => _networkCalls
                                            .checkInternetConnectivity(
                                                onSuccess: (msg) {
                                          _internet = msg;
                                          if (msg == true) {
                                            _signInWithApple(context);
                                          } else {
                                            if (mounted) {
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        }),
                                        child: Image.asset(
                                          'assets/images/apple.png',
                                          height: sizeheight * .04,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    flaxibleGap(1),
                                    GestureDetector(
                                      child: Image.asset(
                                        'assets/images/google.png',
                                        height: sizeheight * .038,
                                        fit: BoxFit.fill,
                                      ),
                                      onTap: () {
                                        _networkCalls.checkInternetConnectivity(
                                            onSuccess: (msg) {
                                          _internet = msg;
                                          if (msg == true) {
                                            _loginGoogle();
                                          } else {
                                            if (mounted) {
                                              showMessage(
                                                  AppLocalizations.of(context)!
                                                      .noInternetConnection);
                                            }
                                          }
                                        });
                                      },
                                    ),
                                    flaxibleGap(4),
                                  ],
                                ),

                                flaxibleGap(7),
                                Container(
                                  width: sizewidth,
                                  alignment:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? Alignment.bottomRight
                                          : Alignment.bottomLeft,
                                  child: AppLocalizations.of(context)!.locale ==
                                          "en"
                                      ? Text(
                                          "${_packageInfo.version}(${_packageInfo.buildNumber})",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        )
                                      : Text(
                                          "${_packageInfo.version.split('').reversed.join()}(${_packageInfo.buildNumber})",
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                ),
                                flaxibleGap(2),
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
                      setState(() {});
                    }
                  });
                },
              ));
  }

  void navigateToDetail() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }

  void navigateToSocialDetail(var detail) {
    Navigator.pushNamed(context, RouteNames.socialDetail, arguments: detail);
  }

  void navigateToOwnerHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.homePitchOwner, (r) => false);
  }

  void navigateToDetail3() {
    Navigator.pushNamed(context, RouteNames.chooseAccount);
  }

  void navigateForgotPassword() {
    Navigator.pushNamed(context, RouteNames.forgotPassword);
  }
}

class LoginDetail {
  String? email;
  String? password;
  String? fcmToken;
  String? deviceType;
  LoginDetail({this.email, this.password, this.fcmToken, this.deviceType});
}
