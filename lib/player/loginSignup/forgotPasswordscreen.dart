import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class ForgotPasswordScreen extends StatefulWidget {
  String token;
  ForgotPasswordScreen({required this.token});
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final focus = FocusNode();
  bool password_hide = true;
  bool password_hide1 = true;
  bool _internet = true;
  late bool tokenStatusField;
  bool _isLoading = true;
  final _passwordController = TextEditingController(text: '');
  bool monVal = false;
  final _formKey = GlobalKey<FormState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  late String newPassword;

  tokenStatus() {
    var tokenDetail = {
      "token": widget.token,
    };
    _networkCalls.tokenStatus(
      token: tokenDetail,
      onSuccess: (msg) {
        if (msg == false) {
          setState(() {
            tokenStatusField = msg;
            _isLoading = false;
          });
        } else {
          Navigator.pushReplacementNamed(context, RouteNames.login,
              arguments: 'Token has been Expired');
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      if (_internet == true) {
        _isLoading = false;
        tokenStatus();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            key: scaffoldkey,
            body: Container(
              width: sizewidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 60.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 200.0,
                                      color: Colors.white,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                    ),
                                    Container(
                                      height: sizeheight * .5,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 100.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : _internet
            ? Scaffold(
                key: scaffoldkey,
                backgroundColor: const Color(0XFFF0F0F0),
                appBar: AppBar(
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
                    AppLocalizations.of(context)!.newpassword,
                    style: TextStyle(
                        fontSize: appHeaderFont,
                        color: const Color(0XFFFFFFFF),
                        fontFamily: AppLocalizations.of(context)!.locale == "en"
                            ? "Poppins"
                            : "VIP",
                        fontWeight: AppLocalizations.of(context)!.locale == "en"
                            ? FontWeight.w600
                            : FontWeight.normal),
                  ),
                  backgroundColor: const Color(0XFF032040),
                ),
                bottomNavigationBar: Material(
                  color: const Color(0XFF25A163),
                  child: InkWell(
                    splashColor: Colors.black,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var changeDetail = {
                          "token": widget.token,
                          "password": newPassword
                        };
                        _networkCalls.resetPassword(
                          detail: changeDetail,
                          onSuccess: (msg) {
                            //navigateToDetail(msg);
                            Navigator.pushReplacementNamed(
                                context, RouteNames.resetPasswordSuccess,
                                arguments: msg);
                            //showMessage(msg, scaffoldkey);
                          },
                          onFailure: (msg) {
                            showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      //color: Color(0XFF25A163),
                      height: sizeheight * .1,
                      child: Text(
                        AppLocalizations.of(context)!.setPassword,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: sizewidth * .05,
                        right: sizewidth * .05,
                        top: sizewidth * .1),
                    child: Container(
                      height: sizeheight * .4,
                      color: const Color(0XFFFFFFFF),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: sizewidth * .03, right: sizewidth * .03),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              flaxibleGap(
                                4,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .pleaseEnterNewPassword,
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: Color(0XFFADADAD)),
                                ),
                              ),
                              flaxibleGap(
                                2,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (value) {
                                  FocusScope.of(context).requestFocus(focus);
                                },
                                controller: _passwordController,
                                onSaved: (value) {
                                  String encoded =
                                      base64.encode(utf8.encode(value!));
                                  newPassword = encoded;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return AppLocalizations.of(context)!
                                        .pleaseEnterNewPassword;
                                  }
                                  return null;
                                },
                                autofocus: false,
                                obscureText: password_hide1,
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  labelText:
                                      AppLocalizations.of(context)!.newpassword,
                                  //\uD83D\uDD12
                                  labelStyle:
                                      const TextStyle(color: Color(0XFFADADAD)),
                                  suffixIcon: GestureDetector(
                                    child: password_hide1
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Color(0XFFADADAD),
                                          )
                                        : const Icon(
                                            Icons.visibility,
                                            color: Color(0XFFADADAD),
                                          ),
                                    onTap: () {
                                      setState(() {
                                        password_hide1 = !password_hide1;
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
                                focusNode: focus,
                                validator: (e) {
                                  return validateConfirmPassword(e.toString());
                                },
                                autofocus: false,
                                obscureText: password_hide,
                                style: const TextStyle(
                                    color: Color(0XFF032040),
                                    fontWeight: FontWeight.w500),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.all(0),
                                  labelText: AppLocalizations.of(context)!
                                      .confermpassword,
                                  //\uD83D\uDD12
                                  labelStyle:
                                      const TextStyle(color: Color(0XFFADADAD)),
                                  suffixIcon: GestureDetector(
                                    child: password_hide
                                        ? const Icon(
                                            Icons.visibility_off,
                                            color: Color(0XFFADADAD),
                                          )
                                        : const Icon(
                                            Icons.visibility,
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
                              flaxibleGap(
                                3,
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
                    if (msg == true) {
                      tokenStatus();
                    }
                  });
                },
              );
  }

  void navigateToDetail(String msg) {
    Navigator.pushReplacementNamed(context, RouteNames.profile, arguments: msg);
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return AppLocalizations.of(context)!.passwordMismatch;
    }
    return '';
  }
}
