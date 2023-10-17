import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

import '../../common_widgets/grediant_text.dart';
import '../../common_widgets/internet_loss.dart';
import '../../common_widgets/story_view.dart';
import '../../constant.dart';
import '../../drop_down_file.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/venue_detail_model_class.dart';
import '../../modelClass/venue_slot_model_class.dart';
import '../../network/network_calls.dart';

class VenueDetailScreen extends StatefulWidget {
  Map detail;

  VenueDetailScreen({super.key, required this.detail});

  @override
  _VenueDetailScreenState createState() => _VenueDetailScreenState();
}

class _VenueDetailScreenState extends State<VenueDetailScreen>
    with TickerProviderStateMixin {
  late bool internet;
  late SpecificVenueModelClass _venueDetail;
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  bool isStateLoading = true;
  late bool _auth;
  SlotPrice _slotPrice =
  SlotPrice(isPlayer: false, pricePerPlayer: [], pricePerVenue: []);
  double _currentIndexPage = 0;
  List<int> listMaxPlayer = [];
  Map<String, List<String>> slotInformation = {};
  late bool favoriteState;
  bool isPerPlayer = true;
  int indexItem = 1;
  int indexItemSubPitch = 1;
  List<SlotModelClass> slotModelClass = [];
  late String dataTime;
  final itemSize = 100.0;
  late ScrollController _controller;
  List<Marker> allMarkers = [];
  int tabIndex = 0;
  var id = 0;
  double _boxHeight = 0;
  late TabController tabController;
  final List _slotTime = [];
  int date = 0;
  final nextPageController = CarouselController();
  late ScrollController _scrollController;

  favorite(bool favoriteState) async {
    var detail = {
      "pitch_id": widget.detail["pitchId"].toString(),
      "is_favourite": favoriteState
    };
    await _networkCalls.favorite(
      detail: detail,
      onSuccess: (msg) {
        venueDetail();
      },
      onFailure: (msg) {
        venueDetail();
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  addMarker() async {
    allMarkers.clear();
    getBytesFromAsset("assets/images/marker.png", 70)
        .then((markerIcon) =>
        setState(() {
          allMarkers.add(Marker(
            markerId: const MarkerId('myMarker'),
            icon: BitmapDescriptor.fromBytes(markerIcon),
            draggable: false,
            onTap: () {
              debugPrint('marker');
            },
            position:
            LatLng(_venueDetail.latitude!, _venueDetail.longitude!),
          ));
        }));
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(_venueDetail.latitude!, _venueDetail.longitude!);
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
                      onTap: () =>
                          map.showMarker(
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

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context)!.toReserve),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.login),
                onPressed: () {
                  navigateToDetail1();
                },
              )
            ],
          );
        });
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      bool isTop = _scrollController.position.pixels == 250;
      if (isTop) {
        setState(() {
          _boxHeight = 100;
        });
      } else {
        setState(() {
          _boxHeight = 0;
        });
      }
    });
    dataTime = apiFormatter.format(DateTime.now());
    print(DateTime.now().toString());
    checkAuth();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        venueDetail();
        slotDetail();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });

    _controller = ScrollController();
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (tabController.indexIsChanging) {
          setState(() {
            tabIndex = tabController.index;
          });

          print(tabController.index);
        }
      });
  }

  venueDetail() {
    _networkCalls.venueDetail(
        id: widget.detail["pitchId"].toString(),
        subPitchId: widget.detail["subPitchId"]["id"].toString(),
        onSuccess: (detail) {
          setState(() {
            _venueDetail = detail;
            allMarkers.add(Marker(
                position:
                LatLng(_venueDetail.latitude!, _venueDetail.longitude!),
                markerId: const MarkerId("0")));
            isStateLoading = false;
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  slotDetail() {
    _networkCalls.slotDetail(
        id: widget.detail["pitchId"].toString(),
        subPitchId: widget.detail["subPitchId"]["id"].toString(),
        date: dataTime,
        dateTime: "&today_datetime=${DateTime.now().toString()}",
        onSuccess: (detail) {
          setState(() {
            slotModelClass = detail;
            if (slotModelClass.isNotEmpty &&
                slotModelClass[0].slotDetail!.isNotEmpty) {
              listMaxPlayer = List<int>.generate(
                  slotModelClass[0].slotDetail![0]!.maximumPlayers!.toInt(),
                      (i) => i + 1);
            } else {
              listMaxPlayer.clear();
            }
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  static const _kBasePadding = 16.0;
  static const kExpandedHeight = 250.0;

  final ValueNotifier<double> _titlePaddingNotifier =
  ValueNotifier(_kBasePadding);

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 60.0;

    if (_scrollController.hasClients) {
      return min(
          _kBasePadding + kCollapsedPadding,
          _kBasePadding +
              (kCollapsedPadding * _scrollController.offset) /
                  (kExpandedHeight - kToolbarHeight));
    }

    return _kBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return isStateLoading
        ? _buildShemmer(size.width, size.height)
        : internet
        ? DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0XFFE5E5E5),
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: AppBar(
              backgroundColor: const Color(0XFF032040),
            )),
        bottomNavigationBar: Container(
          color: const Color(0XFFE5E5E5),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 70,
              child: Material(
                color: const Color(0XFF25A163),
                child: InkWell(
                  splashColor: Colors.black,
                  onTap: tabIndex == 0
                      ? () {
                    setState(() {
                      tabController.index = 1;
                      tabIndex = 1;
                    });
                  }
                      : () {
                    if (_auth) {
                      if (_slotPrice.pricePerVenue.isEmpty &&
                          _slotPrice.pricePerPlayer.isEmpty) {
                        showMessage(
                            "Please select your slot first");
                      } else {
                        Map apiDetail = {
                          "date": dataTime,
                          "id": _slotTime
                        };
                        var detail = {
                          "price": isPerPlayer
                              ? slotPriceCalculation(_slotPrice
                              .pricePerPlayer) *
                              indexItem
                              : slotPriceCalculation(
                              _slotPrice.pricePerVenue),
                          "apiDetail": apiDetail,
                          "slotDetail": slotInformation,
                          "venueName":
                          _venueDetail.venueDetails!.name,
                          "pitchType": _venueDetail
                              .venueDetails!
                              .pitchType![0]!
                              .area,
                          "ids": widget.detail["pitchId"],
                          "subPitchId":
                          widget.detail["subPitchId"]["id"],
                          "player_count": indexItem,
                          "slug": isPerPlayer
                              ? "price-per-player"
                              : "venue-price"
                        };
                        print('VanueDetail$detail');
                        navigateToDetail(detail);
                      }
                    } else {
                      onWillPop();
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      child: tabIndex == 0
                          ? Text(
                        AppLocalizations.of(context)!.bookNowS,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            AppLocalizations.of(context)!
                                .locale ==
                                "en"
                                ? 18
                                : 22,
                            color: const Color(0XFFFFFFFF)),
                      )
                          : isPerPlayer
                          ? _slotPrice.pricePerPlayer.isEmpty
                          ? Text(
                        AppLocalizations.of(context)!
                            .bookNowS,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            AppLocalizations.of(
                                context)!
                                .locale ==
                                "en"
                                ? 18
                                : 22,
                            color: const Color(
                                0XFFFFFFFF)),
                      )
                          : Text(
                        "${AppLocalizations.of(context)!
                            .slotPrice}: ${(slotPriceCalculation(
                            _slotPrice.pricePerPlayer) * indexItem)
                            .round()
                            .toString()} AED",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            AppLocalizations.of(
                                context)!
                                .locale ==
                                "en"
                                ? 18
                                : 22,
                            color: const Color(
                                0XFFFFFFFF)),
                      )
                          : _slotPrice.pricePerVenue.isEmpty
                          ? Text(
                        AppLocalizations.of(context)!
                            .bookNowS,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            AppLocalizations.of(
                                context)!
                                .locale ==
                                "en"
                                ? 18
                                : 22,
                            color: const Color(
                                0XFFFFFFFF)),
                      )
                          : Text(
                        "${AppLocalizations.of(context)!
                            .slotPrice}: ${slotPriceCalculation(
                            _slotPrice.pricePerVenue).round().toString()} AED",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                            AppLocalizations.of(
                                context)!
                                .locale ==
                                "en"
                                ? 18
                                : 22,
                            color: const Color(
                                0XFFFFFFFF)),
                      )),
                ),
              ),
            ),
          ),
        ),
        body: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (context, value) {
            return [
              SliverAppBar(
                pinned: true,
                centerTitle: false,
                expandedHeight: 200.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  centerTitle: false,
                  titlePadding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 0),
                  title: ValueListenableBuilder(
                    valueListenable: _titlePaddingNotifier,
                    builder: (context, value, child) {
                      return Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: value),
                        child: GradientText(
                          _venueDetail.venueDetails!.name ?? "",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontFamily: "Poppins",
                              decoration: TextDecoration.none),
                          gradient: LinearGradient(colors: [
                            Colors.green.shade400,
                            Colors.green.shade500,
                            Colors.green.shade600,
                            Colors.green.shade700,
                            Colors.green.shade800,
                            Colors.green.shade900,
                          ]),
                        ),
                      );
                    },
                  ),
                  background: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                              builder: (context) =>
                                  StoryPage(
                                    files: _venueDetail
                                        .images!.files!,
                                  )));
                        },
                        child: CarouselSlider.builder(
                            carouselController: nextPageController,
                            itemCount:
                            _venueDetail.images!.files!.length,
                            itemBuilder: (BuildContext context,
                                int itemIndex, int pageViewIndex) {
                              return cachedNetworkImage(
                                height: 200,
                                imageFit: BoxFit.cover,
                                width:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                cuisineImageUrl: _venueDetail
                                    .images!
                                    .files![itemIndex]!
                                    .filePath ??
                                    "",
                              );
                            },
                            options: CarouselOptions(
                                height: 200,
                                viewportFraction: 1,
                                initialPage: 0,
                                autoPlay: true,
                                enableInfiniteScroll: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                pageSnapping: true,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    _currentIndexPage =
                                        index.toDouble();
                                  });
                                })),
                      ),
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 0.0,
                        child: DotsIndicator(
                          dotsCount:
                          _venueDetail.images!.files!.length,
                          position: _currentIndexPage.toInt(),
                          decorator: DotsDecorator(
                            activeSize: const Size(10.0, 10.0),
                            color: Colors.white,
                            activeColor: const Color(0xFF25A163),
                            activeShape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 20,
                    width: 20,
                    decoration: const BoxDecoration(
                        color: Color(0xFF25A163),
                        shape: BoxShape.circle),
                    child: RawMaterialButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 2.0,
                      fillColor: const Color(0xFF25A163),
                      padding: const EdgeInsets.all(5.0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.arrow_back_sharp,
                          color: Colors.white),
                    ),
                  ),
                ),
                actions: [
                  _auth
                      ? _venueDetail.isFavourite? IconButton(
                      onPressed: () {
                        _networkCalls
                            .checkInternetConnectivity(
                            onSuccess: (msg) {
                              if (msg) {
                                setState(() {
                                  _venueDetail.isFavourite =
                                  false;
                                  favorite(false);
                                });
                              } else {
                                showMessage(
                                    AppLocalizations.of(context)!
                                        .noInternetConnection);
                              }
                            });
                      },
                      icon: Image.asset(
                          "assets/images/favorite.png"))
                      : IconButton(
                      onPressed: () {
                        _networkCalls
                            .checkInternetConnectivity(
                            onSuccess: (msg) {
                              if (msg) {
                                setState(() {
                                  _venueDetail.isFavourite = true;
                                  favorite(true);
                                });
                              } else {
                                showMessage(
                                    AppLocalizations.of(context)!
                                        .noInternetConnection);
                              }
                            });
                      },
                      icon: Image.asset(
                        "assets/images/favorit.png",
                        color: Colors.red,
                      ))
                      : Container(),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: const BoxDecoration(
                        color: Color(0xFF25A163),
                        shape: BoxShape.circle),
                    child: RawMaterialButton(
                      onPressed: () {
                        Share.share(
                          "pitchDetail.link",
                          // subject:
                          // 'Look what I made!');
                          //launchInBrowser(pitchDetail.link);
                        );
                      },
                      elevation: 2.0,
                      fillColor: const Color(0xFF25A163),
                      padding: const EdgeInsets.all(5.0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.share,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
              // SliverToBoxAdapter(
              //   child: Container(
              //     height: 280,
              //     color: Colors.white,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: <Widget>[
              //         Stack(
              //           children: <Widget>[
              //             cachedNetworkImage(
              //               height: 220,
              //               width: MediaQuery.of(context).size.width,
              //               cuisineImageUrl: _venueDetail
              //                       .images.files[0].filePath ??
              //                   "",
              //             ),
              //             Row(
              //               children: [
              //                 Container(
              //                   height: 35,
              //                   width: 35,
              //                   decoration: const BoxDecoration(
              //                       color: Color(0xFF25A163),
              //                       shape: BoxShape.circle),
              //                   child: RawMaterialButton(
              //                     onPressed: () {
              //                       Navigator.of(context).pop();
              //                     },
              //                     elevation: 2.0,
              //                     fillColor: const Color(0xFF25A163),
              //                     child:const Icon(Icons.arrow_back_sharp,
              //                         color: Colors.white
              //                     ),
              //                     padding: const EdgeInsets.all(5.0),
              //                     shape: const CircleBorder(),
              //                   ),
              //                 ),
              //
              //                 Spacer(),
              //                 IconButton(
              //                     onPressed: () {
              //                       _networkCalls
              //                           .checkInternetConnectivity(
              //                               onSuccess: (msg) {
              //                         if (msg) {
              //                           favoriteState = false;
              //                         } else {
              //                           showMessage(
              //                               AppLocalizations.of(
              //                                       context)
              //                                   .noInternetConnection,
              //                               scaffoldkey);
              //                         }
              //                       });
              //                     },
              //                     icon: Image.asset(
              //                         "images/favorite.png")),
              //                 Container(
              //                   height: 35,
              //                   width: 35,
              //                   decoration: const BoxDecoration(
              //                       color: Color(0xFF25A163),
              //                       shape: BoxShape.circle),
              //                   child: RawMaterialButton(
              //                     onPressed: () {
              //                       Share.share(
              //                         "pitchDetail.link",
              //                         // subject:
              //                         // 'Look what I made!');
              //                         //launchInBrowser(pitchDetail.link);
              //                       );
              //                     },
              //                     elevation: 2.0,
              //                     fillColor: const Color(0xFF25A163),
              //                     child:const Icon( Icons.share,
              //                         color: Colors.white
              //                     ),
              //                     padding: const EdgeInsets.all(5.0),
              //                     shape: const CircleBorder(),
              //                   ),
              //                 ),
              //               ],
              //             )
              //           ],
              //         ),
              //         flaxibleGap(3),
              //         Row(
              //           children: [
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: size.width * .05),
              //               child: Container(
              //                 child: Text(
              //                   _venueDetail.venueDetails.name ?? "",
              //                   overflow: TextOverflow.ellipsis,
              //                   style: TextStyle(
              //                       fontSize: 16,
              //                       fontWeight: FontWeight.w500,
              //                       color: appTheamColor,
              //                       decoration: TextDecoration.none),
              //                 ),
              //               ),
              //             ),
              //             flaxibleGap(1),
              //             Padding(
              //               padding: EdgeInsets.symmetric(
              //                   horizontal: size.width * .05),
              //               child: Container(
              //                 height: 40,
              //                 width: 120,
              //                 color: appTheamColor,
              //                 alignment: Alignment.center,
              //                 child: Text(
              //                   _venueDetail.venueDetails?.gamePlay
              //                           ?.name ??
              //                       "",
              //                   style: TextStyle(
              //                       fontFamily: 'Poppins',
              //                       color: Colors.white,
              //                       //fontWeight: FontWeight.bold,
              //                       fontSize: 15),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         flaxibleGap(3),
              //       ],
              //     ),
              //   ),
              // ),

              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.only(bottom: 10),
              //     child: Container(
              //       color: Color(0XFFF0F0F0),
              //       padding: EdgeInsets.symmetric(
              //         horizontal: 20,
              //       ),
              //       height: 70.0 + (68.0 * (5 - 1)),
              //       alignment: Alignment.center,
              //       child: ListView.builder(
              //           physics: ScrollPhysics(),
              //           scrollDirection: Axis.vertical,
              //           itemCount: 5,
              //           itemBuilder:
              //               (BuildContext context, int blockIdx) {
              //             return Padding(
              //               padding: EdgeInsets.all(4.0),
              //               child: Container(
              //                 width: size.width * .28,
              //                 height: 60,
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: count == blockIdx
              //                       ? Color(0XFF25A163).withOpacity(.5)
              //                       : Colors.white,
              //                 ),
              //                 child: Row(
              //                   children: <Widget>[
              //                     flaxibleGap(1),
              //                     Text(
              //                       "5x5",
              //                       style: TextStyle(
              //                           fontSize: 20,
              //                           fontWeight: FontWeight.w600,
              //                           color: Color(0XFF032040),
              //                           decoration: TextDecoration.none),
              //                     ),
              //                     flaxibleGap(1),
              //                     Container(
              //                       height: size.height * .05,
              //                       width: 2,
              //                       color: Color(0XFF979797),
              //                     ),
              //                     flaxibleGap(1),
              //                     Column(
              //                       mainAxisAlignment:
              //                           MainAxisAlignment.center,
              //                       children: <Widget>[
              //                         Text(
              //                           "pitch_1",
              //                           style: TextStyle(
              //                               fontSize: 15,
              //                               fontWeight: FontWeight.w600,
              //                               color: Color(0XFF696969),
              //                               decoration:
              //                                   TextDecoration.none),
              //                         ),
              //                         Row(
              //                           children: <Widget>[
              //                             Text(
              //                               "${AppLocalizations.of(context).price} : ",
              //                               style: TextStyle(
              //                                   fontSize: 15,
              //                                   fontWeight:
              //                                       FontWeight.w600,
              //                                   color: Color(0XFF032040),
              //                                   decoration:
              //                                       TextDecoration.none),
              //                             ),
              //                             Text(
              //                               "${AppLocalizations.of(context).currency} 50",
              //                               style: TextStyle(
              //                                   fontSize: 15,
              //                                   fontWeight:
              //                                       FontWeight.w600,
              //                                   color: Color(0XFF25A163),
              //                                   decoration:
              //                                       TextDecoration.none),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                     flaxibleGap(1),
              //                     GestureDetector(
              //                         onTap: () {
              //                           setState(() {
              //                             if (count == blockIdx) {
              //                               pitchTypeName = "";
              //                               id = null;
              //                               count = null;
              //                             } else {
              //                               pitchTypeName = '';
              //                               id = 1;
              //                               count = blockIdx;
              //                             }
              //                           });
              //                         },
              //                         child: count == blockIdx
              //                             ? Image.asset(
              //                                 "images/check.png",
              //                                 color: Color(0XFF032040),
              //                                 height: 30,
              //                               )
              //                             : Image.asset(
              //                                 "images/unchecks.png",
              //                                 color: Color(0XFF032040),
              //                                 height: 30,
              //                               )),
              //                     flaxibleGap(1),
              //                   ],
              //                 ),
              //               ),
              //             );
              //           }),
              //     ),
              //   ),
              // ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(TabBar(
                  labelColor: const Color(0XFF032040),
                  controller: tabController,
                  labelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Poppins"),
                  unselectedLabelColor: const Color(0XFFADADAD),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding: const EdgeInsets.only(),
                  indicatorColor: const Color(0XFF032040),
                  indicatorWeight: 4,
                  tabs: [
                    Tab(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Container(
                            width: size.width * .4,
                            alignment: Alignment.bottomCenter,
                            child:
                            Text(AppLocalizations.of(context)!.about,
                                style: const TextStyle(
                                  //color: Color(0XFF032040),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins")),
                          ),
                        )),
                    Tab(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6.0),
                        child: Container(
                          width: size.width * .4,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            AppLocalizations.of(context)!.play,
                            style: const TextStyle(
                              // color: Color(0XFF032040),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Material(
                      elevation: 1,
                      borderRadius: const BorderRadius.all(
                          Radius.circular(20.0)),
                      color: Colors.white,
                      child: Container(
                        width: size.width,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .descriptionS,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0XFF424242),
                                )),
                            Text(_venueDetail
                                .venueDetails?.description ??
                                ""),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    elevation: 1,
                    borderRadius:
                    const BorderRadius.all(Radius.circular(20.0)),
                    color: Colors.white,
                    child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .facilitiesProvided,
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF424242),
                                  )),
                            ),
                            SizedBox(
                              width: size.width,
                              height: size.height * .13,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: _venueDetail
                                      .venueDetails!
                                      .facilities!
                                      .length,
                                  itemExtent: itemSize,
                                  controller: _controller,
                                  padding:
                                  AppLocalizations.of(context)!
                                      .locale ==
                                      "en"
                                      ? const EdgeInsets.only(
                                      left: 10)
                                      : const EdgeInsets.only(
                                      right: 10),
                                  itemBuilder: (BuildContext context,
                                      int blockIdx) {
                                    return Padding(
                                      padding:
                                      const EdgeInsets.all(2.0),
                                      child: Container(
                                        width: size.width * .28,
                                        height: size.width * .07,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10),
                                          color:
                                          const Color(0XFF25A163)
                                              .withOpacity(.3),
                                        ),
                                        child: Column(
                                          children: [
                                            flaxibleGap(2),
                                            cachedNetworkImage(
                                                height:
                                                size.height * .07,
                                                width:
                                                size.width * .18,
                                                cuisineImageUrl: _venueDetail
                                                    .venueDetails
                                                    ?.facilities![
                                                blockIdx]
                                                    ?.image ??
                                                    "",
                                                imageFit:
                                                BoxFit.contain),
                                            flaxibleGap(1),
                                            Text(
                                                _venueDetail
                                                    .venueDetails
                                                    ?.facilities![
                                                blockIdx]
                                                    ?.name ??
                                                    "",
                                                style: const TextStyle(
                                                    fontFamily:
                                                    'Poppins',
                                                    fontSize: 12,
                                                    color: Color(
                                                        0XFF424242),
                                                    decoration:
                                                    TextDecoration
                                                        .none)),
                                            flaxibleGap(1),
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      openMapsSheet(context);
                      // makeMap(_getLaunchUrl().toString());
                    },
                    child: Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        children: [
                          Container(
                            width: size.width,
                            height: size.height * .2,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0)),
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20.0),
                                  topLeft: Radius.circular(20.0)),
                              child: GoogleMap(
                                zoomControlsEnabled: true,
                                myLocationButtonEnabled: false,
                                onTap: (value) {
                                  openMapsSheet(context);
                                  //makeMap(_getLaunchUrl().toString());
                                },
                                mapType: MapType.normal,
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        _venueDetail.latitude!,
                                        _venueDetail.longitude!),
                                    zoom: 15.0),
                                // markers: Set.identity(),
                                markers: Set.from(allMarkers),
                              ),
                            ),
                          ),
                          Material(
                            elevation: 1,
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20.0),
                                bottomLeft: Radius.circular(20.0)),
                            child: SizedBox(
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 7, left: 7, top: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 20,
                                            ),
                                            SizedBox(
                                              width: size.width * .6,
                                              child: Text(
                                                AppLocalizations.of(
                                                    context)!
                                                    .location,
                                                overflow: TextOverflow
                                                    .ellipsis,
                                                maxLines: 5,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                    Colors.black,
                                                    fontWeight:
                                                    FontWeight
                                                        .w500,
                                                    decoration:
                                                    TextDecoration
                                                        .none),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width * .75,
                                          child: Text(
                                            _venueDetail.venueDetails
                                                ?.location ??
                                                "",
                                            overflow:
                                            TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color:
                                                Color(0XFF8B8B8B),
                                                fontWeight:
                                                FontWeight.w500,
                                                decoration:
                                                TextDecoration
                                                    .none),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      color: Colors.black
                                          .withOpacity(.3),
                                      height: 60,
                                      width: 2,
                                    ),
                                    Image.asset(
                                      "assets/images/location_direction.png",
                                      height: 30,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: EdgeInsets.symmetric(vertical: 10),
                  //   child: Material(
                  //     elevation: 10,
                  //     child: Container(
                  //         width: MediaQuery.of(context).size.width,
                  //         color: Colors.white,
                  //         child: Padding(
                  //           padding:
                  //           AppLocalizations.of(context)!.locale == "en"
                  //               ? EdgeInsets.only(
                  //             left: 20,
                  //             bottom: 20,
                  //           )
                  //               : EdgeInsets.only(
                  //             right: 20,
                  //             bottom: 20,
                  //           ),
                  //           child: Column(
                  //             mainAxisAlignment: MainAxisAlignment.start,
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: <Widget>[
                  //               Padding(
                  //                 padding:
                  //                 EdgeInsets.only(top: 10, bottom: 10),
                  //                 child: Row(
                  //                   children: <Widget>[
                  //                     Padding(
                  //                       padding: AppLocalizations.of(context)!
                  //                           .locale ==
                  //                           "en"
                  //                           ? EdgeInsets.only(right: 10)
                  //                           : EdgeInsets.only(left: 10),
                  //                       child: Image.asset("images/organized_image.png",height: 20,),
                  //                     ),
                  //                     Text(
                  //                         "Oragnised By",
                  //                         style: TextStyle(
                  //                             fontSize: 14,
                  //                             fontWeight: FontWeight.w500,
                  //                             color: Color(0XFF303030
                  //                             ),
                  //                             decoration:
                  //                             TextDecoration.none))
                  //                   ],
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: EdgeInsets.only(bottom: 5),
                  //                 child: Text(
                  //                     "Downtown Dubai Hub" ?? '',
                  //                     style: TextStyle(
                  //                         fontSize: 16,
                  //                         fontWeight: FontWeight.w600,
                  //                         color: Color(0XFF032040),
                  //                         decoration: TextDecoration.none)),
                  //               ),
                  //               Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi.",
                  //                   style: TextStyle(
                  //                       fontSize: 16,
                  //                       color: Color(0XFF424242),
                  //                       decoration: TextDecoration.none))
                  //             ],
                  //           ),
                  //         )),
                  //   ),
                  // ),
                  weekdayWidget(size),
                  Container(
                    height: 20,
                    color: Colors.transparent,
                  )
                ],
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                      height: _boxHeight,
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 20),
                      child: Material(
                        elevation: 1,
                        child: Container(
                          width: size.width,
                          color: Colors.white,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                                itemCount: 14,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (date != index) {
                                          _slotTime.clear();
                                          _slotPrice.pricePerPlayer
                                              .clear();
                                          _slotPrice.pricePerVenue
                                              .clear();
                                          slotInformation = {};
                                          date = index;
                                          dataTime = apiFormatter
                                              .format(DateTime.now()
                                              .add(Duration(
                                              days: index)));
                                          slotDetail();
                                          _slotPrice = SlotPrice(
                                              pricePerVenue: [],
                                              pricePerPlayer: []);
                                        }
                                      });
                                    },
                                    child: date == index
                                        ? Padding(
                                      padding: const EdgeInsets
                                          .symmetric(
                                          vertical: 8.0),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        alignment:
                                        Alignment.center,
                                        decoration: const BoxDecoration(
                                            color: Color(
                                                0XFF25A163),
                                            borderRadius:
                                            BorderRadius
                                                .all(Radius
                                                .circular(
                                                5))),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              DateFormat('E')
                                                  .format(DateTime
                                                  .now()
                                                  .add(Duration(
                                                  days:
                                                  index))),
                                              style: const TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                            Text(
                                              DateTime
                                                  .now()
                                                  .add(Duration(
                                                  days:
                                                  index))
                                                  .day
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Colors
                                                      .white,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(
                                      height: 60,
                                      width: 60,
                                      alignment:
                                      Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            DateFormat('E')
                                                .format(DateTime
                                                .now()
                                                .add(Duration(
                                                days:
                                                index))),
                                            style: const TextStyle(
                                                color: Color(
                                                    0XFFA3A3A3),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight
                                                    .w500),
                                          ),
                                          Text(
                                            DateTime
                                                .now()
                                                .add(Duration(
                                                days:
                                                index))
                                                .day
                                                .toString(),
                                            style: const TextStyle(
                                                color: Color(
                                                    0XFFA3A3A3),
                                                fontSize: 16,
                                                fontWeight:
                                                FontWeight
                                                    .w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: size.width * .05,
                          right: size.width * .05,
                          bottom: 10),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          AppLocalizations.of(context)!.locale == "en"
                              ? SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: isPerPlayer
                                      ? null
                                      : () {
                                    setState(() {
                                      _slotTime.clear();
                                      _slotPrice
                                          .pricePerPlayer
                                          .clear();
                                      _slotPrice
                                          .pricePerVenue
                                          .clear();
                                      slotInformation =
                                      {};
                                      isPerPlayer = true;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    decoration: BoxDecoration(
                                      color: isPerPlayer
                                          ? const Color(
                                          0XFF25A163)
                                          : Colors.white,
                                      borderRadius:
                                      const BorderRadius
                                          .only(
                                        topLeft:
                                        Radius.circular(40),
                                        bottomLeft:
                                        Radius.circular(40),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(
                                            0XFF25A163),
                                        style:
                                        BorderStyle.solid,
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .perPlayer),
                                  ),
                                ),
                                InkWell(
                                  onTap: !isPerPlayer
                                      ? null
                                      : () {
                                    if (_venueDetail
                                        .sports!
                                        .sportSlug ==
                                        "swimming") {
                                      showMessage(
                                          "${AppLocalizations.of(context)!
                                              .perVenue} ${AppLocalizations.of(
                                              context)!
                                              .unavailable} for ${_venueDetail
                                              .sports!.name}");
                                    } else {
                                      setState(() {
                                        _slotTime.clear();
                                        _slotPrice
                                            .pricePerPlayer
                                            .clear();
                                        _slotPrice
                                            .pricePerVenue
                                            .clear();
                                        slotInformation =
                                        {};
                                        isPerPlayer =
                                        false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isPerPlayer
                                          ? Colors.white
                                          : const Color(
                                          0XFF25A163),
                                      borderRadius:
                                      const BorderRadius
                                          .only(
                                        topRight:
                                        Radius.circular(40),
                                        bottomRight:
                                        Radius.circular(40),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(
                                            0XFF25A163),
                                        style:
                                        BorderStyle.solid,
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .perVenue),
                                  ),
                                )
                              ],
                            ),
                          )
                              : SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: isPerPlayer
                                      ? null
                                      : () {
                                    if (_venueDetail
                                        .sports!
                                        .sportSlug ==
                                        "swimming") {
                                      showMessage(
                                          "${AppLocalizations.of(context)!
                                              .perVenue} ${AppLocalizations.of(
                                              context)!
                                              .unavailable} for ${_venueDetail
                                              .sports!.name}");
                                    } else {
                                      setState(() {
                                        _slotTime.clear();
                                        _slotPrice
                                            .pricePerPlayer
                                            .clear();
                                        _slotPrice
                                            .pricePerVenue
                                            .clear();
                                        slotInformation =
                                        {};
                                        isPerPlayer =
                                        false;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: isPerPlayer
                                          ? Colors.white
                                          : const Color(
                                          0XFF25A163),
                                      borderRadius:
                                      const BorderRadius
                                          .only(
                                        topRight:
                                        Radius.circular(40),
                                        bottomRight:
                                        Radius.circular(40),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(
                                            0XFF25A163),
                                        style:
                                        BorderStyle.solid,
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .perVenue),
                                  ),
                                ),
                                InkWell(
                                  onTap: isPerPlayer
                                      ? null
                                      : () {
                                    setState(() {
                                      _slotTime.clear();
                                      _slotPrice
                                          .pricePerPlayer
                                          .clear();
                                      _slotPrice
                                          .pricePerVenue
                                          .clear();
                                      slotInformation =
                                      {};
                                      isPerPlayer = true;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding:
                                    const EdgeInsets.all(
                                        10.0),
                                    decoration: BoxDecoration(
                                      color: isPerPlayer
                                          ? const Color(
                                          0XFF25A163)
                                          : Colors.white,
                                      borderRadius:
                                      const BorderRadius
                                          .only(
                                        topLeft:
                                        Radius.circular(40),
                                        bottomLeft:
                                        Radius.circular(40),
                                      ),
                                      border: Border.all(
                                        width: 1,
                                        color: const Color(
                                            0XFF25A163),
                                        style:
                                        BorderStyle.solid,
                                      ),
                                    ),
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .perPlayer),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width * .36,
                            child: CustomDropdown(
                              leadingIcon: false,
                              icon: Image.asset(
                                "assets/images/drop_down.png",
                                height: 6,
                                color: appThemeColor,
                              ),
                              onChange: (int value, int index) =>
                                  setState(() {
                                    indexItemSubPitch = index;
                                  }),
                              dropdownButtonStyle:
                              const DropdownButtonStyle(
                                width: 160,
                                height: 45,
                                elevation: 1,
                                backgroundColor: Colors.white,
                              ),
                              dropdownStyle: DropdownStyle(
                                borderRadius:
                                BorderRadius.circular(0),
                                elevation: 6,
                                padding: const EdgeInsets.all(5),
                              ),
                              items: _venueDetail
                                  .venueDetails!.pitchType!
                                  .asMap()
                                  .entries
                                  .map(
                                    (item) =>
                                    DropdownItem(
                                      value: item.key + 1,
                                      child: SizedBox(
                                        height: 30,
                                        child: Text(
                                            item.value!.area
                                                .toString(),
                                            textAlign:
                                            TextAlign.center,
                                            style: const TextStyle(
                                              color: appThemeColor,
                                            )),
                                      ),
                                    ),
                              )
                                  .toList(),
                              child: Text(
                                _venueDetail
                                    .venueDetails!.pitchType![0]!.area
                                    .toString(),
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: appThemeColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    !isPerPlayer
                        ? const SizedBox.shrink()
                        : listMaxPlayer.isNotEmpty
                        ? IgnorePointer(
                      ignoring: !isPerPlayer,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .05),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,
                          children: [
                            Text(
                              AppLocalizations.of(context)!
                                  .selectnumber,
                              style: const TextStyle(
                                  color: appThemeColor),
                            ),
                            SizedBox(
                              width: size.width * .4,
                              child: CustomDropdown(
                                leadingIcon: false,
                                icon: Image.asset(
                                  "assets/images/drop_down.png",
                                  height: 6,
                                  color: appThemeColor,
                                ),
                                onChange:
                                    (int value, int index) {
                                  if (index !=
                                      indexItem - 1) {
                                    setState(() {
                                      indexItem = index + 1;
                                    });
                                  }
                                },
                                dropdownButtonStyle:
                                const DropdownButtonStyle(
                                  width: 170,
                                  height: 45,
                                  elevation: 1,
                                  backgroundColor:
                                  Colors.white,
                                ),
                                dropdownStyle:
                                DropdownStyle(
                                  borderRadius:
                                  BorderRadius.circular(
                                      0),
                                  elevation: 6,
                                  padding:
                                  const EdgeInsets.all(
                                      5),
                                ),
                                items: listMaxPlayer
                                    .asMap()
                                    .entries
                                    .map(
                                      (item) =>
                                      DropdownItem(
                                        value: item.key,
                                        child: SizedBox(
                                          height: 30,
                                          child: isPerPlayer
                                              ? Text(
                                              item.value
                                                  .toString(),
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: const TextStyle(
                                                  color:
                                                  appThemeColor))
                                              : Text(
                                              listMaxPlayer[listMaxPlayer
                                                  .length -
                                                  1]
                                                  .toString(),
                                              textAlign:
                                              TextAlign
                                                  .center,
                                              style: const TextStyle(
                                                  color:
                                                  appThemeColor)),
                                        ),
                                      ),
                                )
                                    .toList(),
                                child: !isPerPlayer
                                    ? Text(
                                    listMaxPlayer[
                                    listMaxPlayer
                                        .length -
                                        1]
                                        .toString(),
                                    textAlign: TextAlign
                                        .center,
                                    style: const TextStyle(
                                        color:
                                        appThemeColor))
                                    : Text(
                                  listMaxPlayer[0]
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color:
                                      appThemeColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                        : const SizedBox.shrink(),
                    const Divider(),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          slotModelClass.isEmpty
                              ? SizedBox(
                            height: 100,
                            child: Center(
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .thisDayHoliday),
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0),
                            child: ListView.builder(
                              itemCount: slotModelClass.length,
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return slotModelClass[index]
                                    .slotDetail!
                                    .isEmpty
                                    ? SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                        AppLocalizations.of(
                                            context)!
                                            .noSlotsAvailable),
                                  ),
                                )
                                    : Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment
                                      .start,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                          vertical:
                                          8.0),
                                      child: InkWell(
                                        onTap: () {
                                          print("${slotModelClass[index]
                                              .sessionName} ( ${slotModelClass[index]
                                              .slotDetail![0]!.sportSlotTime
                                              .toString()} mins Slot )",);
                                        },
                                        child: Text(
                                          "${slotModelClass[index]
                                              .sessionName} ( ${slotModelClass[index]
                                              .slotDetail![0]!.sportSlotTime
                                              .toString()} mins Slot )",
                                          style: const TextStyle(
                                              color:
                                              appThemeColor,
                                              fontSize: 14,
                                              fontWeight:
                                              FontWeight
                                                  .w600),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                          vertical:
                                          10),
                                      child: GridView
                                          .builder(
                                          shrinkWrap:
                                          true,
                                          itemCount: slotModelClass[
                                          index]
                                              .slotDetail!
                                              .length,
                                          physics:
                                          const NeverScrollableScrollPhysics(),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent:
                                              100,
                                              childAspectRatio:
                                              4 /
                                                  2,
                                              crossAxisSpacing:
                                              20,
                                              mainAxisSpacing:
                                              20),
                                          itemBuilder:
                                              (context,
                                              indexx) {
                                            return !slotModelClass[index]
                                                .slotDetail![indexx]!
                                                .isBooked! &&
                                                availability(
                                                    slotModelClass[index]
                                                        .slotDetail![indexx])!
                                                ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_slotTime.contains(
                                                      slotModelClass[index]
                                                          .slotDetail![indexx]!
                                                          .id)) {
                                                    _slotTime.remove(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .id);
                                                    _slotPrice.pricePerPlayer
                                                        .remove(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .slotPlayerPrice);
                                                    _slotPrice.pricePerVenue
                                                        .remove(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .slotPrice);
                                                    if (slotInformation[slotModelClass[index]
                                                        .sessionName]!.length >
                                                        1) {
                                                      slotInformation[slotModelClass[index]
                                                          .sessionName]!.remove(
                                                          slotModelClass[index]
                                                              .slotDetail![indexx]!
                                                              .startTime);
                                                    } else {
                                                      slotInformation.remove(
                                                          slotModelClass[index]
                                                              .sessionName);
                                                    }
                                                  } else {
                                                    _slotTime.add(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .id!.toInt());
                                                    _slotPrice.pricePerPlayer
                                                        .add(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .slotPlayerPrice!
                                                            .toDouble());
                                                    _slotPrice.pricePerVenue
                                                        .add(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .slotPrice!
                                                            .toDouble());
                                                    if (slotInformation
                                                        .containsKey(
                                                        slotModelClass[index]
                                                            .sessionName)) {
                                                      slotInformation[slotModelClass[index]
                                                          .sessionName]!.add(
                                                          slotModelClass[index]
                                                              .slotDetail![indexx]!
                                                              .startTime
                                                              .toString());
                                                    } else {
                                                      slotInformation[slotModelClass[index]
                                                          .sessionName
                                                          .toString()] = [
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .startTime
                                                            .toString()
                                                      ];
                                                    }
                                                  }
                                                });
                                              },
                                              child: _slotTime.contains(
                                                  slotModelClass[index]
                                                      .slotDetail![indexx]!.id)
                                                  ?
                                              // Container()
                                              Container(
                                                  height: 100,
                                                  width: 140,
                                                  alignment: Alignment
                                                      .bottomLeft,
                                                  child: Badge(
                                                    label: Text(
                                                      slotModelClass[index]
                                                          .slotDetail![indexx]!
                                                          .maximumPlayers
                                                          .toString(),
                                                      // slotModelClass[index].slotDetail![indexx]!.bookedPlayersCount!.toInt()).toString(),
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight
                                                              .w600),
                                                    ),
                                                    isLabelVisible: isPerPlayer,
                                                    backgroundColor: appThemeColor,
                                                    alignment: Alignment
                                                        .topRight,
                                                    child: Container(
                                                      height: 35,
                                                      width: 70,
                                                      alignment: Alignment
                                                          .center,
                                                      decoration: BoxDecoration(
                                                          color: const Color(
                                                              0XFF25A163),
                                                          border: Border.all(
                                                              color: const Color(
                                                                  0XFF25A163))),
                                                      child: Text(
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .startTime!
                                                            .substring(0, 5) ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontWeight: FontWeight
                                                                .w600,
                                                            fontSize: 16,
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    ),
                                                  ))
                                                  :
                                              // Container()
                                              Container(
                                                height: 100,
                                                width: 140,
                                                alignment: Alignment.bottomLeft,
                                                child: Badge(
                                                  isLabelVisible: isPerPlayer,
                                                  label: Text(
                                                    (slotModelClass[index]
                                                        .slotDetail![indexx]!
                                                        .maximumPlayers! -
                                                        slotModelClass[index]
                                                            .slotDetail![indexx]!
                                                            .bookedPlayersCount!
                                                            .toInt())
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: appThemeColor,
                                                        fontWeight: FontWeight
                                                            .w600),
                                                  ),
                                                  backgroundColor: Colors.white,
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    height: 35,
                                                    width: 70,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors
                                                                .grey)),
                                                    child: Text(
                                                      slotModelClass[index]
                                                          .slotDetail![indexx]!
                                                          .startTime!.substring(
                                                          0, 5) ?? "",
                                                      style: const TextStyle(
                                                          fontWeight: FontWeight
                                                              .w600,
                                                          fontSize: 16,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                                : !slotModelClass[index]
                                                .slotDetail![indexx]!
                                                .isAvailable!
                                                ? Container(
                                              height: 40,
                                              width: 80,
                                              alignment: Alignment.center,
                                              color: appThemeColor,
                                              child: Text(
                                                slotModelClass[index]
                                                    .slotDetail![indexx]!
                                                    .startTime!.substring(
                                                    0, 5) ?? "",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            )
                                                : Container(
                                              height: 40,
                                              width: 80,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey,
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Text(
                                                slotModelClass[index]
                                                    .slotDetail![indexx]!
                                                    .startTime!.substring(
                                                    0, 5) ?? "",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(
                          //     horizontal: 10.0,
                          //     vertical: 10,
                          //   ),
                          //   child: Row(
                          //       mainAxisAlignment:
                          //           MainAxisAlignment.start,
                          //       children: [
                          //         Image.asset(
                          //           "images/unavailable_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Unavailable",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/available_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Available",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/selected_image.png",
                          //           height: 20,
                          //           width: 20,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Selected",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //         fixedGap(width: 20.0),
                          //         Image.asset(
                          //           "images/selected_image.png",
                          //           height: 20,
                          //           width: 20,
                          //           color: appTheamColor,
                          //         ),
                          //         fixedGap(width: 10.0),
                          //         Text(
                          //           "Booked",
                          //           style: TextStyle(
                          //               fontSize: 10,
                          //               fontWeight: FontWeight.w400,
                          //               color: Colors.black),
                          //         ),
                          //       ]),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    )
        : Material(
      child: SizedBox(
        height: size.height,
        width: size.width,
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

  void navigateToDetail(Map detail) {
    Navigator.pushNamed(context, RouteNames.enterDetailPitch,
        arguments: detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  double slotPriceCalculation(List<double> priceList) {
    double slotPrice = 0.0;
    for (var element in priceList) {
      slotPrice = slotPrice + element;
    }
    return slotPrice;
  }

  bool? availability(var value) {
    if (value.isBooked) {
      return false;
    } else if (!value.bookedPlayer && !value.bookedVenue) {
      return true;
    } else if (value.bookedPlayer && !value.bookedVenue) {
      return isPerPlayer ? true : false;
    }
    return null;
  }

  _buildShemmer(sizewidth, sizeheight) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      bottomNavigationBar: Container(
        color: const Color(0XFF25A163),
        child: SizedBox(
          height: 70,
          child: Material(
            color: const Color(0XFF25A163),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                AppLocalizations.of(context)!.bookNowS,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize:
                    AppLocalizations.of(context)!.locale == "en" ? 18 : 22,
                    color: const Color(0XFFFFFFFF)),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        height: sizeheight,
        width: sizewidth,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 200,
                color: const Color(0XFF032040),
                child: Stack(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        height: 200,
                        color: Colors.white,
                        width: sizewidth,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: const BoxDecoration(
                                color: Color(0xFF25A163),
                                shape: BoxShape.circle),
                            child: const RawMaterialButton(
                              onPressed: null,
                              elevation: 2.0,
                              fillColor: Color(0xFF25A163),
                              padding: EdgeInsets.all(5.0),
                              shape: CircleBorder(),
                              child: Icon(Icons.arrow_back_sharp,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 35,
                          width: 35,
                          decoration: const BoxDecoration(
                              color: Color(0xFF25A163), shape: BoxShape.circle),
                          child: const RawMaterialButton(
                            onPressed: null,
                            elevation: 2.0,
                            fillColor: Color(0xFF25A163),
                            padding: EdgeInsets.all(5.0),
                            shape: CircleBorder(),
                            child: Icon(Icons.share, color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: const Color(0XFFF0F0F0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 5, right: 7),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.grey.shade100,
                    enabled: true,
                    child: Container(
                      height: 50,
                      width: sizewidth * .5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                width: sizewidth,
                height: sizeheight * .22,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: const Color(0XFFF0F0F0),
                child: Padding(
                  padding: const EdgeInsets.only(left: 7, top: 5, right: 7),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Container(
                            height: 50,
                            width: sizewidth * .5,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.all(Radius.circular(5.0) //

                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                color: const Color(0XFFF0F0F0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding:
                            AppLocalizations.of(context)!.locale == "en"
                                ? const EdgeInsets.only(right: 10)
                                : const EdgeInsets.only(left: 10),
                            child: const Icon(Icons.event),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .5,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .2,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .2,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 30,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 30,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 30,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 30,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 20),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          height: 30,
                          width: sizewidth * .7,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                            BorderRadius.all(Radius.circular(5.0) //

                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: sizeheight * .25,
                  color: const Color(0XFFF0F0F0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        child: Row(
                          children: <Widget>[
                            Padding(
                              padding:
                              AppLocalizations.of(context)!.locale == "en"
                                  ? const EdgeInsets.only(
                                right: 10,
                              )
                                  : const EdgeInsets.only(
                                left: 10,
                              ),
                              child: const Icon(Icons.description),
                            ),
                            Text(AppLocalizations.of(context)!.facilityProvided,
                                style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: Color(0XFF424242),
                                    decoration: TextDecoration.none))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: sizewidth,
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios),
                            SizedBox(
                              height: sizeheight * .15,
                              width: sizewidth * .82,
                              child: ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemExtent: itemSize,
                                  itemBuilder:
                                      (BuildContext context, int blockIdx) {
                                    return Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          width: sizewidth * .28,
                                          height: sizewidth * .07,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: const Color(0XFF25A163)
                                                .withOpacity(.3),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: const Color(0XFFF0F0F0),
                  child: Padding(
                    padding: AppLocalizations.of(context)!.locale == "en"
                        ? const EdgeInsets.only(
                      left: 20,
                      bottom: 20,
                    )
                        : const EdgeInsets.only(
                      right: 20,
                      bottom: 20,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10,
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding:
                                AppLocalizations.of(context)!.locale == "en"
                                    ? const EdgeInsets.only(right: 10)
                                    : const EdgeInsets.only(left: 10),
                                child: const Icon(Icons.person),
                              ),
                              Text(AppLocalizations.of(context)!.organisedby,
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: Color(0XFF424242),
                                      decoration: TextDecoration.none))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .4,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 50,
                              width: sizewidth,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0) //

                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget weekdayWidget(var size) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: 320,
        decoration: BoxDecoration(
          color: const Color(0XFF25A163).withOpacity(.2),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: size.width,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.day,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(AppLocalizations.of(context)!.start,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                    Text(AppLocalizations.of(context)!.end,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ),
            _buildDays(AppLocalizations.of(context)!.monday,
                _venueDetail.weekTimeTable!.monday),
            _buildDays(AppLocalizations.of(context)!.tuesday,
                _venueDetail.weekTimeTable!.tuesday),
            _buildDays(AppLocalizations.of(context)!.wednesday,
                _venueDetail.weekTimeTable!.wednesday),
            _buildDays(AppLocalizations.of(context)!.thursday,
                _venueDetail.weekTimeTable!.thursday),
            _buildDays(AppLocalizations.of(context)!.friday,
                _venueDetail.weekTimeTable!.friday),
            _buildDays(AppLocalizations.of(context)!.saturday,
                _venueDetail.weekTimeTable!.saturday),
            _buildDays(AppLocalizations.of(context)!.sunday,
                _venueDetail.weekTimeTable!.sunday),
          ],
        ));
  }

  Widget _buildDays(String days, TimeTable? venueDay) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 90,
              child: Text(
                days,
                style: const TextStyle(
                    color: Color(0xFF868686),
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )),
          _buildHolidayStart(venueDay ??
              TimeTable(endTime: '10:00:00', startTime: '10:00:00')),
          _buildHoliday(venueDay ??
              TimeTable(startTime: '10:00:00', endTime: '10:00:00')),
        ],
      ),
    );
  }

  Widget _buildHoliday(TimeTable time) {
    return time != null
        ? Text(time.endTime.toString(),
        style: const TextStyle(
            color: Color(0xFF868686),
            fontSize: 14,
            fontWeight: FontWeight.w500))
        : Text(AppLocalizations.of(context)!.holiday,
        style: const TextStyle(
            color: Color(0xFF868686),
            fontSize: 14,
            fontWeight: FontWeight.w500));
  }

  Widget _buildHolidayStart(TimeTable time) {
    return time != null
        ? Text(time.startTime.toString(),
        style: const TextStyle(
            color: Color(0xFF868686),
            fontSize: 14,
            fontWeight: FontWeight.w500))
        : Text(AppLocalizations.of(context)!.holiday,
        style: const TextStyle(
            color: Color(0xFF868686),
            fontSize: 14,
            fontWeight: FontWeight.w500));
  }
}

class Cliping extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 20);
    path.quadraticBezierTo(
        size.width / 3, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 20);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 50;

  @override
  double get maxExtent => 50;

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return Material(
      elevation: 1,
      color: const Color(0XFFE5E5E5),
      child: SizedBox(
        height: 60,
        child: _tabBar,
      ),
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }
}

class CalenderList {
  String? date;
  String? day;

  CalenderList({this.date, this.day});

  @override
  bool operator ==(Object other) {
    if (other is CalenderList) {
      return other.date == date && other.day == day;
    }
    return false;
  }
}

class SlotPrice {
  bool isPlayer;
  List<double> pricePerPlayer;
  List<double> pricePerVenue;

  SlotPrice({required this.pricePerPlayer,
    this.isPlayer = false,
    required this.pricePerVenue});
}
