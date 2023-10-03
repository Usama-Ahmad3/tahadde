import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
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
  bool _isLoading = true;
  bool _internet = true;
  final _formKey = GlobalKey<FormState>();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();

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
    return _isLoading
        ? _internet
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
                              textField(
                                  name: AppLocalizations.of(context)!.email,
                                  hint: AppLocalizations.of(context)!.email,
                                  text: false,
                                  keybordType: false,
                                  text1: false,
                                  onSaved: (value) {
                                    email = value!;
                                  },
                                  onchange: (value) {
                                    if (value == "xxxxxx") {
                                      FocusScope.of(context).unfocus();
                                      navigateToAccountSetting();
                                    }
                                  },
                                  validator: (value) {
                                    var msg;
                                    if (!isMail(value!.trim())) {
                                      msg = AppLocalizations.of(context)!
                                          .invalidEmail;
                                    }
                                    return msg;
                                  }),
                              flaxibleGap(3),
                              Ink(
                                decoration: BoxDecoration(
                                    color: Colors.yellowAccent,
                                    borderRadius: BorderRadius.circular(13)),
                                child: InkWell(
                                  splashColor: Colors.black,
                                  onTap: () {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
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
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 45,
                                    alignment: Alignment.center,
                                    child: Text(
                                      AppLocalizations.of(context)!.sendEmail,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ),
                                ),
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
              )
        : Scaffold(
            key: scaffoldkey,
            body: SizedBox(
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
          );
  }

  void navigateToDetail({String? msg}) {
    Navigator.of(context).pop();
    Navigator.pushReplacementNamed(context, RouteNames.login, arguments: msg);
  }

  void navigateToAccountSetting() {
    Navigator.pushNamed(context, RouteNames.accountSetting);
  }
}
