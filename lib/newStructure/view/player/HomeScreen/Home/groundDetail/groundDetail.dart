import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/groundDetail/groundDetailShimmer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;

import '../../../../../../common_widgets/grediant_text.dart';
import '../../../../../../common_widgets/internet_loss.dart';
import '../../../../../../homeFile/routingConstant.dart';
import '../../../../../../homeFile/utility.dart';
import '../../../../../../localizations.dart';
import '../../../../../../modelClass/venue_detail_model_class.dart';
import '../../../../../../network/network_calls.dart';
import 'carousel.dart';
import 'facilities.dart';

class GroundDetail extends StatefulWidget {
  Map detail;

  GroundDetail({super.key, required this.detail});

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
  bool _auth = false;
  List<int> listMaxPlayer = [];
  int? selectedIndex;
  bool? favoriteState;
  final itemSize = 100.0;
  List<Marker> allMarkers = [];
  var id = 0;
  int date = 0;

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
                position: LatLng(privateVenueDetail.latitude!,
                    privateVenueDetail.longitude!),
              ));
            }));
  }

  openMapsSheet(context) async {
    try {
      final coords =
          Coords(privateVenueDetail.latitude!, privateVenueDetail.longitude!);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkAuth();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        venueDetail();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
  }

  venueDetail() async {
    await _networkCalls.venueDetail(
        id: widget.detail["pitchId"].toString(),
        subPitchId: widget.detail["subPitchId"]["id"].toString(),
        onSuccess: (detail) {
          setState(() {
            privateVenueDetail = detail;
            allMarkers.add(Marker(
                position: LatLng(privateVenueDetail.latitude!,
                    privateVenueDetail.longitude!),
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isStateLoading
        ? GroundShimmer.buildShemmer(width, height, context)
        : internet
            ? Scaffold(
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
                      flexibleSpace: const FlexibleSpaceBar(
                          collapseMode: CollapseMode.pin,
                          centerTitle: false,
                          titlePadding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          background: Carousel()),
                      actions: [
                        ///favoriteIcon
                        _auth
                            ? IconButton(
                                onPressed: () {
                                  _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                    if (msg) {
                                      if (privateVenueDetail.isFavourite ==
                                          false) {
                                        privateVenueDetail.isFavourite = true;
                                        favorite(true);
                                      } else {
                                        privateVenueDetail.isFavourite = false;
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
                                  privateVenueDetail.isFavourite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: height * 0.05,
                                ))
                            : Container(),

                        ///shareIcon
                        Container(
                          height: 35,
                          width: 35,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: RawMaterialButton(
                            onPressed: () {
                              Share.share(
                                "pitchDetail.link",
                              );
                            },
                            elevation: 2.0,
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
                                // borderRadius: BorderRadius.only(
                                //     topRight: Radius.circular(20),
                                //     topLeft: Radius.circular(20))
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: height * 0.024,
                                    vertical: height * 0.033),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ///titleName
                                    privateVenueDetail.images != null
                                        ? GradientText(
                                            privateVenueDetail
                                                    .venueDetails!.name ??
                                                "",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: height * 0.026,
                                                color: Colors.white,
                                                fontFamily: "Poppins",
                                                decoration:
                                                    TextDecoration.none),
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
                                            child:
                                                const CircularProgressIndicator(
                                              color: Colors.greenAccent,
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
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    ReadMoreText(
                                      privateVenueDetail
                                              .venueDetails?.description ??
                                          "",
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

                                    ///GroundList
                                    Text(
                                        AppLocalizations.of(context)!
                                            .groundList,
                                        style:
                                            TextStyle(fontSize: height * 0.03)),
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
                                                        BorderRadius.circular(
                                                            10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: Colors.black12,
                                                        spreadRadius: 1,
                                                        offset: Offset(0, 1),
                                                        blurStyle:
                                                            BlurStyle.outer,
                                                      )
                                                    ]),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: width * 0.01,
                                                    ),
                                                    Container(
                                                      height: height * 0.05,
                                                      width: width * 0.1,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                    Checkbox(
                                                        shape:
                                                            const CircleBorder(),
                                                        activeColor:
                                                            Colors.greenAccent,
                                                        value: selectedIndex ==
                                                                index
                                                            ? true
                                                            : false,
                                                        onChanged: (onChanged) {
                                                          selectedIndex = index;
                                                          setState(() {});
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            )),

                                    ///facilities
                                    Facilities(),

                                    ///location
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.008),
                                      child: Text(
                                        AppLocalizations.of(context)!.location,
                                        style:
                                            TextStyle(fontSize: height * 0.03),
                                      ),
                                    ),
                                    Card(
                                      elevation: 3,
                                      child: ExpansionTile(
                                        title: ReadMoreText(
                                          privateVenueDetail
                                                  .venueDetails?.location ??
                                              "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                          trimLength: 2,
                                          trimMode: TrimMode.Line,
                                          lessStyle: const TextStyle(
                                              color: Colors.black38,
                                              fontWeight: FontWeight.bold),
                                          moreStyle: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                          trimCollapsedText: 'More',
                                          trimExpandedText: '.Less',
                                        ),
                                        tilePadding: EdgeInsets.symmetric(
                                            vertical: height * 0.02,
                                            horizontal: width * 0.02),
                                        trailing: const Icon(
                                            Icons.location_searching),
                                        children: [
                                          Card(
                                            color: Colors.white70,
                                            child: ListTile(
                                              onTap: () {
                                                openMapsSheet(context);
                                              },
                                              title: Center(
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .chooseLocation)),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    ///popularFeature
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height * 0.013),
                                      child: Text(
                                        AppLocalizations.of(context)!.popular,
                                        style:
                                            TextStyle(fontSize: height * 0.03),
                                      ),
                                    ),
                                    Wrap(
                                      crossAxisAlignment:
                                          WrapCrossAlignment.center,
                                      children: [
                                        ...List.generate(
                                            5,
                                            (index) => Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: height * .008,
                                                      horizontal:
                                                          width * 0.008),
                                                  child: Wrap(
                                                    crossAxisAlignment:
                                                        WrapCrossAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: height * 0.0065,
                                                        backgroundColor:
                                                            Colors.grey,
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    width *
                                                                        0.02),
                                                        child: Text(
                                                          popular[index],
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: height *
                                                                  0.02),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                          textWidthBasis:
                                                              TextWidthBasis
                                                                  .parent,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ))
                                      ],
                                    ),

                                    ///BookButton
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.01,
                                          vertical: height * 0.01),
                                      child: InkWell(
                                        onTap: () {
                                          navigateToBookingScreen(
                                              widget.detail);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height: height * 0.06,
                                          child: Center(
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .bookNowS)),
                                        ),
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
  List ground = ['Main Ground', 'Futsal Ground', 'tennis Ground'];

  void navigateToBookingScreen(Map detail) {
    Navigator.pushNamed(context, RouteNames.bookingScreen, arguments: detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }
}
