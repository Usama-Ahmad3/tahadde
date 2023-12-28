import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/homeFile/utility.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/app_bar.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: appBarWidget(
          sizeWidth: width,
          sizeHeight: height,
          context: context,
          title: AppLocalizations.of(context)!.tahaddiShop,
          back: false),
      body: Container(
          color: Colors.black,
          child: Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.darkTheme,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.059, vertical: height * 0.02),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: height,
                        decoration: BoxDecoration(
                            color: MyAppState.mode == ThemeMode.light
                                ? AppColors.white
                                : AppColors.darkTheme,
                            borderRadius: true
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))
                                : BorderRadius.zero),
                        child: Column(
                          children: [
                            flaxibleGap(15),
                            SizedBox(
                                height: width * .4,
                                width: height * .4,
                                child: Image.asset(
                                  'assets/images/icon.png',
                                )),
                            flaxibleGap(4),
                            Text(AppLocalizations.of(context)!.coming,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? const Color(0XFF424242)
                                          : AppColors.white,
                                      fontFamily: "Poppins",
                                    )),
                            flaxibleGap(1),
                            // Text(
                            //   AppLocalizations.of(context)!
                            //       .youHaveBooked,
                            //   style: Theme.of(context)
                            //       .textTheme
                            //       .titleSmall!
                            //       .copyWith(
                            //     color: MyAppState.mode ==
                            //         ThemeMode.light
                            //         ? const Color(0XFF7A7A7A)
                            //         : Colors.white38,
                            //     fontFamily: "Poppins",
                            //   ),
                            // ),
                            flaxibleGap(30),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))),
    );
  }
}
