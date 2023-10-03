import 'dart:ui' as ui;

import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart' hide MapType;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common_widgets/internet_loss.dart';
import '../../homeFile/utility.dart';
import '../../localizations.dart';
import '../../modelClass/turnamentModelClass.dart';
import '../../network/network_calls.dart';

class LeagueTahaddi extends StatefulWidget {
  Map leaguedata;
  LeagueTahaddi({super.key, required this.leaguedata});
  @override
  _LeagueTahaddiState createState() => _LeagueTahaddiState();
}

class _LeagueTahaddiState extends State<LeagueTahaddi> {
  dynamic leaguedata;
  final List<String> imgList = [
    'assets/images/T.png',
  ];
  List<Marker> allMarkers = [];
  var id;
  final scaffoldkey = GlobalKey<ScaffoldState>();
  bool loading = true;
  late bool internet;
  final NetworkCalls _networkCalls = NetworkCalls();
  late SharedPreferences pref;

  loadProfile() {
    if (widget.leaguedata["status"] == true) {
      _networkCalls.tahaddiLeague(
        id: widget.leaguedata["id"],
        event: widget.leaguedata["event"],
        onSuccess: (msg) {
          setState(() {
            leaguedata = msg;
            loading = false;
            addMarker();
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
    } else if (widget.leaguedata["status"] == false) {
      _networkCalls.tahaddiTournament(
        id: widget.leaguedata["id"],
        event: widget.leaguedata["event"],
        onSuccess: (msg) {
          setState(() {
            leaguedata = msg;
            loading = false;
            addMarker();
          });
        },
        onFailure: (msg) {
          showMessage(msg);
        },
        tokenExpire: () {
          if (mounted) on401(context);
        },
      );
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
          loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var sizeheight = MediaQuery.of(context).size.height;
    var sizewidth = MediaQuery.of(context).size.width;
    Event event = Event(
      title: 'Event Name',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      allDay: false,
    );
    return loading
        ? Scaffold(
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
                                      height: 150.0,
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
                                      height: 300.0,
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
        : internet
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
                        launchInBrowser(leaguedata.link);
                      },
                      icon: const Icon(
                        Icons.share,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                key: scaffoldkey,
                bottomNavigationBar: Container(
                  color: const Color(0XFF032040),
                  height: 56,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Add2Calendar.addEvent2Cal(event),
                          splashColor: Colors.black,
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height,
                            //width: 150,
                            // color: Colors.white,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                flaxibleGap(1),
                                const Icon(Icons.calendar_today,
                                    color: Colors.white),
                                flaxibleGap(1),
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
                                flaxibleGap(1),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Material(
                          color: const Color(0XFF25A163),
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(AppLocalizations.of(context)!.booked,
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
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  ClipPath(
                                      clipper: Cliping(),
                                      child: cachedNetworkImage(
                                        height: 250,
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
                                      )),
                                ],
                              ),
                              flaxibleGap(2),
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: sizewidth * .08),
                                    child: Text(
                                      leaguedata.name ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: Colors.white,
                                          decoration: TextDecoration.none),
                                    ),
                                  ),
                                  flaxibleGap(10),
                                ],
                              ),
                              flaxibleGap(1),
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
                                  flaxibleGap(2),
                                  Container(
                                    width: 2,
                                    height: 15,
                                    color: Colors.grey,
                                  ),
                                  flaxibleGap(2),
                                  Text(
                                    leaguedata.gamePlay.name ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0XFF25A163),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  flaxibleGap(20),
                                ],
                              ),
                              flaxibleGap(2),
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
                          markers: Set.from(allMarkers),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            openMapsSheet(context);
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFF0F0F0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 7, top: 5, right: 7),
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
                                      padding: AppLocalizations.of(context)!
                                                  .locale ==
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
                                    left: 20, right: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.start,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Color(0XFF898989),
                                          decoration: TextDecoration.none),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.end,
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Color(0XFF898989),
                                          decoration: TextDecoration.none),
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
                                            (DateFormat.yMMMEd('en_US').format(
                                                DateTime.parse(
                                                    leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.yMMMEd('ar_SA').format(
                                                DateTime.parse(
                                                    leaguedata.startDate))),
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
                                            (DateFormat.yMMMEd('en_US').format(
                                                DateTime.parse(
                                                    leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                color: Color(0XFF898989),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.yMMMEd('ar_SA').format(
                                                DateTime.parse(
                                                    leaguedata.endDate))),
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
                                            (DateFormat.jm('en_US').format(
                                                DateTime.parse(
                                                    leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.jm('ar_SA').format(
                                                DateTime.parse(
                                                    leaguedata.startDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                    AppLocalizations.of(context)!.locale == "en"
                                        ? Text(
                                            (DateFormat.jm('en_US').format(
                                                DateTime.parse(
                                                    leaguedata.endDate))),
                                            style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 20,
                                                color: Color(0XFF4A4A4A),
                                                decoration:
                                                    TextDecoration.none),
                                          )
                                        : Text(
                                            (DateFormat.jm('ar_SA').format(
                                                DateTime.parse(
                                                    leaguedata.endDate))),
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
                                                // decoration: TextDecoration.underline,
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
                            color: const Color(0XFFF0F0F0),
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
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
                                              .description,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 20,
                                              color: Color(0XFF424242),
                                              decoration: TextDecoration.none))
                                    ],
                                  ),
                                ),
                                Text(leaguedata.description ?? '',
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: Color(0XFF424242),
                                        decoration: TextDecoration.none))
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0XFFF0F0F0),
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
                                      top: 20, bottom: 10),
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
                                              decoration: TextDecoration.none))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Text(leaguedata.organisedBy.name ?? '',
                                      style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: Color(0XFF424242),
                                          decoration: TextDecoration.none)),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                      Icon(Icons.star),
                                      Icon(Icons.star)
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    makePhoneCall(
                                        "tel:${leaguedata.organisedBy.contact_number ?? ""}");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? const EdgeInsets.only(
                                                  right: 10,
                                                )
                                              : const EdgeInsets.only(left: 10),
                                          child: const Icon(Icons.call),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!
                                                      .locale ==
                                                  "en"
                                              ? "${leaguedata.organisedBy.countryCode ?? ""}" "${leaguedata.organisedBy.contact_number ?? ""}"
                                              : "${leaguedata.organisedBy.countryCode == null ? "" : leaguedata.organisedBy.countryCode.substring(1)}${leaguedata.organisedBy.contact_number ?? ""}${leaguedata.organisedBy.countryCode == null ? "" : leaguedata.organisedBy.countryCode.substring(0, 1)}",
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: Color(0XFF25A163),
                                              decoration: TextDecoration.none),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    launch(
                                        "mailto:${leaguedata.organisedBy.email ?? ""}?subject=Tahaddi&body= Tahaddi");
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: AppLocalizations.of(context)!
                                                    .locale ==
                                                "en"
                                            ? const EdgeInsets.only(right: 10)
                                            : const EdgeInsets.only(left: 10),
                                        child: const Icon(Icons.mail),
                                      ),
                                      Text(
                                        leaguedata.organisedBy.email ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'Poppins',
                                            color: Color(0XFF25A163),
                                            decoration: TextDecoration.none),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              )
            : InternetLoss(
                onChange: () {
                  _networkCalls.checkInternetConnectivity(onSuccess: (msg) {
                    internet = msg;
                    if (msg == true) {
                      setState(() {
                        loadProfile();
                      });
                    }
                  });
                },
              );
  }

  bool tornamentchecking() {
    if (leaguedata is Turnament) {
      id = "tournament/${leaguedata.id}/verifytournamentbooking/";
      return true;
    } else {
      id = "league/${leaguedata.id}/verifyleaguebooking/";

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
