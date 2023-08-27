import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/yourTahaddiBookPitch.dart';
import '../../modelClass/yourTahaddiModelClass.dart';
import '../../network/network_calls.dart';

class BookPitchYourTahaddi extends StatefulWidget {
  YourTahaddi bookpitch;
  BookPitchYourTahaddi({required this.bookpitch});
  @override
  _BookPitchYourTahaddiState createState() => _BookPitchYourTahaddiState();
}

class _BookPitchYourTahaddiState extends State<BookPitchYourTahaddi> {
  late List<YourTahaddiBookPitchDetail> pitchDetail;
  late bool _internet;
  int id = 0;
  List<Marker> allMarkers = [];
  final NetworkCalls _networkCalls = NetworkCalls();
  bool _isLoading = true;
  var _detail;
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
                position: LatLng(pitchDetail[0].bookPitch!.latitude!.toDouble(),
                    pitchDetail[0].bookPitch!.longitude!.toDouble()),
              ));
            }));
  }

  loadProfile() {
    loadDetail();
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

  openMapsSheet(context) async {
    try {
      final coords = Coords(pitchDetail[0].bookPitch!.latitude!.toDouble(),
          pitchDetail[0].bookPitch!.longitude!.toDouble());
      final title = pitchDetail[0].bookPitch!.location ?? '';
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
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
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  loadDetail() {
    _networkCalls.tahaddiBookPitch(
      id: widget.bookpitch.tahaddis!.id!.toInt(),
      event: widget.bookpitch.transactionFor.toString(),
      ids: widget.bookpitch.pitchType![0]!.id!.toInt(),
      onSuccess: (msg) {
        setState(() {
          pitchDetail = msg;
          _isLoading = false;
          addMarker();
        });
      },
      onFailure: (msg) {},
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
      _internet = msg;
      if (msg == true) {
        loadProfile();
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    return _isLoading
        ? Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: const Color(0XFF032040),
                )),
            body: SizedBox(
              width: sizewidth,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 350.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 180.0,
                                      color: Colors.white,
                                      padding: const EdgeInsets.only(
                                          left: 16, right: 16),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 4.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 140.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : _internet
            ? Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0XFFFFFFFF),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  backgroundColor: const Color(0XFF032040),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () {
                        launchInBrowser(
                            pitchDetail[0].bookPitch!.link.toString());
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
                              ClipPath(
                                clipper: Cliping(),
                                child: cachedNetworkImage(
                                  height: 250,
                                  width: MediaQuery.of(context).size.width,
                                  cuisineImageUrl: widget.bookpitch?.tahaddis
                                      ?.files?.files?.filePath,
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(),
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .1),
                                    child: Text(
                                      pitchDetail[0].bookPitch!.name ?? '',
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                  flaxibleGap(10)
                                ],
                              ),
                              flaxibleGap(1),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: sizewidth * .1,
                                    right: sizewidth * .1),
                                child: Text(
                                  pitchDetail[0].bookPitch!.gamePlay!.name ??
                                      '',
                                  style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Color(0XFF25A163),
                                      //fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                              flaxibleGap(
                                3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: sizeheight * .4 +
                                sizeheight *
                                    .22 *
                                    (pitchDetail[0].bookingDetails!.length - 1),
                            color: const Color(0XFFF0F0F0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
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
                                                .bookingDetails,
                                            style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 18,
                                              color: Color(0XFF424242),
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: sizeheight *
                                        .22 *
                                        pitchDetail[0].bookingDetails!.length,
                                    child: ListView.builder(
                                        physics: const ScrollPhysics(),
                                        itemCount: pitchDetail[0]
                                            .bookingDetails!
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            int blockIdx) {
                                          return Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Container(
                                                height: sizeheight * .2,
                                                width: sizewidth * .6,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: sizewidth * .03,
                                                      right: sizewidth * .03,
                                                      top: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Row(
                                                        children: <Widget>[
                                                          Text(
                                                            "${pitchDetail[0].bookingDetails![blockIdx]!.pitchType!.area}",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0XFF032040),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                          flaxibleGap(
                                                            1,
                                                          ),
                                                          Container(
                                                            height: sizeheight *
                                                                .03,
                                                            width: 1,
                                                            color: const Color(
                                                                0XFF979797),
                                                          ),
                                                          flaxibleGap(1),
                                                          Text(
                                                            pitchDetail[0]
                                                                .bookingDetails![
                                                                    blockIdx]!
                                                                .pitchType!
                                                                .name
                                                                .toString(),
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0XFF696969),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                          flaxibleGap(1),
                                                          Container(
                                                            height: sizeheight *
                                                                .03,
                                                            width: 1,
                                                            color: const Color(
                                                                0XFF979797),
                                                          ),
                                                          flaxibleGap(1),
                                                          Text(
                                                            "${pitchDetail[0].bookingDetails![blockIdx]!.paidTotal!.round().toString()} ${AppLocalizations.of(context)!.currency}",
                                                            style: const TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0XFF25A163),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none),
                                                          ),
                                                        ],
                                                      ),
                                                      flaxibleGap(1),
                                                      Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .slots,
                                                        style: const TextStyle(
                                                            fontSize: 10,
                                                            color: Color(
                                                                0XFFADADAD),
                                                            decoration:
                                                                TextDecoration
                                                                    .none),
                                                      ),
                                                      flaxibleGap(1),
                                                      Row(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: sizeheight *
                                                                .12,
                                                            width:
                                                                sizewidth * .6,
                                                            child: ListView
                                                                .builder(
                                                                    physics:
                                                                        const ScrollPhysics(),
                                                                    scrollDirection:
                                                                        Axis
                                                                            .vertical,
                                                                    itemCount: pitchDetail[
                                                                            0]
                                                                        .bookingDetails![
                                                                            blockIdx]!
                                                                        .slotDate!
                                                                        .length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            indexInner) {
                                                                      return Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          AppLocalizations.of(context)!.locale == "en"
                                                                              ? Text(
                                                                                  DateFormat.yMMMMd('en_US').format(DateTime.parse(pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.date.toString())),
                                                                                  style: const TextStyle(fontSize: 15, color: Color(0XFF032040), decoration: TextDecoration.none),
                                                                                )
                                                                              : Text(
                                                                                  DateFormat.yMMMMd('ar_SA').format(DateTime.parse(pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.date.toString())),
                                                                                  style: const TextStyle(fontSize: 15, color: Color(0XFF032040), decoration: TextDecoration.none),
                                                                                ),
                                                                          Row(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              SizedBox(
                                                                                width: sizewidth * .52,
                                                                                height: sizeheight * .03,
                                                                                child: ListView.builder(
                                                                                    shrinkWrap: true,
                                                                                    physics: const ScrollPhysics(),
                                                                                    scrollDirection: Axis.horizontal,
                                                                                    itemCount: pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.slots!.length,
                                                                                    itemBuilder: (context, indexInnerSecond) {
                                                                                      return indexInnerSecond < 2
                                                                                          ? Text(
                                                                                              "(${timing(y: pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.slots![indexInnerSecond]!.startTime.toString())} - ${timing(y: pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.slots![indexInnerSecond]!.endTime.toString())}),",
                                                                                              style: const TextStyle(fontSize: 12, color: Color(0XFF25A163), decoration: TextDecoration.none),
                                                                                            )
                                                                                          : Container();
                                                                                    }),
                                                                              ),
                                                                              pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.slots!.length > 2
                                                                                  ? Container(
                                                                                      alignment: Alignment.center,
                                                                                      width: sizewidth * .08,
                                                                                      height: sizeheight * .03,
                                                                                      decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                        color: const Color(0XFF25A163),
                                                                                      ),
                                                                                      child: Text("+${pitchDetail[0].bookingDetails![blockIdx]!.slotDate![indexInner]!.slots!.length - 2}", style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12, color: Color(0XFF032040), decoration: TextDecoration.none)),
                                                                                    )
                                                                                  : Container(),
                                                                              flaxibleGap(
                                                                                1,
                                                                              ),
                                                                            ],
                                                                          )
                                                                        ],
                                                                      );
                                                                    }),
                                                          ),
                                                          flaxibleGap(1),
                                                          GestureDetector(
                                                            onTap: () {
                                                              id = pitchDetail[
                                                                      0]
                                                                  .bookingDetails![
                                                                      blockIdx]!
                                                                  .pitchType!
                                                                  .id!
                                                                  .toInt();
                                                              navigateToDetail();
                                                            },
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height:
                                                                  sizeheight *
                                                                      .04,
                                                              width: sizewidth *
                                                                  .20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: const Color(
                                                                    0XFF25A163),
                                                              ),
                                                              child: Text(
                                                                  AppLocalizations.of(
                                                                          context)!
                                                                      .rebook,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                      color: Colors
                                                                          .white,
                                                                      decoration:
                                                                          TextDecoration
                                                                              .none)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      flaxibleGap(1),
                                                    ],
                                                  ),
                                                ),
                                              ));
                                        }),
                                  ),
                                  flaxibleGap(2),
                                  Text(
                                    AppLocalizations.of(context)!.pitchcontact,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Color(0XFFADADAD),
                                        decoration: TextDecoration.none),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      makePhoneCall(
                                          "tel:${pitchDetail[0].bookPitch!.organisedBy!.contact_number}");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.call,
                                          color: Color(0XFF25A163),
                                          size: 14,
                                        ),
                                        Container(
                                          width: sizewidth * .02,
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? (pitchDetail[0]
                                                          .bookPitch!
                                                          .organisedBy!
                                                          .countryCode ??
                                                      "") +
                                                  (pitchDetail[0]
                                                          .bookPitch!
                                                          .organisedBy!
                                                          .contact_number ??
                                                      "")
                                              : (pitchDetail[0]
                                                              .bookPitch!
                                                              .organisedBy!
                                                              .countryCode ==
                                                          null
                                                      ? ""
                                                      : pitchDetail[0]
                                                          .bookPitch!
                                                          .organisedBy!
                                                          .countryCode!
                                                          .substring(1)) +
                                                  (pitchDetail[0]
                                                          .bookPitch!
                                                          .organisedBy!
                                                          .contact_number ??
                                                      "") +
                                                  (pitchDetail[0]
                                                              .bookPitch!
                                                              .organisedBy!
                                                              .countryCode ==
                                                          null
                                                      ? ""
                                                      : pitchDetail[0]
                                                          .bookPitch!
                                                          .organisedBy!
                                                          .countryCode!
                                                          .substring(0, 1)),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF25A163),
                                              decoration: TextDecoration.none),
                                        ),
                                        flaxibleGap(2),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launch(
                                          "mailto:${pitchDetail[0].bookPitch!.organisedBy!.email}?subject=Tahaddi&body= Tahaddi");
                                    },
                                    child: Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.mail,
                                          color: Color(0XFF25A163),
                                          size: 14,
                                        ),
                                        Container(
                                          width: sizewidth * .02,
                                        ),
                                        Text(
                                          "${pitchDetail[0].bookPitch!.organisedBy!.email}",
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Color(0XFF25A163),
                                              decoration: TextDecoration.none),
                                        ),
                                        flaxibleGap(1),
                                      ],
                                    ),
                                  ),
                                  flaxibleGap(1),
                                ],
                              ),
                            )),
                      ),
                      GestureDetector(
                        onTap: () {
                          openMapsSheet(context);
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
                                          pitchDetail[0]
                                              .bookPitch!
                                              .latitude!
                                              .toDouble(),
                                          pitchDetail[0]
                                              .bookPitch!
                                              .longitude!
                                              .toDouble()),
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
                                            pitchDetail[0]
                                                    .bookPitch!
                                                    .location ??
                                                '',
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
                            height: sizeheight * .27,
                            color: const Color(0XFFF0F0F0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
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
                                    height: sizeheight * .15,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: pitchDetail[0]
                                            .bookPitch!
                                            .facilities!
                                            .length,
                                        itemBuilder: (BuildContext context,
                                            int blockIdx) {
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              width: sizewidth * .28,
                                              height: sizewidth * .07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: const Color(0XFF25A163)
                                                    .withOpacity(.3),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Flexible(
                                                    flex: 2,
                                                    child: Container(),
                                                  ),
                                                  cachedNetworkImage(
                                                    height: sizeheight * .08,
                                                    width: sizewidth * .18,
                                                    cuisineImageUrl:
                                                        pitchDetail[0]
                                                            ?.bookPitch
                                                            ?.facilities![
                                                                blockIdx]
                                                            ?.image
                                                            ?.filePath,
                                                  ),
                                                  flaxibleGap(1),
                                                  Text(
                                                      pitchDetail[0]
                                                          .bookPitch!
                                                          .facilities![
                                                              blockIdx]!
                                                          .name
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontSize: 12,
                                                          color:
                                                              Color(0XFF424242),
                                                          decoration:
                                                              TextDecoration
                                                                  .none)),
                                                  flaxibleGap(1),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                  )
                                ],
                              ),
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
                                        top: 20, bottom: 20),
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
                                                .organisedby,
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
                                        pitchDetail[0]
                                                .bookPitch!
                                                .organisedBy!
                                                .name ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color(0XFF424242),
                                            decoration: TextDecoration.none)),
                                  ),
                                  Text(
                                      pitchDetail[0].bookPitch!.description ??
                                          '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Color(0XFF424242),
                                          decoration: TextDecoration.none))
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      setState(() {
                        loadProfile();
                      });
                    }
                  });
                },
              );
  }

  void navigateToDetail() {
    _detail = {
      "id": pitchDetail[0].bookPitch!.id,
      "year": pitchDetail[0].bookPitch!.currentYear,
      "month": pitchDetail[0].bookPitch!.currentMonth,
      "ids": id,
      "email": pitchDetail[0].bookPitch!.organisedBy
    };
    Navigator.pushNamed(context, RouteNames.bookPitchSlot, arguments: _detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  String timing({required String y}) {
    int x = int.parse(y.substring(0, 2));
    var day;
    switch (x) {
      case 0:
        day = "12 ${AppLocalizations.of(context)!.am}";
        break;
      case 1:
        day = "1 ${AppLocalizations.of(context)!.am}";
        break;
      case 2:
        day = "2 ${AppLocalizations.of(context)!.am}";
        break;
      case 3:
        day = "3 ${AppLocalizations.of(context)!.am}";
        break;
      case 4:
        day = "4 ${AppLocalizations.of(context)!.am}";
        break;
      case 5:
        day = "5 ${AppLocalizations.of(context)!.am}";
        break;
      case 6:
        day = "6 ${AppLocalizations.of(context)!.am}";
        break;
      case 7:
        day = "7 ${AppLocalizations.of(context)!.am}";
        break;
      case 8:
        day = "8 ${AppLocalizations.of(context)!.am}";
        break;
      case 9:
        day = "9 ${AppLocalizations.of(context)!.am}";
        break;
      case 10:
        day = "10 ${AppLocalizations.of(context)!.am}";
        break;
      case 11:
        day = "11 ${AppLocalizations.of(context)!.am}";
        break;
      case 12:
        day = "12 ${AppLocalizations.of(context)!.pm}";
        break;
      case 13:
        day = "1 ${AppLocalizations.of(context)!.pm}";
        break;
      case 14:
        day = "2 ${AppLocalizations.of(context)!.pm}";
        break;
      case 15:
        day = "3 ${AppLocalizations.of(context)!.pm}";
        break;
      case 16:
        day = "4 ${AppLocalizations.of(context)!.pm}";
        break;
      case 17:
        day = "5 ${AppLocalizations.of(context)!.pm}";
        break;
      case 18:
        day = "6 ${AppLocalizations.of(context)!.pm}";
        break;
      case 19:
        day = "7 ${AppLocalizations.of(context)!.pm}";
        break;
      case 20:
        day = "8 ${AppLocalizations.of(context)!.pm}";
        break;
      case 21:
        day = "9 ${AppLocalizations.of(context)!.pm}";
        break;
      case 22:
        day = "10 ${AppLocalizations.of(context)!.pm}";
        break;
      default:
        day = "11 ${AppLocalizations.of(context)!.pm}";
        break;
    }
    return day;
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
