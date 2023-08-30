import 'dart:math';
import 'dart:ui' as ui;

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;

import '../../../../../../common_widgets/grediant_text.dart';
import '../../../../../../common_widgets/story_view.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/venue_detail_model_class.dart';
import '../../../../../../modelClass/venue_slot_model_class.dart';
import '../../../../../../network/network_calls.dart';
import '../../../../../../player/bookPitch/venueDetail.dart';

class GroundDetail extends StatefulWidget {
  Map detail;

  GroundDetail({super.key, required this.detail});

  @override
  State<GroundDetail> createState() => _GroundDetailState();
}

class _GroundDetailState extends State<GroundDetail>
    with TickerProviderStateMixin {
  late bool internet;
  SpecificVenueModelClass _venueDetail = SpecificVenueModelClass();
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  final DateFormat apiFormatter = DateFormat('yyyy-MM-dd', 'en_US');
  bool isStateLoading = true;
  bool _auth = false;
  final SlotPrice _slotPrice =
      SlotPrice(isPlayer: false, pricePerPlayer: [], pricePerVenue: []);
  double _currentIndexPage = 0;
  List<int> listMaxPlayer = [];
  Map<String, List<String>> slotInformation = {};
  bool? favoriteState;
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
      "is_favourite": favoriteState ?? 'yes'
    };
    await _networkCalls.favorite(
      detail: detail,
      onSuccess: (msg) {
        venueDetail();
        print('Detail$detail');
      },
      onFailure: (msg) {
        venueDetail();
        showMessage(msg);
        print('DetailFailed$detail');
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  addMarker() async {
    allMarkers.clear();
    getBytesFromAsset("assets/images/marker.png", 70)
        .then((markerIcon) => setState(() {
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
                  // navigateToDetail1();
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

  venueDetail() async {
    await _networkCalls.venueDetail(
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

  slotDetail() async {
    await _networkCalls.slotDetail(
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            centerTitle: false,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              centerTitle: false,
              titlePadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
              background: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => StoryPage(
                                files: _venueDetail.images!.files!,
                              )));
                    },
                    child: CarouselSlider.builder(
                        carouselController: nextPageController,
                        itemCount: _venueDetail.images == null
                            ? 5
                            : _venueDetail.images!.files!.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          return cachedNetworkImage(
                            height: height * 0.3,
                            imageFit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                            cuisineImageUrl: _venueDetail
                                    .images?.files![itemIndex]!.filePath ??
                                "",
                          );
                        },
                        options: CarouselOptions(
                            height: height,
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
                  ),
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: DotsIndicator(
                      dotsCount: _venueDetail.images == null
                          ? 5
                          : _venueDetail.images!.files!.length,
                      position: _currentIndexPage.toInt(),
                      decorator: DotsDecorator(
                        activeSize: const Size(20.0, 10.0),
                        color: Colors.grey,
                        activeColor: const Color(0xFF25A163),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // leading: Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //     height: 20,
            //     width: 20,
            //     decoration: const BoxDecoration(
            //         color: Color(0xFF25A163), shape: BoxShape.circle),
            //     child: RawMaterialButton(
            //       onPressed: () {
            //         Navigator.of(context).pop();
            //       },
            //       elevation: 2.0,
            //       fillColor: const Color(0xFF25A163),
            //       padding: const EdgeInsets.all(5.0),
            //       shape: const CircleBorder(),
            //       child:
            //           const Icon(Icons.arrow_back_sharp, color: Colors.white),
            //     ),
            //   ),
            // ),
            actions: [
              _auth
                  ? IconButton(
                      onPressed: () {
                        _networkCalls.checkInternetConnectivity(
                            onSuccess: (msg) {
                          if (msg) {
                            if (_venueDetail.isFavourite == false) {
                              _venueDetail.isFavourite = true;
                              favorite(true);
                            } else {
                              _venueDetail.isFavourite = false;
                              favorite(false);
                            }
                            setState(() {});
                          } else {
                            showMessage(AppLocalizations.of(context)!
                                .noInternetConnection);
                          }
                        });
                      },
                      icon: Icon(
                        _venueDetail.isFavourite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: height * 0.05,
                      ))
                  : Container(),
              Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                    // color: Color(0xFF25A163),
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
                  // fillColor: const Color(0xFF25A163),
                  padding: const EdgeInsets.all(5.0),
                  shape: const CircleBorder(),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: height * 0.05,
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.03,
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: height * 0.024, vertical: height * 0.033),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _venueDetail.images != null
                              ? GradientText(
                                  _venueDetail.venueDetails!.name ?? "",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: height * 0.026,
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      decoration: TextDecoration.none),
                                  gradient: LinearGradient(colors: [
                                    Colors.green.shade100,
                                    Colors.lightGreenAccent.shade200,
                                    Colors.lightGreenAccent.shade400,
                                    Colors.lightGreenAccent.shade700,
                                  ]),
                                )
                              : SizedBox(
                                  height: height * 0.028,
                                  width: width * 0.04,
                                  child: const CircularProgressIndicator(
                                    color: Colors.greenAccent,
                                    strokeAlign: 1,
                                    strokeWidth: 2,
                                  ),
                                ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Text(
                            AppLocalizations.of(context)!.descriptionS,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          ReadMoreText(
                            _venueDetail.venueDetails?.description ?? "",
                            trimLength: 2,
                            trimMode: TrimMode.Line,
                            lessStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            moreStyle: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            trimCollapsedText: 'See More',
                            trimExpandedText: 'See Less',
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Text('Ground List',
                              style: TextStyle(fontSize: height * 0.03)),
                          ...List.generate(
                              3,
                              (index) => Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.01,
                                        vertical: height * 0.01),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white70,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 1,
                                              offset: Offset(0, 1),
                                              blurStyle: BlurStyle.outer,
                                            )
                                          ]),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: width * 0.01,
                                          ),
                                          Container(
                                            height: height * 0.05,
                                            width: width * 0.12,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                image: const DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        'https://tse1.mm.bing.net/th?id=OIP.Pi1ySxKBf7DyNStcLdOASwHaEo&pid=Api&rs=1&c=1&qlt=95&w=168&h=105'))),
                                          ),
                                          SizedBox(
                                            width: width * 0.03,
                                          ),
                                          Text(ground[index]),
                                          SizedBox(
                                            width: width * 0.3,
                                          ),
                                          Radio(
                                              value: null,
                                              groupValue: null,
                                              onChanged: (value) {})
                                        ],
                                      ),
                                    ),
                                  )),
                          Text(
                            AppLocalizations.of(context)!.facilitiesProvided,
                            style: TextStyle(fontSize: height * 0.03),
                          ),
                          Wrap(
                            children: [
                              ...List.generate(
                                  _venueDetail.venueDetails!.facilities!.length,
                                  (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * .008),
                                        child: SizedBox(
                                          width: width * 0.44,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                radius: height * 0.028,
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: cachedNetworkImage(
                                                    height: height * .07,
                                                    width: width * .18,
                                                    cuisineImageUrl:
                                                        _venueDetail
                                                                .venueDetails
                                                                ?.facilities![
                                                                    index]
                                                                ?.image ??
                                                            "",
                                                    imageFit: BoxFit.contain),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.015),
                                                child: Text(
                                                  _venueDetail
                                                          .venueDetails
                                                          ?.facilities![index]
                                                          ?.name ??
                                                      "",
                                                  style: const TextStyle(
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: true,
                                                  textWidthBasis:
                                                      TextWidthBasis.parent,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.008),
                            child: Text(
                              AppLocalizations.of(context)!.location,
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                          ),
                          ExpansionTile(
                            title: ReadMoreText(
                              _venueDetail.venueDetails?.location ?? "",
                              trimLength: 2,
                              trimMode: TrimMode.Line,
                              lessStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              moreStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              trimCollapsedText: 'See More',
                              trimExpandedText: 'See Less',
                            ),
                            trailing: const Icon(Icons.location_searching),
                            children: [
                              Card(
                                color: Colors.white70,
                                child: ListTile(
                                  onTap: () {
                                    openMapsSheet(context);
                                  },
                                  title:
                                      Center(child: Text('Get Your Location')),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: height * 0.008),
                            child: Text(
                              'Our Popular Features',
                              style: TextStyle(fontSize: height * 0.03),
                            ),
                          ),
                          Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              ...List.generate(
                                  5,
                                  (index) => Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: height * .008,
                                            horizontal: width * 0.008),
                                        child: Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: height * 0.006,
                                              backgroundColor: Colors.grey,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.015),
                                              child: Text(
                                                popular[index],
                                                style: TextStyle(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: height * 0.023),
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                textWidthBasis:
                                                    TextWidthBasis.parent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.01,
                                vertical: height * 0.01),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(10)),
                              height: height * 0.06,
                              child: const Center(child: Text('Book Now')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List icon = [
    Icons.directions_car_sharp,
    Icons.camera_alt,
    Icons.meeting_room_outlined,
    Icons.chair
  ];
  List title = ['Parking Sport', 'Camera', 'Waiting Room', 'Changing Room'];
  List popular = [
    'Hiring Partners',
    'Miniature Field',
    'Grass Pitch',
    'Outdoor/Indoor',
    'Nature Grass Pitch'
  ];
  List ground = ['Main Ground', 'Futsal Ground', 'tennis Ground'];
}
