import 'package:flutter/material.dart';

import '../utils.dart';

class Splash2 extends StatelessWidget {
  const Splash2({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // spalash2J9F (331:12298)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xff7b61ff),
        ),
        child: Stack(
          children: [
            Positioned(
              // frame1000006384Biq (373:17273)
              left: 0 * fem,
              top: 27.3779296875 * fem,
              child: Align(
                child: SizedBox(
                  width: 428.4 * fem,
                  height: 622.8 * fem,
                  child: Image.asset(
                    'assets/light-design/images/frame-1000006384.png',
                    width: 428.4 * fem,
                    height: 622.8 * fem,
                  ),
                ),
              ),
            ),
            Positioned(
              // frame1000006404ecR (373:17377)
              left: 39.6235351562 * fem,
              top: 81.86328125 * fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    12.49 * fem, 39.53 * fem, 5.38 * fem, 16 * fem),
                width: 356.56 * fem,
                height: 635.9 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffc300),
                  borderRadius: BorderRadius.circular(29.8846130371 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupzyzhryP (RQpKhsF1TH8aHDZLnUzyZh)
                      margin: EdgeInsets.fromLTRB(
                          117.27 * fem, 0 * fem, 73.42 * fem, 3.12 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 22.94 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      child: Align(
                        // frameNB3 (373:17387)
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 41.1 * fem,
                          height: 41.1 * fem,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 106.9 * fem, 0 * fem),
                            child: Image.asset(
                              'assets/light-design/images/frame-QvM.png',
                              width: 41.1 * fem,
                              height: 41.1 * fem,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      // autogroup2sth4Zf (RQpKvhCy9wsheo8axH2STH)
                      width: double.infinity,
                      height: 513.21 * fem,
                      child: Stack(
                        children: [
                          Positioned(
                            // rectangle40203ziD (373:17378)
                            left: 0 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 338.69 * fem,
                                height: 483.23 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(22.2238521576 * fem),
                                      topRight:
                                          Radius.circular(22.2238521576 * fem),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // frame10000064004TB (373:17379)
                            left: 80.6220703125 * fem,
                            top: 467.68359375 * fem,
                            child: SizedBox(
                              width: 233.92 * fem,
                              height: 45.53 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // homevVP (373:17380)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        20.01 * fem, 33.72 * fem, 0 * fem),
                                    width: 32.01 * fem,
                                    height: 25.51 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/home.png',
                                      width: 32.01 * fem,
                                      height: 25.51 * fem,
                                    ),
                                  ),
                                  Container(
                                    // ticketqMT (373:17382)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        6.45 * fem, 34.15 * fem, 0 * fem),
                                    width: 16.44 * fem,
                                    height: 16.44 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/ticket.png',
                                      width: 16.44 * fem,
                                      height: 16.44 * fem,
                                    ),
                                  ),
                                  Container(
                                    // searchnormalwvH (373:17383)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 34.15 * fem, 5.4 * fem),
                                    width: 16.44 * fem,
                                    height: 16.44 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/search-normal-eyP.png',
                                      width: 16.44 * fem,
                                      height: 16.44 * fem,
                                    ),
                                  ),
                                  Container(
                                    // alarmqVs (373:17384)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 34.15 * fem, 17.24 * fem),
                                    width: 16.44 * fem,
                                    height: 16.44 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/alarm.png',
                                      width: 16.44 * fem,
                                      height: 16.44 * fem,
                                    ),
                                  ),
                                  Container(
                                    // profilevGR (373:17385)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 29.09 * fem),
                                    width: 16.44 * fem,
                                    height: 16.44 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/profile-ooo.png',
                                      width: 16.44 * fem,
                                      height: 16.44 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // chooseoptionnpR (373:17391)
                            left: 21.0288085938 * fem,
                            top: 19.3193359375 * fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(4.74 * fem,
                                  16.93 * fem, 28.53 * fem, 4.74 * fem),
                              width: 254.08 * fem,
                              height: 70.53 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xfff2f2f2),
                                borderRadius:
                                    BorderRadius.circular(12.8076915741 * fem),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // signinandsignup52q (373:17392)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 26.51 * fem, 0 * fem),
                                    width: 140.5 * fem,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          8.5384607315 * fem),
                                    ),
                                    child: Container(
                                      // signinbWy (373:17393)
                                      padding: EdgeInsets.fromLTRB(43.35 * fem,
                                          17.1 * fem, 43.35 * fem, 17.1 * fem),
                                      width: double.infinity,
                                      height: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: const Color(0xffffffff)),
                                        color: const Color(0xffffffff),
                                        borderRadius: BorderRadius.circular(
                                            8.5384607315 * fem),
                                      ),
                                      child: Center(
                                        // rectangle40197JwB (373:17394)
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 14.66 * fem,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      7.0892791748 * fem),
                                              color: const Color(0xffa1a1a1),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // rectangle401973Ny (373:17395)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 28.26 * fem),
                                    width: 53.8 * fem,
                                    height: 14.66 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          7.0892791748 * fem),
                                      color: const Color(0xffd9d9d9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // frame1000006408iED (373:17396)
                            left: 27.2244873047 * fem,
                            top: 95.09375 * fem,
                            child: SizedBox(
                              width: 262.79 * fem,
                              height: 127.34 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // frame1000006406po3 (373:17397)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 7.62 * fem, 3.06 * fem),
                                    width: 255.17 * fem,
                                    height: 62.29 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/frame-1000006406.png',
                                      width: 255.17 * fem,
                                      height: 62.29 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    // frame1000006407VPP (373:17401)
                                    width: 255.13 * fem,
                                    height: 61.99 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/frame-1000006407.png',
                                      width: 255.13 * fem,
                                      height: 61.99 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            // rectangle40197cyo (373:17415)
                            left: 256.6938476562 * fem,
                            top: 198.9716796875 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 34.85 * fem,
                                height: 11.34 * fem,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        9.2599372864 * fem),
                                    color: const Color(0xffff0d0d),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // buttontRX (373:17416)
                            left: 44.884765625 * fem,
                            top: 228.4033203125 * fem,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(98.88 * fem,
                                  9.08 * fem, 98.88 * fem, 9.08 * fem),
                              width: 253.76 * fem,
                              height: 67.74 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xffdddddd),
                                borderRadius:
                                    BorderRadius.circular(11.1119251251 * fem),
                              ),
                              child: Text(
                                'Button',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 17 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4705882353 * ffem / fem,
                                  color: const Color(0xff050505),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // orJk9 (373:17417)
                            left: 51.8842773438 * fem,
                            top: 288.1845703125 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 249.24 * fem,
                                height: 0.46 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/or.png',
                                  width: 249.24 * fem,
                                  height: 0.46 * fem,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // frame1000006409DMK (373:17420)
                            left: 54.4688720703 * fem,
                            top: 310.2578125 * fem,
                            child: SizedBox(
                              width: 252.26 * fem,
                              height: 54.93 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // googleandfacebookjqT (373:17421)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        15.51 * fem, 12.62 * fem, 0 * fem),
                                    width: 119.82 * fem,
                                    height: 39.43 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/google-and-facebook.png',
                                      width: 119.82 * fem,
                                      height: 39.43 * fem,
                                    ),
                                  ),
                                  Container(
                                    // googleandfacebookoqK (373:17427)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 15.51 * fem),
                                    width: 119.82 * fem,
                                    height: 39.43 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/google-and-facebook-U3s.png',
                                      width: 119.82 * fem,
                                      height: 39.43 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // contentUAm (331:12339)
              left: 0 * fem,
              top: 427 * fem,
              child: Container(
                padding: EdgeInsets.fromLTRB(
                    24 * fem, 24 * fem, 27.5 * fem, 77 * fem),
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
                      // textandsliderwq3 (331:12340)
                      margin: EdgeInsets.fromLTRB(
                          3.5 * fem, 0 * fem, 0 * fem, 60 * fem),
                      width: 320 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // headlineandbodyGsK (331:12341)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 42 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // captionat1 (331:12342)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 20 * fem),
                                  constraints: BoxConstraints(
                                    maxWidth: 200 * fem,
                                  ),
                                  child: Text(
                                    'Search a ground you \nwant to book',
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
                                  // bodye7B (331:12343)
                                  constraints: BoxConstraints(
                                    maxWidth: 320 * fem,
                                  ),
                                  child: Text(
                                    'We select only the best options for you accordance with your requirements.',
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
                            // slider9Zj (331:12344)
                            width: 38 * fem,
                            height: 12 * fem,
                            child: Image.asset(
                              'assets/light-design/images/slider-HGD.png',
                              width: 38 * fem,
                              height: 12 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // buttonandskipgpZ (331:12351)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 1.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // skipcy7 (331:12352)
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
                            // frame1000006380viu (331:12353)
                            width: 64 * fem,
                            height: 64 * fem,
                            child: Image.asset(
                              'assets/light-design/images/frame-1000006380.png',
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
