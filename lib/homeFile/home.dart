import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../common_widgets/internet_loss.dart';
import '../constant.dart';
import '../localizations.dart';
import '../modelClass/pramotion_model_class.dart';
import '../modelClass/teamModelClass.dart';
import '../network/network_calls.dart';
import '../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import 'routingConstant.dart';
import 'utility.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  double _currentIndexPage = 0;

  // ignore: prefer_typing_uninitialized_variables
  var _tapPosition;
  String? country;
  String? city;
  String? arabicCountry;
  String? arabicCity;
  var _count = 0;
  final nextPageController = CarouselController();
  bool? _internet;
  final ScrollController _listScrollController = ScrollController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _focus = FocusNode();
  final _searchEvent = TextEditingController();
  final NetworkCalls _networkCalls = NetworkCalls();
  int indexItem = 1;
  bool _isLoading = true;
  var _bookPitchData;
  final List<SportsList> _sportsList = [];
  List<PromotionModelClass> _promotionData = [];

  getSports() async {
    _networkCalls.sportsList(onSuccess: (detail) {
      _sportsList.clear();
      for (int i = 0; i < detail.length; i++) {
        _sportsList.add(SportsList(
            name: detail[i]["sport_name"],
            nameArabic: detail[i]["sport_arabic_name"],
            slug: detail[i]["sport_slug"],
            bannerImage: detail[i]["banner_image"] == null
                ? ""
                : detail[i]["banner_image"]["filePath"],
            image: detail[i]["sport_image"] == null
                ? ""
                : detail[i]["sport_image"]["filePath"]));
      }
      setState(() {
        // _isLoading = false;
      });
    }, onFailure: (detail) {
      setState(() {
        // _isLoading = false;
      });
    }, tokenExpire: () {
      if (mounted) on401(context);
    });
  }

  getAddress() async {
    country = await _networkCalls.getKey("country");
    city = await _networkCalls.getKey("city");
    arabicCountry = await _networkCalls.getKey("arabicCountry");
    arabicCity = await _networkCalls.getKey("arabicCity");
    setState(() {});
  }

  loadVenues() async {
    await _networkCalls.bookpitch(
      urldetail: null,
      onSuccess: (pitchInfo) {
        if (mounted) {
          setState(() {
            _isLoading = false;
            _bookPitchData = pitchInfo;
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  getPromotion() async {
    await _networkCalls.getPromotion(
      onSuccess: (promotionInfo) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
            _promotionData = promotionInfo;
            print(_promotionData);
          });
        }
      },
      onFailure: (msg) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
          });
        }
      },
      tokenExpire: () {},
      // tokenExpire: () {
      //   if (mounted) on401(context);
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    return Material(
        child: RefreshIndicator(
      displacement: 200,
      onRefresh: () async {
        _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
          _internet = msg;
          if (msg == true) {
            if (mounted) {
              setState(() {
                _isLoading = true;
              });
            }
            loadVenues();
            getAddress();
            getSports();
            getPromotion();
          } else {
            setState(() {});
          }
        });
      },
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 150,
              width: sizeWidth,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AppLocalizations.of(context)!.locale == "en"
                      ? const AssetImage("assets/images/header.png")
                      : const AssetImage("assets/images/arabicHeader.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteNames.selectLocation);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/images/location_pitch.png",
                          color: Colors.white,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.locale == "en"
                                ? country.toString() ?? ""
                                : arabicCountry.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            AppLocalizations.of(context)!.locale == "en"
                                ? city.toString()
                                : arabicCity.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Image.asset(
                          "assets/images/down_icon.png",
                          color: Colors.white,
                          height: 15,
                          width: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            _isLoading
                ? _buildShimmer(sizeHeight, sizeWidth)
                : _internet!
                    ? Expanded(
                        child: ListView(
                            padding: EdgeInsets.zero,
                            physics: const ScrollPhysics(),
                            controller: _listScrollController,
                            children: [
                              // searchWidget(sizeWidth),
                              _promotionData.isEmpty
                                  ? const SizedBox.shrink()
                                  : GestureDetector(
                                      onLongPress: () {
                                        final RenderObject? overlay =
                                            Overlay.of(context)
                                                .context
                                                .findRenderObject();

                                        showMenu(
                                                context: context,
                                                items: [PlusMinusEntry()],
                                                position: RelativeRect.fromRect(
                                                    _tapPosition &
                                                        const Size(40, 40),
                                                    Rect.zero
                                                    // smaller rect, the touch area
                                                    // Offset.zero &
                                                    //     overlay// Bigger rect, the entire screen
                                                    ))
                                            // This is how you handle user selection
                                            .then<void>((int? delta) {
                                          // delta would be null if user taps on outside the popup menu
                                          // (causing it to close without making selection)
                                          if (delta == null) return;

                                          setState(() {
                                            _count = _count + delta;
                                          });
                                        });

                                        // Another option:
                                        //
                                        // final delta = await showMenu(...);
                                        //
                                        // Then process `delta` however you want.
                                        // Remember to make the surrounding function `async`, that is:
                                        //
                                        // void _showCustomMenu() async { ... }
                                      },
                                      child: bannerWidget()),
                              gameWidget(sizeWidth),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizeWidth * .05, vertical: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.venues,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: appThemeColor),
                                    ),
                                    GestureDetector(
                                        child: Text(
                                            AppLocalizations.of(context)!
                                                .viewAll,
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 13,
                                                color: Color(0XFF25A163))),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, RouteNames.viewMore,
                                              arguments: _promotionData);
                                        }),
                                  ],
                                ),
                              ),
                              _bookPitchData != null
                                  ? ListView.separated(
                                      padding: EdgeInsets.zero,
                                      itemCount: _bookPitchData.length,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return fixedGap(height: 10.0);
                                      },
                                      itemBuilder: ((context, index) {
                                        return venuesWidget(sizeWidth, index);
                                      }))
                                  : const SizedBox.shrink()
                            ]),
                      )
                    : Expanded(
                        child: InternetLoss(
                          onChange: () {
                            _networkCalls.checkInternetConnectivity(
                                onSuccess: (msg) {
                              _internet = msg;
                              if (msg == true) {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                }
                                loadVenues();
                                getAddress();
                                getSports();
                                getPromotion();
                              } else {
                                setState(() {});
                              }
                            });
                          },
                        ),
                      ),
          ],
        ),
      ),
    ));
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        _listScrollController.addListener(_scrollListener);
        getAddress();
        getSports();
        getPromotion();
        loadVenues();
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    });
  }

  _scrollListener() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void navigateToBookPitchDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.venueDetailScreen,
        arguments: detail);
  }

  void navigateToviewMorePitch(Map detail) {
    Navigator.pushNamed(context, RouteNames.viewMoreBookPitch,
        arguments: detail);
  }

  void navigateToviewJoinTeam(TeamModelClass detail) {
    Navigator.pushNamed(context, RouteNames.joinTeam, arguments: detail);
  }

  void navigateTeamViewMore() {
    Navigator.pushNamed(context, RouteNames.viewMoreTeam);
  }

  void navigateSpecificSpots(Map slug) {
    Navigator.pushNamed(context, RouteNames.specificSportsScreen,
        arguments: slug);
  }

  void navigateSpecificPromotion(var detail) {
    Navigator.pushNamed(context, RouteNames.associationPromotion,
        arguments: detail);
  }

  Widget searchWidget(double sizeWidth) {
    return Material(
      elevation: 5,
      child: Container(
        height: 80,
        width: sizeWidth,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          children: [
            Expanded(
              child: searchbar(
                  controller: _searchEvent,
                  node: _focus,
                  hintText: AppLocalizations.of(context)!.searchlocationorevent,
                  color: 0xFF9B9B9B,
                  onchange: (value) {},
                  submit: (value) {},
                  colorText: 0XFFFFFFFF,
                  icon: 'assets/images/Shape.png',
                  opacity: .26),
            ),
            fixedGap(width: 10.0),
            GestureDetector(
                onTap: () {
                  filterBottomSheet(onTap: () {});
                },
                child: Image.asset(
                  "assets/images/filter.png",
                  height: 40,
                  width: 40,
                ))
          ],
        ),
      ),
    );
  }

  Widget bannerWidget() {
    return SizedBox(
      height: 140,
      child: Stack(
        children: [
          CarouselSlider.builder(
              carouselController: nextPageController,
              itemCount: _promotionData.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                return GestureDetector(
                  onTap: () {
                    if (_promotionData[itemIndex].link != null) {
                      launchInBrowser(
                          _promotionData[itemIndex].link.toString());
                    } else {
                      navigateSpecificPromotion(_promotionData[itemIndex]);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Stack(
                      children: [
                        cachedNetworkImage(
                            cuisineImageUrl:
                                _promotionData[itemIndex].image_url ?? "",
                            imageFit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width,
                            height: 140),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Text("${_promotionData[itemIndex].name}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                  height: 140,
                  viewportFraction: 1,
                  initialPage: 0,
                  autoPlay: true,
                  enableInfiniteScroll: false,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndexPage = index.toDouble();
                    });
                  })),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: DotsIndicator(
              dotsCount: _promotionData.length,
              position: _currentIndexPage.toInt(),
              decorator: DotsDecorator(
                size: const Size.square(8.0),
                activeSize: const Size(18.0, 6.0),
                color: _currentIndexPage == 0
                    ? const Color(0XFFffffff).withOpacity(.2)
                    : Colors.white.withOpacity(.2),
                activeColor: _currentIndexPage == 0
                    ? const Color(0XFFffffff)
                    : Colors.white,
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gameWidget(double sizeWidth) {
    return Material(
      elevation: 5,
      child: Container(
        height: 100,
        width: sizeWidth,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            itemCount: _sportsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Map detail = {
                        "slug": _sportsList[index].slug,
                        "bannerImage": _sportsList[index].bannerImage,
                        "sportName":
                            AppLocalizations.of(context)!.locale == "en"
                                ? _sportsList[index].name
                                : _sportsList[index].nameArabic
                      };
                      navigateSpecificSpots(detail);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0XFF25A163),
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: cachedNetworkImage(
                                height: 60,
                                width: 60,
                                imageFit: BoxFit.contain,
                                color: appThemeColor,
                                cuisineImageUrl: _sportsList[index].image),
                          )),
                    ),
                  ),
                ],
              );
            })),
      ),
    );
  }

  Widget gameWidgetShimmer(double sizeWidth) {
    return Material(
      elevation: 5,
      child: Container(
        height: 100,
        width: sizeWidth,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0XFF25A163),
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: cachedNetworkImage(
                              height: 60,
                              width: 60,
                              imageFit: BoxFit.contain,
                              color: appThemeColor,
                              cuisineImageUrl: ""),
                        )),
                  ),
                ],
              );
            })),
      ),
    );
  }

  Widget venuesWidget(double sizeWidth, int index) {
    return GestureDetector(
      onTap: () {
        dynamic detail = {
          "pitchId": _bookPitchData[index]["id"] ?? 0,
          "subPitchId": _bookPitchData[index]["pitchType"][0] ?? 0
        };
        navigateToBookPitchDetail(detail);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Material(
            elevation: 5,
            color: Colors.white,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            child: SizedBox(
              height: 210,
              width: sizeWidth,
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: cachedNetworkImage(
                      cuisineImageUrl: _bookPitchData[index]["bookpitchfiles"]
                                  ["files"]
                              .isNotEmpty
                          ? _bookPitchData[index]["bookpitchfiles"]["files"][0]
                              ["filePath"]
                          : Container(),
                      height: 150,
                      width: sizeWidth,
                      imageFit: BoxFit.fitWidth,
                      errorFit: BoxFit.fitHeight,
                    ),
                  ),
                  flaxibleGap(2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _bookPitchData[index]["name"],
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: appThemeColor),
                        ),
                        Text(AppLocalizations.of(context)!.showDirections,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0XFF25A163))),
                      ],
                    ),
                  ),
                  flaxibleGap(2),
                  Container(
                    height: 30,
                    width: sizeWidth,
                    decoration: BoxDecoration(
                        color: const Color(0XFF25A163).withOpacity(.18),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        )),
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.locale == "en"
                              ? _bookPitchData[index]["sports_types"]
                                      ["sport_name"] ??
                                  ""
                              : _bookPitchData[index]["sports_types"]
                                      ["sport_arabic_name"] ??
                                  "",
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: appThemeColor),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        cachedNetworkImage(
                          cuisineImageUrl:
                              _bookPitchData[index]["sports_types"] != null
                                  ? _bookPitchData[index]["sports_types"]
                                              ["sport_image"] !=
                                          null
                                      ? _bookPitchData[index]["sports_types"]
                                          ["sport_image"]["filePath"]
                                      : Container()
                                  : Container(),
                          height: 30,
                          width: 30,
                          color: appThemeColor,
                          imageFit: BoxFit.contain,
                          errorFit: BoxFit.contain,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _buildShimmer(sizeHeight, sizeWidth) {
    return Expanded(
      child: Padding(
        padding: AppLocalizations.of(context)!.locale == "en"
            ? EdgeInsets.only(left: MediaQuery.of(context).size.width * .02)
            : EdgeInsets.only(right: MediaQuery.of(context).size.width * .02),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemBuilder: (_, __) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                gameWidgetShimmer(sizeWidth),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: sizeWidth * .032, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.venues,
                        style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: appThemeColor),
                      ),
                      Text(AppLocalizations.of(context)!.viewAll,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Color(0XFF25A163))),
                    ],
                  ),
                ),
                fixedGap(height: 8.0),
                _secondCard(),
                fixedGap(height: 10.0),
                _secondCard(),
                fixedGap(height: 20.0),
                _secondCard(),
              ],
            ),
          ),
          itemCount: 2,
        ),
      ),
    );
  }

  Widget _secondCard() {
    return Padding(
      padding: AppLocalizations.of(context)!.locale == "en"
          ? EdgeInsets.only(left: MediaQuery.of(context).size.width * .00)
          : EdgeInsets.only(right: MediaQuery.of(context).size.width * .00),
      child: SizedBox(
          width: double.infinity,
          height: 200.0,
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4),
            child: Column(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Container(
                    width: double.infinity,
                    height: 140,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      shimmer(width: 90),
                      Text(AppLocalizations.of(context)!.showDirections,
                          style: const TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0XFF25A163))),
                    ],
                  ),
                ),
                flaxibleGap(2),
                Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: const Color(0XFF25A163).withOpacity(.18),
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      shimmer(width: 90),
                      const SizedBox(
                        width: 10,
                      ),
                      cachedNetworkImage(
                        cuisineImageUrl: "",
                        height: 25,
                        width: 25,
                        color: appThemeColor,
                        imageFit: BoxFit.fill,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }

  filterBottomSheet({required Function onTap}) {
    var size = MediaQuery.of(context).size;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return FractionallySizedBox(
              heightFactor: .98,
              child: Scaffold(
                appBar: appBar(
                    title: AppLocalizations.of(context)!.filterBy,
                    language: AppLocalizations.of(context)!.locale,
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                bottomNavigationBar: Material(
                  color: const Color(0XFF25A163),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      onTap();
                    },
                    splashColor: Colors.black,
                    child: Container(
                        height: size.height * .104,
                        alignment: Alignment.center,
                        child: const Text(
                          "Apply",
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                              color: Colors.white),
                        )),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Container(
                    color: const Color(0XFFE5E5E5),
                    height: size.height * .8,
                    child: Form(
                        child: Column(children: [
                      Material(
                        elevation: 5,
                        child: Container(
                          height: 80,
                          width: size.width,
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: searchbar(
                                    controller: _searchEvent,
                                    node: _focus,
                                    hintText: AppLocalizations.of(context)!
                                        .searchlocationorevent,
                                    color: 0xFF9B9B9B,
                                    onchange: (value) {},
                                    submit: (value) {},
                                    colorText: 0XFFFFFFFF,
                                    icon: 'assets/images/location_pitch.png',
                                    opacity: .26),
                              ),
                              fixedGap(width: 10.0),
                              Image.asset(
                                "assets/images/speeker_image.png",
                                height: 40,
                                width: 40,
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
                  ),
                ),
              ),
            ); //whatever you're returning, does not have to be a Container
          });
        });
  }

  @override
  bool get wantKeepAlive => true;
}

class LeagueListItem extends StatelessWidget {
  final String? file;

  LeagueListItem({this.file});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0) //
                  ),
            ),
            width: MediaQuery.of(context).size.width * 0.44,
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: cachedNetworkImage(
                  height: 130, width: 140, cuisineImageUrl: file.toString()),
            )),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(5.0) //
                ),
          ),
          height: 50,
          width: 160,
        ),
      ],
    );
  }
}

class PlusMinusEntry extends PopupMenuEntry<int> {
  @override
  double height = 100;

  // height doesn't matter, as long as we are not giving
  // initialValue to showMenu().

  @override
  bool represents(int? n) => n == 1 || n == -1;

  @override
  PlusMinusEntryState createState() => PlusMinusEntryState();
}

class PlusMinusEntryState extends State<PlusMinusEntry> {
  void _plus1() {
    // This is how you close the popup menu and return user selection.
    Navigator.pop<int>(context, 1);
  }

  void _minus1() {
    Navigator.pop<int>(context, -1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: TextButton(onPressed: _plus1, child: const Text('+1'))),
        Expanded(
            child: TextButton(onPressed: _minus1, child: const Text('-1'))),
      ],
    );
  }
}
