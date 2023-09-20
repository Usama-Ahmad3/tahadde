import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/events/events.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/bottomSheet.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/editProfile.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/settings/settings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/listWidgetSettings.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';

class ProfileDrawer extends StatefulWidget {
  String name;
  String position;
  String profileImage;
  bool playerTag;

  ProfileDrawer(
      {super.key,
      required this.name,
      required this.position,
      required this.profileImage,
      this.playerTag = true});

  @override
  State<ProfileDrawer> createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  String msg =
      'hello,this is my App:https://tahadde.page.link?link=https://www.google.com/&apn=com.root.tahadde';

  privacyPolicy(String text) async {
    NetworkCalls().privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  Future onWillPop(String description, bool isLogout) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            backgroundColor: Colors.grey.shade200,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(AppLocalizations.of(context)!.logout),
            content: Text(
              description,
              style: const TextStyle(color: Colors.red),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                  NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      if (isLogout) {
                        NetworkCalls().logout(
                          onSuccess: (msg) {
                            NetworkCalls().clearToken(key: 'token');
                            NetworkCalls().clearToken(key: 'role');
                            NetworkCalls().clearToken(key: "auth");
                            // navigateToHome();
                          },
                          onFailure: (msg) {
                            showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      } else {
                        NetworkCalls().deleteAccount(
                          onSuccess: (msg) {
                            NetworkCalls().clearToken(key: 'token');
                            NetworkCalls().clearToken(key: 'role');
                            NetworkCalls().clearToken(key: "auth");
                            // navigateToHome();
                          },
                          onFailure: (msg) {
                            showMessage(msg);
                          },
                          tokenExpire: () {
                            if (mounted) on401(context);
                          },
                        );
                      }
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                      }
                    }
                  });
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
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? Colors.white
          : const Color(0xff686868),
      body: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        curve: Curves.elasticInOut,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.grey
                      : Colors.white54),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.grey.shade200,
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                          ),
                          Text(
                            widget.position,
                            style: const TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      widget.profileImage.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => CupertinoAlertDialog(
                                    content: Container(
                                      height: height * 0.25,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  widget.profileImage))),
                                    ),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                  radius: height * 0.06,
                                  backgroundImage:
                                      NetworkImage(widget.profileImage)),
                            )
                          : CircleAvatar(
                              radius: height * 0.06,
                              backgroundImage:
                                  const AssetImage("assets/images/profile.png"),
                            )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(AppLocalizations.of(context)!.account),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ...List.generate(
                      widget.playerTag ? 5 : 3,
                      (index) => widget.playerTag
                          ? Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: ListTile(
                                onTap: index == 0
                                    ? () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const EditProfileScreen()));
                                      }
                                    : index == 1
                                        ? () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        EventsScreen(
                                                          bookingTag: true,
                                                        )));
                                          }
                                        : index == 2
                                            ? () {
                                                Navigator.pushNamed(context,
                                                    RouteNames.myInterest);
                                              }
                                            : index == 3
                                                ? () {
                                                    Navigator.pushNamed(context,
                                                        RouteNames.rate);
                                                  }
                                                : () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                SettingsScreen(
                                                                  bookingTag:
                                                                      true,
                                                                )));
                                                  },
                                titleAlignment: ListTileTitleAlignment.center,
                                tileColor: MyAppState.mode == ThemeMode.light
                                    ? Colors.grey.shade200
                                    : Colors.black12,
                                shape: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white12),
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(
                                  icon[index],
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                titleTextStyle: const TextStyle(
                                    leadingDistribution:
                                        TextLeadingDistribution.even),
                                title: Text(
                                  title[index],
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 14),
                                ),
                                subtitle: Text(
                                  subtitle[index],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                trailing: Icon(
                                  AppLocalizations.of(context)!.locale == 'en'
                                      ? Icons.keyboard_arrow_right
                                      : Icons.keyboard_arrow_left,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )
                          : Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: ListTile(
                                onTap: index == 0
                                    ? () {}
                                    : index == 1
                                        ? () {
                                            navigateToMyPitches();
                                          }
                                        : () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        SettingsScreen(
                                                          bookingTag: true,
                                                        )));
                                          },
                                titleAlignment: ListTileTitleAlignment.center,
                                tileColor: MyAppState.mode == ThemeMode.light
                                    ? Colors.grey.shade200
                                    : Colors.black12,
                                shape: OutlineInputBorder(
                                    borderSide:
                                        const BorderSide(color: Colors.white12),
                                    borderRadius: BorderRadius.circular(10)),
                                leading: Icon(
                                  ownerIcon[index],
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                                titleTextStyle: const TextStyle(
                                    leadingDistribution:
                                        TextLeadingDistribution.even),
                                title: Text(
                                  ownerTitle[index],
                                  style: TextStyle(
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 14),
                                ),
                                subtitle: Text(
                                  ownerSubtitle[index],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white),
                                ),
                                trailing: Icon(
                                  AppLocalizations.of(context)!.locale == 'en'
                                      ? Icons.keyboard_arrow_right
                                      : Icons.keyboard_arrow_left,
                                  color: MyAppState.mode == ThemeMode.light
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(AppLocalizations.of(context)!.support),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      tileColor: MyAppState.mode == ThemeMode.light
                          ? Colors.grey.shade200
                          : Colors.black12,
                      onTap: () {
                        BottomSheett.settingModalBottomSheet(context, height);
                      },
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white12),
                          borderRadius: BorderRadius.circular(10)),
                      leading: Icon(
                        Icons.help,
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      style: ListTileStyle.list,
                      titleTextStyle: const TextStyle(
                          leadingDistribution: TextLeadingDistribution.even),
                      title: Text(
                        AppLocalizations.of(context)!.help,
                        style: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 14),
                      ),
                      trailing: Icon(
                        AppLocalizations.of(context)!.locale == 'en'
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_left,
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(AppLocalizations.of(context)!.legal),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  ...List.generate(
                      2,
                      (index) => Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.01),
                            child: ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              tileColor: MyAppState.mode == ThemeMode.light
                                  ? Colors.grey.shade200
                                  : Colors.black12,
                              onTap: index == 0
                                  ? () {
                                      privacyPolicy("terms_and_conditions_url");
                                    }
                                  : () {
                                      privacyPolicy("privacy_policy_url");
                                    },
                              shape: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white12),
                                  borderRadius: BorderRadius.circular(10)),
                              leading: Icon(
                                iconList[index],
                                color: MyAppState.mode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              style: ListTileStyle.list,
                              titleTextStyle: const TextStyle(
                                  leadingDistribution:
                                      TextLeadingDistribution.even),
                              title: Text(
                                listTitle[index],
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14),
                              ),
                              trailing: Icon(
                                AppLocalizations.of(context)!.locale == 'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                color: MyAppState.mode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      tileColor: MyAppState.mode == ThemeMode.light
                          ? Colors.grey.shade200
                          : Colors.black12,
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white12),
                          borderRadius: BorderRadius.circular(10)),
                      leading: const Icon(
                        Icons.logout_sharp,
                        color: Colors.red,
                      ),
                      onTap: () {
                        onWillPop(
                            AppLocalizations.of(context)!.areYouSure, true);
                      },
                      style: ListTileStyle.list,
                      titleTextStyle: const TextStyle(
                          leadingDistribution: TextLeadingDistribution.even),
                      title: Text(
                        AppLocalizations.of(context)!.logout,
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      trailing: Icon(
                        AppLocalizations.of(context)!.locale == 'en'
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_left,
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigateToMyPitches() {
    Navigator.pushNamed(context, RouteNames.myVenues);
  }

  List icon = [
    Icons.person,
    Icons.sports_baseball_outlined,
    Icons.interests_outlined,
    Icons.rate_review_outlined,
    Icons.settings
  ];
  List ownerIcon = [
    FontAwesomeIcons.bank,
    FontAwesomeIcons.flag,
    Icons.settings
  ];
  List title = [
    AppLocalizations().editProfile,
    AppLocalizations().bookingDetails,
    AppLocalizations().yourInterest,
    AppLocalizations().myReviewsRatings,
    AppLocalizations().setting
  ];
  List ownerTitle = [
    AppLocalizations().bankDetails,
    AppLocalizations().myBooking,
    AppLocalizations().setting
  ];
  List subtitle = [
    AppLocalizations().nameEmail,
    AppLocalizations().bookingVenue,
    'payment,methods,transactions',
    AppLocalizations().ratingsReviews,
    AppLocalizations().languageTheme
  ];
  List ownerSubtitle = [
    'payment,methods,transactions',
    AppLocalizations().bookingVenue,
    AppLocalizations().languageTheme
  ];
  List listTitle = [
    AppLocalizations().termsofUse,
    AppLocalizations().privacyPolicy
  ];
  List iconList = [Icons.verified_user_outlined, Icons.privacy_tip_outlined];
}
