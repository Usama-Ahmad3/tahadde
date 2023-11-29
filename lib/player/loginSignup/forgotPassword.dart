import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/textFormField.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class ForgotPassword extends StatefulWidget {
  bool tokenStatus;

  ForgotPassword({super.key, required this.tokenStatus});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool monVal = false;
  late String email;
  bool _isLoading = false;
  bool _internet = true;
  final _formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((Duration) {
      if (widget.tokenStatus == true) {
        showMessage(AppLocalizations.of(context)!.tokenhasbeenExpired);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
      return _internet
            ? Scaffold(
                backgroundColor: MyAppState.mode == ThemeMode.light
                    ? const Color(0XFFF0F0F0)
                    : Colors.grey.shade300,
                appBar: PreferredSize(
                  preferredSize: Size(sizewidth, sizeheight * 0.1),
                  child: AppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Color(0XFFFFFFFF),
                      ),
                    ),
                    automaticallyImplyLeading: false,
                    title: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: TextStyle(
                          fontSize: appHeaderFont,
                          color: const Color(0XFFFFFFFF),
                          fontFamily:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? "Poppins"
                                  : "VIP",
                          fontWeight:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? FontWeight.w600
                                  : FontWeight.normal),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: sizewidth * .05,
                        right: sizewidth * .05,
                        top: sizewidth * .1),
                    child: SizedBox(
                      height: sizeheight * .6,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizewidth * .03, right: sizewidth * .03),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              flaxibleGap(2),
                              Container(
                                child: Image.asset(
                                  'assets/images/password.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                              flaxibleGap(2),
                              Text(
                                AppLocalizations.of(context)!.pleaseEnterEmail,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              flaxibleGap(2),
                              TextFieldWidget(
                                  controller: emailController,
                                  hintText: AppLocalizations.of(context)!.email,
                              onChanged: (value) {
                                  email = value!;
                        if (value == "xxxxxx") {
                        FocusScope.of(context).unfocus();
                        navigateToAccountSetting();
                        }
                        },
                              onValidate:  (value) {
                                var msg;
                                if (!isMail(value!.trim())) {
                                  msg = AppLocalizations.of(context)!
                                      .invalidEmail;
                                }
                                return msg;
                              },
                                enableBorder: OutlineInputBorder(
                                    borderSide: MyAppState.mode == ThemeMode.light
                                        ? BorderSide.none
                                        : BorderSide(color: AppColors.white, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                focusBorder: OutlineInputBorder(
                                    borderSide: MyAppState.mode == ThemeMode.light
                                        ? BorderSide.none
                                        : BorderSide(color: AppColors.white, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                                border: OutlineInputBorder(
                                    borderSide: MyAppState.mode == ThemeMode.light
                                        ? BorderSide.none
                                        : BorderSide(color: AppColors.white, width: 1),
                                    borderRadius: BorderRadius.circular(12)),
                              ),
                              flaxibleGap(3),
                              ButtonWidget(onTaped: () {
                        if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _isLoading = true;
                        _networkCalls.checkInternetConnectivity(
                        onSuccess: (msg) {
                        _internet = msg;
                        if (msg == true) {
                        _networkCalls.checkEmailExist(
                        email: email,
                        onSuccess: (msg) {
                        if (msg ==
                        'This email already exists') {
                        _networkCalls.forgotPassword(
                        email: email,
                        onSuccess: (msg) {
                          _isLoading = false;
                          showMessage('Check your mail, Email has been sent');
                        navigateToDetail(
                        msg: msg);
                        },
                        onFailure: (msg) {
                        setState(() {});
                        showMessage(msg);
                        },
                        tokenExpire: () {
                        if (mounted) {
                        on401(context);
                        }
                        },
                        );
                        }
                        },
                        onFailure: (msg) {
                        setState(() {});
                        showMessage(msg);
                        },
                        tokenExpire: () {
                        if (mounted) on401(context);
                        });
                        } else {
                        if (mounted) setState(() {});
                        }
                        });
                        }
                        }, title: Text(AppLocalizations.of(context)!.sendEmail,style: TextStyle(color: AppColors.white),),
                                isLoading: _isLoading,

                              ),

                            ],
                          ),
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
                    if (mounted) {
                      setState(() {
                        _isLoading = true;
                      });
                    }
                  });
                },
              );

  }

  void navigateToDetail({String? msg}) {
    Navigator.of(context).pop();
    // Navigator.pushReplacementNamed(context, RouteNames.signupPage,
    //     arguments: msg);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(message: 'message', clicked: 1),
        ));
  }

  void navigateToAccountSetting() {
    Navigator.pushNamed(context, RouteNames.accountSetting);
  }
}
