import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/listWidgetSettings.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../common_widgets/localeHelper.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../main.dart';
import '../../../../../network/network_calls.dart';
import '../profileScreen/bottomSheet.dart';

class SettingsScreen extends StatefulWidget {
  bool bookingTag;

  SettingsScreen({super.key, this.bookingTag = false});

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
                            navigateToHome();
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
            backgroundColor: Colors.black54,
            appBar: PreferredSize(
              preferredSize: Size(width, height * 0.1),
              child: AppBar(
                title: Text(
                  AppLocalizations.of(context)!.setting,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.black45,
                leadingWidth: width * 0.18,
                leading: widget.bookingTag
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(height * 0.008),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  shape: BoxShape.circle),
                              child: const Center(
                                child: FaIcon(
                                  FontAwesomeIcons.close,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      )
                    : Container(),
              ),
            ),
            body: DefaultTextStyle(
                style: TextStyle(
                    fontSize: height * 0.02,
                    color: MyAppState.mode == ThemeMode.light
                        ? Colors.grey
                        : Colors.white),
                child: Container(
                  color: Colors.black54,
                  child: Container(
                    height: height,
                    decoration: BoxDecoration(
                        color: MyAppState.mode == ThemeMode.light
                            ? Colors.white
                            : const Color(0xff686868),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06, vertical: height * 0.02),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ...List.generate(
                                _auth ? 2 : 3,
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
                                                      BottomSheett
                                                          .settingModalBottomSheet(
                                                              context, height);
                                                    }
                                                  : () {
                                                      privacyPolicy(
                                                          "privacy_policy_url");
                                                    }
                                              : () {
                                                  privacyPolicy(
                                                      "privacy_policy_url");
                                                },
                                      title: title[_auth ? index + 1 : index],
                                      icon: icon[_auth ? index + 1 : index],
                                    )),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(vertical: height * 0.01),
                              child: Container(
                                height: height * 0.09,
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? Colors.grey.shade200
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Center(
                                  child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    tileColor:
                                        MyAppState.mode == ThemeMode.light
                                            ? Colors.grey.shade200
                                            : Colors.black12,
                                    onTap: () {
                                      BottomSheett.settingModalBottomSheet(
                                          context, height);
                                    },
                                    shape: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: Icon(
                                      Icons.sign_language_outlined,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    titleTextStyle: const TextStyle(
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    title: Text(
                                      AppLocalizations.of(context)!.language,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? Colors.black
                                                  : Colors.white,
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
                                                      ? const Color(0XFFB7B7B7)
                                                      : darkMode
                                                          ? Colors.white
                                                          : const Color(
                                                              0xFF032040))),
                                          Switch(
                                            value: isSwitched,
                                            inactiveTrackColor:
                                                Colors.amber.shade200,
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
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? const Color(0xffffc300)
                                                    : Colors.grey,
                                            inactiveThumbColor:
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? Colors.grey
                                                    : const Color(0xffffc300),
                                          ),
                                          Text(
                                            'En',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: isSwitched
                                                    ? darkMode
                                                        ? Colors.white
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
                                        ? Colors.grey.shade200
                                        : Colors.black12,
                                    borderRadius: BorderRadius.circular(13)),
                                child: Center(
                                  child: ListTile(
                                    titleAlignment:
                                        ListTileTitleAlignment.center,
                                    tileColor:
                                        MyAppState.mode == ThemeMode.light
                                            ? Colors.grey.shade200
                                            : Colors.black12,
                                    onTap: () {
                                      BottomSheett.settingModalBottomSheet(
                                          context, height);
                                    },
                                    shape: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.white12),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    leading: Icon(
                                      Icons.dark_mode,
                                      color: MyAppState.mode == ThemeMode.light
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    titleTextStyle: const TextStyle(
                                        leadingDistribution:
                                            TextLeadingDistribution.even),
                                    title: Text(
                                      AppLocalizations.of(context)!.darkMode,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? Colors.black
                                                  : Colors.white,
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
                                                      ? const Color(0XFFB7B7B7)
                                                      : const Color(
                                                          0xFF032040))),
                                          Switch(
                                            value: darkMode,
                                            inactiveTrackColor: Colors.black,
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
                                                const Color(0xffffc300),
                                            inactiveThumbColor: Colors.grey,
                                          ),
                                          Text('On',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: darkMode
                                                      ? Colors.white
                                                      : const Color(
                                                          0XFFB7B7B7)))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
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
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              borderRadius:
                                                  BorderRadius.circular(13)),
                                          child: Center(
                                            child: ListTile(
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              tileColor: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? Colors.grey.shade200
                                                  : Colors.black12,
                                              shape: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white12),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              leading: Icon(
                                                accountIcon[index],
                                                color: Colors.red,
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
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 16),
                                              ),
                                              trailing: Icon(
                                                AppLocalizations.of(context)!
                                                            .locale ==
                                                        'en'
                                                    ? Icons.keyboard_arrow_right
                                                    : Icons.keyboard_arrow_left,
                                                color: MyAppState.mode ==
                                                        ThemeMode.light
                                                    ? Colors.black
                                                    : Colors.white,
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
    AppLocalizations().contectUs,
    AppLocalizations().ourPolicy,
  ];
  List icon = [Icons.calendar_view_day, Icons.call, Icons.policy_rounded];
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
