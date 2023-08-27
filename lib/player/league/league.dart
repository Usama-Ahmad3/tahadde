import 'dart:async';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:ui' as ui;

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/routingConstant.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';


class League extends StatefulWidget {
  final Map? eventData;

  League({this.eventData});

  @override
  _League1State createState() => _League1State();
}

class _League1State extends State<League> {
  final List<String> imgList = [
    'assets/images/T.png',
  ];
  var id;
  dynamic leaguedata;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool _isLoading = true;
  bool isscroll = false;
  late bool _auth;
  late bool _internet;
  final itemSize = 120.0;
  late ScrollController _controller;
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;
  List<Marker> allMarkers = [];

  loadProfile() async {
    _auth = (await checkAuthorizaton())!;
    if (mounted) {
      widget.eventData!["type"] == "League"
          ? detailLeague()
          : detailTournament();
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

  openMapsSheet(context) async {
    try {
      final coords = Coords(leaguedata.latitude, leaguedata.longitude);
      final title = leaguedata.location ?? '';
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

  _moveUp() {
    _controller.animateTo(_controller.offset - itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  _moveDown() {
    _controller.animateTo(_controller.offset + itemSize,
        curve: Curves.linear, duration: const Duration(milliseconds: 500));
  }

  Future onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            content: Text(AppLocalizations.of(context)!.toReserve),
            actions: <Widget>[
              TextButton(
                child: Text(AppLocalizations.of(context)!.cancel),
                onPressed: () {
                  Navigator.of(cntext).pop(false);
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
                position: LatLng(leaguedata.latitude, leaguedata.longitude),
              ));
            }));
  }

  detailLeague() async {
    _networkCalls.leagueDetail(
        id: widget.eventData!["id"],
        onSuccess: (msg) {
          setState(() {
            leaguedata = msg;
            addMarker();
            _isLoading = false;
          });
        },
        onFailure: (msg) {
          showMessage(msg);
          Navigator.pop(context);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
  }

  detailTournament() async {
    _networkCalls.tournamentDetail(
        id: widget.eventData!["id"],
        onSuccess: (msg) {
          setState(() {
            leaguedata = msg;
            addMarker();
            _isLoading = false;
          });
        },
        onFailure: (msg) {
          showMessage(msg);
          Navigator.pop(context);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        });
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
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    Event event = !_isLoading && _internet
        ? Event(
            title: leaguedata.name ?? " ",
            startDate: DateTime.parse(leaguedata.startDate)
                .subtract(const Duration(hours: 4)),
            endDate:
                DateTime.parse(leaguedata.endDate).subtract(const Duration(hours: 4)),
            allDay: false,
            timeZone: "Etc/GMT-4")
        : Event(title: '', startDate: DateTime.now(), endDate: DateTime.now());
    return _isLoading
        ? Scaffold(
            key: scaffoldkey,
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: AppBar(
                  backgroundColor: const Color(0XFF032040),
                )),
            bottomNavigationBar: Container(
              color: const Color(0XFF032040),
              height: sizeheight * .1,
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      //width: 150,
                      // color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          flaxibleGap(
                            1,
                          ),
                          const Icon(Icons.calendar_today, color: Colors.white),
                          flaxibleGap(
                            1,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.addto,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', color: Colors.white),
                              ),
                              Text(
                                AppLocalizations.of(context)!.calendar,
                                style: const TextStyle(
                                    fontFamily: 'Poppins', color: Colors.white),
                              ),
                            ],
                          ),
                          flaxibleGap(
                            1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Material(
                      color: const Color(0XFF25A163),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(AppLocalizations.of(context)!.bookNow,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Color(0XFFFFFFFF))),
                      ),
                    ),
                  ),
                ],
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
                                child: Container(
                                  child: cachedNetworkImage(
                                      height: 220,
                                      width: MediaQuery.of(context).size.width,
                                      cuisineImageUrl: '',
                                      placeholder: 'images/placeHolder.png'),
                                ),
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
                                    onPressed: () {
                                      Share.share(
                                        leaguedata.link,
                                        // subject:
                                        // 'Look what I made!');
                                        //launchInBrowser(leaguedata.link);
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
                          flaxibleGap(
                            2,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizewidth * .08),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: Container(
                                    height: 20,
                                    width: sizewidth * .7,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                            1,
                          ),
                          Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: sizewidth * .08),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: Container(
                                    height: 20,
                                    width: sizewidth * .4,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 2,
                                height: 15,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                width: sizewidth * .08,
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
                          flaxibleGap(
                            2,
                          ),
                        ],
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
                                      AppLocalizations.of(context)!.locale ==
                                              "en"
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

                                          ),
                                    ),
                                  ),
                                ),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey.shade300,
                                  highlightColor:Colors.grey.shade100,
                                  enabled: true,
                                  child: Container(
                                    height: 20,
                                    width: sizewidth * .2,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
                              highlightColor:Colors.grey.shade100,
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
                                        AppLocalizations.of(context)!.locale ==
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
                                          itemBuilder: (BuildContext context,
                                              int blockIdx) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey.shade300,
                                                highlightColor:
                                                Colors.grey.shade100,
                                                enabled: true,
                                                child: Container(
                                                  width: sizewidth * .28,
                                                  height: sizewidth * .07,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
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
                                          AppLocalizations.of(context)!.locale ==
                                                  "en"
                                              ? const EdgeInsets.only(right: 10)
                                              : const EdgeInsets.only(left: 10),
                                      child: const Icon(Icons.person),
                                    ),
                                    Text(
                                        AppLocalizations.of(context)!
                                            .organisedby,
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
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

                                          ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Shimmer.fromColors(
                                  baseColor:Colors.grey.shade300,
                                  highlightColor: Colors.grey.shade100,
                                  enabled: true,
                                  child: Container(
                                    height: 50,
                                    width: sizewidth,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0) //

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
          )
        : _internet
            ? Scaffold(
                key: scaffoldkey,
                appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(0),
                    child: AppBar(
                      backgroundColor: const Color(0XFF032040),
                    )),
                bottomNavigationBar: Container(
                  color: const Color(0XFF032040),
                  height: sizeheight * .1,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () async {
                            var status = await Permission.calendar.status;
                            if (status.isGranted) {
                              Add2Calendar.addEvent2Cal(event);
                            } else if (status.isDenied) {
                              Add2Calendar.addEvent2Cal(event);
                            } else {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      CupertinoAlertDialog(
                                        title: Text(AppLocalizations.of(context)!
                                            .calendarPermission),
                                        content: Text(AppLocalizations.of(
                                                context)!
                                            .thisCalendarPicturesUploadImage),
                                        actions: <Widget>[
                                          CupertinoDialogAction(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .deny),
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                          ),
                                          CupertinoDialogAction(
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .setting),
                                            onPressed: () => openAppSettings(),
                                          ),
                                        ],
                                      ));
                            }
                          },
                          splashColor: Colors.black,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            //width: 150,
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                flaxibleGap(
                                  1,
                                ),
                                const Icon(Icons.calendar_today, color: Colors.white),
                                flaxibleGap(
                                  1,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.addto,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.calendar,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                                flaxibleGap(
                                  1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Material(
                          color: const Color(0XFF25A163),
                          child: InkWell(
                            splashColor: Colors.black,
                            onTap: () {
                              _auth
                                  ? _networkCalls.checkInternetConnectivity(
                                      onSuccess: (msg) {
                                      _internet = msg;
                                      if (msg == true) {
                                        _networkCalls.verifyLeagueTournament(
                                          onSuccess: (msg) {
                                            showMessage(msg);
                                          },
                                          id: id,
                                          onFailure: (msg) {
                                            navigateToDetail(leaguedata);
                                          },
                                          tokenExpire: () {
                                            if (mounted) on401(context);
                                          },
                                        );
                                      } else {
                                        if (mounted) {
                                          showMessage(
                                              AppLocalizations.of(context)!
                                                  .noInternetConnection);
                                        }
                                      }
                                    })
                                  : onWillPop();
                            },
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context)!.bookNow,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: Color(0XFFFFFFFF))),
                                  Text(
                                      "${AppLocalizations.of(context)!.currency} ${leaguedata.paymentSummary.grandTotal.round()}",
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color: Color(0XFFFFFFFF))),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                                children: <Widget>[
                                  ClipPath(
                                      clipper: Cliping(),
                                      child: cachedNetworkImage(
                                        height: 220,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        cuisineImageUrl: tornamentchecking()
                                            ? leaguedata.tournamentfiles != null
                                                ? leaguedata.tournamentfiles
                                                    .files.filePath
                                                : ''
                                            : leaguedata.leaguefiles != null
                                                ? leaguedata
                                                    .leaguefiles.files.filePath
                                                : '',
                                        placeholder: 'images/placeHolder.png',
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
                                      IconButton(
                                        onPressed: () {
                                          Share.share(
                                            leaguedata.link,
                                            // subject:
                                            // 'Look what I made!');
                                            //launchInBrowser(leaguedata.link);
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
                              flaxibleGap(
                                2,
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .08),
                                    child: SizedBox(
                                      width: sizewidth * .7,
                                      child: Text(
                                        leaguedata.name ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: Colors.white,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                  flaxibleGap(
                                    10,
                                  ),
                                ],
                              ),
                              flaxibleGap(
                                1,
                              ),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .08),
                                    child: Text(
                                      leaguedata.pitchType.name ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Color(0XFF25A163),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                  Container(
                                    width: 2,
                                    height: 15,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: sizewidth * .08,
                                  ),
                                  Text(
                                    leaguedata.gamePlay.name ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0XFF25A163),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
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
                      SizedBox(
                        width: sizewidth,
                        height: sizeheight * .22,
                        child: GoogleMap(
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          onTap: (value) {
                            openMapsSheet(context);
                            //makeMap(_getLaunchUrl().toString());
                          },
                          compassEnabled: true,
                          mapType: MapType.normal,
                          initialCameraPosition: CameraPosition(
                              target: LatLng(
                                  leaguedata.latitude, leaguedata.longitude),
                              zoom: 15.0),
                          //markers: Set.identity(),
                          markers: Set.from(allMarkers),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            openMapsSheet(context);
                            //makeMap(_getLaunchUrl().toString());
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFF0F0F0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 7, top: 5, right: 7),
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
                                    child: SizedBox(
                                      width: sizewidth * .5,
                                      child: Text(
                                        leaguedata.location ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 5,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            color: Color(0XFF8B8B8B),
                                            decoration: TextDecoration.none),
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
                                          AppLocalizations.of(context)!.locale ==
                                                  "en"
                                              ? const EdgeInsets.only(right: 10)
                                              : const EdgeInsets.only(left: 10),
                                      child: const Icon(Icons.event),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.dateTime,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Color(0XFF424242),
                                          decoration: TextDecoration.none),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.EEEE('en_US').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.EEEE('ar_SA').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.EEEE('en_US').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.EEEE('ar_SA').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.yMMMd('en_US').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.yMMMd('ar_SA').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                    Text(
                                      AppLocalizations.of(context)!.to,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Color(0XFF898989),
                                          decoration: TextDecoration.none),
                                    ),
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.yMMMd('en_US').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.yMMMd('ar_SA').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.jm('en_US').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.jm('ar_SA').format(DateTime.parse(leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.jm('en_US').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.jm('ar_SA').format(DateTime.parse(leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, bottom: 20),
                                child:
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            '${AppLocalizations.of(context)!.lastDate} ${DateFormat.yMMMMd('en_US').format(DateTime.parse(leaguedata.bookingLastDate))}',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                //decoration: TextDecoration.underline,
                                                color: Color(0XFF25A163),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                          )
                                        : Text(
                                            '${AppLocalizations.of(context)!.lastDate} ${DateFormat.yMMMMd('ar_SA').format(DateTime.parse(leaguedata.bookingLastDate))}',
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                // decoration: TextDecoration.underline,
                                                color: Color(0XFF25A163),
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
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
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
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
                                              decoration: TextDecoration.none))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: sizewidth,
                                  child: Row(
                                    children: [
                                      leaguedata.facilities.length > 3
                                          ? GestureDetector(
                                              onTap: () {
                                                _moveUp();
                                              },
                                              child: const Icon(Icons.arrow_back_ios))
                                          : Container(),
                                      Expanded(
                                        child: SizedBox(
                                          height: sizeheight * .15,
                                          width:
                                              leaguedata.facilities.length > 3
                                                  ? sizewidth * .82
                                                  : sizewidth * .87,
                                          child: ListView.builder(
                                              controller: _controller,
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  leaguedata.facilities.length,
                                              itemExtent: itemSize,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int blockIdx) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    width: sizewidth * .28,
                                                    height: sizewidth * .07,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(0XFF25A163)
                                                          .withOpacity(.3),
                                                    ),
                                                    child: Column(
                                                      children: <Widget>[
                                                        flaxibleGap(
                                                          2,
                                                        ),
                                                        cachedNetworkImage(
                                                            height: sizeheight *
                                                                .08,
                                                            width:
                                                                sizewidth * .18,
                                                            cuisineImageUrl:
                                                                leaguedata
                                                                    ?.facilities[
                                                                        blockIdx]
                                                                    ?.image
                                                                    ?.filePath,
                                                            imageFit:
                                                                BoxFit.fill,
                                                            placeholder:
                                                                'images/placeHolder.png'),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                        Text(
                                                            leaguedata
                                                                .facilities[
                                                                    blockIdx]
                                                                .name,
                                                            style: const TextStyle(
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0XFF424242),
                                                                decoration:
                                                                    TextDecoration
                                                                        .none)),
                                                        flaxibleGap(
                                                          1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ),
                                      leaguedata.facilities.length > 3
                                          ? GestureDetector(
                                              onTap: () {
                                                _moveDown();
                                              },
                                              child:
                                                  const Icon(Icons.arrow_forward_ios))
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
                                      top: 10,
                                    ),
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
                                                fontFamily: 'Poppins',
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
                                        leaguedata.organisedBy.name ?? '',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0XFF032040),
                                            decoration: TextDecoration.none)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Text(leaguedata.description,
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            color: Color(0XFF424242),
                                            decoration: TextDecoration.none)),
                                  ),
                                ],
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    _internet = msg;
                    if (msg == true) {
                      loadProfile();
                    } else {
                      setState(() {});
                    }
                  });
                },
              );
  }

  void navigateToDetail(dynamic leaguedata) {
    var detail = {
      "detail": leaguedata,
      "id": tornamentchecking()
          ? "tournament&id=${leaguedata.id}"
          : "league&id=${leaguedata.id}"
    };
    Navigator.pushNamed(context, RouteNames.enterYourDetail, arguments: detail);
  }

  void navigateToDetail1() {
    Navigator.pushNamed(context, RouteNames.login);
  }

  bool tornamentchecking() {
    if (leaguedata is Turnament) {
      AppLocalizations.of(context)!.locale == "en"
          ? id =
              "tournament/${leaguedata.id}/verifytournamentbooking/?language=en"
          : id =
              "tournament/${leaguedata.id}/verifytournamentbooking/?language=ar";
      return true;
    } else {
      AppLocalizations.of(context)!.locale == "en"
          ? id = "league/${leaguedata.id}/verifyleaguebooking/?language=en"
          : id = "league/${leaguedata.id}/verifyleaguebooking/?language=ar";
      return false;
    }
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
