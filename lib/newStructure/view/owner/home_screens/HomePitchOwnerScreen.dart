import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../constant.dart';
import '../../../../localizations.dart';
import '../../../app_colors/app_colors.dart';
import '../../player/HomeScreen/NotificationScreenBoth/notification.dart';
import '../../player/HomeScreen/profileScreen/profileDetail.dart';
import 'bookingScreens/bookingScreen.dart';
import 'home_page/main_home/picthowner_main_home.dart';

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
            backgroundColor: AppColors.grey200,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(
              AppLocalizations.of(context)!.youGoingExit,
              style: TextStyle(color: AppColors.red),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.black,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.no,
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.transparent,
                    border: Border.all(width: 1, color: AppColors.red),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.yes,
                      style: TextStyle(color: AppColors.red),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  final page = [
    const PitchOwnerMainHome(),
    const BookingScreen(),
    NotificationScreen(
      player: false,
    ),
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
                        style: TextStyle(color: AppColors.black),
                      ),
                      activeIcon:  Icon(
                        Icons.home,
                        color: AppColors.black,
                      ),
                      unselectedColor: AppColors.grey,
                      selectedColor: AppColors.appThemeColor,
                    ),
                    SalomonBottomBarItem(
                      icon: SizedBox(
                        height: 23,
                        width: 23,
                        child: Image.asset(
                          'assets/images/booking2.png',
                          color: AppColors.grey,
                        ),
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.booking,
                        style: const TextStyle(color: Colors.black),
                      ),
                      activeIcon: SizedBox(
                        height: 23,
                        width: 23,
                        child: Image.asset(
                          'assets/images/file.png',
                          color: Colors.black,
                        ),
                      ),
                      selectedColor: const Color(0xff1d7e55),
                      unselectedColor: Colors.grey,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.notifications_none,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.notification,
                        style: TextStyle(color: AppColors.black),
                      ),
                      activeIcon: Icon(
                        Icons.notifications_sharp,
                        color: AppColors.black,
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
                        style:  TextStyle(color: AppColors.black),
                      ),
                      activeIcon: Icon(
                        Icons.person,
                        color: AppColors.black,
                      ),
                      selectedColor:  AppColors.appThemeColor,
                      unselectedColor: AppColors.grey,
                    ),
                  ],
                ),
                body: page[widget.index],
              )),
        ));
  }
}
