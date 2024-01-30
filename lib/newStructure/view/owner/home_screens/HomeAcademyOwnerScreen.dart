import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/shop_screen/shop_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../constant.dart';
import '../../../../localizations.dart';
import '../../../app_colors/app_colors.dart';
import '../../player/HomeScreen/NotificationScreenBoth/notification.dart';
import '../../player/HomeScreen/profileScreen/profileDetail.dart';
import 'bookingScreens/bookingScreen.dart';
import 'home_page/main_home/academyowner_main_home.dart';

// ignore: must_be_immutable
class HomePitchOwnerScreen extends StatefulWidget {
  int index;
  HomePitchOwnerScreen({super.key, required this.index});
  @override
  State<HomePitchOwnerScreen> createState() => _HomePitchOwnerScreenState();
}

class _HomePitchOwnerScreenState extends State<HomePitchOwnerScreen> {
  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            elevation: 2,
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.darkTheme,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              AppLocalizations.of(context)!.areYouSure,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.065),
            content: Text(
              AppLocalizations.of(context)!.youGoingExit,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: AppColors.appThemeColor),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.appThemeColor,
                          border: Border.all(width: 1, color: AppColors.white),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.no,
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).pop(true);
                      exit(0);
                    },
                    child: Center(
                      child: Container(
                        height: 35,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.red,
                          border: Border.all(width: 1, color: AppColors.white),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of(context)!.yes,
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }

  final page = [
    const AcademyOwnerMainHome(),
    const BookingScreen(),
    NotificationScreen(
      player: false,
    ),
    const ShopScreen(),
    ProfileDetailScreen(playerTag: false),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: WillPopScope(
          onWillPop: () {
            return onWillPop();
          },
          child: Material(
              color: appThemeColor,
              child: Scaffold(
                bottomNavigationBar: SalomonBottomBar(
                  currentIndex: widget.index,
                  onTap: (index) {
                    widget.index = index;
                    setState(() {});
                  },
                  selectedItemColor: AppColors.appThemeColor,
                  backgroundColor: AppColors.black,
                  selectedColorOpacity: 1,
                  curve: Curves.bounceInOut,
                  items: [
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.home_outlined,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.home,
                        style: TextStyle(color: AppColors.white),
                      ),
                      activeIcon: Icon(
                        Icons.home,
                        color: AppColors.white,
                      ),
                      unselectedColor: AppColors.grey,
                      selectedColor: AppColors.appThemeColor,
                    ),
                    SalomonBottomBarItem(
                      icon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/images/booking2.png',
                          color: AppColors.grey,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.booking,
                        style: TextStyle(color: AppColors.white),
                      ),
                      activeIcon: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/images/file.png',
                          color: AppColors.white,
                        ),
                      ),
                      selectedColor: AppColors.appThemeColor,
                      unselectedColor: Colors.grey,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.notifications_none,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.notification,
                        style: TextStyle(
                            color: AppColors.white,
                            fontSize:
                                MediaQuery.sizeOf(context).height * 0.0153),
                      ),
                      activeIcon: Icon(
                        Icons.notifications_sharp,
                        color: AppColors.white,
                        size: MediaQuery.sizeOf(context).height * 0.023,
                      ),
                      selectedColor: AppColors.appThemeColor,
                      unselectedColor: AppColors.grey,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.shopping_basket_outlined,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.shop,
                        style: TextStyle(color: AppColors.white),
                      ),
                      activeIcon: Icon(
                        Icons.shopping_basket,
                        color: AppColors.white,
                        size: MediaQuery.of(context).size.height * 0.024,
                      ),
                      selectedColor: AppColors.appThemeColor,
                      unselectedColor: AppColors.grey,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.person_2_outlined,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.account,
                        style: TextStyle(color: AppColors.white),
                      ),
                      activeIcon: Icon(
                        Icons.person,
                        color: AppColors.white,
                      ),
                      selectedColor: AppColors.appThemeColor,
                      unselectedColor: AppColors.grey,
                    ),
                  ],
                ),
                body: page[widget.index],
              )),
        ));
  }
}
