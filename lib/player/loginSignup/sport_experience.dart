import 'package:flutter/material.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';
import '../../pitchOwner/loginSignupPitchOwner/select_sport.dart';

class SportExperience extends StatefulWidget {
  const SportExperience({Key? key}) : super(key: key);

  @override
  _SportExperienceState createState() => _SportExperienceState();
}

class _SportExperienceState extends State<SportExperience> {
  bool _isLoading = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final List<String> _sportsListSlug = [];
  final List<SportsList> _sportsList = [];

  _onSelected(String slug) {
    if (_sportsListSlug.contains(slug)) {
      setState(() {
        _sportsListSlug.remove(slug);
      });
    } else {
      setState(() {
        _sportsListSlug.add(slug);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSportsExperience();
  }

  getSportsExperience() async {
    _networkCalls.sportsExperienceList(onSuccess: (detail) {
      for (int i = 0; i < detail.length; i++) {
        _sportsList.add(SportsList(
            name: detail[i]["name"],
            slug: detail[i]["slug"],
            image: detail[i]["image"] == null
                ? ""
                : detail[i]["sport_image"]["filePath"]));
      }
      setState(() {
        _isLoading = false;
      });
    }, onFailure: (detail) {
      setState(() {
        _isLoading = false;
      });
    }, tokenExpire: () {
      if (mounted) on401(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: appBar(
            language: AppLocalizations.of(context)!.locale,
            title: "Experience Level",
            onTap: () {
              Navigator.of(context).pop();
            },
            isBack: false),
        body: Container(
            color: Colors.white,
            width: size.width,
            child: Column(
              children: [
                _isLoading
                    ? const Expanded(
                        child: Center(
                            child: CircularProgressIndicator(
                          color: appThemeColor,
                        )),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20.0,
                            ),
                            const Text(
                              "Select your experience",
                              style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: appThemeColor,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            _sportsList.isNotEmpty
                                ? SizedBox(
                                    height: size.height * .45,
                                    width: size.width,
                                    child: Wrap(
                                        spacing: 15.0,
                                        runSpacing: 10.0,
                                        children: List.generate(
                                            _sportsList.length,
                                            (index) => SizedBox(
                                                  height: 30.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _onSelected(
                                                          _sportsList[index]
                                                              .slug
                                                              .toString());
                                                    },
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      color: _sportsListSlug
                                                              .contains(
                                                                  _sportsList[
                                                                          index]
                                                                      .slug)
                                                          ? appThemeColor
                                                          : const Color(
                                                              0XFFEBEBEB),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5.0,
                                                                horizontal: 10),
                                                        child: Text(
                                                          _sportsList[index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: _sportsListSlug
                                                                      .contains(
                                                                          _sportsList[index]
                                                                              .slug)
                                                                  ? Colors.white
                                                                  : const Color(
                                                                      0XFF868686),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontSize: 12),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ))),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(height: 20),
                            _sportsListSlug.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      navigateToDetail();
                                    },
                                    child: Container(
                                        height: 50,
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                            "images/back_icon.png")),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                      ),
              ],
            )),
      ),
    );
  }

  void navigateToDetail() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        RouteNames.profileDetail, (Route<dynamic> route) => false);
  }
}
