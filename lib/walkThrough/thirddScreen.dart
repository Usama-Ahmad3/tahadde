import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../common_widgets/localeHelper.dart';
import '../homeFile/routingConstant.dart';
import '../homeFile/utility.dart';
import '../localizations.dart';
import '../network/network_calls.dart';
import '../newStructure/view/player/HomeScreen/playerHomeScreen.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final NetworkCalls _networkCalls = NetworkCalls();

  _initializeLanguage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var languageCode = pref.get("lang");
    if (languageCode == null && mounted) {
      var defaultLocale = Localizations.localeOf(context).languageCode;
      if (defaultLocale.toLowerCase() == "ar" ||
          defaultLocale.toLowerCase() == "en") {
        print(defaultLocale.toLowerCase());
        _networkCalls.saveLanguage(defaultLocale.toLowerCase());
      } else {
        _networkCalls.saveLanguage("ar");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      body: Container(
        height: sizeHeight,
        width: sizeWidth,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: sizeHeight * .5,
              width: sizeWidth,
              color: const Color(0XFF032040),
              child: Stack(
                children: [
                  AppLocalizations.of(context)!.locale == "en"
                      ? Image.asset(
                          "assets/images/backEng.png",
                          height: sizeHeight * .5,
                          width: sizeWidth,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/images/left.png",
                          height: sizeHeight * .5,
                          width: sizeWidth,
                          fit: BoxFit.cover,
                        ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        flaxibleGap(1),
                        Row(
                          children: [
                            flaxibleGap(30),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? helper
                                          .onLocaleChanged(const Locale("ar"))
                                      : helper
                                          .onLocaleChanged(const Locale("en"));
                                });
                              },
                              child:
                                  AppLocalizations.of(context)!.locale == "en"
                                      ? Image.asset(
                                          "assets/images/langEng.png",
                                          height: sizeHeight * .05,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/images/arabicLang.png",
                                          height: sizeHeight * .05,
                                          fit: BoxFit.cover,
                                        ),
                            ),
                            flaxibleGap(
                              1,
                            ),
                          ],
                        ),
                        flaxibleGap(
                          1,
                        ),
                        SizedBox(
                            width: sizeWidth * .6,
                            child: Text(
                              AppLocalizations.of(context)!.walkcreatePitch,
                              style: const TextStyle(
                                  color: Color(0XFF25A163),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  height: 1),
                            )),
                        flaxibleGap(
                          1,
                        ),
                        Image.asset(
                          "assets/images/createEvent.png",
                          height: sizeHeight * .28,
                          width: sizeWidth,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            flaxibleGap(
              1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: SizedBox(
                  width: sizeWidth * .7,
                  child: Text(
                    AppLocalizations.of(context)!.pitchTournament,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        height: 1.2,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            flaxibleGap(
              1,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: SizedBox(
                  width: sizeWidth * .65,
                  child: Text(
                    AppLocalizations.of(context)!.youCanBuild,
                    style:
                        const TextStyle(color: Color(0XFFB5B5B5), fontSize: 18),
                  )),
            ),
            flaxibleGap(
              2,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: Row(
                children: [
                  flaxibleGap(
                    2,
                  ),
                  GestureDetector(
                      onTap: () {
                        _networkCalls.savewalk("walk");
                        _initializeLanguage();
                        // navigateToHome();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerHomeScreen(
                                      index: 0,
                                    )
                                // SelectYourLocation(),
                                ));
                      },
                      child: Container(
                        height: sizeHeight * 0.07,
                        width: sizeWidth * 0.15,
                        decoration: const BoxDecoration(
                            color: Colors.yellow, shape: BoxShape.circle),
                        child: const Icon(
                          Icons.arrow_forward_outlined,
                          color: Colors.black,
                        ),
                      )),
                ],
              ),
            ),
            flaxibleGap(
              2,
            ),
          ],
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushNamed(context, RouteNames.selectLocation);
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.permissionPriming, (r) => false);
  }
}
