import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../constant.dart';
import '../../../../localizations.dart';
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
            backgroundColor: Colors.grey.shade200,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(
              AppLocalizations.of(context)!.youGoingExit,
              style: const TextStyle(color: Colors.red),
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
                    color: Colors.black,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.no,
                      style: const TextStyle(color: Colors.white),
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
                    color: Colors.transparent,
                    border: Border.all(width: 1, color: Colors.red),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.yes,
                      style: const TextStyle(color: Colors.red),
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
                  selectedItemColor: const Color(0xff1d7e55),
                  backgroundColor: Colors.black,
                  selectedColorOpacity: 1,
                  curve: Curves.bounceInOut,
                  items: [
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.home_outlined,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.home,
                        style: const TextStyle(color: Colors.black),
                      ),
                      activeIcon: const Icon(
                        Icons.home,
                        color: Colors.black,
                      ),
                      unselectedColor: Colors.grey,
                      selectedColor: const Color(0xff1d7e55),
                    ),
                    SalomonBottomBarItem(
                      icon: SizedBox(
                        height: 23,
                        width: 23,
                        child: Image.asset(
                          'assets/images/booking2.png',
                          color: Colors.grey,
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
                        style: const TextStyle(color: Colors.black),
                      ),
                      activeIcon: const Icon(
                        Icons.notifications_sharp,
                        color: Colors.black,
                      ),
                      selectedColor: const Color(0xff1d7e55),
                      unselectedColor: Colors.grey,
                    ),
                    SalomonBottomBarItem(
                      icon: const Icon(
                        Icons.person_2_outlined,
                      ),
                      title: Text(
                        AppLocalizations.of(context)!.account,
                        style: const TextStyle(color: Colors.black),
                      ),
                      activeIcon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      selectedColor: const Color(0xff1d7e55),
                      unselectedColor: Colors.grey,
                    ),
                  ],
                ),
                body: page[widget.index],
              )),
        ));
  }
}
