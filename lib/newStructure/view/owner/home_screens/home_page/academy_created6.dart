import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../app_colors/app_colors.dart';
import '../HomePitchOwnerScreen.dart';

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
              ? AppColors.white
              : AppColors.darkTheme,
          appBar: appBarWidget(size.width, size.height, context,
              AppLocalizations.of(context)!.academyCreated, false),
          body: Container(
              color: AppColors.black,
              child: Container(
                height: size.height,
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.033),
                decoration: BoxDecoration(
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.darkTheme,
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
                      "Thank you for creating a Academy.",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: MyAppState.mode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white),
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
                              ? AppColors.black
                              : AppColors.white),
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (_) => HomePitchOwnerScreen(
                  index: 0,
                )));
    // Navigator.of(context).pushNamedAndRemoveUntil(
    //     RouteNames.homePitchOwner, (Route<dynamic> route) => false);
  }
}
