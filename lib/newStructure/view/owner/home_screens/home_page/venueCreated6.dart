import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';

class VenueCreatedScreen extends StatefulWidget {
  const VenueCreatedScreen({Key? key}) : super(key: key);

  @override
  State<VenueCreatedScreen> createState() => _VenueCreatedScreenState();
}

class _VenueCreatedScreenState extends State<VenueCreatedScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: MyAppState.mode == ThemeMode.light
              ? Colors.white
              : const Color(0xff686868),
          appBar: PreferredSize(
              preferredSize: Size(size.width, size.height * 0.105),
              child: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  AppLocalizations.of(context)!.slotChart,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                backgroundColor: Colors.black,
              )),
          body: Container(
              color: Colors.black,
              child: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? Colors.white
                        : const Color(0xff686868),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    flaxibleGap(
                      15,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/images/checks.png",
                        height: 60,
                        width: 60,
                      ),
                    ),
                    flaxibleGap(
                      2,
                    ),
                    Text(
                      "Thank you for creating a Venue.",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: MyAppState.mode == ThemeMode.light
                              ? Colors.black
                              : Colors.white),
                    ),
                    flaxibleGap(
                      1,
                    ),
                    Text(
                      "It is under review.\n We will notify you once it’s done.",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: MyAppState.mode == ThemeMode.light
                              ? Colors.black
                              : Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    flaxibleGap(
                      15,
                    ),
                    ButtonWidget(
                        onTaped: () {
                          navigateToHome();
                        },
                        title: Text(AppLocalizations.of(context)!.home),
                        isLoading: false),
                    SizedBox(
                      height: size.height * 0.01,
                    )
                  ],
                ),
              )),
        ));
  }

  void navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.homePitchOwner, (Route<dynamic> route) => false);
  }
}
