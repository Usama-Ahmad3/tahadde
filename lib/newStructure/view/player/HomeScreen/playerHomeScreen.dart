import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/home-screen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/NotificationScreen/notification.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileDetail.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../constant.dart';
import '../../../../homeFile/home.dart';
import '../../../../homeFile/more.dart';
import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../player/loginSignup/profile/profile.dart';
import '../../light-design/profile.dart';

class PlayerHomeScreen extends StatefulWidget {
  int index;

  PlayerHomeScreen({super.key, required this.index});

  @override
  // ignore: no_logic_in_create_state
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _handleTabSelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  initDynamicLinks() async {
    bool _auth = await checkAuthorizaton() as bool;
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink = data != null ? data.link : Uri.parse('uri');
    if (deepLink != null && deepLink.queryParameters["token"] != null) {
      if (!_auth) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteNames.forgotPasswordScreen,
            arguments: deepLink.queryParameters["token"]);
      }
    } else if (deepLink != null &&
        deepLink.queryParameters["event_details"] == "pitch_details") {
      navigateToBookPitchDetail(
          int.parse(deepLink.queryParameters["pk"] ?? ''));
    } else if (deepLink != null &&
        deepLink.queryParameters["event_details"] == "league_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "League"
      };
      navigateToLeagueDetail(detail);
    } else if (deepLink != null &&
        deepLink.queryParameters["event_details"] == "tournament_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "Tournament"
      };
      navigateToLeagueDetail(detail);
    }
    FirebaseDynamicLinks.instance.onLink;
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    _tabController =
        TabController(vsync: this, length: 4, initialIndex: widget.index);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(AppLocalizations.of(context)!.youGoingExit),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  final page = [
    HomeScreenView(),
    const NotificationScreen(),
    ProfileScreen(msg: 'msg'),
    More()
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
                selectedItemColor: const Color(0xffffc300),
                backgroundColor: Colors.black,
                selectedColorOpacity: 1,
                curve: Curves.bounceInOut,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    title: const Text(
                      "Home",
                      style: TextStyle(color: Colors.black),
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
                      Icons.notifications_none,
                    ),
                    title: const Text(
                      "Notification",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    selectedColor: const Color(0xffffc300),
                    unselectedColor: Colors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    selectedColor: const Color(0xffffc300),
                    unselectedColor: Colors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    title: const Text(
                      "More",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    selectedColor: const Color(0xffffc300),
                    unselectedColor: Colors.grey,
                  ),
                ],
              ),
              // Container(
              //   padding: Platform.isIOS
              //       ? const EdgeInsets.only(bottom: 10)
              //       : EdgeInsets.zero,
              //   decoration: const BoxDecoration(
              //       color: Colors.white,
              //       border: Border(
              //           top: BorderSide(color: Colors.grey, width: 0.8))),
              //   height: 60,
              //   alignment: Alignment.bottomCenter,
              //   child: TabBar(
              //       labelStyle: const TextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.w700,
              //         fontFamily: 'Poppins',
              //       ),
              //       controller: _tabController,
              //       tabs: [
              //         // Tab(
              //         //   icon: _tabController.index == 0
              //         //       ? Padding(
              //         //           padding: const EdgeInsets.only(top: 5),
              //         //           child: Image.asset(
              //         //             'assets/images/team.png',
              //         //             height: 25,
              //         //           ),
              //         //         )
              //         //       : Padding(
              //         //           padding: const EdgeInsets.only(top: 5),
              //         //           child: Image.asset(
              //         //             'assets/images/teamColor.png',
              //         //             height: 25,
              //         //           ),
              //         //         ),
              //         //   text: AppLocalizations.of(context)!.team
              //         // ),
              //
              //         Tab(
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 0.0),
              //             child: Image.asset(
              //               'assets/images/TC.png',
              //               fit: BoxFit.fill,
              //               color: _tabController.index == 0
              //                   ? const Color(0XFF052040)
              //                   : Colors.grey[500],
              //               height: 25,
              //               // height: 40,
              //               // width: 60,
              //             ),
              //           ),
              //         ),
              //         Tab(
              //           icon: _tabController.index == 1
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/notificationColor.png',
              //                     height: 25,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/notification.png',
              //                     height: 25,
              //                   ),
              //                 ),
              //           // text: AppLocalizations.of(context)!.notification
              //         ),
              //         Tab(
              //           icon: _tabController.index == 2
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/userColor.png',
              //                     height: 25,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/user.png',
              //                     height: 25,
              //                   ),
              //                 ),
              //         ),
              //         Tab(
              //           icon: _tabController.index == 3
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/moreColor.png',
              //                     height: 21,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/more.png',
              //                     height: 21,
              //                   ),
              //                 ),
              //         ),
              //       ],
              //       labelColor: const Color(0XFF032040),
              //       indicatorWeight: 4,
              //       unselectedLabelColor: const Color(0XFF7A7A7A),
              //       indicatorSize: TabBarIndicatorSize.label,
              //       indicatorPadding: const EdgeInsets.only(bottom: 5),
              //       indicatorColor: Colors.transparent
              //       //Color(0XFF032040),
              //       ),
              // ),
              body: page[widget.index],
              // TabBarView(
              //   controller: _tabController,
              //   children: [
              //     // TeamEmpaty(),
              //     HomeScreen(),
              //     NotificationEmpty(),
              //
              //     ProfileScreen(
              //       msg: 'msg'.toString(),
              //     ),
              //     More()
              //   ],
              // )
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
