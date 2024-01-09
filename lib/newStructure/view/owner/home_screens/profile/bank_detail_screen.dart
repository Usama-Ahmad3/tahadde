import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../constant.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';

class BankDetailScreen extends StatefulWidget {
  Map detail;
  BankDetailScreen({super.key, required this.detail});
  @override
  State<BankDetailScreen> createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();
  late String month;
  final focus = FocusNode();
  final focuss = FocusNode();
  bool monVal = false;
  bool _isButtonDisabled = false;
  final _formKey = GlobalKey<FormState>();
  bool _internet = true;
  bool isLoading = false;
  late String holderName;
  late String accountNumber;
  late String ibanNambe;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    //print(widget.detail["documents_expiry_date"]);
    return isLoading
        ? Scaffold(
            key: scaffoldkey,
            backgroundColor: const Color(0XFFFFFFFF),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  buildAppBar(
                      language: AppLocalizations.of(context)!.locale,
                      title: AppLocalizations.of(context)!.bankDetails,
                      backButton: true,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      height: sizeHeight,
                      width: sizeWidth),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: SizedBox(
                        height: sizeHeight * .9,
                        width: sizeWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            flaxibleGap(1),
                            shimmer(width: sizeWidth),
                            fixedGap(height: 10.0),
                            shimmer(width: sizeWidth),
                            fixedGap(height: 10.0),
                            shimmer(width: sizeWidth),
                            fixedGap(height: 10.0),
                            shimmer(width: sizeWidth),
                            fixedGap(height: 10.0),
                            shimmer(width: sizeWidth),
                            flaxibleGap(3),
                            Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: AppColors.barLineColor,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 45,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: AppColors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            flaxibleGap(1),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 1.2,
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        '${AppLocalizations.of(context)!.bysigningupTahaddi} ',
                                    style: const TextStyle(
                                        fontSize: 12, color: Color(0XFF7A7A7A)),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: AppLocalizations.of(context)!
                                            .termsofUse,
                                        style: const TextStyle(
                                          color: AppColors.barLineColor,
                                          fontWeight: FontWeight.bold,
//                                                  decoration:
//                                                      TextDecoration.underline,
                                        ),
                                      ),
                                      TextSpan(
                                          text:
                                              ' ${AppLocalizations.of(context)!.and} '),
                                      TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .privacyPolicy,
                                          style: const TextStyle(
                                            color: AppColors.barLineColor,
                                            fontWeight: FontWeight.bold,
//                                                    decoration: TextDecoration
//                                                        .underline,
                                          )),
                                    ],
                                  ),
                                )),
                            flaxibleGap(1),
                          ],
                        ),
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
                bottomNavigationBar: Material(
                  color: AppColors.barLineColor,
                  child: InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          if (msg = true) {
                            widget.detail["ibanNumber"] = ibanNambe;
                            widget.detail["accountholderName"] = holderName;
                            widget.detail["accountNumber"] = accountNumber;
                            _networkCalls.signUp(
                                signupDetail: widget.detail,
                                onSuccess: (msg) {
                                  navigateToHome();
                                },
                                onFailure: (msg) {
                                  setState(() {});
                                  showMessage(msg);
                                });
                          } else {
                            if (mounted) {
                              showMessage(AppLocalizations.of(context)!
                                  .noInternetConnection);
                            }
                          }
                        });
                      }
                    },
                    splashColor: Colors.black,
                    child: Container(
                        height: sizeHeight * .104,
                        alignment: Alignment.center,
                        child: Text(
                          AppLocalizations.of(context)!.finishSignup,
                          style: const TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: SizedBox(
                      width: sizeWidth,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              AppLocalizations.of(context)!.locale == "en"
                                  ? Image.asset(
                                      'assets/images/header.png',
                                      fit: BoxFit.cover,
                                      width: sizeWidth,
                                      height: sizeHeight * .2,
                                    )
                                  : Image.asset(
                                      'assets/images/arabicHeader.png',
                                      fit: BoxFit.cover,
                                      width: sizeWidth,
                                      height: sizeHeight * .2,
                                    ),
                              SizedBox(
                                height: sizeHeight * .18,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: AppColors.white,
                                          size: 25,
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: sizeWidth,
                                          child: Row(
                                            children: [
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .bankDetails,
                                                style: TextStyle(
                                                    fontSize: appHeaderFont,
                                                    color:
                                                        const Color(0XFFFFFFFF),
                                                    fontFamily:
                                                        AppLocalizations.of(
                                                                        context)!
                                                                    .locale ==
                                                                "en"
                                                            ? "Poppins"
                                                            : "VIP",
                                                    fontWeight: AppLocalizations
                                                                    .of(context)!
                                                                .locale ==
                                                            "en"
                                                        ? FontWeight.bold
                                                        : FontWeight.normal),
                                              ),
                                              flaxibleGap(1),
                                              Material(
                                                color: AppColors.transparent,
                                                child: InkWell(
                                                  splashColor: AppColors.black,
                                                  onTap: () {
                                                    _isButtonDisabled
                                                        ? null
                                                        : setState(() {
                                                            _isButtonDisabled =
                                                                true;
                                                            _networkCalls
                                                                .checkInternetConnectivity(
                                                                    onSuccess:
                                                                        (msg) {
                                                              if (msg == true) {
                                                                if (mounted) {
                                                                  _networkCalls
                                                                      .signUp(
                                                                          signupDetail: widget
                                                                              .detail,
                                                                          onSuccess:
                                                                              (msg) {
                                                                            navigateToHome();
                                                                          },
                                                                          onFailure:
                                                                              (msg) {
                                                                            setState(() {
                                                                              _isButtonDisabled = false;
                                                                            });
                                                                            showMessage(msg);
                                                                          });
                                                                }
                                                              } else {
                                                                if (mounted) {
                                                                  showMessage(AppLocalizations.of(
                                                                          context)!
                                                                      .noInternetConnection);
                                                                }
                                                              }
                                                            });
                                                          });
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .skip,
                                                    style: const TextStyle(
                                                        decoration:
                                                            TextDecoration.none,
                                                        // color: Color(0XFF25A163),
                                                        color: AppColors
                                                            .barLineColor,
                                                        fontSize: 20,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: AppColors.barLineColor,
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: AppColors.barLineColor,
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: AppColors.barLineColor,
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: AppColors.barLineColor,
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: AppColors.barLineColor,
                              ),
                            ],
                          ),
                          Container(
                            height: sizeHeight * .1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .1),
                            child: textField(
                              name: AppLocalizations.of(context)!
                                  .accountHolderName,
                              text: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseenterAccountHolderName;
                                }
                                return '';
                              },
                              submit: (value) {
                                FocusScope.of(context).requestFocus(focus);
                              },
                              onSaved: (value) {
                                holderName = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .1),
                            child: textField(
                              node: focus,
                              name: AppLocalizations.of(context)!.accountNumber,
                              text: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseenterAccountNumber;
                                }
                                return '';
                              },
                              submit: (value) {
                                FocusScope.of(context).requestFocus(focuss);
                              },
                              onSaved: (value) {
                                accountNumber = value!;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: sizeWidth * .1),
                            child: textField(
                              node: focuss,
                              name: AppLocalizations.of(context)!.ibnNumber,
                              text: false,
                              keybordType: false,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return AppLocalizations.of(context)!
                                      .pleaseenterIBANCode;
                                }
                                return '';
                              },
                              onSaved: (value) {
                                ibanNambe = value!;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Column(
                children: [
                  Stack(
                    children: [
                      AppLocalizations.of(context)!.locale == "en"
                          ? Image.asset(
                              'assets/images/header.png',
                              fit: BoxFit.cover,
                              width: sizeWidth,
                              height: sizeHeight * .2,
                            )
                          : Image.asset(
                              'assets/images/arabicHeader.png',
                              fit: BoxFit.cover,
                              width: sizeWidth,
                              height: sizeHeight * .2,
                            ),
                      SizedBox(
                        height: sizeHeight * .18,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: AppColors.white,
                                  size: 25,
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: sizeWidth,
                                  child: Row(
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!
                                            .bankDetails,
                                        style: TextStyle(
                                            fontSize: appHeaderFont,
                                            color: const Color(0XFFFFFFFF),
                                            fontFamily:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? "Poppins"
                                                    : "VIP",
                                            fontWeight:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        "en"
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                      flaxibleGap(1),
                                      GestureDetector(
                                        onTap: () {
                                          _networkCalls.signUp(
                                              signupDetail: widget.detail,
                                              onSuccess: (msg) {
                                                navigateToHome();
                                              },
                                              onFailure: (msg) {
                                                setState(() {});
                                                showMessage(msg);
                                              });
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!.skip,
                                          style: const TextStyle(
                                              decoration: TextDecoration.none,
                                              color: AppColors.barLineColor,
                                              fontSize: 20,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: InternetLoss(
                      onChange: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          _internet = msg;
                          if (msg == true) {
                            if (mounted) setState(() {});
                          }
                        });
                      },
                    ),
                  ),
                ],
              );
  }

  void navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.homePitchOwner, (Route<dynamic> route) => false);
  }
}
