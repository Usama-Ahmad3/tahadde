import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/bottomSheet.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/changePassword.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/editProfile.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/emailContactsFields.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/passwordSecurityFields.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/profileShimmer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../localizations.dart';
import '../../../../../network/network_calls.dart';
import '../../../../app_colors/app_colors.dart';
import 'profileEmpty.dart';
import 'drawer.dart';

// ignore: must_be_immutable
class ProfileDetailScreen extends StatefulWidget {
  bool playerTag;
  ProfileDetailScreen({super.key, this.playerTag = true});

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
              if (mounted) {
                print('getProfile');
                on401(context);
              }
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
      _internet = msg as bool;
      msg
          ? loadProfile()
          : setState(() {
              _isLoading = false;
            });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mode = MyAppState.mode;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.black,
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
                                height: height * 0.144,
                                width: double.infinity,
                                decoration:
                                    BoxDecoration(color: AppColors.black),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    AppLocalizations.of(context)!.profile,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                          color: AppColors.white,
                                        ),
                                  ),
                                )),
                              ),
                              Container(
                                color: AppColors.black,
                                height: height * 0.785,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: mode == ThemeMode.light
                                          ? const Color(0xffffffff)
                                          : AppColors.darkTheme,
                                      borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          topLeft: Radius.circular(20))),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: height * 0.07,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.059),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!
                                                  .copyWith(
                                                      color: mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.white),
                                            ),
                                            widget.playerTag
                                                ? InkWell(
                                                    onTap: () {
                                                      navigateToEditProfile();
                                                    },
                                                    child: CircleAvatar(
                                                      radius: height * 0.018,
                                                      backgroundColor: mode ==
                                                              ThemeMode.light
                                                          ? AppColors.grey200
                                                          : AppColors
                                                              .appThemeColor,
                                                      child: Icon(
                                                        Icons.edit,
                                                        size: height * 0.02,
                                                        color: mode ==
                                                                ThemeMode.light
                                                            ? AppColors.black
                                                            : AppColors.grey,
                                                      ),
                                                    ),
                                                  )
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                      ),
                                      EmailContactDOB(
                                        constant:
                                            '${AppLocalizations.of(context)!.email} :',
                                        constantValue: profileDetail!['email'],
                                      ),
                                      EmailContactDOB(
                                        constant:
                                            '${AppLocalizations.of(context)!.contacts} :',
                                        constantValue: AppLocalizations.of(
                                                        context)!
                                                    .locale ==
                                                "en"
                                            ? "${profileDetail!['countryCode'] ?? ""}${profileDetail!['contact_number'] ?? ""}"
                                            : "${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(1)}${profileDetail!['contact_number'] ?? ""}${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(0, 1)}",
                                      ),
                                      InkWell(
                                        onTap: () {
                                          // navigateToChangePassword();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const ChangePassword(),
                                              ));
                                        },
                                        child: PasswordSecurity(
                                          prefixIcon: Icons.key,
                                          title: AppLocalizations.of(context)!
                                              .changepasswordC,
                                          suffixIcon:
                                              AppLocalizations.of(context)!
                                                          .locale ==
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
                                          title: AppLocalizations.of(context)!
                                              .support,
                                          suffixIcon:
                                              AppLocalizations.of(context)!
                                                          .locale ==
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
                                          title: AppLocalizations.of(context)!
                                              .security,
                                          suffixIcon:
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      'en'
                                                  ? Icons.keyboard_arrow_right
                                                  : Icons.keyboard_arrow_left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Positioned(
                              top: height * 0.079,
                              left: 0,
                              right: width * 0.67,
                              child: _isLoading
                                  ? CircleAvatar(
                                      radius: height * 0.06,
                                      backgroundImage: const AssetImage(
                                          "assets/images/profile.png"),
                                    )
                                  : profileDetail!['profile_pic']
                                          .toString()
                                          .isNotEmpty
                                      ? CircleAvatar(
                                          radius: height * 0.06,
                                          backgroundImage: NetworkImage(
                                              profileDetail!['profile_pic']))
                                      : CircleAvatar(
                                          radius: height * 0.06,
                                          backgroundImage: const AssetImage(
                                              "assets/images/profile.png"),
                                        )),
                          Positioned(
                            top: height * 0.068,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ProfileDrawer(
                                              name:
                                                  '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                              position:
                                                  '${profileDetail!['role']}',
                                              profileImage:
                                                  profileDetail!['profile_pic']
                                                          .toString()
                                                          .isEmpty
                                                      ? ''
                                                      : profileDetail![
                                                          'profile_pic'],
                                              playerTag: widget.playerTag,
                                            ))).then((value) {
                                  if (value == true) {
                                    print('jjjjj');
                                    setState(() {});
                                  }
                                });
                              },
                              child: const Icon(
                                Icons.dehaze,
                                color: AppColors.appThemeColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : const ProfileEmptyScreen()
              : Scaffold(
                  body: Column(
                    children: [
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
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => const EditProfileScreen()));
  }

  void navigateToChangePassword() {
    Navigator.pushNamed(context, RouteNames.resetPassword);
  }
}
