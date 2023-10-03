import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/player/loginSignup/profile/profileEmpty.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common_widgets/internet_loss.dart';
import '../../../homeFile/routingConstant.dart';
import '../../../homeFile/utility.dart';
import '../../../localizations.dart';
import '../../../network/network_calls.dart';

class ProfileScreen extends StatefulWidget {
  String msg;

  ProfileScreen({super.key, required this.msg});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with AutomaticKeepAliveClientMixin {
  bool _internet = true;
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  late bool _auth;
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
  bool get wantKeepAlive => true;

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
    WidgetsBinding.instance.addPostFrameCallback((Duration) {
      if (widget.msg == 'Password has been reset') {
        showMessage(widget.msg);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;

    return Material(
        child: _isLoading
            ? _buildShimmer(sizeWidth, sizeHeight)
            : _internet
                ? _auth
                    ? Scaffold(
                        appBar: AppBar(
                          title: Text(AppLocalizations.of(context)!.profile),
                          backgroundColor: const Color(0XFF032040),
                        ),
                        body: Container(
                          height: sizeHeight,
                          width: sizeWidth,
                          color: const Color(0XFFF0F0F0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: sizeWidth,
                                height: sizeHeight * .2,
                                decoration: BoxDecoration(
                                    color: const Color(0XFF032040),
                                    image: DecorationImage(
                                        image: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? const AssetImage(
                                                'assets/images/header.png')
                                            : const AssetImage(
                                                'assets/images/arabicHeader.png'),
                                        fit: BoxFit.cover)),
                                alignment: Alignment.bottomLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    flaxibleGap(3),
                                    Row(
                                      children: [
                                        flaxibleGap(2),
                                        Container(
                                            height: sizeHeight * .13,
                                            width: sizeHeight * .13,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0XFF4F5C6A),
                                              // image: Image.network(profileDetail.profile_pic),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                              child: profileDetail![
                                                          'profile_pic'] !=
                                                      null
                                                  ? cachedNetworkImage(
                                                      height: sizeHeight * .08,
                                                      width: sizeHeight * .08,
                                                      cuisineImageUrl:
                                                          profileDetail![
                                                                  'profile_pic']
                                                              ['filePath'],
                                                      placeholder:
                                                          "assets/images/profile.png")
                                                  : Image.asset(
                                                      "assets/images/profile.png",
                                                      fit: BoxFit.cover,
                                                    ),
                                            )),
                                        flaxibleGap(2),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${profileDetail!['first_name']} ${profileDetail!['last_name']}',
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.call,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Container(
                                                  width: sizeWidth * .01,
                                                ),
                                                Text(
                                                  AppLocalizations.of(context)!
                                                              .locale ==
                                                          "en"
                                                      ? "${profileDetail!['countryCode'] ?? ""}" "${profileDetail!['contact_number'] ?? ""}"
                                                      : "${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(1)}${profileDetail!['contact_number'] ?? ""}${profileDetail!['countryCode'] == null ? "" : profileDetail!['countryCode'].substring(0, 1)}",
                                                  style: TextStyle(
                                                      fontSize:
                                                          sizeHeight * .025,
                                                      color: Colors.white),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        flaxibleGap(14),
                                      ],
                                    ),
                                    flaxibleGap(1),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  width: sizeWidth,
                                  height: sizeHeight * .65,
                                  color: const Color(0XFFF0F0F0),
                                  child: ListView(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    children: [
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        elevation: 5,
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        child: SizedBox(
                                          height: sizeHeight * .2,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: sizeWidth * .06,
                                                right: sizeWidth * .06),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                flaxibleGap(1),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .personalDetail,
                                                      style: const TextStyle(
                                                          color:
                                                              Color(0XFF032040),
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        navigateToDetail();
                                                      },
                                                      child: const Icon(
                                                        Icons.edit,
                                                        color:
                                                            Color(0XFF9B9B9B),
                                                        size: 20,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                flaxibleGap(1),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/mail.png",
                                                      fit: BoxFit.cover,
                                                      height: 20,
                                                    ),
                                                    flaxibleGap(2),
                                                    // ignore: sized_box_for_whitespace
                                                    Container(
                                                      width: sizeWidth * .6,
                                                      child: Text(
                                                        profileDetail!['email'],
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF25A163),
                                                            fontSize: 12),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    flaxibleGap(5),
                                                  ],
                                                ),
                                                flaxibleGap(1),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      "assets/images/calendar.png",
                                                      fit: BoxFit.cover,
                                                      height: 20,
                                                    ),
                                                    flaxibleGap(2),
                                                    SizedBox(
                                                      width: sizeWidth * .6,
                                                      child: Text(
                                                        profileDetail!['dob'] ??
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .dateofBirth,
                                                        style: const TextStyle(
                                                            color: Color(
                                                                0XFF7A7A7A),
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                    flaxibleGap(5),
                                                  ],
                                                ),
                                                // flaxibleGap(1),
                                                // Row(
                                                //   crossAxisAlignment:
                                                //       CrossAxisAlignment.start,
                                                //   children: <Widget>[
                                                //     Image.asset(
                                                //       "images/gender.png",
                                                //       fit: BoxFit.cover,
                                                //       height: 20,
                                                //     ),
                                                //     flaxibleGap(2),
                                                //     Container(
                                                //       width: sizeWidth * .6,
                                                //       child: Text(
                                                //         profileDetail[
                                                //                 'gender'] ??
                                                //             'Not Available',
                                                //         style: TextStyle(
                                                //             color: Color(
                                                //                 0XFF7A7A7A),
                                                //             fontSize: 12),
                                                //       ),
                                                //     ),
                                                //     flaxibleGap(6),
                                                //   ],
                                                // ),
                                                flaxibleGap(1),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        elevation: 5,
                                        child: InkWell(
                                          onTap: () {
                                            navigateToMyInterest();
                                          },
                                          splashColor: Colors.black,
                                          child: cardWidget(
                                              sizeWidth: sizeWidth,
                                              sizeHeight: sizeHeight,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .myInterest,
                                              image: Icons.favorite,
                                              description:
                                                  AppLocalizations.of(context)!
                                                      .viewInterest),
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        elevation: 5,
                                        child: InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            navigateToMyBooking();
                                          },
                                          child: cardWidget(
                                              sizeWidth: sizeWidth,
                                              sizeHeight: sizeHeight,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .myBooking,
                                              image: Icons.calendar_today,
                                              description:
                                                  AppLocalizations.of(context)!
                                                      .viewbook,
                                              color: Colors.green),
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        elevation: 5,
                                        child: InkWell(
                                          splashColor: Colors.black,
                                          onTap: () {
                                            navigateToRate();
                                          },
                                          child: cardWidget(
                                              sizeWidth: sizeWidth,
                                              sizeHeight: sizeHeight,
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .ratingsReviews,
                                              image: Icons.calendar_today,
                                              description: AppLocalizations.of(
                                                      context)!
                                                  .addreviewspitchyouhaveplayedon,
                                              color: Colors.green),
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      SizedBox(
                                        height: sizeHeight * .06,
                                        child: Material(
                                          color: const Color(0XFFFFFFFF),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(20.0)),
                                          elevation: 5,
                                          child: InkWell(
                                            splashColor: Colors.grey,
                                            child: Center(
                                                child: Text(
                                              AppLocalizations.of(context)!
                                                  .resetPassword,
                                              style: const TextStyle(
                                                  color: Color(0XFF032040)),
                                            )),
                                            onTap: () {
                                              navigateToRestPassword();
                                            },
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        elevation: 5,
                                        child: InkWell(
                                          splashColor: Colors.grey,
                                          child: Container(
                                              //color: Colors.white,
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: sizeHeight * .06,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .logout,
                                                style: const TextStyle(
                                                    color: Color(0XFFD0021B)),
                                              )),
                                          onTap: () {
                                            onWillPop(
                                                AppLocalizations.of(context)!
                                                    .youGoingLogout,
                                                true);
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                      Material(
                                        color: const Color(0XFFFFFFFF),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20.0)),
                                        elevation: 5,
                                        child: InkWell(
                                          splashColor: Colors.grey,
                                          child: Container(
                                              //color: Colors.white,
                                              alignment: Alignment.center,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: sizeHeight * .06,
                                              child: Text(
                                                AppLocalizations.of(context)!
                                                    .deleteAccount,
                                                style: const TextStyle(
                                                    color: Color(0XFFD0021B)),
                                              )),
                                          onTap: () {
                                            onWillPop(
                                                AppLocalizations.of(context)!
                                                    .youGoingDeleteAccount,
                                                false);
                                          },
                                        ),
                                      ),
                                      Container(
                                        height: sizeHeight * .02,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : const ProfileEmpty()
                : Scaffold(
                    body: Column(
                      children: [
                        buildAppBar(
                            language: AppLocalizations.of(context)!.locale,
                            title: AppLocalizations.of(context)!.profileC,
                            height: sizeHeight,
                            width: sizeWidth),
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
                  ));
  }

  Widget _buildShimmer(sizeWidth, sizeHeight) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      body: SizedBox(
        height: sizeHeight,
        width: sizeWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: sizeWidth,
              height: sizeHeight * .2,
              decoration: BoxDecoration(
                  color: const Color(0XFF032040),
                  image: DecorationImage(
                      image: AppLocalizations.of(context)!.locale == "en"
                          ? const AssetImage('assets/images/header.png')
                          : const AssetImage('assets/images/arabicHeader.png'),
                      fit: BoxFit.cover)),
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  flaxibleGap(3),
                  Row(
                    children: <Widget>[
                      flaxibleGap(2),
                      Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: sizeHeight * .13,
                          width: sizeHeight * .13,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0XFF4F5C6A),
                            // image: Image.network(profileDetail.profile_pic),
                          ),
                        ),
                      ),
                      flaxibleGap(2),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          shimmer(width: sizeWidth * .4),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              const Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 20,
                              ),
                              Container(
                                width: sizeWidth * .02,
                              ),
                              shimmer(width: sizeWidth * .4),
                            ],
                          )
                        ],
                      ),
                      flaxibleGap(14),
                    ],
                  ),
                  flaxibleGap(1),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: sizeWidth,
                height: sizeHeight * .65,
                color: const Color(0XFFF0F0F0),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: sizeWidth * .06, right: sizeWidth * .06),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: SizedBox(
                          height: sizeHeight * .2,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .06, right: sizeWidth * .06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!
                                          .personalDetail,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.edit,
                                      color: Color(0XFF9B9B9B),
                                      size: 20,
                                    )
                                  ],
                                ),
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/mail.png",
                                      fit: BoxFit.cover,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    shimmer(width: sizeWidth * .6),
                                  ],
                                ),
                                flaxibleGap(1),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/images/calendar.png",
                                      fit: BoxFit.cover,
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    shimmer(width: sizeWidth * .4),
                                  ],
                                ),
                                // flaxibleGap(1),
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: <Widget>[
                                //     Image.asset(
                                //       "images/gender.png",
                                //       fit: BoxFit.cover,
                                //       height: 20,
                                //     ),
                                //     SizedBox(
                                //       width: 10,
                                //     ),
                                //     shimmer(width: sizeWidth * .2),
                                //   ],
                                // ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: SizedBox(
                          height: sizeHeight * .13,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .06, right: sizeWidth * .06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.myInterest,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  ],
                                ),
                                flaxibleGap(2),
                                Text(
                                  AppLocalizations.of(context)!.viewInterest,
                                  style: const TextStyle(
                                      color: Color(0XFF7A7A7A), fontSize: 12),
                                ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: SizedBox(
                          height: sizeHeight * .13,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .06, right: sizeWidth * .06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.myBooking,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.green,
                                    )
                                  ],
                                ),
                                flaxibleGap(2),
                                Text(
                                  AppLocalizations.of(context)!.viewbook,
                                  style: const TextStyle(
                                      color: Color(0XFF7A7A7A), fontSize: 12),
                                ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: SizedBox(
                          height: sizeHeight * .13,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: sizeWidth * .06, right: sizeWidth * .06),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                flaxibleGap(1),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!
                                          .ratingsReviews,
                                      style: const TextStyle(
                                          color: Color(0XFF032040),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Image.asset("assets/images/star.png")
                                  ],
                                ),
                                flaxibleGap(2),
                                Text(
                                  AppLocalizations.of(context)!
                                      .addreviewspitchyouhaveplayedon,
                                  style: const TextStyle(
                                      color: Color(0XFF7A7A7A), fontSize: 12),
                                ),
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      // Container(
                      //   height: sizeHeight * .02,
                      // ),
                      // Material(
                      //   color: Color(0XFFFFFFFF),
                      //   child: Container(
                      //     height: sizeHeight * .13,
                      //     child: Padding(
                      //       padding: EdgeInsets.only(
                      //           left: sizeWidth * .06,
                      //           right: sizeWidth * .06),
                      //       child: Column(
                      //         crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //         children: <Widget>[
                      //           flaxibleGap(1),
                      //           Row(
                      //             mainAxisAlignment:
                      //             MainAxisAlignment
                      //                 .spaceBetween,
                      //             children: <Widget>[
                      //               Text(
                      //                 AppLocalizations.of(
                      //                     context)
                      //                     .savePaymentMethod,
                      //                 style: TextStyle(
                      //                     color: Color(
                      //                         0XFF032040),
                      //                     fontSize: 14,
                      //                     fontWeight:
                      //                     FontWeight
                      //                         .bold),
                      //               ),
                      //               Image.asset(
                      //                 "images/credit.png",
                      //                 height: 25,
                      //               )
                      //             ],
                      //           ),
                      //           flaxibleGap(1),
                      //           Text(
                      //             AppLocalizations.of(
                      //                 context)
                      //                 .viewsavePaymentMethod,
                      //             style: TextStyle(
                      //                 color:
                      //                 Color(0XFF7A7A7A),
                      //                 fontSize: 12),
                      //           ),
                      //           flaxibleGap(1),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: SizedBox(
                          height: sizeHeight * .06,
                          child: Material(
                            color: Colors.white,
                            child: Center(
                                child: Text(
                              AppLocalizations.of(context)!.resetPassword,
                              style: const TextStyle(color: Color(0XFF032040)),
                            )),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                      Material(
                        elevation: 5,
                        color: const Color(0XFFFFFFFF),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20.0)),
                        child: InkWell(
                          splashColor: Colors.grey,
                          child: Container(
                              //color: Colors.white,
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: sizeHeight * .06,
                              child: Text(
                                AppLocalizations.of(context)!.logout,
                                style:
                                    const TextStyle(color: Color(0XFFD0021B)),
                              )),
                          onTap: () {
                            //onWillPop();
                          },
                        ),
                      ),
                      Container(
                        height: sizeHeight * .02,
                      ),
                    ],
                  ),
                ),
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

  void navigateToDetail() {
    Navigator.pushNamed(context, RouteNames.editProfile);
  }

  void navigateToRate() {
    Navigator.pushNamed(context, RouteNames.rate);
  }

  void navigateToRestPassword() {
    Navigator.pushNamed(context, RouteNames.resetPassword);
  }

  void navigateToMyBooking() {
    Navigator.pushNamed(context, RouteNames.myBookings);
  }

  void navigateToMyInterest() {
    Navigator.pushNamed(context, RouteNames.myInterest);
  }

  // void navigateToSavePayment() {
  //   Navigator.pushNamed(context, savePayment);
  // }
  cardWidget(
      {sizeWidth,
      sizeHeight,
      String? title,
      IconData? image,
      String? description,
      Color? color,
      String? imageIcon}) {
    return SizedBox(
      height: sizeHeight * .13,
      child: Padding(
        padding: EdgeInsets.only(left: sizeWidth * .06, right: sizeWidth * .06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            flaxibleGap(2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title!,
                  style: const TextStyle(
                      color: Color(0XFF032040),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                imageIcon != null
                    ? Image.asset("assets/images/star.png")
                    : Icon(
                        image,
                        color: color ?? Colors.red,
                      )
              ],
            ),
            flaxibleGap(2),
            Text(
              description!,
              style: const TextStyle(color: Color(0XFF7A7A7A), fontSize: 12),
            ),
            flaxibleGap(2),
          ],
        ),
      ),
    );
  }
}
