import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';
import 'package:flutter_tahaddi/newStructure/utils/models.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/playerHomeScreen.dart';

import '../../constant.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../network/network_calls.dart';

class PreferredSports extends StatefulWidget {
  const PreferredSports({Key? key}) : super(key: key);

  @override
  _PreferredSportsState createState() => _PreferredSportsState();
}

class _PreferredSportsState extends State<PreferredSports> {
  bool _isLoading = true;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  final List<String> _sportsListSlug = [];
  final List<SportsList> _sportsList = [];
  final List<SportsList> _expertList = [];
  String? _expertListSlug;

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

    sportsTypes();
    getSportsExperience();
  }

  _onSelectedExpert(String slug) {
    setState(() {
      _expertListSlug = slug;
    });
  }

  getSportsExperience() async {
    _networkCalls.sportsExperienceList(onSuccess: (detail) {
      for (int i = 0; i < detail.length; i++) {
        _expertList.add(SportsList(
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

  sportsTypes() {
    _networkCalls.sportsTypes(
      onSuccess: (data) {
        if (mounted) {
          setState(() {
            for (int i = 0; i < data.length; i++) {
              _sportsList.add(SportsList(
                  name: data[i]["sport_name"],
                  nameArabic: data[i]["sport_arabic_name"],
                  slug: data[i]["sport_slug"],
                  bannerImage: data[i]["banner_image"] == null
                      ? ""
                      : data[i]["banner_image"]["filePath"],
                  image: data[i]["sport_image"] == null
                      ? ""
                      : data[i]["sport_image"]["filePath"]));
            }
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
    );
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
            title: "Preferred Sports and Experience",
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
                            Text(
                              "Select Your Preferred Sports",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            _sportsList.isNotEmpty
                                ? SizedBox(
                                    width: size.width,
                                    child: Wrap(
                                        spacing: 15.0,
                                        runSpacing: 10.0,
                                        children: List.generate(
                                            _sportsList.length,
                                            (index) => SizedBox(
                                                  height: 40,
                                                  child: ChipButton(
                                                      bgColor: _sportsListSlug
                                                              .contains(
                                                                  _sportsList[index]
                                                                      .slug)
                                                          ? AppColors
                                                              .appThemeColor
                                                          : const Color(
                                                              0XFFEBEBEB),
                                                      textStyle: _sportsListSlug.contains(
                                                              _sportsList[index]
                                                                  .slug)
                                                          ? const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal)
                                                          : const TextStyle(
                                                              color: Color(
                                                                  0XFF868686),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                      title: _sportsList[index]
                                                          .name
                                                          .toString(),
                                                      image: _sportsList[index]
                                                          .image
                                                          .toString(),
                                                      onTap: () {
                                                        _onSelected(
                                                            _sportsList[index]
                                                                .slug
                                                                .toString());
                                                      }),
                                                ))),
                                  )
                                : const SizedBox.shrink(),
                            const SizedBox(
                              height: 60.0,
                            ),
                            Text(
                              "Select your experience",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            _expertList.isNotEmpty
                                ? SizedBox(
                                    width: size.width,
                                    child: Wrap(
                                        spacing: 15.0,
                                        runSpacing: 10.0,
                                        children: List.generate(
                                            _expertList.length,
                                            (index) => SizedBox(
                                                  height: 40.0,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      _onSelectedExpert(
                                                          _expertList[index]
                                                              .slug
                                                              .toString());
                                                    },
                                                    child: Material(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      color: _expertList[index]
                                                                  .slug ==
                                                              _expertListSlug
                                                          ? AppColors
                                                              .appThemeColor
                                                          : const Color(
                                                              0XFFEBEBEB),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 10.0,
                                                                horizontal: 10),
                                                        child: Text(
                                                          _expertList[index]
                                                              .name
                                                              .toString(),
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: _expertList[
                                                                              index]
                                                                          .slug ==
                                                                      _expertListSlug
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
                            const SizedBox(height: 40),
                            _sportsListSlug.isNotEmpty &&
                                    _expertListSlug != null
                                ? GestureDetector(
                                    onTap: () {
                                      navigateToDetail();
                                    },
                                    child: Container(
                                        height: 50,
                                        alignment: Alignment.centerRight,
                                        child: Image.asset(
                                            "assets/images/back_icon.png")),
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
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => PlayerHomeScreen(index: 3),
        ),
        (Route<dynamic> route) => false);
  }
}

class ChipButton extends StatelessWidget {
  const ChipButton(
      {Key? key,
      required this.bgColor,
      required this.textStyle,
      required this.title,
      required this.image,
      required this.onTap})
      : super(key: key);
  final Color bgColor;
  final String title;
  final TextStyle textStyle;
  final VoidCallback onTap;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 110.0,
      child: GestureDetector(
        onTap: onTap,
        child: Material(
          borderRadius: BorderRadius.circular(40.0),
          clipBehavior: Clip.hardEdge,
          color: bgColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              flaxibleGap(
                1,
              ),
              cachedNetworkImage(
                  height: 30,
                  width: 30,
                  imageFit: BoxFit.contain,
                  color: appThemeColor,
                  cuisineImageUrl: image ?? ""),
              flaxibleGap(
                1,
              ),
              Text(
                title,
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: textStyle.color,
                    fontWeight: textStyle.fontWeight,
                    fontSize: 12),
              ),
              flaxibleGap(
                1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
