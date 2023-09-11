import 'package:flutter/material.dart';

import '../apis/apis.dart';
import '../homeFile/routingConstant.dart';
import '../homeFile/utility.dart';
import '../localizations.dart';
import '../network/network_calls.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String baseUrl = RestApis.BASE_URL;
  final NetworkCalls _networkCalls = NetworkCalls();

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Container(
        color: const Color(0XFF25A163),
        child: SafeArea(
          child: Container(
            height: 60,
            child: Material(
              color: const Color(0XFF25A163),
              child: InkWell(
                splashColor: Colors.black,
                onTap: () {
                  RestApis.BASE_URL = baseUrl;
                  _networkCalls.saveBaseUrl(onSuccess: (msg) {
                    navigateToHome();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.continu,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0XFFFFFFFF)),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildAppBar(
                language: AppLocalizations.of(context)!.locale,
                title: "Account Setting",
                backButton: true,
                onTap: () {
                  Navigator.of(context).pop();
                },
                height: sizeHeight,
                width: sizeWidth),
            GestureDetector(
              onTap: () {
                if (baseUrl == "https://tahadi.theclientdemos.com") {
                  setState(() {
                    baseUrl = "https://powerhouse.tahadde.ae";
                  });
                }
              },
              child: Container(
                width: sizeWidth,
                height: sizeHeight * .1,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Live",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      baseUrl == "https://powerhouse.tahadde.ae"
                          ? Image.asset(
                              "assets/images/check.png",
                              height: 20,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: sizeWidth,
              height: 1,
              alignment: Alignment.centerLeft,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {
                if (baseUrl == "https://powerhouse.tahadde.ae") {
                  setState(() {
                    baseUrl = "https://tahadi.theclientdemos.com";
                  });
                }
              },
              child: Container(
                width: sizeWidth,
                height: sizeHeight * .1,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Material(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Stage",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      baseUrl == "https://tahadi.theclientdemos.com"
                          ? Image.asset(
                              "assets/images/check.png",
                              height: 20,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }
}
