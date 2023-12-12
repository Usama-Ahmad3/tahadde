import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/network/network_calls.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/home-screen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/bookings/bookings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/settings/settings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../../homeFile/routingConstant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../modelClass/cart_model.dart';
import '../../../app_colors/app_colors.dart';
import 'cart_screen/cart_screen.dart';

class PlayerHomeScreen extends StatefulWidget {
  int index;

  PlayerHomeScreen({super.key, required this.index});

  @override
  // ignore: no_logic_in_create_state
  _PlayerHomeScreenState createState() => _PlayerHomeScreenState();
}

class _PlayerHomeScreenState extends State<PlayerHomeScreen> {
  List<CartModel> cartModel = [];
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
    } else if (deepLink.queryParameters["event_details"] ==
        "tournament_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "Tournament"
      };
      navigateToLeagueDetail(detail);
    }
    FirebaseDynamicLinks.instance.onLink;
  }

  getCartAcademies() async {
    await NetworkCalls().getCartAcademy(
        onSuccess: (detail) {
          for (int i = 0; i < detail.length; i++) {
            cartModel.add(CartModel.fromJson(detail[i]));
          }
          setState(() {});
        },
        onFailure: (onFailure) {},
        tokenExpire: () {});
  }

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
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            content: Text(
              AppLocalizations.of(context)!.youGoingExit,
              style: const TextStyle(color: AppColors.appThemeColor),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(false);
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
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
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop(true);

                  ///close the app
                  exit(0);
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.appThemeColor,
                      border:
                          Border.all(width: 1, color: AppColors.transparent),
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
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartAcademies();
  }

  final page = [
    const HomeScreenView(),
    PlayerBookingScreen(bookingTag: false),
    const CartScreen(),
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
            color: AppColors.appThemeColor,
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
                      width: 22,
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
                      width: 22,
                      child: Image.asset(
                        'assets/images/file.png',
                        color: AppColors.white,
                      ),
                    ),
                    selectedColor: AppColors.appThemeColor,
                    unselectedColor: AppColors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon:cartModel.length == 0? Badge(
                      alignment: Alignment.topRight,
                      textColor: AppColors.red,
                      label: Text(
                        cartModel.length.toString(),
                        style: TextStyle(color: AppColors.white),
                      ),
                      child:const SizedBox(
                          height: 23,
                          width: 22,
                          child: Icon(Icons.add_shopping_cart)),
                    ):const SizedBox(
                        height: 23,
                        width: 22,
                        child: Icon(Icons.add_shopping_cart)),
                    title: Text(
                      AppLocalizations.of(context)!.cart,
                      style: TextStyle(color: AppColors.white),
                    ),
                    activeIcon:cartModel.length == 0? Badge(
                      alignment: Alignment.topRight,
                      textColor: AppColors.red,
                      label: Text(
                        cartModel.length.toString(),
                        style: TextStyle(color: AppColors.white),
                      ),
                      child: const SizedBox(
                        height: 23,
                        width: 22,
                        child: Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                        ),
                      ),
                    ):SizedBox.shrink(),
                    selectedColor: AppColors.appThemeColor,
                    unselectedColor: AppColors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    title: Text(
                      AppLocalizations.of(context)!.more,
                      style: TextStyle(color: AppColors.white),
                    ),
                    activeIcon: Icon(
                      Icons.settings,
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
