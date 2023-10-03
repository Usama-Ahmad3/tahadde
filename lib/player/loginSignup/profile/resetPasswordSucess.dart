import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../homeFile/utility.dart';
import '../../../localizations.dart';

class PassworSuccess extends StatefulWidget {
  const PassworSuccess({super.key});

  @override
  _PassworSuccess createState() => _PassworSuccess();
}

class _PassworSuccess extends State<PassworSuccess> {
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
                AppLocalizations.of(context)!.viewProfile,
                style: const TextStyle(
                    color: Color(0XFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: "Poppins"),
              ),
            ),
          ),
          body: SizedBox(
            height: sizeheight,
            width: sizewidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                flaxibleGap(
                  15,
                ),
                Lottie.asset('assets/lottiefiles/success.json',
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
    Navigator.of(context).pop();
    // Navigator.pushReplacementNamed(context, profile);
  }
}
