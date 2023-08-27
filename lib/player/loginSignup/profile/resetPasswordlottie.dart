import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';

class ResetPasswordSuccess extends StatefulWidget {
  var msg;
  ResetPasswordSuccess({this.msg});
  @override
  _ResetPasswordSuccess createState() => _ResetPasswordSuccess();
}

class _ResetPasswordSuccess extends State<ResetPasswordSuccess> {
  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          bottomNavigationBar: GestureDetector(
            onTap: () {
              navigateToDetail();
            },
            child: Container(
              height: sizeheight * .1,
              width: sizewidth,
              color: const Color(0XFF25A163),
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.gotoLoginPage,
                style: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
            ),
          ),
          body: Container(
            height: sizeheight,
            width: sizewidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                flaxibleGap(
                  15,
                ),
                Lottie.asset('lottiefiles/success.json',
                    height: sizeheight * .4, width: sizewidth * .7),
                Text(
                  AppLocalizations.of(context)!.resetPassword,
                  style: const TextStyle(
                      color: Color(0XFF2F2F2F),
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: sizewidth * .146, right: sizewidth * .146),
                  child: Text(
                    AppLocalizations.of(context)!.youHaveSuccessfully,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0XFF898989)),
                  ),
                ),
                flaxibleGap(
                  20,
                ),
              ],
            ),
          )),
    );
  }

  void navigateToDetail() {
    Navigator.pushReplacementNamed(context, RouteNames.login,
        arguments: widget.msg);
  }
}
