import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart' as fMessaging;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/HomeAcademyOwnerScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../../common_widgets/internet_loss.dart';
import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../../network/network_calls.dart';
import '../../../../player/loginSignup/signup.dart';
import '../../../app_colors/app_colors.dart';
import 'loginWidget.dart';
import 'signUpWidget.dart';

class LoginScreen extends StatefulWidget {
  String message;
  int? clicked;
  bool backHome;

  LoginScreen(
      {super.key,
      required this.message,
      this.clicked = 1,
      this.backHome = false});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var lastnameController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var signupEmailController = TextEditingController();
  var sigupPasswordController = TextEditingController();
  var confirmSignPasswordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  // FacebookAuth facebookSignIn = FacebookAuth.instance;
  var signingIntoFirebase = false;
  var error;
  late OverlayEntry? overlayEntry;
  int clicked = 0;
  static bool isLoading = false;
  bool _internet = true;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  static var logDetail = SignUpSignInDetail();
  var isAppleSigninAvailable = false;
  List<String> playerPostion = [];
  List<String> playerPostionSlug = [];
  late String playerSlug;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final fMessaging.FirebaseMessaging _firebaseMessaging =
      fMessaging.FirebaseMessaging.instance;

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  // ignore: non_constant_identifier_names
  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) {
      logDetail.deviceType = "IOS";
    } else {
      logDetail.deviceType = "Android";
    }

    _firebaseMessaging.getToken().then((token) {
      logDetail.fcmToken = token!;
      // print(token);
    });
  }

  ////apple login //////
  _getAppleSigninAvailability() {
    SignInWithApple.isAvailable().then((isAvailable) => setState(() {
          isAppleSigninAvailable = isAvailable;
        }));
  }

  Future<void> signInWithApple() async {
    final result = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      webAuthenticationOptions: WebAuthenticationOptions(
        clientId: 'com.shopez.root',
        redirectUri: Uri.parse(
          'https://peridot-spectacled-papyrus.glitch.me/callbacks/sign_in_with_apple',
        ),
      ),
    );

    final appleIdCredential = result;
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
        idToken: String.fromCharCodes(
            appleIdCredential.identityToken as Iterable<int>),
        accessToken: String.fromCharCodes(
            appleIdCredential.authorizationCode as Iterable<int>));
    Map detail = {
      "first_name": appleIdCredential.givenName,
      "last_name": appleIdCredential.familyName,
      "email": appleIdCredential.email,
      "deviceType": logDetail.deviceType,
      "deviceToken": logDetail.fcmToken,
      "appleId": appleIdCredential.identityToken,
    };
    debugPrint(
      logDetail.fcmToken,
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
      error = null;
      signingIntoFirebase = false;
    });
  }

  void _finishSignIn() {
    setState(() {
      signingIntoFirebase = false;
      error = null;
    });
  }

  void _finishSignInWithError(err) {
    setState(() {
      signingIntoFirebase = false;
      error = err;
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
  // _loginFacebook() async {
  //   FacebookAuth.getInstance();
  //   facebookSignIn.isWebSdkInitialized;
  //   try {
  //     final result = await facebookSignIn.login();
  //     switch (result.status) {
  //       case LoginStatus.success:
  //         final AccessToken? accessToken = result.accessToken;
  //         var details = {
  //           "fbUserToken": accessToken!.token,
  //           "deviceType": logDetail.deviceType,
  //           "deviceToken": logDetail.fcmToken
  //         };
  //         _networkCalls.loginFacebook(
  //             loginDetail: details,
  //             onSuccess: (msg) {
  //               if (msg["token"] != null) {
  //                 _networkCalls.saveToken(msg["token"]);
  //                 _networkCalls.saveRole(msg["role"]);
  //                 _networkCalls.authorizationSave(true);
  //                 navigateToDetail();
  //               } else {
  //                 var detail = {"detail": msg, "facebook": true};
  //                 navigateToSocialDetail(detail);
  //               }
  //             },
  //             onFailure: (msg) {
  //               showMessage(msg);
  //             });
  //
  //         break;
  //       case LoginStatus.cancelled:
  //         // ignore: use_build_context_synchronously
  //         showMessage(AppLocalizations.of(context)!.logincancelledbytheuser);
  //         break;
  //       case LoginStatus.failed:
  //         showMessage('Something went wrong with the login process.\n'
  //             'Here\'s the error Facebook gave us: ${result.message}');
  //         print("jiiii${result.message}");
  //         break;
  //       default:
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  //
  // Future _logOut() async {
  //   FacebookAuth.getInstance();
  //   facebookSignIn.isWebSdkInitialized;
  //   try {
  //     await facebookSignIn.logOut();
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Future _loginGoogle() async {
    try {
      await _googleSignIn.signIn().then((result) {
        result!.authentication.then((googleKey) {
          var details = {
            "accessToken": googleKey.accessToken,
            "deviceType": logDetail.deviceType,
            "deviceToken": logDetail.fcmToken
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

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
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
    clicked = widget.clicked!.toInt();
    isLoading = false;
    // _logOut();
    _getAppleSigninAvailability();
    firebaseCloudMessaging_Listeners();
    if (Platform.isIOS) {
      SignUpWidgetState.phoneFocus.addListener(() {
        bool hasFocus = SignUpWidgetState.phoneFocus.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
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

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    signupEmailController.dispose();
    sigupPasswordController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    confirmSignPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    if (_internet) {
      return Scaffold(
        backgroundColor: MyAppState.mode == ThemeMode.light
            ? AppColors.white
            : AppColors.darkTheme,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                pinned: true,
                centerTitle: false,
                expandedHeight: 250.0,
                automaticallyImplyLeading: false,
                leading: InkWell(
                  onTap: () {
                    widget.backHome
                        ? Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerHomeScreen(index: 0),
                            ))
                        : Navigator.pop(context);
                  },
                  child: SizedBox(
                      height: height * 0.03,
                      child: Image.asset(
                        'assets/images/back.png',
                        color: AppColors.white,
                      )),
                ),
                leadingWidth: width * 0.13,
                backgroundColor: AppColors.transparent,
                flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: false,
                    titlePadding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    background: Image.asset(
                      'assets/images/image-7z1.png',
                      fit: BoxFit.fill,
                    ))),
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.black,
                child: Container(
                  decoration: BoxDecoration(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.darkTheme,
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ///tab
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.049,
                              vertical: height * 0.02),
                          child: Container(
                            height: height * 0.065,
                            width: width,
                            decoration: BoxDecoration(
                                color: MyAppState.mode == ThemeMode.light
                                    ? AppColors.grey200
                                    : AppColors.containerColorW12,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clicked = 1;
                                    });
                                  },
                                  child: Container(
                                    height: height * 0.065,
                                    width: width * 0.44,
                                    decoration: BoxDecoration(
                                        color: clicked == 1
                                            ? AppColors.appThemeColor
                                            : AppColors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                            AppLocalizations.of(context)!.login,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: clicked == 1
                                                        ? AppColors.white
                                                        : MyAppState.mode ==
                                                                ThemeMode.light
                                                            ? AppColors.black
                                                            : AppColors
                                                                .white))),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      clicked = 2;
                                    });
                                  },
                                  child: Container(
                                    height: height * 0.065,
                                    width: width * 0.44,
                                    decoration: BoxDecoration(
                                        color: clicked == 2
                                            ? AppColors.appThemeColor
                                            : AppColors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      AppLocalizations.of(context)!.register,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              color: clicked == 2
                                                  ? AppColors.white
                                                  : MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? AppColors.black
                                                      : AppColors.white),
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        clicked == 1
                            ? LogInWidget(
                                loading: isLoading,
                                forgetTap: () {
                                  navigateForgotPassword();
                                },
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isLoading = true;
                                    });
                                    _networkCalls.checkInternetConnectivity(
                                        onSuccess: (msg) {
                                      if (msg == true) {
                                        String encoded = base64.encode(utf8
                                            .encode(passwordController.text));
                                        var details = {
                                          "email": emailController.text,
                                          "password": encoded,
                                          "deviceType": LoginScreenState
                                              .logDetail.deviceType,
                                          "deviceToken": LoginScreenState
                                              .logDetail.fcmToken
                                        };
                                        _networkCalls.login(
                                            loginDetail: details,
                                            onSuccess: (msg) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              if (msg == "pitchowner") {
                                                navigateToOwnerHome();
                                              } else {
                                                navigateToDetail();
                                              }
                                            },
                                            onFailure: (msg) {
                                              setState(() {
                                                isLoading = false;
                                                showMessage(msg);
                                              });
                                            });
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        showMessage(
                                            AppLocalizations.of(context)!
                                                .noInternetConnection);
                                      }
                                    });
                                  }
                                },
                                emailController: emailController,
                                passwordController: passwordController,
                              )
                            : SignUpWidget(
                                player: (String? value) {
                                  SignUpWidgetState.player = value;
                                  logDetail.player = value;
                                  setState(() {});
                                },
                                loading: isLoading,
                                signUp: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      logDetail.phoneNumber =
                                          phoneController.text;
                                      logDetail.firstName = nameController.text;
                                      logDetail.lastName =
                                          lastnameController.text;
                                      logDetail.password =
                                          sigupPasswordController.text;
                                      logDetail.email =
                                          signupEmailController.text;
                                      isLoading = true;
                                    });
                                    if (logDetail.phoneNumber != null) {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          _networkCalls
                                              .checkAvailabilityOfEmail(
                                                  email: logDetail.email
                                                      .toString(),
                                                  onSuccess: (msg) async {
                                                    // navigateToVerification(logDetail);
                                                    _networkCalls
                                                        .checkAvailabilityOfPhoneNumber(
                                                            phone: logDetail
                                                                .phoneNumber
                                                                .toString(),
                                                            onSuccess: (msg) {
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                              print(logDetail
                                                                  .phoneNumber);
                                                              navigateToVerification(
                                                                  logDetail);
                                                            },
                                                            onFailure: (msg) {
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                              showMessage(
                                                                msg,
                                                              );
                                                            },
                                                            tokenExpire: () {
                                                              if (mounted) {
                                                                on401(context);
                                                                isLoading =
                                                                    false;
                                                              }
                                                            });
                                                  },
                                                  onFailure: (msg) {
                                                    if (mounted) {
                                                      setState(() {
                                                        isLoading = false;
                                                      });
                                                    }
                                                    isLoading = false;
                                                    showMessage(msg);
                                                  },
                                                  tokenExpire: () {
                                                    if (mounted) {
                                                      on401(context);
                                                    }
                                                  });
                                        } else {
                                          showMessage(
                                              AppLocalizations.of(context)!
                                                  .noInternetConnection);
                                          isLoading = false;
                                        }
                                      });
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    logDetail.countryCode = value.toString();
                                  });
                                },
                                onChangedController: (value) {
                                  logDetail.phoneNumber = value;
                                },
                                confirmController:
                                    confirmSignPasswordController,
                                lastnameController: lastnameController,
                                passwordController: sigupPasswordController,
                                emailController: signupEmailController,
                                nameController: nameController,
                                phoneController: phoneController,
                              ),

                        ///google facebook login
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.02, horizontal: width * 0.2),
                          child: Row(
                            mainAxisAlignment: Platform.isIOS
                                ? MainAxisAlignment.spaceEvenly
                                : MainAxisAlignment.center,
                            children: [
                              // GestureDetector(
                              //   child: Image.asset(
                              //     'assets/images/facebook.png',
                              //     height: height * .05,
                              //     fit: BoxFit.fill,
                              //   ),
                              //   onTap: () {
                              //     _networkCalls.checkInternetConnectivity(
                              //         onSuccess: (msg) {
                              //       _internet = msg;
                              //       if (msg == true) {
                              //         _loginFacebook();
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
                              Platform.isIOS
                                  ? Visibility(
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
                                          'assets/images/pngwing.png',
                                          height: height * .05,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              GestureDetector(
                                child: Image.asset(
                                  'assets/images/google_icon.png',
                                  height: height * .05,
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
                            ],
                          ),
                        ),

                        ///package info last
                        Padding(
                          padding: AppLocalizations.of(context)!.locale == "en"
                              ? EdgeInsets.only(right: width * 0.09)
                              : EdgeInsets.only(left: width * 0.09),
                          child: Container(
                            width: width,
                            alignment:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? Alignment.bottomRight
                                    : Alignment.bottomLeft,
                            child: AppLocalizations.of(context)!.locale == "en"
                                ? Text(
                                    "${_packageInfo.version}(${_packageInfo.buildNumber})",
                                    style: TextStyle(color: AppColors.grey),
                                  )
                                : Text(
                                    "${_packageInfo.version.split('').reversed.join()}(${_packageInfo.buildNumber})",
                                    style: TextStyle(color: AppColors.grey),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return InternetLoss(
        onChange: () {
          _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
            _internet = msg;
            if (msg == true) {
              setState(() {});
            }
          });
        },
      );
    }
  }

  void navigateToDetail() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PlayerHomeScreen(index: 0)));
    // Navigator.pushNamedAndRemoveUntil(
    //     context, RouteNames.playerHome, (r) => false);
  }

  void navigateToSocialDetail(var detail) {
    Navigator.pushNamed(context, RouteNames.socialDetail, arguments: detail);
  }

  void navigateToOwnerHome() {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => HomePitchOwnerScreen(index: 0)));
    // Navigator.pushNamedAndRemoveUntil(
    //     context, RouteNames.homePitchOwner, (r) => false);
  }

  void navigateToVerification(SignUpSignInDetail detail) {
    Navigator.pushNamed(context, RouteNames.verificationScreen,
            arguments: detail)
        .then((onValue) {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      isLoading = false;
    });
  }

  void navigateToDetail3() {
    Navigator.pushNamed(context, RouteNames.chooseAccount);
  }

  void navigateForgotPassword() {
    Navigator.pushNamed(context, RouteNames.forgotPassword);
  }
}

class SignUpSignInDetail {
  String? email;
  String? firstName;
  String? lastName;
  String? password;
  String? phoneNumber;
  String? fcmToken;
  String? countryCode;
  String? deviceType;
  String? dob;
  String? player;
  String? id;

  SignUpSignInDetail(
      {this.email,
      this.password,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.deviceType,
      this.fcmToken,
      this.dob,
      this.id,
      this.player = 'player',
      this.countryCode = "+971"});
}
