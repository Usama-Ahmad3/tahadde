import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../app_colors/app_colors.dart';
import '../HomePitchOwnerScreen.dart';

class academy_created_screen extends StatefulWidget {
  const academy_created_screen({Key? key}) : super(key: key);

  @override
  State<academy_created_screen> createState() => _academy_created_screenState();
}

class _academy_created_screenState extends State<academy_created_screen> {
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
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.2,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.appThemeColor),
                        child: Icon(
                          FontAwesomeIcons.check,
                          color: AppColors.white,
                          size: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ),
                    ),
                    flaxibleGap(
                      2,
                    ),
                    Text(
                      AppLocalizations.of(context)!.thankyouAcademy,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: MyAppState.mode == ThemeMode.light
                              ? AppColors.black
                              : AppColors.white),
                    ),
                    flaxibleGap(
                      1,
                    ),
                    Text(
                      "${AppLocalizations.of(context)!.underReview}\n ${AppLocalizations.of(context)!.notify}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                        title: Text(
                          AppLocalizations.of(context)!.home,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.white),
                        ),
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
