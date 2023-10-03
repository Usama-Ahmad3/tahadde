import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/home-screen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/settings/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../constant.dart';
import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import 'events/events.dart';

class PlayerHomeScreen extends StatefulWidget {
  int index;

  PlayerHomeScreen({super.key, required this.index});

  @override
  // ignore: no_logic_in_create_state
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  initDynamicLinks() async {
    bool auth = await checkAuthorizaton() as bool;
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink = data != null ? data.link : Uri.parse('uri');
    if (deepLink.queryParameters["token"] != null) {
      if (!auth) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteNames.forgotPasswordScreen,
            arguments: deepLink.queryParameters["token"]);
      }
    } else if (deepLink.queryParameters["event_details"] == "pitch_details") {
      navigateToBookPitchDetail(
          int.parse(deepLink.queryParameters["pk"] ?? ''));
    } else if (deepLink.queryParameters["event_details"] == "league_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "League"
      };
      navigateToLeagueDetail(detail);
    } else if (deepLink.queryParameters["event_details"] == "tournament_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "Tournament"
      };
      navigateToLeagueDetail(detail);
    }
    FirebaseDynamicLinks.instance.onLink;
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

  final page = [
    const HomeScreenView(),
    EventsScreen(bookingTag: false),
    SettingsScreen(bookingTag: false),
    // ignore: prefer_const_constructors
    ProfileDetailScreen()
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
                      Icons.settings_outlined,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.more,
                      style: const TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.settings,
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
                      AppLocalizations.of(context)!.personalDetail,
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
      ),
    );
  }

  void navigateToBookPitchDetail(dynamic bookPitchData) {
    Navigator.pushNamed(context, RouteNames.bookPitch,
        arguments: bookPitchData);
  }

  void navigateToLeagueDetail(Map leaguedata) {
    Navigator.pushNamed(context, RouteNames.league, arguments: leaguedata);
  }
}
