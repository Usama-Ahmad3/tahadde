import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _passwordController = TextEditingController(text: '');
  bool monVal = false;
  final _formKey = GlobalKey<FormState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  String? currentPassword;
  String? newPassword;
  final focus = FocusNode();
  final focuss = FocusNode();
  bool internet = true;

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return internet
        ? Scaffold(
            key: scaffoldkey,
            backgroundColor: const Color(0XFFF0F0F0),
            appBar: appBar(
              title: AppLocalizations.of(context)!.resetPassword,
              language: AppLocalizations.of(context)!.locale,
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            bottomNavigationBar: Material(
              color: const Color(0XFF25A163),
              child: InkWell(
                splashColor: Colors.black,
                onTap: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        var changeDetail = {
                          "current_password": currentPassword,
                          "new_password": newPassword
                        };
                        _networkCalls.changePassword(
                          changeDetail: changeDetail,
                          onSuccess: (msg) {
                            navigateToDetail(msg);
                            // showMessage(msg, scaffoldkey);
                          },
                          onFailure: (msg) {
                            showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      }
                    } else {
                      if (mounted)
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                    }
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: sizeheight * .1,
                  child: Text(
                    AppLocalizations.of(context)!.changepassword,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
                          Flexible(
                            child: Container(),
                            flex: 2,
                          ),
                          textField(
                            name: AppLocalizations.of(context)!.currentpassword,
                            hint: AppLocalizations.of(context)!.currentpassword,
                            text: false,
                            text1: false,
                            submit: (value) {
                              FocusScope.of(context).requestFocus(focus);
                            },
                            onSaved: (value) {
                              String encoded =
                                  base64.encode(utf8.encode(value!));
                              currentPassword = encoded;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .pleaseenterCurrentPassword;
                              }
                              return '';
                            },
                          ),
                          textField(
                            name: AppLocalizations.of(context)!.newpassword,
                            hint: AppLocalizations.of(context)!.newpassword,
                            text: false,
                            text1: false,
                            node: focus,
                            submit: (value) {
                              FocusScope.of(context).requestFocus(focuss);
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
                                    .pleaseenterNewPassword;
                              }
                              return '';
                            },
                          ),
                          textField(
                            name: AppLocalizations.of(context)!.confermpassword,
                            hint: AppLocalizations.of(context)!.confermpassword,
                            text: false,
                            text1: false,
                            node: focuss,
                            keybordType: false,
                            validator: (e) {
                              return validateConfirmPassword(e.toString());
                            },
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
                internet = msg;
                if (msg == true) {
                  setState(() {});
                }
              });
            },
          );
  }

  void navigateToDetail(String msg) {
    // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, child: Profile(msg: msg,)));
    Navigator.pushReplacementNamed(context, RouteNames.passworSuccess);
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return AppLocalizations.of(context)!.passwordMismatch;
    }
    return '';
  }
}
