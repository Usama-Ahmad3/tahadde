import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/bookPitchModelClass.dart';
import '../../network/network_calls.dart';

class BookPitch extends StatefulWidget {
  final int pitchDetail;

  const BookPitch({super.key, required this.pitchDetail});

  @override
  _BookPitchState createState() => _BookPitchState();
}

class _BookPitchState extends State<BookPitch> {
  late BookPitchDetail pitchDetail;
  late bool internet;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  bool isStateLoading = true;
  bool isscroll = false;
  late bool _auth;
  late bool favoriteState;
  var detail;
  final itemSize = 100.0;
  late ScrollController _controller;
  List<Marker> allMarkers = [];
  var id = 0;
  String pitchTypeName = "";
  late int count;

  addMarker() async {
    allMarkers.clear();
    getBytesFromAsset("images/marker.png", 70)
        .then((markerIcon) => setState(() {
              allMarkers.add(Marker(
                markerId: const MarkerId('myMarker'),
                icon: BitmapDescriptor.fromBytes(markerIcon),
                draggable: false,
                onTap: () {
                  debugPrint('marker');
                },
                position: LatLng(pitchDetail.latitude!, pitchDetail.longitude!),
              ));
            }));
  }

  loadProfile() async {
    _auth = (await checkAuthorizaton())!;
    loadBookPitch();
  }

