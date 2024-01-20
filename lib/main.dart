import 'dart:async';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import 'apis/apis.dart';
import 'common_widgets/internetStatus.dart';
import 'common_widgets/localNotificationChannel.dart';
import 'common_widgets/localeHelper.dart';
import 'common_widgets/router.dart';
import 'constant.dart';
import 'homeFile/home.dart';
import 'homeFile/more.dart';
import 'homeFile/notificationEmpty.dart';
import 'homeFile/routingConstant.dart';
import 'homeFile/utility.dart';
import 'localizations.dart';
import 'newStructure/view/owner/home_screens/HomeAcademyOwnerScreen.dart';
import 'newStructure/view/player/HomeScreen/playerHomeScreen.dart';
import 'player/loginSignup/profile/profile.dart';
import 'walkThrough/walkThrough.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  //print('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  // var devices = ['754FD214F18DBD3A6DCD076B0593951E'];
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize;
  await Firebase.initializeApp();
  // RequestConfiguration requestConfiguration =
  //     RequestConfiguration(testDeviceIds: devices);
  // MobileAds.instance.updateRequestConfiguration(requestConfiguration);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = const DarwinInitializationSettings();
  InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  runApp(const SplaceVedio());
  // runZonedGuarded(() {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ]).then((value) => );
  // }, (error, stackTrace) {
  //   FirebaseCrashlytics.instance.recordError(error, stackTrace);
  // });
}

class SplaceVedio extends StatefulWidget {
  const SplaceVedio({super.key});

  @override
  _SplaceVedioState createState() => _SplaceVedioState();
}

class _SplaceVedioState extends State<SplaceVedio> {
  late SharedPreferences pref;
  late String _language;
  late String _role;
  late String _walk;
  late String _country;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    loadLanguage();
  }

  loadLanguage() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      RestApis.BASEURL = pref.get("baseUrl").toString() ?? RestApis.BASEURL;
      _language = pref.get("lang").toString();
      _role = pref.get("role").toString();
      _walk = pref.get("walk").toString();
      _country = pref.get("country").toString();
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Material()
        : Material(
            color: Colors.white,
            child: MyApp(
              language: _language,
              role: _role,
              walk: _walk,
              country: _country,
            ),
          );
  }
}

class MyApp extends StatefulWidget {
  final String? language;
  final String? role;
  final String? walk;
  final String? country;

  const MyApp({super.key, this.language, this.role, this.walk, this.country});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late SpecificLocalizationDelegate _specificLocalizationDelegate;
  String? _language;
  static ThemeMode? mode;

  @override
  void initState() {
    super.initState();
    _language = widget.language;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(Locale(_language ?? "ar", ''));
    helper.onLocaleChanged = onLocaleChange;
  }

  onLocaleChange(Locale locale) {
    setState(() {
      _language = locale.languageCode;
      _specificLocalizationDelegate = SpecificLocalizationDelegate(locale);
    });
    print(locale.languageCode);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    Brightness currentSystemBrightness =
        MediaQuery.of(context).platformBrightness;
    mode = currentSystemBrightness == Brightness.light
        ? ThemeMode.light
        : ThemeMode.dark;
    return MaterialApp(
      title: "Tahadde",
      color: Colors.white,
      themeMode: mode ?? ThemeMode.light,
      theme: ThemeData(
        useMaterial3: false,
        brightness: currentSystemBrightness,
        fontFamily: 'Poppins',
        textTheme: TextTheme(
            titleSmall: TextStyle(
              fontSize: 13 * ffem,
              fontWeight: FontWeight.w400,
            ),
            bodyMedium: TextStyle(
              fontSize: 15 * ffem,
              fontWeight: FontWeight.w500,
            ),
            titleMedium: TextStyle(
                color: mode == ThemeMode.light ? Colors.black : Colors.white,
                fontSize: 20 * ffem,
                fontWeight: FontWeight.w600,
                height: 1.25 * ffem / fem,
                letterSpacing: -0.2 * fem)),
        appBarTheme: const AppBarTheme(backgroundColor: Colors.black54),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterPage.generateRoute,
      // initialRoute: RouteNames.languageSave,
      localizationsDelegates: [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        _specificLocalizationDelegate
      ],
      supportedLocales: const [Locale('en', ''), Locale('ar', '')],
      locale: _language != null ? Locale(_language!, '') : null,
      //locale: _specificLocalizationDelegate.overriddenLocale,
      home: LanguageSave(
        role: widget.role.toString(),
        walk: widget.walk.toString(),
        country: widget.country.toString(),
      ),
    );
  }
}

class LanguageSave extends StatefulWidget {
  final String? role;
  final String? walk;
  final String? country;

