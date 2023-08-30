import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/emailContactsFields.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/passwordSecurityFields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../player/loginSignup/profile/profileEmpty.dart';

class ProfileDetailScreen extends StatefulWidget {
  const ProfileDetailScreen({super.key});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  String msg =
      'hello,this is my App:https://tahadde.page.link?link=https://www.google.com/&apn=com.root.tahadde';
  bool _internet = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  bool _auth = false;
  Map? profileDetail;
  SharedPreferences? pref;

  loadProfile() async {
    _auth = (await checkAuthorizaton())!;
    _auth
        ? _networkCalls.getProfile(
            onSuccess: (msg) {
              if (mounted) {
                setState(() {
                  profileDetail = msg;
                  _isLoading = false;
                });
              }
            },
            onFailure: (msg) {
              if (mounted) showMessage(msg);
            },
            tokenExpire: () {
              if (mounted) on401(context);
            },
          )
        : {
            if (mounted)
              setState(() {
                _isLoading = false;
              })
          };
  }

  privacyPolicy() async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg["privacy_policy_url"]);
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
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(description),
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
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    if (msg == true) {
                      if (isLogout) {
                        _networkCalls.logout(
                          onSuccess: (msg) {
                            _networkCalls.clearToken(key: 'token');
                            _networkCalls.clearToken(key: 'role');
                            _networkCalls.clearToken(key: "auth");
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
                        _networkCalls.deleteAccount(
                          onSuccess: (msg) {
                            _networkCalls.clearToken(key: 'token');
                            _networkCalls.clearToken(key: 'role');
                            _networkCalls.clearToken(key: "auth");
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
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      msg
          ? loadProfile()
          : setState(() {
              _isLoading = false;
            });
    });
    super.initState();
    // ignore: avoid_types_as_parameter_names
    // WidgetsBinding.instance.addPostFrameCallback((Duration) {
    //   if (widget.msg == 'Password has been reset') {
    //     showMessage(widget.msg);
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    var mode = MyAppState.mode;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor:
          mode == ThemeMode.light ? Color(0xffffffff) : Color(0xff686868),
      body: _isLoading
          ? _buildShimmer(width, height)
          : _internet
              ? _auth
                  ? SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                height: height * 0.25,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/light-design/images/bg-image.png'),
                                        fit: BoxFit.fitWidth)),
                              ),
                              SizedBox(
                                height: height * 0.08,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.06),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.025,
                                          color: mode == ThemeMode.light
                                              ? Colors.black
                                              : Colors.white),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        navigateToEditProfile();
                                      },
                                      child: CircleAvatar(
                                        radius: height * 0.018,
                                        backgroundColor: mode == ThemeMode.light
                                            ? Colors.grey.shade200
                                            : Colors.yellowAccent,
                                        child: Icon(
                                          Icons.edit,
                                          size: height * 0.02,
                                          color: mode == ThemeMode.light
                                              ? Colors.black
                                              : Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * 0.04,
                              ),
                              EmailContactDOB(
                                constant: 'Email :',
                                constantValue: profileDetail!['email'],
                              ),
                              EmailContactDOB(
                                  constant: 'DOB :',
                                  constantValue: profileDetail!['dob'] ??
                                      AppLocalizations.of(context)!
                                          .dateofBirth),
                              EmailContactDOB(
                                constant: 'Contact :',
                                constantValue: AppLocalizations.of(context)!
                                            .locale ==
                                        "en"
                                    ? "${profileDetail!['countryCode'] ?? ""}${profileDetail!['contact_number'] ?? ""}"
                                    : "${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(1)}${profileDetail!['contact_number'] ?? ""}${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(0, 1)}",
                              ),
                              InkWell(
                                onTap: () {
                                  navigateToChangePassword();
                                },
                                child: PasswordSecurity(
                                  prefixIcon: Icons.key,
                                  title: 'Change Password',
                                  suffixIcon: Icons.keyboard_arrow_right,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  _settingModalBottomSheet(context, height);
                                },
                                child: PasswordSecurity(
                                  prefixIcon: Icons.support_agent,
                                  title: 'Support',
                                  suffixIcon: Icons.keyboard_arrow_right,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  privacyPolicy();
                                },
                                child: PasswordSecurity(
                                  prefixIcon: Icons.security,
                                  title: 'Security',
                                  suffixIcon: Icons.keyboard_arrow_right,
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                              top: height * 0.186,
                              left: 0,
                              right: width * 0.67,
                              child: profileDetail!['profile_pic'] != null
                                  ? CircleAvatar(
                                      radius: height * 0.06,
                                      backgroundImage: NetworkImage(
                                          profileDetail!['profile_pic']
                                              ['filePath']))
                                  : CircleAvatar(
                                      radius: height * 0.06,
                                      backgroundImage: const AssetImage(
                                          "assets/images/profile.png"),
                                    ))
                        ],
                      ),
                    )
                  : ProfileEmpty()
              : Scaffold(
                  body: Column(
                    children: [
                      buildAppBar(
                          language: AppLocalizations.of(context)!.locale,
                          title: AppLocalizations.of(context)!.profileC,
                          height: height,
                          width: width),
                      Expanded(
                        child: InternetLoss(
                          onChange: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              _internet = msg;
                              msg
                                  ? loadProfile()
                                  : setState(() {
                                      _isLoading = false;
                                    });
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: sizeHeight * 0.25,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/light-design/images/bg-image.png'),
                            fit: BoxFit.fitWidth)),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.08,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: sizeHeight * 0.025),
                        ),
                        CircleAvatar(
                          radius: sizeHeight * 0.018,
                          backgroundColor: Colors.grey.shade200,
                          child: Icon(
                            Icons.edit,
                            size: sizeHeight * 0.02,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: sizeHeight * 0.04,
                  ),
                  EmailContactDOB(
                    constant: 'Email :',
                    constantValue: 'Email',
                  ),
                  EmailContactDOB(
                      constant: 'DOB :',
                      constantValue: AppLocalizations.of(context)!.dateofBirth),
                  EmailContactDOB(
                    constant: 'Contact :',
                    constantValue: '0000-0000-0000',
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.key,
                    title: 'Change Password',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.support_agent,
                    title: 'Support',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                  PasswordSecurity(
                    prefixIcon: Icons.security,
                    title: 'Security',
                    suffixIcon: Icons.keyboard_arrow_right,
                  ),
                ],
              ),
              Positioned(
                  top: sizeHeight * 0.186,
                  left: 0,
                  right: sizeWidth * 0.67,
                  child: CircleAvatar(
                    radius: sizeHeight * 0.06,
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteNames.playerHome, (r) => false);
  }

  void navigateToEditProfile() {
    Navigator.pushNamed(context, RouteNames.editProfile);
  }

  void navigateToChangePassword() {
    Navigator.pushNamed(context, RouteNames.resetPassword);
  }
}
