import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tahaddi/modelClass/player_rating.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetailShimmer.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/profileScreen/view_your_review.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../../common_widgets/grediant_text.dart';
import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../main.dart';
import '../../../../../../modelClass/venue_detail_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../app_colors/app_colors.dart';
import 'bookAcademyScreens/BookingScreen.dart';
import 'carousel.dart';
import 'facilities.dart';

class GroundDetail extends StatefulWidget {
  Map detail;
  bool? myInterest;
  bool navigateFromInovative;

  GroundDetail(
      {super.key,
      required this.detail,
      this.myInterest = false,
      this.navigateFromInovative = false});

  @override
  State<GroundDetail> createState() => GroundDetailState();
}

class GroundDetailState extends State<GroundDetail>
    with TickerProviderStateMixin {
  bool internet = true;
  static SpecificVenueModelClass privateVenueDetail = SpecificVenueModelClass();
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  bool isStateLoading = true;
  List<PlayerRating> rating = [];
  var isDialOpen = ValueNotifier<bool>(false);
  bool _auth = false;
  List<int> listMaxPlayer = [];
  int? selectedIndex;
  List facilitySlugD = [];
  var _academyModel = [];
  bool? favoriteState;
  final itemSize = 100.0;
  List<Marker> allMarkers = [];
  List<int> indexList = [];
  List academyIds = [];
  var id = 0;
  int date = 0;
  getFavorites() {
    print(';hi');
    _networkCalls.getFavorites(
      onSuccess: (msg) {
        setState(() {
          _academyModel = msg;
          ids();
        });
      },
      onFailure: (msg) {
        setState(() {});
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  ids() {
    academyIds.clear();
    if (_academyModel.isEmpty) {
      setState(() {});
    } else {
      for (int i = 0; i < _academyModel.length; i++) {
        academyIds.add(_academyModel[i]['academy_id']);
      }
    }
    print(academyIds);
  }

  favorite(bool favoriteState) async {
    await _networkCalls.favorite(
      favorite: favoriteState,
      id: widget.detail["academy_id"].toString(),
      onSuccess: (msg) {
        // venueDetail();
        showMessage('operation successful');
        print(msg);
      },
      onFailure: (msg) {
        // venueDetail();
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  addMarker() async {
    allMarkers.clear();
    getBytesFromAsset("assets/images/marker.png", 70).then((markerIcon) =>
        setState(() {
          allMarkers.add(Marker(
            markerId: const MarkerId('myMarker'),
            icon: BitmapDescriptor.defaultMarker,
            infoWindow: InfoWindow(title: widget.detail['Academy_Location']),
            onTap: () {
              debugPrint('marker');
            },
            visible: true,
            flat: true,
            position:
                LatLng(widget.detail['latitude']!, widget.detail['longitude']!),
          ));
        }));
  }

  loadingRating() async {
    await _networkCalls.ratingGetForPlayer(
      id: widget.detail["academy_id"].toString(),
      onSuccess: (msg) {
        setState(() {
          for (int i = 0; i < msg.length; i++) {
            rating.add(PlayerRating.fromJson(msg[i]));
          }
          isStateLoading = false;
          // rating = msg;
          print("rating$rating");
        });
      },
      onFailure: (msg) {
        setState(() {
          isStateLoading = false;
        });
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  openMapsSheet(context) async {
    try {
      final coords =
          Coords(widget.detail['latitude']!, widget.detail['longitude']!);
      const title = 'Dubai';
      final availableMaps = await MapLauncher.installedMaps;
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Wrap(
                children: [
                  for (var map in availableMaps)
                    ListTile(
                      onTap: () => map.showMarker(
                        coords: coords,
                        title: title,
                      ),
                      title: Text(map.mapName),
                      leading: SvgPicture.asset(
                        map.icon,
                        height: 30.0,
                        width: 30.0,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  checkAuth() async {
    _auth = (await checkAuthorizaton())!;
  }

  facilityDiff() {
    facilitySlugD =
        widget.detail['facilitySlug']!.split(',').map((e) => e.trim()).toList();
    facilitySlugD
        .forEach((element) => indexList.add(int.parse(element.toString())));
  }

  @override
  void initState() {
    print(widget.detail);
    widget.navigateFromInovative ? null : facilityDiff();
    super.initState();
    checkAuth();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadingRating();
        getFavorites();
        // venueDetail();
        setStateFun();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
  }

  setStateFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isStateLoading
        ? GroundShimmer.buildShemmer(width, height, context)
        : internet
            ? Scaffold(
                floatingActionButton: SpeedDial(
                  elevation: 3,
                  activeChild: Icon(
                    Icons.close,
                    color: MyAppState.mode == ThemeMode.light
                        ? AppColors.white
                        : AppColors.black,
                    size: height * 0.035,
                  ),
                  animationCurve: Curves.easeInOutCirc,
                  spacing: height * 0.02,
                  animationDuration: const Duration(milliseconds: 300),
                  openCloseDial: isDialOpen,
                  mini: false,
                  closeManually: true,
                  isOpenOnStart: false,
                  backgroundColor: MyAppState.mode == ThemeMode.light
                      ? AppColors.appThemeColor
                      : AppColors.appThemeColor,
                  renderOverlay: false,
                  onPress: () {
                    setState(() {
                      ids();
                      isDialOpen.value = !isDialOpen.value;
                    });
                  },
                  children: [
                    widget.navigateFromInovative
                        ? SpeedDialChild()
                        : _auth
                            ? SpeedDialChild(
                                visible: true,
                                backgroundColor: AppColors.appThemeColor,
                                child: Icon(
                                    academyIds.contains(
                                            widget.detail['academy_id'])
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: AppColors.white),
                                onTap: () {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    if (msg) {
                                      if (academyIds.contains(
                                          widget.detail['academy_id'])) {
                                        privateVenueDetail.isFavourite = true;
                                        favorite(true);
                                        setState(() {
                                          isDialOpen.value = !isDialOpen.value;
                                          getFavorites();
                                        });
                                      } else {
                                        favorite(false);
                                        setState(() {
                                          isDialOpen.value = !isDialOpen.value;
                                          getFavorites();
                                        });
                                      }
                                    } else {
                                      showMessage(AppLocalizations.of(context)!
                                          .noInternetConnection);
                                      setState(() {
                                        isDialOpen.value = !isDialOpen.value;
                                      });
                                    }
                                  });
                                })
                            : SpeedDialChild(),

                    ///TODO Later
                    ///share Button
                    // SpeedDialChild(
                    //     visible: true,
                    //     backgroundColor: AppColors.appThemeColor,
                    //     child: Icon(
                    //       Icons.share,
                    //       color: AppColors.white,
                    //     ),
                    //     onTap: () {
                    //       Share.share(
                    //         "pitchDetail.link",
                    //       );
                    //       setState(() {
                    //         isDialOpen.value = !isDialOpen.value;
                    //       });
                    //     }),
                    SpeedDialChild(
                        visible: true,
                        backgroundColor: AppColors.appThemeColor,
                        child: Icon(
                          Icons.email_outlined,
                          color: AppColors.white,
                        ),
                        onTap: () async {
                          launch("mailto:info@tahadde.com");
                          setState(() {
                            isDialOpen.value = !isDialOpen.value;
                          });
                        })
                  ],
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                    size: height * 0.04,
                  ),
                ),
                body: CustomScrollView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      centerTitle: false,
                      expandedHeight: 200.0,
                      leading: Padding(
                        padding: EdgeInsets.only(left: height * 0.01),
                        child: InkWell(
                            onTap: () {
                              widget.myInterest!
                                  ? Navigator.pushReplacementNamed(
                                      context, RouteNames.myInterest)
                                  : Navigator.pop(context);
                            },
                            child: Container(
                                height: height * 0.045,
                                width: width * 0.01,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.017),
                                    child: Icon(
                                      Icons.arrow_back_ios,
                                      color: AppColors.black,
                                    ),
                                  ),
                                ))),
                      ),
                      leadingWidth: width * 0.11,
                      backgroundColor: AppColors.transparent,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          centerTitle: false,
                          titlePadding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 0),
                          background: Carousel(
                            image: widget.detail['academy_image'],
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              color: AppColors.black,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.white
                                        : AppColors.darkTheme,
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20))),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: height * 0.033,
                                      vertical: height * 0.033),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ///titleName
                                      widget.detail['academy_image'] != null
                                          ? GradientText(
                                              AppLocalizations.of(context)!
                                                          .locale ==
                                                      'en'
                                                  ? widget.detail[
                                                      'Academy_NameEnglish']
                                                  : widget.detail[
                                                          'Academy_NameArabic'] ??
                                                      "",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: height * 0.026,
                                                  color: AppColors.white,
                                                  fontFamily: "Poppins",
                                                  decoration:
                                                      TextDecoration.none),
                                              gradient: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? LinearGradient(colors: [
                                                      Colors.black38,
                                                      Colors.black45,
                                                      AppColors
                                                          .containerColorB54
                                                    ])
                                                  : const LinearGradient(
                                                      colors: [
                                                          Colors.white,
                                                          Colors.white,
                                                        ]),
                                            )
                                          : SizedBox(
                                              height: height * 0.028,
                                              width: width * 0.04,
                                              child:
                                                  const CircularProgressIndicator(
                                                color: AppColors.appThemeColor,
                                                strokeAlign: 1,
                                                strokeWidth: 2,
                                              ),
                                            ),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),

                                      ///description
                                      Text(
                                          AppLocalizations.of(context)!
                                              .descriptionS,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? AppColors.black
                                                      : AppColors.white)),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      ReadMoreText(
                                        AppLocalizations.of(context)!.locale ==
                                                'en'
                                            ? widget
                                                .detail['descriptionEnglish']
                                            : widget.detail[
                                                    'descriptionArabic'] ??
                                                "",
                                        trimLength: 2,
                                        trimMode: TrimMode.Line,
                                        lessStyle: TextStyle(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.black
                                                : Colors.yellowAccent,
                                            fontWeight: FontWeight.bold),
                                        moreStyle: TextStyle(
                                            color: MyAppState.mode ==
                                                    ThemeMode.light
                                                ? AppColors.black
                                                : Colors.yellowAccent,
                                            fontWeight: FontWeight.bold),
                                        trimCollapsedText: 'See More',
                                        trimExpandedText: 'See Less',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .copyWith(
                                              color: MyAppState.mode ==
                                                      ThemeMode.light
                                                  ? AppColors.black
                                                  : AppColors.white,
                                            ),
                                      ),
                                      SizedBox(
                                        height: height * 0.025,
                                      ),

                                      ///GroundList
                                      // Text(
                                      //     AppLocalizations.of(context)!
                                      //         .academyList,
                                      //     style: Theme.of(context)
                                      //         .textTheme
                                      //         .titleMedium!
                                      //         .copyWith(
                                      //             color: MyAppState.mode ==
                                      //                     ThemeMode.light
                                      //                 ? AppColors.black
                                      //                 : AppColors.white)),
                                      // ...List.generate(
                                      //     3,
                                      //     (index) => Padding(
                                      //           padding: EdgeInsets.symmetric(
                                      //               vertical: height * 0.01),
                                      //           child: Container(
                                      //             height: height * 0.08,
                                      //             decoration: BoxDecoration(
                                      //               color: Colors.white,
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       10),
                                      //               boxShadow: [
                                      //                 BoxShadow(
                                      //                     color: Colors.black38
                                      //                         .withOpacity(
                                      //                             0.17),
                                      //                     blurStyle:
                                      //                         BlurStyle.normal,
                                      //                     offset: const Offset(
                                      //                         1, 1),
                                      //                     blurRadius: 12,
                                      //                     spreadRadius: 2)
                                      //               ],
                                      //             ),
                                      //             child: Row(
                                      //               crossAxisAlignment:
                                      //                   CrossAxisAlignment
                                      //                       .center,
                                      //               mainAxisAlignment:
                                      //                   MainAxisAlignment
                                      //                       .spaceBetween,
                                      //               children: [
                                      //                 SizedBox(
                                      //                   width: width * 0.01,
                                      //                 ),
                                      //                 Container(
                                      //                   height: height * 0.06,
                                      //                   width: width * 0.13,
                                      //                   decoration: BoxDecoration(
                                      //                       borderRadius:
                                      //                           BorderRadius
                                      //                               .circular(
                                      //                                   10),
                                      //                       image: const DecorationImage(
                                      //                           fit:
                                      //                               BoxFit.fill,
                                      //                           image: NetworkImage(
                                      //                               'https://tse1.mm.bing.net/th?id=OIP.Pi1ySxKBf7DyNStcLdOASwHaEo&pid=Api&rs=1&c=1&qlt=95&w=168&h=105'))),
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: width * 0.03,
                                      //                 ),
                                      //                 Text(
                                      //                   ground[index],
                                      //                   style: Theme.of(context)
                                      //                       .textTheme
                                      //                       .bodyMedium!
                                      //                       .copyWith(
                                      //                         color: MyAppState
                                      //                                     .mode ==
                                      //                                 ThemeMode
                                      //                                     .light
                                      //                             ? AppColors
                                      //                                 .black
                                      //                             : AppColors
                                      //                                 .white,
                                      //                       ),
                                      //                 ),
                                      //                 SizedBox(
                                      //                   width: width * 0.2,
                                      //                 ),
                                      //                 Checkbox(
                                      //                     shape:
                                      //                         const CircleBorder(),
                                      //                     activeColor: AppColors
                                      //                         .appThemeColor,
                                      //                     value:
                                      //                         selectedIndex ==
                                      //                                 index
                                      //                             ? true
                                      //                             : false,
                                      //                     onChanged:
                                      //                         (onChanged) {
                                      //                       selectedIndex =
                                      //                           index;
                                      //                       setState(() {});
                                      //                     }),
                                      //               ],
                                      //             ),
                                      //           ),
                                      //         )),

                                      ///facilities
                                      SizedBox(
                                        height: height * 0.015,
                                      ),
                                      widget.navigateFromInovative!
                                          ? SizedBox.shrink()
                                          : FacilitiesList(facility: indexList),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            AppLocalizations.of(context)!
                                                .reviews,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? const Color(
                                                            0xff050505)
                                                        : const Color(
                                                            0xffffffff)),
                                          ),
                                          InkWell(
                                            onTap: rating.isNotEmpty
                                                ? () {
                                                    navigateToReviews(widget
                                                        .detail['academy_id']
                                                        .toString());
                                                  }
                                                : null,
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .viewAll,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                    fontWeight: FontWeight.w400,
                                                    color: MyAppState.mode ==
                                                            ThemeMode.light
                                                        ? AppColors.darkTheme
                                                        : Colors.white70,
                                                  ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: height * 0.015,
                                      ),
                                      rating.isNotEmpty
                                          ? Row(
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: Colors.amberAccent,
                                                  size: height * 0.04,
                                                ),
                                                SizedBox(
                                                  width: width * 0.01,
                                                ),
                                                Text(
                                                    rating[0].rating.toString(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors
                                                                    .black
                                                                : AppColors
                                                                    .white)),
                                                Text(
                                                    "(${rating.length.toString()})",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall!
                                                        .copyWith(
                                                            color: MyAppState
                                                                        .mode ==
                                                                    ThemeMode
                                                                        .light
                                                                ? AppColors.grey
                                                                    .withOpacity(
                                                                        0.5)
                                                                : AppColors
                                                                    .white)),
                                              ],
                                            )
                                          : Text(
                                              AppLocalizations.of(context)!
                                                  .noReviews,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall!
                                                  .copyWith(
                                                      color: MyAppState.mode ==
                                                              ThemeMode.light
                                                          ? AppColors.black
                                                          : AppColors.white)),
                                      SizedBox(
                                        height: height * 0.02,
                                      ),

                                      ///location
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * 0.008),
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                  color: MyAppState.mode ==
                                                          ThemeMode.light
                                                      ? AppColors.black
                                                      : AppColors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          openMapsSheet(context);
                                          // makeMap(_getLaunchUrl().toString());
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5),
                                          child: Column(
                                            children: [
                                              Container(
                                                width: width,
                                                height: height * .3,
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(15)),
                                                  child: GoogleMap(
                                                    zoomControlsEnabled: true,
                                                    myLocationButtonEnabled:
                                                        true,
                                                    onTap: (value) {
                                                      // openMapsSheet(context);
                                                      //makeMap(_getLaunchUrl().toString());
                                                      setState(() {});
                                                    },
                                                    indoorViewEnabled: true,
                                                    compassEnabled: true,
                                                    mapToolbarEnabled: true,
                                                    buildingsEnabled: true,
                                                    mapType: MapType.hybrid,
                                                    rotateGesturesEnabled: true,
                                                    liteModeEnabled: false,
                                                    initialCameraPosition:
                                                        CameraPosition(
                                                            target: LatLng(
                                                                widget.detail[
                                                                    'latitude'],
                                                                widget.detail[
                                                                    'longitude']),
                                                            zoom: 14.0),
                                                    // markers: Set.identity(),
                                                    markers:
                                                        Set.from(allMarkers),
                                                    zoomGesturesEnabled: true,
                                                  ),
                                                ),
                                              ),
                                              // Material(
                                              //   elevation: 1,
                                              //   color: AppColors.white,
                                              //   borderRadius: const BorderRadius
                                              //       .only(
                                              //       bottomRight:
                                              //           Radius.circular(20.0),
                                              //       bottomLeft:
                                              //           Radius.circular(20.0)),
                                              //   child: SizedBox(
                                              //     width: MediaQuery.of(context)
                                              //         .size
                                              //         .width,
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.only(
                                              //               right: 7,
                                              //               left: 7,
                                              //               top: 10),
                                              //       child: Row(
                                              //         mainAxisAlignment:
                                              //             MainAxisAlignment
                                              //                 .spaceBetween,
                                              //         children: [
                                              //           Column(
                                              //             crossAxisAlignment:
                                              //                 CrossAxisAlignment
                                              //                     .start,
                                              //             children: [
                                              //               Row(
                                              //                 children: [
                                              //                   const Icon(
                                              //                     Icons
                                              //                         .location_on,
                                              //                     size: 20,
                                              //                   ),
                                              //                   SizedBox(
                                              //                     width: width *
                                              //                         0.002,
                                              //                   ),
                                              //                   SizedBox(
                                              //                     width: width *
                                              //                         .6,
                                              //                     child: Text(
                                              //                       AppLocalizations.of(
                                              //                               context)!
                                              //                           .location,
                                              //                       overflow:
                                              //                           TextOverflow
                                              //                               .ellipsis,
                                              //                       maxLines: 5,
                                              //                       style: Theme.of(
                                              //                               context)
                                              //                           .textTheme
                                              //                           .bodyMedium!
                                              //                           .copyWith(
                                              //                             color:
                                              //                                 AppColors.black,
                                              //                           ),
                                              //                     ),
                                              //                   ),
                                              //                 ],
                                              //               ),
                                              //               SizedBox(
                                              //                 width:
                                              //                     width * .75,
                                              //                 child: Text(
                                              //                   widget.detail[
                                              //                           'Academy_Location'] ??
                                              //                       "",
                                              //                   overflow:
                                              //                       TextOverflow
                                              //                           .ellipsis,
                                              //                   maxLines: 2,
                                              //                   style: Theme.of(
                                              //                           context)
                                              //                       .textTheme
                                              //                       .titleSmall!
                                              //                       .copyWith(
                                              //                         color: const Color(
                                              //                             0XFF8B8B8B),
                                              //                       ),
                                              //                 ),
                                              //               ),
                                              //             ],
                                              //           ),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ),

                                      ///BookButton
                                      ButtonWidget(
                                          isLoading: false,
                                          onTaped: () {
                                            navigateToBookingScreen(
                                                widget.detail,
                                                widget.navigateFromInovative);
                                          },
                                          title: Text(
                                            AppLocalizations.of(context)!
                                                .bookNowS,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: AppColors.white),
                                          )),

                                      ///popularFeature
                                      // Padding(
                                      //   padding: EdgeInsets.symmetric(
                                      //       vertical: height * 0.013),
                                      //   child: Text(
                                      //     AppLocalizations.of(context)!.popular,
                                      //     style: TextStyle(
                                      //       fontSize: height * 0.03,
                                      //       color: MyAppState.mode ==
                                      //               ThemeMode.light
                                      //           ? AppColors.black
                                      //           : AppColors.white,
                                      //     ),
                                      //   ),
                                      // ),
                                      // Wrap(
                                      //   crossAxisAlignment:
                                      //       WrapCrossAlignment.center,
                                      //   children: [
                                      //     ...List.generate(
                                      //         5,
                                      //         (index) => Padding(
                                      //               padding:
                                      //                   EdgeInsets.symmetric(
                                      //                       vertical:
                                      //                           height * .008,
                                      //                       horizontal:
                                      //                           width * 0.008),
                                      //               child: Wrap(
                                      //                 crossAxisAlignment:
                                      //                     WrapCrossAlignment
                                      //                         .center,
                                      //                 children: [
                                      //                   CircleAvatar(
                                      //                     radius:
                                      //                         height * 0.0065,
                                      //                     backgroundColor:
                                      //                     AppColors.grey,
                                      //                   ),
                                      //                   Padding(
                                      //                     padding: EdgeInsets
                                      //                         .symmetric(
                                      //                             horizontal:
                                      //                                 width *
                                      //                                     0.02),
                                      //                     child: Text(
                                      //                       popular[index],
                                      //                       style: TextStyle(
                                      //                           color: MyAppState
                                      //                                       .mode ==
                                      //                                   ThemeMode
                                      //                                       .light
                                      //                               ? AppColors
                                      //                                   .black
                                      //                               : AppColors
                                      //                                   .white,
                                      //                           overflow:
                                      //                               TextOverflow
                                      //                                   .ellipsis,
                                      //                           fontSize:
                                      //                               height *
                                      //                                   0.02),
                                      //                       overflow:
                                      //                           TextOverflow
                                      //                               .ellipsis,
                                      //                       softWrap: true,
                                      //                       textWidthBasis:
                                      //                           TextWidthBasis
                                      //                               .parent,
                                      //                     ),
                                      //                   ),
                                      //                 ],
                                      //               ),
                                      //             ))
                                      //   ],
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Material(
                child: SizedBox(
                  height: height,
                  width: width,
                  child: InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        internet = msg;
                        if (msg == true) {}
                      });
                    },
                  ),
                ),
              );
  }

  List popular = [
    'Hiring Partners',
    'Miniature Field',
    'Grass Pitch',
    'Outdoor/Indoor',
    'Nature Grass Pitch'
  ];
  List ground = ['Main Academy', 'Futsal Academy', 'tennis Academy'];

  void navigateToBookingScreen(Map detail, bool innovativeNavigation) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlayerBookingScreenView(
              detail: detail, navigateFromInnovative: innovativeNavigation),
        ));
    // Navigator.pushNamed(context, RouteNames.bookingScreen, arguments: detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  void navigateToReviews(String id) {
    // Navigator.pushNamed(context, RouteNames.rate);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => YourReviews(academyId: id),
        ));
  }
}