  _moveUp() {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  openMapsSheet(context) async {
    try {
      final coords = Coords(pitchDetail.latitude!, pitchDetail.longitude!);
      final title = pitchDetail.location ?? '';
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
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
            ),
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  loadBookPitch() {
    Map detail = {
      "id": widget.pitchDetail,
      "language": AppLocalizations.of(context)!.locale
    };
    _networkCalls.bookpitchdetail(
      urldetail: detail,
      onSuccess: (msg) {
        setState(() {
          pitchDetail = msg;
          isStateLoading = false;
          addMarker();
        });
      },
      onFailure: (msg) {
        showMessage(msg);
        Navigator.pop(context);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  favorite() async {
    detail = {"pitch_id": pitchDetail.id, "is_favourite": favoriteState};
    await _networkCalls.favorite(
      // detail: detail,
      onSuccess: (msg) {
        setState(() {
          pitchDetail = msg;
        });
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
      id: '0', favorite: false,
    );
  }

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            //title: Text('Are you sure?'),
            content: Text(AppLocalizations.of(context)!.toReserve),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          isStateLoading = false;
        });
      }
    });
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;

    return isStateLoading
        ? _buildShemmer(sizewidth, sizeheight)
        : internet
            ? Scaffold(
                key: scaffoldkey,
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: AppBar(
                      backgroundColor: const Color(0XFF032040),
                    )),
                bottomNavigationBar: Container(
                  color: const Color(0XFF25A163),
                  child: SafeArea(
                    child: SizedBox(
                      height: 55,
                      child: Material(
                        color: const Color(0XFF25A163),
                        child: InkWell(
                          splashColor: Colors.black,
                          onTap: () {
                            if (_auth) {
                              if (pitchTypeName == "") {
                                showMessage(AppLocalizations.of(context)!
                                    .pleaseselectyourfield);
                              } else {
                                navigateToDetail();
                              }
                            } else {
                              onWillPop();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              AppLocalizations.of(context)!.bookYourSlot,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
                                          ? 18
                                          : 22,
                                  color: const Color(0XFFFFFFFF)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 320,
                          color: const Color(0XFF032040),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  ClipPath(
                                      clipper: Cliping(),
                                      child: cachedNetworkImage(
                                        height: 220,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        cuisineImageUrl: pitchDetail
                                            .bookpitchfiles
                                            ?.files![0]
                                            ?.filePath,
                                      )),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          color: Color(0XFFFFFFFF),
                                        ),
                                      ),
                                      const Spacer(),
                                      _auth
                                          ? pitchDetail.my_favourite!
                                              ? IconButton(
                                                  onPressed: () {
                                                    _networkCalls
                                                        .checkInternetConnectivity(
                                                            onSuccess: (msg) {
                                                      if (msg) {
                                                        favoriteState = false;
                                                        favorite();
                                                      } else {
                                                        showMessage(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .noInternetConnection);
                                                      }
                                                    });
                                                  },
                                                  icon: Image.asset(
                                                      "images/favorite.png"))
                                              : IconButton(
                                                  onPressed: () {
                                                    _networkCalls
                                                        .checkInternetConnectivity(
                                                            onSuccess: (msg) {
                                                      if (msg) {
                                                        favoriteState = true;
                                                        favorite();
                                                      } else {
                                                        showMessage(
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .noInternetConnection);
                                                      }
                                                    });
                                                  },
                                                  icon: Image.asset(
                                                    "images/favorit.png",
                                                    color: Colors.white,
                                                  ))
                                          : Container(),
                                      IconButton(
                                        onPressed: () {
                                          Share.share(
                                            pitchDetail.link!,
                                            // subject:
                                            // 'Look what I made!');
                                            //launchInBrowser(pitchDetail.link);
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              flaxibleGap(3),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .05),
                                    child: SizedBox(
                                      width: sizewidth * .7,
                                      child: Text(
                                        pitchDetail.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: sizeheight * .03,
                                    width: sizewidth * .16,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: const Color(
                                          0XFF979797,
                                        ))),
                                    child: Row(
                                      children: <Widget>[
                                        flaxibleGap(1),
                                        Image.asset(
                                          'images/star.png',
                                          height: sizeheight * .02,
                                        ),
                                        flaxibleGap(1),
                                        Text(
                                          "${pitchDetail.organisedBy!.ratings!.ratingsAvg ?? "0"}/5",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFFCBCBCB)),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(4),
                                ],
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizewidth * .05),
                                child: Text(
                                  pitchDetail.gamePlay?.name ?? '',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0XFF25A163),
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              flaxibleGap(3),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          color: const Color(0XFFF0F0F0),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          height: 70.0 +
                              (68.0 * (pitchDetail.pitchType!.length - 1)),
                          alignment: Alignment.center,
                          child: ListView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: pitchDetail.pitchType!.length,
                              itemBuilder:
                                  (BuildContext context, int blockIdx) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    width: sizewidth * .28,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: count == blockIdx
                                          ? const Color(0XFF25A163)
                                              .withOpacity(.5)
                                          : Colors.white,
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        flaxibleGap(1),
                                        Text(
                                          "${pitchDetail.pitchType![blockIdx]!.area}",
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0XFF032040),
                                              decoration: TextDecoration.none),
                                        ),
                                        flaxibleGap(1),
                                        Container(
                                          height: sizeheight * .05,
                                          width: 2,
                                          color: const Color(0XFF979797),
                                        ),
                                        flaxibleGap(1),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "${pitchDetail.pitchType![blockIdx]!.name}",
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0XFF696969),
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  "${AppLocalizations.of(context)!.price} : ",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0XFF032040),
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                                Text(
                                                  "${AppLocalizations.of(context)!.currency} ${pitchDetail.pitchType![blockIdx]!.paymentSummary!.grandTotal.round().toString()}",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0XFF25A163),
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        flaxibleGap(1),
                                        GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (count == blockIdx) {
                                                  pitchTypeName = "";
                                                  id = 0;
                                                  count = 0;
                                                } else {
                                                  pitchTypeName = pitchDetail
                                                      .pitchType![blockIdx]!
                                                      .name
                                                      .toString();
                                                  id = pitchDetail
                                                      .pitchType![blockIdx]!.id!
                                                      .toInt();
                                                  count = blockIdx;
                                                }
                                              });
                                            },
                                            child: count == blockIdx
                                                ? Image.asset(
                                                    "images/check.png",
                                                    color:
                                                        const Color(0XFF032040),
                                                    height: 30,
                                                  )
                                                : Image.asset(
                                                    "images/unchecks.png",
                                                    color:
                                                        const Color(0XFF032040),
                                                    height: 30,
                                                  )),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          openMapsSheet(context);
                          // makeMap(_getLaunchUrl().toString());
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              SizedBox(
                                width: sizewidth,
                                height: sizeheight * .2,
                                child: GoogleMap(
                                  zoomControlsEnabled: false,
                                  myLocationButtonEnabled: false,
                                  onTap: (value) {
                                    openMapsSheet(context);
                                    //makeMap(_getLaunchUrl().toString());
                                  },
                                  mapType: MapType.normal,
                                  initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          pitchDetail.latitude!.toDouble(),
                                          pitchDetail.longitude!.toDouble()),
                                      zoom: 15.0),
                                  //markers: Set.identity(),
                                  markers: Set.from(allMarkers),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                color: const Color(0XFFF0F0F0),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 7, left: 7, top: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const Icon(
                                        Icons.location_on,
                                        size: 20,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          width: sizewidth * .5,
                                          child: Text(
                                            pitchDetail.location ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0XFF8B8B8B),
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: sizeheight * .25,
                            color: const Color(0XFFF0F0F0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? const EdgeInsets.only(
                                                right: 10,
                                              )
                                            : const EdgeInsets.only(
                                                left: 10,
                                              ),
                                        child: const Icon(Icons.description),
                                      ),
                                      Text(
                                          AppLocalizations.of(context)!
                                              .facilityProvided,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Color(0XFF424242),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: sizewidth,
                                  child: Row(
                                    children: [
                                      pitchDetail.facilities!.length > 3
                                          ? GestureDetector(
                                              onTap: () {
                                                _moveUp();
                                              },
                                              child: const Icon(
                                                  Icons.arrow_back_ios))
                                          : Container(),
                                      flaxibleGap(1),
                                      SizedBox(
                                        height: sizeheight * .15,
                                        width:
                                            pitchDetail.facilities!.length > 3
                                                ? sizewidth * .82
                                                : sizewidth * .87,
                                        child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                pitchDetail.facilities!.length,
                                            itemExtent: itemSize,
                                            controller: _controller,
                                            itemBuilder: (BuildContext context,
                                                int blockIdx) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Container(
                                                  width: sizewidth * .28,
                                                  height: sizewidth * .07,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        const Color(0XFF25A163)
                                                            .withOpacity(.3),
                                                  ),
                                                  child: Column(
                                                    children: <Widget>[
                                                      flaxibleGap(2),
                                                      cachedNetworkImage(
                                                          height:
                                                              sizeheight * .08,
                                                          width:
                                                              sizewidth * .18,
                                                          cuisineImageUrl:
                                                              pitchDetail
                                                                  .facilities![
                                                                      blockIdx]
                                                                  ?.image
                                                                  ?.filePath,
                                                          imageFit:
                                                              BoxFit.fill),
                                                      flaxibleGap(1),
                                                      Text(
                                                          pitchDetail
                                                              .facilities![
                                                                  blockIdx]!
                                                              .name
                                                              .toString(),
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
                                      flaxibleGap(1),
                                      pitchDetail.facilities!.length > 3
                                          ? GestureDetector(
                                              onTap: () {
                                                _moveDown();
                                              },
                                              child: const Icon(
                                                  Icons.arrow_forward_ios))
                                          : Container()
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFF0F0F0),
                            child: Padding(
                              padding:
                                  AppLocalizations.of(context)!.locale == "en"
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
                                        top: 10, bottom: 10),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? const EdgeInsets.only(right: 10)
                                              : const EdgeInsets.only(left: 10),
                                          child: const Icon(Icons.person),
                                        ),
                                        Text(
                                            AppLocalizations.of(context)!
                                                .pitchOwner,
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color(0XFF424242),
                                                decoration:
                                                    TextDecoration.none))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text(
                                        pitchDetail.organisedBy!.name ?? '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF032040),
                                            decoration: TextDecoration.none)),
                                  ),
                                  Text(pitchDetail.description ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF424242),
                                          decoration: TextDecoration.none))
                                ],
                              ),
                            )),
                      ),
                      pitchDetail.organisedBy!.userReviews!.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: const Color(0XFFF0F0F0),
                                  child: Padding(
                                    padding:
                                        AppLocalizations.of(context)!.locale ==
                                                "en"
                                            ? const EdgeInsets.only(
                                                left: 20,
                                                bottom: 20,
                                              )
                                            : const EdgeInsets.only(
                                                right: 20,
                                                bottom: 20,
                                              ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20, bottom: 10),
                                          child: Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: AppLocalizations.of(
                                                                context)!
                                                            .locale ==
                                                        "en"
                                                    ? const EdgeInsets.only(
                                                        right: 10)
                                                    : const EdgeInsets.only(
                                                        left: 10),
                                                child: const Icon(Icons.person),
                                              ),
                                              Text(
                                                  AppLocalizations.of(context)!
                                                      .commentForThisPitch,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Color(0XFF424242),
                                                      decoration:
                                                          TextDecoration.none))
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: sizeheight *
                                                .07 *
                                                pitchDetail.organisedBy!
                                                    .userReviews!.length,
                                            child: ListView.builder(
                                              itemCount: pitchDetail
                                                  .organisedBy!
                                                  .userReviews!
                                                  .length,
                                              scrollDirection: Axis.vertical,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int blockIdx) {
                                                return Padding(
                                                  padding: AppLocalizations.of(
                                                                  context)!
                                                              .locale ==
                                                          "en"
                                                      ? const EdgeInsets.only(
                                                          right: 10)
                                                      : const EdgeInsets.only(
                                                          left: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${pitchDetail.organisedBy!.userReviews![blockIdx]!.user!.first_name} ${pitchDetail.organisedBy!.userReviews![blockIdx]!.user!.last_name}",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF424242),
                                                                fontSize: 16),
                                                          ),
                                                          Text(
                                                            "  ${pitchDetail.organisedBy!.userReviews![blockIdx]!.review}",
                                                            style: const TextStyle(
                                                                color: Color(
                                                                    0XFF25A163),
                                                                fontSize: 16),
                                                          ),
                                                        ],
                                                      ),
                                                      AppLocalizations.of(
                                                                      context)!
                                                                  .locale ==
                                                              "en"
                                                          ? Text(
                                                              (DateFormat.yMMMMEEEEd('en_US').format(DateTime.parse(pitchDetail
                                                                      .organisedBy!
                                                                      .userReviews![
                                                                          blockIdx]!
                                                                      .created_at
                                                                      .toString())) ??
                                                                  ''),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF8B8B8B)),
                                                            )
                                                          : Text(
                                                              (DateFormat.yMMMMEEEEd('ar_SA').format(DateTime.parse(pitchDetail
                                                                      .organisedBy!
                                                                      .userReviews![
                                                                          blockIdx]!
                                                                      .created_at
                                                                      .toString())) ??
                                                                  ''),
                                                              style: const TextStyle(
                                                                  fontSize: 12,
                                                                  color: Color(
                                                                      0XFF8B8B8B)),
                                                            ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ))
                                      ],
                                    ),
                                  )),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            : Material(
                child: SizedBox(
                  height: sizeheight,
                  width: sizewidth,
                  child: InternetLoss(
                    onChange: () {
                      _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                        internet = msg;
                        if (msg == true) {
                          loadProfile();
                        }
                      });
                    },
                  ),
                ),
              );
  }

  void navigateToDetail() {
    detail = {
      "id": pitchDetail.id,
      "year": pitchDetail.currentYear,
      "month": pitchDetail.currentMonth,
      "ids": id,
      "email": pitchDetail.organisedBy
    };
    Navigator.pushNamed(context, RouteNames.bookPitchSlot, arguments: detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  _buildShemmer(sizewidth, sizeheight) {
    return Scaffold(
      key: scaffoldkey,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: const Color(0XFF032040),
          )),
      bottomNavigationBar: Container(
        color: const Color(0XFF25A163),
        child: SafeArea(
          child: SizedBox(
            height: 55,
            child: Material(
              color: const Color(0XFF25A163),
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.bookYourSlot,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: AppLocalizations.of(context)!.locale == "en"
                          ? 18
                          : 22,
                      color: const Color(0XFFFFFFFF)),
                ),
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
                height: 320,
                color: const Color(0XFF032040),
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: [
                        ClipPath(
                          clipper: Cliping(),
                          child: cachedNetworkImage(
                              height: 220,
                              width: MediaQuery.of(context).size.width,
                              cuisineImageUrl: '',
                              placeholder: 'images/placeHolder.png'),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Color(0XFFFFFFFF),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    flaxibleGap(
                      2,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizewidth * .08),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.shade300,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: Container(
                              height: 20,
                              width: sizewidth * .3,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0) //

                                        ),
                              ),
                            ),
                          ),
                        ),
                        flaxibleGap(
                          5,
                        ),
                        Container(
                          height: sizeheight * .03,
                          width: sizewidth * .16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                  color: const Color(
                                0XFF979797,
                              ))),
                          child: Row(
                            children: <Widget>[
                              flaxibleGap(1),
                              Image.asset(
                                'images/star.png',
                                height: sizeheight * .02,
                              ),
                              flaxibleGap(1),
                              const Text(
                                "0/5",
                                style: TextStyle(
                                    fontSize: 12, color: Color(0XFFCBCBCB)),
                              ),
                              flaxibleGap(1),
                            ],
                          ),
                        ),
                        flaxibleGap(
                          1,
                        ),
                      ],
                    ),
                    flaxibleGap(
                      1,
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: sizewidth * .08),
                          child: Shimmer.fromColors(
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
                        ),
                        flaxibleGap(
                          10,
                        ),
                      ],
                    ),
                    flaxibleGap(
                      2,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                color: const Color(0XFFF0F0F0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                height: 70.0 + (68.0 * (2 - 1)),
                alignment: Alignment.center,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int blockIdx) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          width: sizewidth * .28,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Row(
                            children: <Widget>[
                              flaxibleGap(1),
                              Shimmer.fromColors(
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                                enabled: true,
                                child: Container(
                                  height: 30,
                                  width: sizewidth * .2,
                                  color: Colors.white,
                                ),
                              ),
                              flaxibleGap(1),
                              Container(
                                height: sizeheight * .05,
                                width: 2,
                                color: const Color(0XFF979797),
                              ),
                              flaxibleGap(1),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      height: 20,
                                      width: sizewidth * .4,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: 20,
                                          width: sizewidth * .2,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Shimmer.fromColors(
                                        baseColor: Colors.grey.shade300,
                                        highlightColor: Colors.grey.shade100,
                                        enabled: true,
                                        child: Container(
                                          height: 20,
                                          width: sizewidth * .2,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              flaxibleGap(1),
                              Image.asset(
                                "images/unchecks.png",
                                color: const Color(0XFF032040),
                                height: 30,
                              ),
                              flaxibleGap(1),
                            ],
                          ),
                        ),
                      );
                    }),
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
                width: MediaQuery.of(context).size.width,
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
                width: MediaQuery.of(context).size.width,
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
//                    Padding(
//                      padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
//                      child: Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Text(
//                            AppLocalizations.of(context).start,
//                            style: TextStyle(
//                                fontFamily: 'Poppins',
//                                fontSize: 16,
//                                color: Color(0XFF898989),
//                                decoration: TextDecoration.none),
//                          ),
//                          Text(
//                            AppLocalizations.of(context).end,
//                            style: TextStyle(
//                                fontFamily: 'Poppins',
//                                fontSize: 16,
//                                color: Color(0XFF898989),
//                                decoration: TextDecoration.none),
//                          )
//                        ],
//                      ),
//                    ),
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
                  width: MediaQuery.of(context).size.width,
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
                            Expanded(
                              child: SizedBox(
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
                  width: MediaQuery.of(context).size.width,
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
//
                        ),
//
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
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
