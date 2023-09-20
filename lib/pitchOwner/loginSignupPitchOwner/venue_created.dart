import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';

class VenueCreated extends StatefulWidget {
  const VenueCreated({Key? key}) : super(key: key);

  @override
  _VenueCreatedState createState() => _VenueCreatedState();
}

class _VenueCreatedState extends State<VenueCreated> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: appBar(
              title: "Venue Created",
              language: AppLocalizations.of(context)!.locale,
              onTap: () {
                Navigator.of(context).pop();
              },
              isBack: true),
          bottomNavigationBar: Material(
            color: const Color(0XFF25A163),
            child: InkWell(
              onTap: () {
                navigateToHome();
              },
              splashColor: Colors.black,
              child: Container(
                  height: size.height * .104,
                  alignment: Alignment.center,
                  child: const Text(
                    "HOME",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  )),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              flaxibleGap(
                15,
              ),
              Image.asset(
                "assets/images/checks.png",
                height: 60,
                width: 60,
              ),
              flaxibleGap(
                2,
              ),
              const Text(
                "Thank you for creating a Venue.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: appThemeColor),
              ),
              flaxibleGap(
                1,
              ),
              const Text(
                "It is under review.\n We will notify you once it’s done.",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: appThemeColor),
                textAlign: TextAlign.center,
              ),
              flaxibleGap(
                15,
              ),
            ],
          )),
    );
  }

  void navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.homePitchOwner, (Route<dynamic> route) => false);
  }
}
