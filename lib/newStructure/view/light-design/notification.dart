import 'package:flutter/material.dart';

import '../../../homeFile/utility.dart';
import '../../../network/network_calls.dart';
import '../utils.dart';

class NotificationL extends StatefulWidget {
  const NotificationL({super.key});

  @override
  State<NotificationL> createState() => _NotificationLState();
}

class _NotificationLState extends State<NotificationL> {
  final NetworkCalls _networkCalls = NetworkCalls();
  final scaffoldkey = GlobalKey<ScaffoldState>();
  List? detail = [];
  bool _isLoading = true;
  late bool _internet;
  late bool _auth;
  loadNotification() async {
    await _networkCalls.notificationGet(
      onSuccess: (msg) {
        if (mounted) {
          setState(() {
            detail = msg;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _networkCalls.checkInternetConnectivity(
      onSuccess: (msg) async {
        _internet = msg;
        _auth = (await checkAuthorizaton())!;
        if (mounted) {
          msg
              ? _auth
                  ? loadNotification()
                  : {
                      if (mounted)
                        setState(() {
                          _isLoading = false;
                        })
                    }
              : {
                  if (mounted)
                    setState(() {
                      _isLoading = false;
                    })
                };
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color(0xff050505),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 55),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 83.5 * fem, 0 * fem),
                  width: 32 * fem,
                  height: 32 * fem,
                  child: Image.asset(
                    'assets/light-design/images/icon-7AR.png',
                    width: 32 * fem,
                    height: 32 * fem,
                  ),
                ),
                Text(
                  'Notification',
                  textAlign: TextAlign.center,
                  style: SafeGoogleFont(
                    'Inter',
                    fontSize: 17 * ffem,
                    fontWeight: FontWeight.w600,
                    height: 1.4705882353 * ffem / fem,
                    color: const Color(0xffffffff),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 575 * fem,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30 * fem),
                  topLeft: Radius.circular(30 * fem)),
              // ignore: prefer_const_constructors
              color: Color(0xfff2f2f2),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 8.0 * fem),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12 * fem),
                      child: Text(
                        'New',
                        textAlign: TextAlign.center,
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 15 * ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.3333333333 * ffem / fem,
                          color: Color(0xff686868),
                        ),
                      ),
                    ),
                    ...List.generate(
                      10,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 5),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  15 * fem, 12 * fem, 15 * fem, 12 * fem),
                              width: double.infinity,
                              height: 62 * fem,
                              decoration: BoxDecoration(
                                color: Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // iconpL1 (I303:11933;303:11890)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                    width: 32 * fem,
                                    height: 32 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/icon-Zow.png',
                                      width: 32 * fem,
                                      height: 32 * fem,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 26 * fem, 0 * fem),
                                    constraints: BoxConstraints(
                                      maxWidth: 175 * fem,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          color: Color(0xff050505),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Hover Ground',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3846153846 * ffem / fem,
                                              color: Color(0xff050505),
                                            ),
                                          ),
                                          TextSpan(
                                            text: ' ',
                                          ),
                                          TextSpan(
                                            text:
                                                'has accepted your booking request.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3846153846 * ffem / fem,
                                              color: Color(0xff686868),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Text(
                                    // houragoGYh (I303:11933;303:11894)
                                    '1 Hour ago',
                                    textAlign: TextAlign.right,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 11 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3636363636 * ffem / fem,
                                      color: Color(0xff686868),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: index == 3 ? 16 * fem : 0 * fem,
                            ),
                            index == 3
                                ? Text(
                                    'Earlier',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3333333333 * ffem / fem,
                                      color: Color(0xff686868),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
