import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/bookingScreens/bookingWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/owner/home_screens/profile/innovative_bookings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/bookings/bookings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/bottomSheet.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/editProfile.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../../../owner/home_screens/HomePitchOwnerScreen.dart';
import '../playerHomeScreen.dart';
import 'settings/setting_params.dart';
import 'settings/settings.dart';

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
        text == 'privacy_policy_url'
            ? AppLocalizations().locale == 'en'
                ? launchInBrowser(msg[text])
                : launchInBrowser("https://ar.tahadde.ae/privacy-policy")

            ///if terms and conditions
            : AppLocalizations().locale == 'en'
                ? launchInBrowser(msg[text])
                : launchInBrowser("https://ar.tahadde.ae/terms-conditions");
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
            backgroundColor: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.darkTheme,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(
              AppLocalizations.of(context)!.logout,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            contentPadding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.065),
            content: Text(
              description,
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
                      Navigator.pop(context);
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
                            AppLocalizations.of(context)!.yes,
                            style: TextStyle(color: AppColors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NetworkCalls().checkInternetConnectivity(
                          onSuccess: (msg) {
                        if (msg == true) {
                          if (isLogout) {
                            NetworkCalls().logout(
                              onSuccess: (msg) {
                                NetworkCalls().clearToken(key: 'token');
                                NetworkCalls().clearToken(key: 'role');
                                NetworkCalls().clearToken(key: "auth");
                                setState(() {
                                  navigateToHome();
                                });
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
                                navigateToHome();
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
                            showMessage(AppLocalizations.of(context)!
                                .noInternetConnection);
                          }
                        }
                      });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setFun();
  }

  setFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyAppState.mode == ThemeMode.light
          ? AppColors.white
          : AppColors.darkTheme,
      body: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        curve: Curves.elasticInOut,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.grey
                      : AppColors.containerColor54),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.045,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => widget.playerTag
                                  ? PlayerHomeScreen(index: 3)
                                  : HomePitchOwnerScreen(
                                      index: 3,
                                    )));
                    },
                    child: SizedBox(
                      height: height * 0.06,
                      child: Image.asset(
                        'assets/images/back.png',
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.black
                            : AppColors.white,
                      ),
                    ),
                    // child: CircleAvatar(
                    //   backgroundColor: AppColors.grey200,
                    //   backgroundImage: NetworkImage(
                    //       'https://icon-library.com/images/ios-back-icon/ios-back-icon-17.jpg'),
                    //   // child: Icon(
                    //   //   Icons.close,
                    //   //   color: AppColors.black,
                    //   // )
                    // ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.039),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white),
                                ),
                                Text(
                                  widget.position == 'player'
                                      ? AppLocalizations.of(context)!.player
                                      : AppLocalizations.of(context)!
                                          .academyOwner,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white),
                                ),
                              ],
                            ),
                            widget.profileImage.isNotEmpty
                                ? InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) =>
                                            CupertinoAlertDialog(
                                          content: Container(
                                            height: height * 0.3,
                                            width: width,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
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
                                    backgroundImage: const AssetImage(
                                        "assets/images/profile.png"),
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
                            widget.playerTag ? 5 : 4,
                            (index) => widget.playerTag
                                ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
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
                                                              PlayerBookingScreen(
                                                                bookingTag:
                                                                    true,
                                                              )));
                                                }
                                              : index == 2
                                                  ? () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          RouteNames
                                                              .myInterest);
                                                    }
                                                  : index == 3
                                                      ? () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              RouteNames.rate);
                                                        }
                                                      : () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) =>
                                                                      SettingsScreen(
                                                                        settingParams: SettingParams(
                                                                            name:
                                                                                widget.name,
                                                                            playerTag: widget.playerTag,
                                                                            position: widget.position,
                                                                            profileImage: widget.profileImage),
                                                                        bookingTag:
                                                                            true,
                                                                      )));
                                                        },
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      tileColor:
                                          MyAppState.mode == ThemeMode.light
                                              ? AppColors.grey200
                                              : AppColors.containerColorW12,
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.containerColorW12),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      horizontalTitleGap: width * 0.015,
                                      leading: Icon(
                                        icon[index],
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
                                      ),
                                      titleTextStyle: const TextStyle(
                                          leadingDistribution:
                                              TextLeadingDistribution.even),
                                      title: Text(
                                        title[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontSize: 14),
                                      ),
                                      // subtitle: Text(
                                      //   subtitle[index].length > 24
                                      //       ? "${subtitle[index].toString().substring(0, 25)}..."
                                      //       : subtitle[index],
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleSmall!
                                      //       .copyWith(
                                      //           color: MyAppState.mode ==
                                      //                   ThemeMode.light
                                      //               ? AppColors.black
                                      //               : AppColors.white),
                                      // ),
                                      trailing: Icon(
                                        AppLocalizations.of(context)!.locale ==
                                                'en'
                                            ? Icons.keyboard_arrow_right
                                            : Icons.keyboard_arrow_left,
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: height * 0.01),
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
                                                  navigateToMyPitches();
                                                }
                                              : index == 2
                                                  ? () {
                                                      navigateToInnovativeBookings();
                                                    }
                                                  : () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  SettingsScreen(
                                                                    settingParams: SettingParams(
                                                                        name: widget
                                                                            .name,
                                                                        playerTag:
                                                                            widget
                                                                                .playerTag,
                                                                        position:
                                                                            widget
                                                                                .position,
                                                                        profileImage:
                                                                            widget.profileImage),
                                                                    bookingTag:
                                                                        true,
                                                                  )));
                                                    },
                                      titleAlignment:
                                          ListTileTitleAlignment.center,
                                      tileColor:
                                          MyAppState.mode == ThemeMode.light
                                              ? AppColors.grey200
                                              : AppColors.containerColorW12,
                                      shape: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  AppColors.containerColorW12),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      horizontalTitleGap: width * 0.015,
                                      leading: Icon(
                                        ownerIcon[index],
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
                                      ),
                                      titleTextStyle: const TextStyle(
                                          leadingDistribution:
                                              TextLeadingDistribution.even),
                                      title: Text(
                                        ownerTitle[index],
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white,
                                                fontSize: 14),
                                      ),
                                      // subtitle: Text(
                                      //   ownerSubtitle[index].length > 24
                                      //       ? "${ownerSubtitle[index].toString().substring(0, 25)}..."
                                      //       : ownerSubtitle[index],
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .titleSmall!
                                      //       .copyWith(
                                      //           color: MyAppState.mode ==
                                      //                   ThemeMode.light
                                      //               ? AppColors.black
                                      //               : AppColors.white),
                                      // ),
                                      trailing: Icon(
                                        AppLocalizations.of(context)!.locale ==
                                                'en'
                                            ? Icons.keyboard_arrow_right
                                            : Icons.keyboard_arrow_left,
                                        color:
                                            MyAppState.mode == ThemeMode.light
                                                ? AppColors.black
                                                : AppColors.white,
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
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            tileColor: MyAppState.mode == ThemeMode.light
                                ? AppColors.grey200
                                : AppColors.containerColorW12,
                            onTap: () {
                              BottomSheett.settingModalBottomSheet(
                                  context, height);
                            },
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.containerColorW12),
                                borderRadius: BorderRadius.circular(10)),
                            leading: Icon(
                              Icons.help,
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                            horizontalTitleGap: width * 0.015,
                            style: ListTileStyle.list,
                            titleTextStyle: const TextStyle(
                                leadingDistribution:
                                    TextLeadingDistribution.even),
                            title: Text(
                              AppLocalizations.of(context)!.help,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.black
                                        : AppColors.white,
                                  ),
                            ),
                            trailing: Icon(
                              AppLocalizations.of(context)!.locale == 'en'
                                  ? Icons.keyboard_arrow_right
                                  : Icons.keyboard_arrow_left,
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
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
                                  padding: EdgeInsets.symmetric(
                                      vertical: height * 0.01),
                                  child: ListTile(
                                    horizontalTitleGap: width * 0.015,
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    tileColor:
                                        MyAppState.mode == ThemeMode.light
                                            ? AppColors.grey200
                                            : AppColors.containerColorW12,
                                    onTap: index == 0
                                        ? () {
                                            privacyPolicy(
                                                "terms_and_conditions_url");
                                          }
                                        : () {
                                            privacyPolicy("privacy_policy_url");
                                          },
                                    shape: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: Icon(
                                      iconList[index],
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                    style: ListTileStyle.list,
                                    titleTextStyle: const TextStyle(
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    title: Text(
                                      listTitle[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white,
                                              fontSize: 14),
                                    ),
                                    trailing: Icon(
                                      AppLocalizations.of(context)!.locale ==
                                              'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                  ),
                                )),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: height * 0.01),
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            tileColor: MyAppState.mode == ThemeMode.light
                                ? AppColors.grey200
                                : AppColors.containerColorW12,
                            shape: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.containerColorW12),
                                borderRadius: BorderRadius.circular(10)),
                            horizontalTitleGap: width * 0.015,
                            leading: Icon(
                              Icons.logout_sharp,
                              color: AppColors.red,
                            ),
                            onTap: () {
                              onWillPop(
                                  AppLocalizations.of(context)!.areYouSure,
                                  true);
                            },
                            style: ListTileStyle.list,
                            titleTextStyle: const TextStyle(
                                leadingDistribution:
                                    TextLeadingDistribution.even),
                            title: Text(
                              AppLocalizations.of(context)!.logout,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: AppColors.red),
                            ),
                            trailing: Icon(
                              AppLocalizations.of(context)!.locale == 'en'
                                  ? Icons.keyboard_arrow_right
                                  : Icons.keyboard_arrow_left,
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        )
                      ],
                    ),
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => BookingWidget(
                  fromDrawer: true,
                )));
    // Navigator.pushNamed(context, RouteNames.myVenues);
  }

  void navigateToBankDetail() {
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => BankDetailScreen()));
    // Navigator.pushNamed(context, RouteNames.myVenues);
  }

  List icon = [
    Icons.person,
    Icons.sports_baseball_outlined,
    Icons.interests_outlined,
    Icons.rate_review_outlined,
    Icons.settings
  ];
  List ownerIcon = [
    Icons.person,
    Icons.library_books_outlined,
    Icons.admin_panel_settings_outlined,
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
    AppLocalizations().editProfile,
    AppLocalizations().myBooking,
    AppLocalizations().innovativeBookings,
    AppLocalizations().setting
  ];
  List subtitle = [
    AppLocalizations().nameEmail,
    AppLocalizations().bookingAcademy,
    AppLocalizations().paymentTransaction,
    AppLocalizations().ratingsReviews,
    AppLocalizations().languageTheme
  ];
  List ownerSubtitle = [
    AppLocalizations().nameEmail,
    AppLocalizations().bookingAcademy,
    AppLocalizations().languageTheme
  ];
  List listTitle = [
    AppLocalizations().termsofUse,
    AppLocalizations().privacyPolicy
  ];
  List iconList = [Icons.verified_user_outlined, Icons.privacy_tip_outlined];
  navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PlayerHomeScreen(index: 0)));
  }

  navigateToInnovativeBookings() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const InnovativeBookings(),
        ));
  }
}
