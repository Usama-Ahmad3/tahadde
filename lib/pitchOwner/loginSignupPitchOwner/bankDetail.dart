import 'dart:io';

import 'package:flutter/material.dart';

import '../../common_widgets/internet_loss.dart';
import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../player/loginSignup/signup.dart';

class BankDetail extends StatefulWidget {
  Map detail;
  BankDetail({required this.detail});
  @override
  _BankDetailState createState() => _BankDetailState();
}

class _BankDetailState extends State<BankDetail> {
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
  late OverlayEntry? overlayEntry;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  showOverlay(BuildContext context) {
    if (overlayEntry != null) return;
    OverlayState overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        right: 0,
        left: 0,
        child: DoneButton(),
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
    // TODO: implement initState
    super.initState();
    if (Platform.isIOS) {
      focuss.addListener(() {
        bool hasFocus = focuss.hasFocus;
        if (hasFocus) {
          showOverlay(context);
        } else {
          removeOverlay();
        }
      });
    }
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
                children: <Widget>[
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
                      child: Container(
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
                                color: const Color(0XFF25A163),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width / 1.2,
                                height: 45,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.signUp,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                            flaxibleGap(1),
                            Container(
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
                                          color: Color(0XFF25A163),
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
                                            color: Color(0XFF25A163),
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
                  color: const Color(0XFF25A163),
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
                    child: Container(
                      width: sizeWidth,
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
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
                              Container(
                                height: sizeHeight * .18,
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          width: sizeWidth,
                                          child: Row(
                                            children: <Widget>[
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
                                                color: Colors.transparent,
                                                child: InkWell(
                                                  splashColor: Colors.black,
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
                                                        color:
                                                            Color(0XFF25A163),
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
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: const Color(0XFF25A163),
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeHeight * .005,
                                width: sizeWidth * .19,
                                color: const Color(0XFF25A163),
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
                    children: <Widget>[
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
                      Container(
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
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: sizeWidth,
                                  child: Row(
                                    children: <Widget>[
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
                                              color: Color(0XFF25A163),
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
