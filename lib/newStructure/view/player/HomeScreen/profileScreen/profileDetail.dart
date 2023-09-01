import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/bottomSheet.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/emailContactsFields.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/passwordSecurityFields.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileShimmer.dart';
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
          ? ProfileShimmer.buildShimmer(width, height, context)
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
                                constant:
                                    '${AppLocalizations.of(context)!.email} :',
                                constantValue: profileDetail!['email'],
                              ),
                              EmailContactDOB(
                                  constant:
                                      '${AppLocalizations.of(context)!.dateofBirth} :',
                                  constantValue: profileDetail!['dob'] ??
                                      AppLocalizations.of(context)!
                                          .dateofBirth),
                              EmailContactDOB(
                                constant:
                                    '${AppLocalizations.of(context)!.contacts} :',
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
                                  title: AppLocalizations.of(context)!
                                      .changepassword,
                                  suffixIcon:
                                      AppLocalizations.of(context)!.locale ==
                                              'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  BottomSheett.settingModalBottomSheet(
                                      context, height);
                                },
                                child: PasswordSecurity(
                                  prefixIcon: Icons.support_agent,
                                  title: AppLocalizations.of(context)!.support,
                                  suffixIcon:
                                      AppLocalizations.of(context)!.locale ==
                                              'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  privacyPolicy();
                                },
                                child: PasswordSecurity(
                                  prefixIcon: Icons.security,
                                  title: AppLocalizations.of(context)!.security,
                                  suffixIcon:
                                      AppLocalizations.of(context)!.locale ==
                                              'en'
                                          ? Icons.keyboard_arrow_right
                                          : Icons.keyboard_arrow_left,
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
