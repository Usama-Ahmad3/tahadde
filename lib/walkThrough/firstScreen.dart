import 'package:flutter/material.dart';

import '../common_widgets/localeHelper.dart';
import '../homeFile/utility.dart';
import '../localizations.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
                        Container(
                          child: Row(
                            children: [
                              flaxibleGap(30),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? helper.onLocaleChanged(
                                            const Locale("ar", ''))
                                        : helper.onLocaleChanged(
                                            const Locale("en", ''));
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
                                            fit: BoxFit.cover),
                              ),
                              flaxibleGap(1),
                            ],
                          ),
                        ),
                        flaxibleGap(1),
                        Container(
                            width: sizeWidth * .4,
                            child: Text(
                              AppLocalizations.of(context)!
                                  .onlineBooking
                                  .toString(),
                              style: const TextStyle(
                                  color: Color(0XFF25A163),
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                  height: 1),
                            )),
                        flaxibleGap(1),
                        Image.asset(
                          "assets/images/online.png",
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
            flaxibleGap(1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: Container(
                  width: sizeWidth * .7,
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.walkBookpitch,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: sizeHeight * 0.023,
                          height: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ),
            flaxibleGap(1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * .05),
              child: Container(
                  width: sizeWidth * .65,
                  child: Text(
                    AppLocalizations.of(context)!.walkHereTahaddi,
                    style: const TextStyle(
                      color: Color(0XFFB5B5B5),
                      fontSize: 16,
                    ),
                  )),
            ),
            flaxibleGap(5),
          ],
        ),
      ),
    );
  }
}
