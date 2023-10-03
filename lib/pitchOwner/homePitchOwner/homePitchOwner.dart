import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../localizations.dart';
import '../../newStructure/view/player/HomeScreen/NotificationScreenBoth/notification.dart';
import '../bookingPitchOwner/booking.dart';
import '../profilePitchOwner/account.dart';
import 'pitchOwnerHome.dart';

class HomePitchOwner extends StatefulWidget {
  int index = 0;
  HomePitchOwner({super.key, required this.index});
  @override
  _HomePitchOwnerState createState() => _HomePitchOwnerState();
}

class _HomePitchOwnerState extends State<HomePitchOwner>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 4, initialIndex: widget.index);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

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

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final page = [const PitchOwnerHome(), const Booking(), NotificationScreen(), const Account()];

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        return onWillPop();
      },
      child: Material(
          child: Scaffold(
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: widget.index,
          onTap: (index) {
            widget.index = index;
            setState(() {});
          },
          selectedItemColor: const Color(0xffffc300),
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
              selectedColor: const Color(0xffffc300),
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.airplane_ticket_outlined,
              ),
              title: Text(
                AppLocalizations.of(context)!.booking,
                style: const TextStyle(color: Colors.black),
              ),
              activeIcon: const Icon(
                Icons.airplane_ticket,
                color: Colors.black,
              ),
              selectedColor: const Color(0xffffc300),
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
              selectedColor: const Color(0xffffc300),
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
              selectedColor: const Color(0xffffc300),
              unselectedColor: Colors.grey,
            ),
          ],
        ),
        body: page[widget.index],
      )),
    );
  }
}
