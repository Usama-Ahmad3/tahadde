import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/modelClass/academy_model.dart';
import 'package:flutter_tahaddi/modelClass/campaign.dart';
import 'package:flutter_tahaddi/modelClass/innovative_hub.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/carousel.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetail.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/campaign_corousel_fro_home_screens.dart';

import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/my_venue_list_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../app_colors/app_colors.dart';
import '../../../../../utils/utils.dart';
import 'view_all.dart';

class AcademyOwnerMainHome extends StatefulWidget {
  const AcademyOwnerMainHome({super.key});

  @override
  State<AcademyOwnerMainHome> createState() => _AcademyOwnerMainHomeState();
}

class _AcademyOwnerMainHomeState extends State<AcademyOwnerMainHome> {
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  List<MyVenueModelClass> _pitchDetail = [];
  List<AcademyModel> _academyDetail = [];
  List<InnovativeHub> _innovativeDetail = [];
  List<AcademyModel> _academyModel = [];
  List<Campaign> campaign = [];
  List campaignImage = [];
  List campaignDescription = [];
  List campaignLinks = [];
  List campaignEndDate = [];
  bool _internet = true;
  int initial = 0;
  int clicked = 1;

  loadMyPitch() async {
    print(await _networkCalls.getKey('token'));
    await _networkCalls.myVenues(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
            _pitchDetail = event;
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

  loadAllAcademies() async {
    await _networkCalls.allAcademies(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
            _academyDetail = event;
            // _isLoading = false;
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

  loadAllInnovative() async {
    await _networkCalls.allInnovative(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            // _isLoading = false;
            _innovativeDetail = event;
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

  loadCampaigns() async {
    await _networkCalls.getCampaign(
      onSuccess: (event) {
        if (mounted) {
          setState(() {
            campaign = event;
          });
        }
        if (campaign.isNotEmpty) {
          campaign.forEach((element) {
            campaignDescription.add(element.description);
            campaignImage.add(element.bannerImage);
            campaignLinks.add(element.link);
            campaignEndDate.add(element.validityEnd);
          });
        }
      },
      onFailure: (msg) {},
      tokenExpire: () {},
    );
  }

  @override
  void initState() {
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (_internet == true) {
        _isLoading = false;
        loadMyPitch();
        loadCampaigns();
        loadAllAcademies();
        loadAllInnovative();
        // loadVerifiedAcademies();
        print(_academyDetail.length);
        print(_innovativeDetail.length);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeHeight = MediaQuery.of(context).size.height;
    var sizeWidth = MediaQuery.of(context).size.width;
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return _internet
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                elevation: 2,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [
                    SizedBox(
                        height: 40 * fem,
                        width: 40 * fem,
                        child: Image.asset(
                          'assets/images/T.png',
                          color: AppColors.green,
                        )),
                    SizedBox(
                      width: sizeWidth * 0.001,
                    ),
                    Text(
                      AppLocalizations.of(context)!.tahaddi,
                      style: SafeGoogleFont(
                        'Inter',
                        fontSize: 22 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.25 * ffem / fem,
                        letterSpacing: -0.2 * fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: SpeedDial(
                elevation: 3,
                label: Text(
                  AppLocalizations.of(context)!.add,
                  style: TextStyle(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.white
                          : AppColors.white,
                      fontSize: 11),
                ),
                animationCurve: Curves.easeInOutCirc,
                backgroundColor: MyAppState.mode == ThemeMode.light
                    ? AppColors.appThemeColor
                    : AppColors.appThemeColor,
                onPress: () {
                  navigateToSports();
                },
                child: Icon(
                  Icons.add,
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.white
                      : AppColors.white,
                  size: sizeHeight * 0.03,
                ),
              ),
              body: _isLoading
                  ? Container(
                      height: sizeHeight,
                      width: sizeWidth,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: MyAppState.mode == ThemeMode.light
                              ? AppColors.white
                              : AppColors.darkTheme,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.appThemeColor,
                        ),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) => ConstrainedBox(
                        constraints:
                            BoxConstraints(maxHeight: constraints.maxHeight),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              campaign.isNotEmpty
                                  ? SizedBox(
                                      height: sizeHeight * 0.21,
                                      width: sizeWidth,
                                      child: CampaignCorousel(
                                        description: campaignDescription,
                                        image: campaignImage,
                                        links: campaignLinks,
                                        endDate: campaignEndDate,
                                      ))
                                  : SizedBox(
                                      height: sizeHeight * 0.2,
                                      width: sizeWidth,
                                      child: const Center(
                                          child: CircularProgressIndicator())),
                              SizedBox(
                                height: sizeHeight * 0.01,
                              ),
                              Material(
                                  color: AppColors.transparent,
                                  child: Container(
                                    height: sizeHeight * 0.07,
                                    color: AppColors.black,
                                    constraints: BoxConstraints(
                                        maxHeight: sizeHeight * 0.06),
                                    child: TabBar(
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      unselectedLabelColor: AppColors.grey,
                                      dividerColor: AppColors.black,
                                      indicatorColor: AppColors.appThemeColor,
                                      isScrollable: true,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      // indicator: BoxDecoration(
                                      //   color: Color(0xff1d7e55),
                                      //   borderRadius: BorderRadius.circular(8),
                                      // ),
                                      padding: EdgeInsets.symmetric(
                                          vertical: sizeHeight * 0.003),
                                      tabs: [
                                        Center(
                                            child: Padding(
                                          padding:
                                              EdgeInsets.all(sizeHeight * 0.01),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .academyOnly,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        )),
                                        Center(
                                            child: Padding(
                                          padding: EdgeInsets.all(
                                              sizeHeight * 0.012),
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .innovative,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          ),
                                        )),
                                      ],
                                    ),
                                  )),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxHeight: constraints.maxHeight * 0.75),
                                child: TabBarView(children: [
                                  RefreshIndicator(
                                    displacement: 200,
                                    onRefresh: () async {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                          }
                                          loadMyPitch();
                                          loadAllAcademies();
                                          // loadVerifiedAcademies();
                                        } else {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                        color: AppColors.black,
                                        child: Container(
                                          height: sizeHeight * 0.7,
                                          width: sizeWidth,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * 0.039),
                                          decoration: BoxDecoration(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.white
                                                  : AppColors.darkTheme,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          child: SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: sizeHeight * 0.01,
                                                  horizontal:
                                                      sizeWidth * 0.014),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 12 * fem,
                                                        top: 12 * fem),
                                                    width: double.infinity,
                                                    child: InkWell(
                                                      onTap: () {
                                                        var details = {
                                                          "bool": false
                                                        };
                                                      },
                                                      child: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .academy,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: MyAppState
                                                                            .mode ==
                                                                        ThemeMode
                                                                            .light
                                                                    ? const Color(
                                                                        0xff050505)
                                                                    : const Color(
                                                                        0xffffffff)),
                                                      ),
                                                    ),
                                                  ),
                                                  ...List.generate(
                                                    _academyDetail.length > 2
                                                        ? 3
                                                        : _academyDetail.length,
                                                    (index) {
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    sizeHeight *
                                                                        0.01),
                                                        child: Container(
                                                          width:
                                                              sizeWidth * 0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .grey200
                                                                : AppColors
                                                                    .containerColorW12,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            12)),
                                                                child:
                                                                    DefaultTextStyle(
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? AppColors
                                                                              .black
                                                                          : AppColors
                                                                              .white),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsets.symmetric(
                                                                            horizontal: sizeWidth *
                                                                                0.02,
                                                                            vertical:
                                                                                sizeHeight * 0.005),
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              '${AppLocalizations.of(context)!.status}:',
                                                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white),
                                                                            ),

                                                                            ///status
                                                                            Text(
                                                                              _academyDetail[index].status == 'Verified'
                                                                                  ? AppLocalizations.of(context)!.verified
                                                                                  : _academyDetail[index].status == 'Decline'
                                                                                      ? AppLocalizations.of(context)!.rejected
                                                                                      : AppLocalizations.of(context)!.inReview,
                                                                              style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: _academyDetail[index].status == 'Verified' ? AppColors.appThemeColor : AppColors.redAccent),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),

                                                                      ///image
                                                                      ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(12),
                                                                        child:
                                                                            SizedBox(
                                                                          height:
                                                                              sizeHeight * 0.193,
                                                                          child:
                                                                              Carousel(
                                                                            rating:
                                                                                false,
                                                                            image:
                                                                                _academyDetail[index].academyImage,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: sizeHeight *
                                                                            0.005,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          cachedNetworkImage(
                                                                            height:
                                                                                sizeHeight * 0.02,
                                                                            imageFit:
                                                                                BoxFit.fill,
                                                                            width:
                                                                                sizeWidth * 0.05,
                                                                            color: MyAppState.mode == ThemeMode.light
                                                                                ? AppColors.black
                                                                                : AppColors.white,
                                                                            cuisineImageUrl:
                                                                                _academyDetail[index].sportImage ?? "",
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                sizeWidth * 0.01,
                                                                          ),
                                                                          Text(
                                                                            AppLocalizations.of(context)!.locale == 'en'
                                                                                ? _academyDetail[index].academyNameEnglish.toString()
                                                                                : _academyDetail[index].academyNameArabic.toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsets.only(
                                                                            bottom: sizeHeight *
                                                                                0.008,
                                                                            left:
                                                                                sizeWidth * 0.007),
                                                                        child:
                                                                            Text(
                                                                          _academyDetail[index]
                                                                              .academyLocation
                                                                              .toString(),
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .titleSmall!
                                                                              .copyWith(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.01,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                sizeWidth *
                                                                    0.01),
                                                    child: Align(
                                                      alignment:
                                                          AppLocalizations.of(
                                                                          context)!
                                                                      .locale ==
                                                                  'en'
                                                              ? Alignment
                                                                  .bottomLeft
                                                              : Alignment
                                                                  .bottomRight,
                                                      child: InkWell(
                                                        onTap: () {
                                                          navigateToAcademyViewMore(
                                                              _academyDetail);
                                                        },
                                                        child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .viewAll,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .titleSmall!
                                                                  .copyWith(
                                                                    color: AppColors
                                                                        .green,
                                                                  ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.04,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        )),
                                  ),
                                  RefreshIndicator(
                                    displacement: 200,
                                    onRefresh: () async {
                                      _networkCalls.checkInternetConnectivity(
                                          onSuccess: (msg) {
                                        _internet = msg;
                                        if (msg == true) {
                                          if (mounted) {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                          }
                                          loadAllInnovative();
                                        } else {
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Container(
                                      color: AppColors.black,
                                      child: Container(
                                          height: sizeHeight,
                                          width: sizeWidth,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: sizeWidth * 0.039),
                                          decoration: BoxDecoration(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.white
                                                  : AppColors.darkTheme,
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20))),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: sizeHeight * 0.01,
                                                horizontal: sizeWidth * 0.014),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        bottom: 12 * fem,
                                                        top: 12 * fem),
                                                    width: double.infinity,
                                                    child: InkWell(
                                                      onTap: () {
                                                        var details = {
                                                          "bool": false
                                                        };
                                                      },
                                                      child: Text(
                                                          AppLocalizations.of(
                                                                  context)!
                                                              .innovative,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .titleMedium!
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: MyAppState
                                                                              .mode ==
                                                                          ThemeMode
                                                                              .light
                                                                      ? const Color(
                                                                          0xff050505)
                                                                      : const Color(
                                                                          0xffffffff))),
                                                    ),
                                                  ),
                                                  _innovativeDetail.isEmpty ||
                                                          _innovativeDetail ==
                                                              null
                                                      ? Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  sizeHeight *
                                                                      0.22,
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                AppLocalizations.of(
                                                                        context)!
                                                                    .noEvents,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyMedium!
                                                                    .copyWith(
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? AppColors
                                                                              .black
                                                                          : AppColors
                                                                              .white,
                                                                    ),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      :

                                                      ///list of innovatives
                                                      Column(
                                                          children: [
                                                            ...List.generate(
                                                                _innovativeDetail
                                                                            .length >
                                                                        2
                                                                    ? 3
                                                                    : _innovativeDetail
                                                                        .length,
                                                                (index) {
                                                              print('hi');
                                                              return InkWell(
                                                                onTap: () {
                                                                  dynamic
                                                                      detail = {
                                                                    "academy_id":
                                                                        _innovativeDetail[index].innovativehubId ??
                                                                            0,
                                                                    "Academy_NameEnglish":
                                                                        _innovativeDetail[index]
                                                                            .nameEnglish,
                                                                    "Academy_NameArabic":
                                                                        _innovativeDetail[index]
                                                                            .nameArabic,
                                                                    "descriptionEnglish":
                                                                        _innovativeDetail[index]
                                                                            .descriptionEnglish,
                                                                    "descriptionArabic":
                                                                        _innovativeDetail[index]
                                                                            .descriptionArabic,
                                                                    "gameplaySlug":
                                                                        _innovativeDetail[index]
                                                                            .sportSlug,
                                                                    "academy_image":
                                                                        [
                                                                      _innovativeDetail[
                                                                              index]
                                                                          .image
                                                                    ],
                                                                    'latitude':
                                                                        _innovativeDetail[index]
                                                                            .latitude,
                                                                    'longitude':
                                                                        _innovativeDetail[index]
                                                                            .longitude,
                                                                    'Academy_Location':
                                                                        _innovativeDetail[index]
                                                                            .location,
                                                                  };
                                                                  navigateToGroundDetail(
                                                                      detail);
                                                                },
                                                                child: Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      vertical:
                                                                          sizeHeight *
                                                                              0.01),
                                                                  child:
                                                                      Container(
                                                                    width:
                                                                        sizeWidth *
                                                                            0.9,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: MyAppState.mode ==
                                                                              ThemeMode
                                                                                  .light
                                                                          ? AppColors
                                                                              .grey200
                                                                          : AppColors
                                                                              .containerColorW12,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        Container(
                                                                          decoration:
                                                                              BoxDecoration(borderRadius: BorderRadius.circular(12)),
                                                                          child:
                                                                              DefaultTextStyle(
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyMedium!.copyWith(color: MyAppState.mode == ThemeMode.light ? AppColors.black : AppColors.white),
                                                                            child:
                                                                                Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.02, vertical: sizeHeight * 0.005),
                                                                                  child: Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Text('${AppLocalizations.of(context)!.status}:'),
                                                                                      Text(
                                                                                        AppLocalizations.of(context)!.approveByAdmin,
                                                                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.redAccent),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                ClipRRect(
                                                                                  borderRadius: BorderRadius.circular(12),
                                                                                  child: cachedNetworkImage(
                                                                                    height: sizeHeight * 0.193,
                                                                                    imageFit: BoxFit.fill,
                                                                                    width: MediaQuery.of(context).size.width,
                                                                                    cuisineImageUrl: '${_innovativeDetail[index].image}' ?? "",
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: sizeHeight * 0.005,
                                                                                ),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    cachedNetworkImage(
                                                                                      height: sizeHeight * 0.02,
                                                                                      imageFit: BoxFit.fill,
                                                                                      width: sizeWidth * 0.05,
                                                                                      cuisineImageUrl: _innovativeDetail[index].sportImage.toString() ?? "",
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: sizeWidth * 0.01,
                                                                                    ),
                                                                                    Text(_innovativeDetail[index].sportSlug.toString()),
                                                                                  ],
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(bottom: sizeHeight * 0.008, left: sizeWidth * 0.007),
                                                                                  child: Text(_innovativeDetail[index].location!, style: Theme.of(context).textTheme.titleSmall),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }),
                                                          ],
                                                        ),
                                                  SizedBox(
                                                    height: sizeHeight * 0.02,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              // ...List.generate(
              //   widget.bookPitchData.length,
              //       (index) => InkWell(
              //     onTap: () {
              //       dynamic detail = {
              //         "pitchId": widget.bookPitchData[index]["id"] ?? 0,
              //         "subPitchId":
              //         widget.bookPitchData[index]["pitchType"][0] ?? 0
              //       };
              //       navigateToGroundDetail(detail);
              //     },
              //     child: Padding(
              //       padding: EdgeInsets.only(bottom: 16 * fem),
              //       child: Container(
              //         padding: EdgeInsets.only(bottom: 16 * fem),
              //         width: double.infinity,
              //         decoration: BoxDecoration(
              //           color: mode == ThemeMode.light
              //               ? const Color(0xffffffff)
              //               : const Color(0xff373737),
              //           borderRadius: BorderRadius.circular(15 * fem),
              //           boxShadow: [
              //             BoxShadow(
              //               color: const Color(0x0f050818),
              //               offset: Offset(10 * fem, 40 * fem),
              //               blurRadius: 30 * fem,
              //             ),
              //           ],
              //         ),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Container(
              //               margin: EdgeInsets.only(bottom: 12 * fem),
              //               width: 327 * fem,
              //               height: 145 * fem,
              //               child: ClipRRect(
              //                 borderRadius: BorderRadius.only(
              //                   topLeft: Radius.circular(15 * fem),
              //                   topRight: Radius.circular(15 * fem),
              //                 ),
              //                 child: cachedNetworkImage(
              //                   cuisineImageUrl: widget
              //                       .bookPitchData[index]["bookpitchfiles"]
              //                   ["files"]
              //                       .isNotEmpty
              //                       ? widget.bookPitchData[index]
              //                   ["bookpitchfiles"]["files"][0]["filePath"]
              //                       : Container(),
              //                   height: 150,
              //                   width: fem,
              //                   imageFit: BoxFit.fitWidth,
              //                   errorFit: BoxFit.fitHeight,
              //                 ),
              //               ),
              //             ),
              //             Padding(
              //               padding:
              //               EdgeInsets.only(left: 4.0 * fem, bottom: 2 * fem),
              //               child: Text(
              //                 widget.bookPitchData[index]["name"],
              //                 style: SafeGoogleFont(
              //                   'Inter',
              //                   fontSize: 20 * ffem,
              //                   fontWeight: FontWeight.w600,
              //                   height: 1.25 * ffem / fem,
              //                   letterSpacing: -0.2 * fem,
              //                   color: mode == ThemeMode.light
              //                       ? const Color(0xff050505)
              //                       : const Color(0xffffffff),
              //                 ),
              //               ),
              //             ),
              //             Row(
              //               children: [
              //                 Container(
              //                   margin: EdgeInsets.only(
              //                       right: 10 * fem, left: 4 * fem),
              //                   width: 24 * fem,
              //                   height: 24 * fem,
              //                   child: Image.asset(
              //                     'assets/light-design/images/icon-bus.png',
              //                     width: 24 * fem,
              //                     height: 24 * fem,
              //                   ),
              //                 ),
              //                 Text(
              //                   AppLocalizations.of(context)!.showDirections,
              //                   style: SafeGoogleFont(
              //                     'Inter',
              //                     fontSize: 13 * ffem,
              //                     fontWeight: FontWeight.w400,
              //                     height: 1.3846153846 * ffem / fem,
              //                     color: const Color(0xff686868),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ),
              // )
            ),
          )
        : Column(
            children: [
              Expanded(
                child: InternetLoss(
                  onChange: () {
                    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                      _internet = msg;
                      if (_internet == true) {
                        _isLoading = false;
                        // loadLeagueData();
                        loadMyPitch();
                        // loadTournamentData();
                      }
                      setState(() {
                        _isLoading = false;
                      });
                    });
                  },
                ),
              ),
            ],
          );
  }

  void navigateToAcademyViewMore(event) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) =>
                ViewMoreAcademyScreen(academy: event as List<AcademyModel>)));
    // Navigator.pushNamed(context, RouteNames.viewMoreVenue, arguments: event);
  }

  void navigateToSports() {
    Navigator.pushNamed(context, RouteNames.selectSport, arguments: true);
  }

  void navigateToGroundDetail(Map detail) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GroundDetail(
            detail: detail,
            navigateFromInovative: true,
          ),
        ));
    // Navigator.pushNamed(context, RouteNames.groundDetail, arguments: detail);
  }
}
