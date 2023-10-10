import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../widgets/buttonWidget.dart';
import '../widgets/textFormField.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _internet = true;
  var currentController = TextEditingController();
  var newController = TextEditingController();
  var confirmController = TextEditingController();
  final FocusNode newNode = FocusNode();
  final FocusNode confirmNode = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
      } else {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    confirmNode.dispose();
    newNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _internet
        ? Scaffold(
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.white
                : AppColors.darkTheme,
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.105),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.changepassword,
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
                        padding: EdgeInsets.all(height * 0.008),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey),
                            shape: BoxShape.circle),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.close,
                            color: AppColors.white,
                          ),
                        )),
                  ),
                ),
              ),
            ),
            body: DefaultTextStyle(
                style: TextStyle(
                    fontSize: height * 0.02,
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.grey
                        : AppColors.white),
                child: Container(
                  color: AppColors.black,
                  child: Container(
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.02),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.01),
                              Text(
                                AppLocalizations.of(context)!.currentpassword,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: currentController,
                                  hintText: AppLocalizations.of(context)!
                                      .pleaseenterCurrentPassword,
                                  suffixIcon: Icons.visibility_off,
                                  hideIcon: Icons.visibility,
                                  obscure: true,
                                  fillColor: AppColors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onValidate: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterCurrentPassword;
                                    }
                                    return null;
                                  },
                                  onSubmitted: (value) {
                                    UtilsSign.focusChange(newNode, context);
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.newpassword,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: newController,
                                  focus: newNode,
                                  hintText: AppLocalizations.of(context)!
                                      .pleaseEnterNewPassword,
                                  suffixIcon: Icons.visibility_off,
                                  hideIcon: Icons.visibility,
                                  obscure: true,
                                  fillColor: AppColors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onValidate: (value) {
                                    if (value.isEmpty) {
                                      return AppLocalizations.of(context)!
                                          .pleaseenterNewPassword;
                                    }
                                    return null;
                                  },
                                  onSubmitted: (value) {
                                    UtilsSign.focusChange(confirmNode, context);
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: height * 0.02),
                              Text(
                                AppLocalizations.of(context)!.confermpassword,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              SizedBox(
                                height: height * 0.062,
                                child: TextFieldWidget(
                                  controller: confirmController,
                                  focus: confirmNode,
                                  hintText: AppLocalizations.of(context)!
                                      .pleaseenterNewPassword,
                                  suffixIcon: Icons.visibility_off,
                                  hideIcon: Icons.visibility,
                                  obscure: true,
                                  fillColor: AppColors.transparent,
                                  suffixIconColor:
                                      MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  onValidate: (e) {
                                    return validateConfirmPassword(
                                        e.toString());
                                  },
                                ),
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              ButtonWidget(
                                  isLoading: isLoading,
                                  onTaped: () {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    if (_formKey.currentState!.validate()) {
                                      NetworkCalls().checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        String encoded = base64.encode(
                                            utf8.encode(newController.text));
                                        String currentEncoded = base64.encode(
                                            utf8.encode(
                                                currentController.text));
                                        if (msg == true) {
                                          var changeDetail = {
                                            "current_password": currentEncoded,
                                            "new_password": encoded
                                          };
                                          NetworkCalls().changePassword(
                                            changeDetail: changeDetail,
                                            onSuccess: (msg) {
                                              setState(() {
                                                isLoading = false;
                                              });
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  scrollable: true,
                                                  actions: [
                                                    ButtonWidget(
                                                        onTaped: () {
                                                          NavigatorToProfile();
                                                        },
                                                        title: Text(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .viewProfile),
                                                        isLoading: isLoading)
                                                  ],
                                                  title: Text(AppLocalizations
                                                          .of(context)!
                                                      .passwordhasbeenchanged),
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  alignment: Alignment.center,
                                                  content: SizedBox(
                                                    height: height * 0.4,
                                                    width: width,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        flaxibleGap(
                                                          15,
                                                        ),
                                                        Lottie.asset(
                                                            'assets/lottiefiles/success.json',
                                                            height: height * .2,
                                                            width: width * .7),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .resetPassword,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF2F2F2F),
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .youHaveSuccessfully,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color: Color(
                                                                  0XFF898989)),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            onFailure: (msg) {
                                              setState(() {
                                                isLoading = false;
                                                showMessage(msg);
                                              });
                                            },
                                            tokenExpire: () {
                                              if (mounted) on401(context);
                                            },
                                          );
                                        } else {
                                          if (mounted) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            showMessage(
                                                AppLocalizations.of(context)!
                                                    .noInternetConnection);
                                          }
                                        }
                                      });
                                    }
                                  },
                                  title: Text(
                                    AppLocalizations.of(context)!.saveChanges,
                                    style: TextStyle(color: AppColors.black),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          )
        : InternetLoss(
            onChange: () {
              NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
                _internet = msg;
                if (msg == true) {
                } else {
                  if (mounted) {
                    setState(() {});
                  }
                }
              });
            },
          );
  }

  validateConfirmPassword(String value) {
    if (value.trim() != newController.text.trim()) {
      return AppLocalizations.of(context)!.passwordMismatch;
    }
    return null;
  }

  // ignore: non_constant_identifier_names
  void NavigatorToProfile() {
    Navigator.pushReplacementNamed(context, RouteNames.profileDetail);
  }
}
