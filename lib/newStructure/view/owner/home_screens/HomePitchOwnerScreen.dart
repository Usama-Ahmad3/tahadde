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
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: AppColors.appThemeColor),
            ),
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Center(
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.appThemeColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.no,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
                      border: Border.all(width: 1, color: AppColors.white),
                    ),
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context)!.yes,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: AppColors.white),
                      ),
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
                        height: 23,
                        width: 23,
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
                        height: 23,
                        width: 23,
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
                        style: TextStyle(color: AppColors.white),
                      ),
                      activeIcon: Icon(
                        Icons.notifications_sharp,
                        color: AppColors.white,
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