  const LanguageSave({super.key, this.role, this.walk, this.country});

  @override
  _LanguageSaveState createState() => _LanguageSaveState();
}

class _LanguageSaveState extends State<LanguageSave> {
  late VideoPlayerController _controller;

  bool _isSplace = true;

  @override
  void initState() {

    _controller = VideoPlayerController.asset(
        'assets/images/New.mp4');
    _controller.addListener(() {
      setState(() {});
    });
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    _controller.setLooping(false);
    _controller.setVolume(5.0);
    Timer(const Duration(milliseconds: 3000), () {
      setState(() {});
      ///
      _isSplace = false;
    });
    // setState(() {});
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                //icon: "app_icon",
                // other properties...
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                //icon: "app_icon",
                // other properties...
              ),
            ));
      }
    });
    FirebaseMessaging.onBackgroundMessage((message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        return flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // channel.description,
                //icon: "app_icon",
                // other properties...
              ),
            ));
      }
      throw Exception();
    });
    
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityStatus(
        child:  _isSplace
            ? SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    width: _controller.value.size.width ?? 0,
                    height: _controller.value.size.height ?? 0,
                    child: VideoPlayer(_controller),
                  ),
                ),
              )
            : widget.walk == null
                ? const WalkThroughScreen()
                : widget.role == "pitchowner"
                    ? HomePitchOwnerScreen(
                        index: 0,
                      )
                    : PlayerHomeScreen(index: 0)
        );
  }
}

class PlayerHome extends StatefulWidget {
  int index;

  PlayerHome({super.key, required this.index});

  @override
  // ignore: no_logic_in_create_state
  _PlayerHomeState createState() => _PlayerHomeState();
}

