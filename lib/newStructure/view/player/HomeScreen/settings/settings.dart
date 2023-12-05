import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/drawer.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/listWidgetSettings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../common_widgets/localeHelper.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import '../profileScreen/bottomSheet.dart';
import '../widgets/app_bar.dart';
import 'setting_params.dart';

class SettingsScreen extends StatefulWidget {
  bool bookingTag;
  SettingParams? settingParams;

  SettingsScreen({super.key, this.bookingTag = false, this.settingParams});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _internet = true;
  bool isSwitched = true;
  bool _auth = false;
  bool _isLoading = true;
  bool darkMode = MyAppState.mode == ThemeMode.light ? false : true;

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

  loadProfile() async {
    _auth = (await checkAuthorizaton())!;
    if (_auth) {
      setState(() {
        _isLoading = false;
        AppLocalizations.of(context)!.locale == "en"
            ? isSwitched = true
            : isSwitched = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        AppLocalizations.of(context)!.locale == "en"
            ? isSwitched = true
            : isSwitched = false;
      });
    }
  }

  Future onWillPop(String description, bool isLogout) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 2,
            backgroundColor: AppColors.grey200,
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(isLogout
                ? AppLocalizations.of(context)!.logout
                : AppLocalizations.of(context)!.deleteAccount),
            content: Text(
              description,
              style: const TextStyle(color: AppColors.appThemeColor),
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
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
                  NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
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
                      }
                    } else {
                      if (mounted) {
                        showMessage(
                            AppLocalizations.of(context)!.noInternetConnection);
                      }
                    }
                  });
                },
                child: Center(
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.8,
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
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        if (mounted) {
          setState(() {});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return _internet
        ? Scaffold(
            backgroundColor: Colors.black,
            appBar: appBarWidget(
                sizeWidth: width,
                sizeHeight: height,
                context: context,
                title: AppLocalizations.of(context)!.setting,
                back: widget.bookingTag ? true : false,
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileDrawer(
                          name: widget.settingParams!.name,
                          position: widget.settingParams!.position,
                          profileImage: widget.settingParams!.profileImage,
                          playerTag: widget.settingParams!.playerTag,
                        ),
                      ));
                }),
            body: DefaultTextStyle(
                style: TextStyle(
                    fontSize: height * 0.02,
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.grey
                        : AppColors.white),
                child: Container(
                  color: Colors.black,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? AppColors.white
                            : AppColors.darkTheme,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.059, vertical: height * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                                _auth ? 2 : 4,
                                (index) => ListWidgetSettings(
                                      callback: index == 0
                                          ? _auth == false
                                              ? () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              LoginScreen(
                                                                message: '',
                                                                clicked: 1,
                                                              )));
                                                }
                                              : () {
                                                  BottomSheett
                                                      .settingModalBottomSheet(
                                                          context, height);
                                                }
                                          : index == 1
                                              ? _auth == false
                                                  ? () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  LoginScreen(
                                                                    message: '',
                                                                    clicked: 2,
                                                                  )));
                                                    }
                                                  : () {
                                                      privacyPolicy(
                                                          "privacy_policy_url");
                                                    }
                                              : _auth == false
                                                  ? index == 2
                                                      ? () {
                                                          BottomSheett
                                                              .settingModalBottomSheet(
                                                                  context,
                                                                  height);
                                                        }
                                                      : () {
                                                          privacyPolicy(
                                                              "privacy_policy_url");
                                                        }
                                                  : () {},
                                      title: title[_auth ? index + 2 : index],
                                      icon: icon[_auth ? index + 2 : index],
                                    )),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Container(
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.grey200
                                        : AppColors.containerColorW12,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Center(
                                  child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    tileColor:
                                        MyAppState.mode == ThemeMode.light
                                            ? AppColors.grey200
                                            : AppColors.containerColorB,
                                    onTap: () {
                                      // BottomSheett.settingModalBottomSheet(
                                      //     context, height);
                                    },
                                    horizontalTitleGap: width * 0.015,
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.containerColorB),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: Icon(
                                      Icons.sign_language_outlined,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                    titleTextStyle: const TextStyle(
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white,
                                          fontSize: 14),
                                    ),
                                    trailing: SizedBox(
                                      width: width * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('Ar',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: isSwitched
                                                      ? AppColors.grey
                                                      : darkMode
                                                          ? MyAppState.mode ==
                                                                  ThemeMode
                                                                      .light
                                                              ? AppColors.black
                                                              : AppColors.white
                                                          : const Color(
                                                              0xFF032040))),
                                          Switch(
                                            value: isSwitched,
                                            inactiveTrackColor:
                                                const Color(0xff1d7e55)
                                                    .withOpacity(0.6),
                                            onChanged: (value) {
                                              if (mounted) {
                                                setState(() {
                                                  isSwitched = value;
                                                  isSwitched
                                                      ? helper.onLocaleChanged(
                                                          const Locale("en"))
                                                      : helper.onLocaleChanged(
                                                          const Locale("ar"));
                                                });
                                              }
                                            },
                                            activeColor:
                                                const Color(0xff1d7e55),
                                            inactiveThumbColor:
                                                const Color(0xff1d7e55),
                                          ),
                                          Text(
                                            'En',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: isSwitched
                                                    ? darkMode
                                                        ? MyAppState.mode ==
                                                                ThemeMode.light
                                                            ? Colors.black
                                                            : AppColors.white
                                                        : const Color(
                                                            0xFF032040)
                                                    : const Color(0XFFB7B7B7)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Container(
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.grey200
                                        : AppColors.containerColorW12,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Center(
                                  child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    tileColor:
                                        MyAppState.mode == ThemeMode.light
                                            ? AppColors.grey200
                                            : AppColors.containerColorB,
                                    onTap: () {
                                      // BottomSheett.settingModalBottomSheet(
                                      //     context, height);
                                    },
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.containerColorW12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: Icon(
                                      Icons.dark_mode,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? AppColors.black
                                          : AppColors.white,
                                    ),
                                    horizontalTitleGap: width * 0.015,
                                    titleTextStyle: const TextStyle(
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    title: Text(
                                      AppLocalizations.of(context)!.darkMode,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white,
                                          fontSize: 14),
                                    ),
                                    trailing: SizedBox(
                                      width: width * 0.3,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text('Off',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: darkMode
                                                      ? MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.grey
                                                      : const Color(
                                                          0xFF032040))),
                                          Switch(
                                            value: darkMode,
                                            inactiveTrackColor: AppColors.black,
                                            onChanged: (value) {
                                              if (mounted) {
                                                setState(() {
                                                  darkMode = value;
                                                  darkMode
                                                      ? MyAppState.mode =
                                                          ThemeMode.dark
                                                      : MyAppState.mode =
                                                          ThemeMode.light;
                                                });
                                              }
                                            },
                                            activeColor:
                                                const Color(0xff1d7e55),
                                            inactiveThumbColor: AppColors.grey,
                                          ),
                                          Text('On',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: darkMode
                                                      ? MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.white
                                                      : const Color(
                                                          0XFFB7B7B7)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   height: height * 0.03,
                            // ),
                            ...List.generate(
                                2,
                                (index) => _auth
                                    ? Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.01),
                                        child: Container(
                                          height: height * 0.09,
                                          decoration: BoxDecoration(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.grey200
                                                  : AppColors.containerColorW12,
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Center(
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.grey200
                                                  : AppColors.containerColorB,
                                              shape: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: AppColors
                                                          .containerColorW12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              horizontalTitleGap: width * 0.015,
                                              leading: Icon(
                                                accountIcon[index],
                                                color: AppColors.red,
                                              ),
                                              onTap: index == 0
                                                  ? () {
                                                      onWillPop(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .areYouSure,
                                                          true);
                                                    }
                                                  : () {
                                                      onWillPop(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .youGoingDeleteAccount,
                                                          false);
                                                    },
                                              style: ListTileStyle.list,
                                              titleTextStyle: const TextStyle(
                                                  leadingDistribution:
                                                      TextLeadingDistribution
                                                          .even),
                                              title: Text(
                                                accountTitle[index],
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: AppColors.red,
                                                    ),
                                              ),
                                              trailing: Icon(
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? Icons.keyboard_arrow_right
                                                    : Icons.keyboard_arrow_left,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? AppColors.black
                                                    : AppColors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()),
                            SizedBox(
                              height: height * 0.02,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          )
        : InternetLoss(
            onChange: () {
              NetworkCalls().checkInternetConnectivity(onSuccess: (msg) {
                _internet = msg;
                if (msg == true) {
                } else {
                  if (mounted) {
                    setState(() {});
                  }
                }
              });
            },
          );
  }

  List title = [
    AppLocalizations().login,
    AppLocalizations().signUp,
    AppLocalizations().contectUs,
    AppLocalizations().ourPolicy,
  ];
  List icon = [
    Icons.calendar_view_day,
    Icons.logout_outlined,
    Icons.call,
    Icons.policy_rounded
  ];
  List accountTitle = [
    AppLocalizations().logout,
    AppLocalizations().deleteAccount
  ];
  List accountIcon = [Icons.logout, Icons.delete_forever_outlined];

  navigateToHome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => PlayerHomeScreen(index: 0)));
  }
}
