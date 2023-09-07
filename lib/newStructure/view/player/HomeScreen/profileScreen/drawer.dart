import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/editProfile.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';

class ProfileDrawer extends StatefulWidget {
  const ProfileDrawer({super.key});

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

  void _settingModalBottomSheet(context, sizeHeight) {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        builder: (BuildContext bc) {
          return Container(
            height: sizeHeight * .35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  flaxibleGap(
                    1,
                  ),
                  Text(
                    AppLocalizations.of(context)!.contectUs,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () async {
                      final link = WhatsAppUnilink(
                        text: msg,
                      );
                      await launch("$link");
                      //FlutterShareMe().shareToWhatsApp(base64Image: base64Image, msg: msg);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/whatApp.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.whatsapp,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchInBrowser("http://instagram.com/tahadde");
                      //InstagramShare.share('/', 'image');
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/instagram.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.instagram,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      launch("mailto:info@tahadde.com");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/mailshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.email,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  flaxibleGap(
                    1,
                  ),
                  GestureDetector(
                    onTap: () {
                      makePhoneCall("tel:");
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/callshare.png',
                          height: 20,
                        ),
                        Container(
                          width: 20,
                        ),
                        Text(
                          AppLocalizations.of(context)!.callus,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Container(),
                    flex: 1,
                  ),
                ],
              ),
            ),
          );
        });
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
    var mode = MyAppState.mode;
    return Scaffold(
      backgroundColor:
          mode == ThemeMode.light ? Colors.white : Color(0xff686868),
      body: AnimatedContainer(
        duration: const Duration(microseconds: 300),
        curve: Curves.elasticInOut,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color:
                      mode == ThemeMode.light ? Colors.grey : Colors.white54),
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
                            'Usama Ahmad',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                          ),
                          const Text(
                            'Player Position',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: height * 0.06,
                        backgroundImage:
                            const AssetImage("assets/images/profile.png"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text('Your Account'),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  ...List.generate(
                      4,
                      (index) => Padding(
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
                                          Navigator.pushNamed(
                                              context, RouteNames.myBookings);
                                        }
                                      : index == 2
                                          ? () {
                                              Navigator.pushNamed(context,
                                                  RouteNames.myInterest);
                                            }
                                          : () {
                                              Navigator.pushNamed(
                                                  context, RouteNames.more);
                                            },
                              titleAlignment: ListTileTitleAlignment.center,
                              tileColor: mode == ThemeMode.light
                                  ? Colors.grey.shade200
                                  : Colors.black12,
                              shape: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.white12),
                                  borderRadius: BorderRadius.circular(10)),
                              leading: Icon(
                                icon[index],
                                color: mode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                              titleTextStyle: const TextStyle(
                                  leadingDistribution:
                                      TextLeadingDistribution.even),
                              title: Text(
                                title[index],
                                style: TextStyle(
                                    color: mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14),
                              ),
                              subtitle: Text(
                                subtitle[index],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white),
                              ),
                              trailing: Icon(
                                AppLocalizations.of(context)!.locale == 'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                color: mode == ThemeMode.light
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          )),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  const Text('Support'),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.01),
                    child: ListTile(
                      titleAlignment: ListTileTitleAlignment.center,
                      tileColor: mode == ThemeMode.light
                          ? Colors.grey.shade200
                          : Colors.black12,
                      onTap: () {
                        _settingModalBottomSheet(context, height);
                      },
                      shape: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white12),
                          borderRadius: BorderRadius.circular(10)),
                      leading: Icon(
                        Icons.help,
                        color: mode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                      style: ListTileStyle.list,
                      titleTextStyle: const TextStyle(
                          leadingDistribution: TextLeadingDistribution.even),
                      title: Text(
                        'Help',
                        style: TextStyle(
                            color: mode == ThemeMode.light
                                ? Colors.black
                                : Colors.white,
                            fontSize: 14),
                      ),
                      trailing: Icon(
                        AppLocalizations.of(context)!.locale == 'en'
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_left,
                        color: mode == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text('Legal Information'),
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
                              tileColor: mode == ThemeMode.light
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
                                color: mode == ThemeMode.light
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
                                    color: mode == ThemeMode.light
                                        ? Colors.black
                                        : Colors.white,
                                    fontSize: 14),
                              ),
                              trailing: Icon(
                                AppLocalizations.of(context)!.locale == 'en'
                                    ? Icons.keyboard_arrow_right
                                    : Icons.keyboard_arrow_left,
                                color: mode == ThemeMode.light
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
                      tileColor: mode == ThemeMode.light
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
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                      trailing: Icon(
                        AppLocalizations.of(context)!.locale == 'en'
                            ? Icons.keyboard_arrow_right
                            : Icons.keyboard_arrow_left,
                        color: mode == ThemeMode.light
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

  List icon = [
    Icons.person,
    Icons.sports_baseball_outlined,
    Icons.payments_sharp,
    Icons.settings
  ];
  List title = ['Edit profile', 'Your bookings', 'Your interest', 'Settings'];
  List subtitle = [
    'name, email, phone, location',
    'booking, venues, leagues',
    'payment,methods,transactions',
    'language, theme, configuration'
  ];
  List listTitle = ['Terms of use', 'Privacy policy'];
  List iconList = [Icons.verified_user_outlined, Icons.privacy_tip_outlined];
}
