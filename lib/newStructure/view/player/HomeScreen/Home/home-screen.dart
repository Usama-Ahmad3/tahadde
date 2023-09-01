import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/vanueList.dart';

import '../../../../../common_widgets/internet_loss.dart';
import '../../../../../homeFile/routingConstant.dart';
import '../../../../../homeFile/utility.dart';
import '../../../../../modelClass/pramotion_model_class.dart';
import '../../../../../modelClass/territory_model_class.dart';
import '../../../../../network/network_calls.dart';
import '../../../../../pitchOwner/loginSignupPitchOwner/select_sport.dart';
import '../../../utils.dart';
import 'shimmerWidgets.dart';
import 'sportList.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  List<TerritoryModelClass> territoryData = [];
  String? country;
  String? city;
  String? arabicCountry;
  String? arabicCity;
  int isSelected = 0;
  bool? _internet;
  final NetworkCalls _networkCalls = NetworkCalls();
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
      setState(() {});
    }, onFailure: (detail) {
      setState(() {});
    }, tokenExpire: () {
      if (mounted) on401(context);
    });
  }

  loadTerritories() async {
    country = await _networkCalls.getKey("country");
    await _networkCalls.getTerritory(
      onSuccess: (territoryInfo) {
        if (mounted) {
          setState(() {
            territoryData = territoryInfo;
            _isLoading = false;
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

  getAddress() async {
    city = await _networkCalls.getKey("city");
    arabicCity = await _networkCalls.getKey("arabicCity");
    setState(() {});
  }

  loadVenues() async {
    await _networkCalls.bookpitch(
      urldetail: '',
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
  void initState() {
    super.initState();
    loadTerritories();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
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

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return RefreshIndicator(
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
          backgroundColor: const Color(0xff050505),
          body: _isLoading
              ? ShimmerWidgets().buildShimmer(fem, context, _bookPitchData)
              : _internet!
                  ? ListView(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///top widget
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20 * fem, bottom: 30 * fem),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      navigateToProfile();
                                    },
                                    child: CircleAvatar(
                                      radius: 23 * fem,
                                      backgroundColor: Colors.white10,
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size: 23 * fem,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)!.tahaddi,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 20 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.25 * ffem / fem,
                                          letterSpacing: -0.2 * fem,
                                          color: const Color(0xffffffff),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.morning,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff999999),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ///location
                                  SizedBox(
                                    width: 130 * fem,
                                    height: 70 * fem,
                                    child: CupertinoPicker(
                                        itemExtent: 40,
                                        backgroundColor: Colors.black,
                                        looping: true,
                                        useMagnifier: true,
                                        magnification: 1,
                                        onSelectedItemChanged: (e) {
                                          showMessage('Tap To Select');
                                        },
                                        children: List.generate(
                                            territoryData[0].cities!.length,
                                            (index) {
                                          return territoryData[0]
                                                  .cities![index]!
                                                  .isDisable as bool
                                              ? const SizedBox.shrink()
                                              : InkWell(
                                                  onTap: () async {
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "country",
                                                            territoryData[0]
                                                                .country!
                                                                .name
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "arabicCountry",
                                                            territoryData[0]
                                                                .country!
                                                                .nameArabic
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "city",
                                                            territoryData[0]
                                                                .cities![index]!
                                                                .city!
                                                                .name
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "arabicCity",
                                                            territoryData[0]
                                                                .cities![index]!
                                                                .city!
                                                                .nameArabic
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "cityId",
                                                            territoryData[0]
                                                                .cities![index]!
                                                                .city!
                                                                .id
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "lat",
                                                            territoryData[0]
                                                                .cities![index]!
                                                                .city!
                                                                .latitude
                                                                .toString());
                                                    await _networkCalls
                                                        .saveKeys(
                                                            "long",
                                                            territoryData[0]
                                                                .cities![index]!
                                                                .city!
                                                                .longitude
                                                                .toString());
                                                    await getAddress();
                                                    showMessage(
                                                        '${territoryData[0].cities![index]!.city!.name.toString()} Selected');
                                                  },
                                                  child: Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              "en"
                                                          ? territoryData[0]
                                                              .cities![index]!
                                                              .city!
                                                              .name
                                                              .toString()
                                                          : territoryData[0]
                                                              .cities![index]!
                                                              .city!
                                                              .nameArabic
                                                              .toString(),
                                                      style: TextStyle(
                                                          fontSize: 17 * fem,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                        })),
                                  ),
                                  CircleAvatar(
                                    radius: 23 * fem,
                                    backgroundColor: Colors.white10,
                                    child: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                      size: 23 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: fem * 22.0),
                              child: SizedBox(
                                height: fem * 50,
                                width: double.infinity,
                                child: const Placeholder(),
                              ),
                            ),
                            SizedBox(
                              height: 15 * fem,
                            ),

                            ///category
                            _sportsList.isEmpty
                                ? const SizedBox.shrink()
                                : SportList(
                                    isSelected: isSelected,
                                    sportsList: _sportsList,
                                  ),
                            _bookPitchData != null
                                ? VanueList(bookPitchData: _bookPitchData)
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
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

  navigateToProfile() {
    Navigator.pushNamed(context, RouteNames.profileDetail);
  }

  void navigateToBookPitchDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.venueDetailScreen,
        arguments: detail);
  }
}