class _PlayerHomeState extends State<PlayerHome>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _handleTabSelection() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  initDynamicLinks() async {
    bool auth = await checkAuthorizaton() as bool;
    PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri deepLink = data != null ? data.link : Uri.parse('uri');
    if (deepLink.queryParameters["token"] != null) {
      if (!auth) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, RouteNames.forgotPasswordScreen,
            arguments: deepLink.queryParameters["token"]);
      }
    } else if (deepLink.queryParameters["event_details"] == "pitch_details") {
      navigateToBookPitchDetail(
          int.parse(deepLink.queryParameters["pk"] ?? ''));
    } else if (deepLink.queryParameters["event_details"] == "league_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "League"
      };
      navigateToLeagueDetail(detail);
    } else if (deepLink.queryParameters["event_details"] ==
        "tournament_details") {
      Map detail = {
        "id": int.parse(deepLink.queryParameters["pk"] ?? ''),
        "type": "Tournament"
      };
      navigateToLeagueDetail(detail);
    }
    FirebaseDynamicLinks.instance.onLink;
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    _tabController =
        TabController(vsync: this, length: 4, initialIndex: widget.index);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  onWillPop() {
    return showDialog(
        context: context,
        builder: (BuildContext cntext) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context)!.areYouSure),
            content: Text(AppLocalizations.of(context)!.youGoingExit),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            actions: [
              TextButton(
                child: Text(AppLocalizations.of(context)!.no),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              TextButton(
                child: Text(AppLocalizations.of(context)!.yes),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  final page = [
    const Home(),
    const NotificationEmpty(),
    ProfileScreen(msg: 'msg'),
    const More()
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () {
          return onWillPop();
        },
        child: Material(
            color: appThemeColor,
            child: Scaffold(
              bottomNavigationBar: SalomonBottomBar(
                currentIndex: widget.index,
                onTap: (index) {
                  widget.index = index;
                  setState(() {});
                },
                selectedItemColor: Colors.yellowAccent,
                backgroundColor: Colors.black,
                selectedColorOpacity: 1,
                items: [
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.home_outlined,
                    ),
                    title: const Text(
                      "Home",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.notifications_none,
                    ),
                    title: const Text(
                      "Notification",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.person_2_outlined,
                    ),
                    title: const Text(
                      "Profile",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.grey,
                  ),
                  SalomonBottomBarItem(
                    icon: const Icon(
                      Icons.settings_outlined,
                    ),
                    title: const Text(
                      "More",
                      style: TextStyle(color: Colors.black),
                    ),
                    activeIcon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    selectedColor: Colors.yellow,
                    unselectedColor: Colors.grey,
                  ),
                ],
              ),
              // Container(
              //   padding: Platform.isIOS
              //       ? const EdgeInsets.only(bottom: 10)
              //       : EdgeInsets.zero,
              //   decoration: const BoxDecoration(
              //       color: Colors.white,
              //       border: Border(
              //           top: BorderSide(color: Colors.grey, width: 0.8))),
              //   height: 60,
              //   alignment: Alignment.bottomCenter,
              //   child: TabBar(
              //       labelStyle: const TextStyle(
              //         fontSize: 10,
              //         fontWeight: FontWeight.w700,
              //         fontFamily: 'Poppins',
              //       ),
              //       controller: _tabController,
              //       tabs: [
              //         // Tab(
              //         //   icon: _tabController.index == 0
              //         //       ? Padding(
              //         //           padding: const EdgeInsets.only(top: 5),
              //         //           child: Image.asset(
              //         //             'assets/images/team.png',
              //         //             height: 25,
              //         //           ),
              //         //         )
              //         //       : Padding(
              //         //           padding: const EdgeInsets.only(top: 5),
              //         //           child: Image.asset(
              //         //             'assets/images/teamColor.png',
              //         //             height: 25,
              //         //           ),
              //         //         ),
              //         //   text: AppLocalizations.of(context)!.team
              //         // ),
              //
              //         Tab(
              //           child: Padding(
              //             padding: const EdgeInsets.only(bottom: 0.0),
              //             child: Image.asset(
              //               'assets/images/TC.png',
              //               fit: BoxFit.fill,
              //               color: _tabController.index == 0
              //                   ? const Color(0XFF052040)
              //                   : Colors.grey[500],
              //               height: 25,
              //               // height: 40,
              //               // width: 60,
              //             ),
              //           ),
              //         ),
              //         Tab(
              //           icon: _tabController.index == 1
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/notificationColor.png',
              //                     height: 25,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/notification.png',
              //                     height: 25,
              //                   ),
              //                 ),
              //           // text: AppLocalizations.of(context)!.notification
              //         ),
              //         Tab(
              //           icon: _tabController.index == 2
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/userColor.png',
              //                     height: 25,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/user.png',
              //                     height: 25,
              //                   ),
              //                 ),
              //         ),
              //         Tab(
              //           icon: _tabController.index == 3
              //               ? Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/moreColor.png',
              //                     height: 21,
              //                   ),
              //                 )
              //               : Padding(
              //                   padding: const EdgeInsets.only(top: 5),
              //                   child: Image.asset(
              //                     'assets/images/more.png',
              //                     height: 21,
              //                   ),
              //                 ),
              //         ),
              //       ],
              //       labelColor: const Color(0XFF032040),
              //       indicatorWeight: 4,
              //       unselectedLabelColor: const Color(0XFF7A7A7A),
              //       indicatorSize: TabBarIndicatorSize.label,
              //       indicatorPadding: const EdgeInsets.only(bottom: 5),
              //       indicatorColor: Colors.transparent
              //       //Color(0XFF032040),
              //       ),
              // ),
              body: page[widget.index],
              // TabBarView(
              //   controller: _tabController,
              //   children: [
              //     // TeamEmpaty(),
              //     HomeScreen(),
              //     NotificationEmpty(),
              //
              //     ProfileScreen(
              //       msg: 'msg'.toString(),
              //     ),
              //     More()
              //   ],
              // )
            )),
      ),
    );
  }

  void navigateToBookPitchDetail(dynamic bookPitchData) {
    Navigator.pushNamed(context, RouteNames.bookPitch,
        arguments: bookPitchData);
  }

  void navigateToLeagueDetail(Map leaguedata) {
    Navigator.pushNamed(context, RouteNames.league, arguments: leaguedata);
  }
}

/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  const VideoApp({super.key});

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'));
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
