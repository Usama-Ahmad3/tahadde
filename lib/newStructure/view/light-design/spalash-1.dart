import 'package:flutter/material.dart';

import '../utils.dart';

class Splash1 extends StatelessWidget {
  const Splash1({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // spalash1QQq (200:10874)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xff7b61ff),
        ),
        child: Stack(
          children: [
            Positioned(
              // frame1000006383v8H (373:17180)
              left: 24 * fem,
              top: 88 * fem,
              child: Align(
                child: SizedBox(
                  width: 314.17 * fem,
                  height: 587.64 * fem,
                  child: Image.asset(
                    'assets/light-design/images/frame-1000006383-uc5.png',
                    width: 314.17 * fem,
                    height: 587.64 * fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // frame1000006382mPo (373:17039)
              left: 0 * fem,
              top: 14.693359375 * fem,
              child: Container(
                width: 514.19 * fem,
                height: 675.37 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f1),
                  borderRadius: BorderRadius.circular(30.0866775513 * fem),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x306e6f7f),
                      offset: Offset(-32.2357254028 * fem, 21.4904823303 * fem),
                      blurRadius: 42.9809646606 * fem,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      // frame1000006384CED (373:17040)
                      left: 220.228515625 * fem,
                      top: 51.91796875 * fem,
                      child: SizedBox(
                        width: 239.46 * fem,
                        height: 123.68 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              // frame1000006383hgm (373:17041)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 166.64 * fem, 55.21 * fem),
                              width: 72.82 * fem,
                              height: 38.91 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // rectangle40197cYq (373:17042)
                                    left: 5.0451660156 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 67.78 * fem,
                                        height: 37.58 * fem,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                9.3165607452 * fem),
                                            color: const Color(0xff2c344b),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // rectangle40198KCM (373:17043)
                                    left: 0 * fem,
                                    top: 16.8203125 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 43.18 * fem,
                                        height: 22.09 * fem,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                1.8633122444 * fem),
                                            color: const Color(0x4ca1a1a1),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // icon1L5 (373:17044)
                              width: 29.55 * fem,
                              height: 29.55 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xffc5c5c5),
                                borderRadius:
                                    BorderRadius.circular(27.9496841431 * fem),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // addresschange9SH (373:17046)
                      left: 195.7763671875 * fem,
                      top: 92.6279296875 * fem,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(
                            9.85 * fem, 9.85 * fem, 9.85 * fem, 28.33 * fem),
                        width: 278.43 * fem,
                        height: 155.85 * fem,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xffe3e3e3)),
                          borderRadius:
                              BorderRadius.circular(13.9748420715 * fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // autogroupf9rzzC1 (RQpMNjdGUxdVKMvHSHf9RZ)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 133.61 * fem, 39.21 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 37.32 * fem, 0 * fem),
                              width: double.infinity,
                              height: 48.9 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // icon3RB (373:17049)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 2.31 * fem, 19.34 * fem),
                                    width: 29.55 * fem,
                                    height: 29.55 * fem,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffc5c5c5),
                                      borderRadius: BorderRadius.circular(
                                          27.9496841431 * fem),
                                    ),
                                  ),
                                  Container(
                                    // rectangle40199oYm (373:17047)
                                    width: 55.93 * fem,
                                    height: 27.81 * fem,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffe3e3e3),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // iconM4V (373:17048)
                              margin: EdgeInsets.fromLTRB(
                                  163.53 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 29.55 * fem,
                              height: 29.55 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xffffc300),
                                borderRadius:
                                    BorderRadius.circular(27.9496841431 * fem),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // frame10000063903T7 (373:17050)
                      left: 179.3743896484 * fem,
                      top: 147.0283203125 * fem,
                      child: SizedBox(
                        width: 253.56 * fem,
                        height: 121.59 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // group1000006149x4H (373:17051)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 7.69 * fem, 83.64 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  6 * fem, 5.15 * fem, 10.22 * fem, 9.6 * fem),
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius:
                                    BorderRadius.circular(12.8942899704 * fem),
                              ),
                              child: Center(
                                // frame1000006385Fp5 (373:17053)
                                child: SizedBox(
                                  width: 39.6 * fem,
                                  height: 23.2 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/frame-1000006385.png',
                                    width: 39.6 * fem,
                                    height: 23.2 * fem,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // group1000006148Aw3 (373:17056)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 10.55 * fem, 36.64 * fem),
                              width: 39.6 * fem,
                              height: 23.2 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000006148.png',
                                width: 39.6 * fem,
                                height: 23.2 * fem,
                              ),
                            ),
                            Container(
                              // group1000006150641 (373:17060)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 8.37 * fem, 10.55 * fem, 0 * fem),
                              width: 39.6 * fem,
                              height: 23.2 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000006150.png',
                                width: 39.6 * fem,
                                height: 23.2 * fem,
                              ),
                            ),
                            Container(
                              // group1000006151ydb (373:17064)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 53.38 * fem, 10.55 * fem, 0 * fem),
                              width: 39.6 * fem,
                              height: 23.2 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000006151.png',
                                width: 39.6 * fem,
                                height: 23.2 * fem,
                              ),
                            ),
                            Container(
                              // group1000006152gY1 (373:17068)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 98.39 * fem, 0 * fem, 0 * fem),
                              width: 39.6 * fem,
                              height: 23.2 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000006152.png',
                                width: 39.6 * fem,
                                height: 23.2 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      // rectangle40203oMj (373:17072)
                      left: 1.4079589844 * fem,
                      top: 175.9482421875 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 416.16 * fem,
                          height: 456.92 * fem,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(22.359746933 * fem),
                                topRight: Radius.circular(22.359746933 * fem),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // frame1000006394scV (373:17073)
                      left: 95.4582519531 * fem,
                      top: 203.9765625 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 295.19 * fem,
                          height: 249.57 * fem,
                          child: Image.asset(
                            'assets/light-design/images/frame-1000006394.png',
                            width: 295.19 * fem,
                            height: 249.57 * fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // frame1000006399MGm (373:17108)
                      left: 27.5622558594 * fem,
                      top: 370.5751953125 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 288.33 * fem,
                          height: 234.27 * fem,
                          child: Image.asset(
                            'assets/light-design/images/frame-1000006399.png',
                            width: 288.33 * fem,
                            height: 234.27 * fem,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      // frame1000006400qhj (373:17128)
                      left: 12.3259277344 * fem,
                      top: 535.5078125 * fem,
                      child: SizedBox(
                        width: 221.83 * fem,
                        height: 113.12 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // homejo7 (373:17129)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 25.52 * fem, 80.52 * fem),
                              width: 36.35 * fem,
                              height: 32.61 * fem,
                              child: Image.asset(
                                'assets/light-design/images/home-VXf.png',
                                width: 36.35 * fem,
                                height: 32.61 * fem,
                              ),
                            ),
                            Container(
                              // ticketFmT (373:17131)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 27.05 * fem, 32.45 * fem),
                              width: 19.7 * fem,
                              height: 19.7 * fem,
                              child: Image.asset(
                                'assets/light-design/images/ticket-9LV.png',
                                width: 19.7 * fem,
                                height: 19.7 * fem,
                              ),
                            ),
                            Container(
                              // searchnormal7of (373:17132)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 9.5 * fem, 27.05 * fem, 0 * fem),
                              width: 19.7 * fem,
                              height: 19.7 * fem,
                              child: Image.asset(
                                'assets/light-design/images/search-normal-c97.png',
                                width: 19.7 * fem,
                                height: 19.7 * fem,
                              ),
                            ),
                            Container(
                              // alarmENV (373:17133)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 51.46 * fem, 27.05 * fem, 0 * fem),
                              width: 19.7 * fem,
                              height: 19.7 * fem,
                              child: Image.asset(
                                'assets/light-design/images/alarm-JTj.png',
                                width: 19.7 * fem,
                                height: 19.7 * fem,
                              ),
                            ),
                            Container(
                              // profilek5w (373:17134)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 93.42 * fem, 0 * fem, 0 * fem),
                              width: 19.7 * fem,
                              height: 19.7 * fem,
                              child: Image.asset(
                                'assets/light-design/images/profile-4KT.png',
                                width: 19.7 * fem,
                                height: 19.7 * fem,
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
            Positioned(
              // content4MX (331:12297)
              left: 0 * fem,
              top: 427 * fem,
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 29 * fem, 77 * fem),
                width: 375 * fem,
                height: 385 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xff050505),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24 * fem),
                    topRight: Radius.circular(24 * fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // textandslidertLZ (217:11921)
                      margin: EdgeInsets.fromLTRB(
                          17.5 * fem, 0 * fem, 12.5 * fem, 60 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // headlineandbodyoTX (217:11920)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 42 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // captionjMB (200:10875)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 20 * fem),
                                  constraints: BoxConstraints(
                                    maxWidth: 200 * fem,
                                  ),
                                  child: Text(
                                    'One-step solution to \nbook a ground',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.25 * ffem / fem,
                                      letterSpacing: -0.2 * fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                Container(
                                  // bodycfs (200:10876)
                                  constraints: BoxConstraints(
                                    maxWidth: 292 * fem,
                                  ),
                                  child: Text(
                                    'Easily view nearby popular grounds and make a booking at your preferred time.',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846 * ffem / fem,
                                      color: const Color(0xff828282),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // slider7cd (202:12255)
                            width: 38 * fem,
                            height: 12 * fem,
                            child: Image.asset(
                              'assets/light-design/images/slider-7XP.png',
                              width: 38 * fem,
                              height: 12 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // buttonandskipday (217:11922)
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // skipzAd (217:11919)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 224 * fem, 0 * fem),
                            child: Text(
                              'SKIP',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333 * ffem / fem,
                                color: const Color(0xff505050),
                              ),
                            ),
                          ),
                          SizedBox(
                            // frame1000006380Jh7 (217:11917)
                            width: 64 * fem,
                            height: 64 * fem,
                            child: Image.asset(
                              'assets/light-design/images/frame-1000006380-Jim.png',
                              width: 64 * fem,
                              height: 64 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
