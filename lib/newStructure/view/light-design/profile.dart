import 'package:flutter/material.dart';

import '../utils.dart';

class ProfileScreenView extends StatefulWidget {
  const ProfileScreenView({super.key});

  @override
  State<ProfileScreenView> createState() => _ProfileScreenViewState();
}

class _ProfileScreenViewState extends State<ProfileScreenView> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xff050505),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // autogroupm7yhng9 (RQoSEM1ds5Fu92vpXGM7yh)
            margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 39 * fem),
            width: double.infinity,
            height: 725 * fem,
            child: Stack(
              children: [
                Positioned(
                  // bgimageuEy (314:12230)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 375 * fem,
                      height: 263 * fem,
                      child: Image.asset(
                        'assets/light-design/images/bg-image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // bgBiH (314:12232)
                  left: 0 * fem,
                  top: 195 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 375 * fem,
                      height: 530 * fem,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(24 * fem),
                            bottomLeft: Radius.circular(24 * fem),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // editbuttonLjb (390:17024)
                  left: 331 * fem,
                  top: 246 * fem,
                  child: Align(
                    child: SizedBox(
                      width: 20 * fem,
                      height: 20 * fem,
                      child: Image.asset(
                        'assets/light-design/images/edit-button.png',
                        width: 20 * fem,
                        height: 20 * fem,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // toolbarpPs (314:12231)
                  left: 0 * fem,
                  top: 0 * fem,
                  child: SizedBox(
                    width: 375 * fem,
                    height: 92 * fem,
                    child: Container(
                      // topbarxFB (I314:12231;84:7741)
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      height: 44 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timepYH (I314:12231;84:7757)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 224.67 * fem, 0 * fem),
                            child: Text(
                              '10:55',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'SF Pro Text',
                                fontSize: 14 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2575 * ffem / fem,
                                letterSpacing: -0.2800000012 * fem,
                                color: const Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // cellularconnectionuJq (I314:12231;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-d5b.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifioQD (I314:12231;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-iWu.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // battery8Bb (I314:12231;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-HB7.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  // profiledetailsQeu (315:12462)
                  left: 24 * fem,
                  top: 155 * fem,
                  child: SizedBox(
                    width: 327 * fem,
                    height: 546 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // frame1000006390i9o (315:12460)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 24 * fem),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                // imageandnameRpu (314:12234)
                                width: 161 * fem,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // imageMTf (314:12236)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                      width: 72 * fem,
                                      decoration: BoxDecoration(
                                        color: const Color(0xfff59ba3),
                                        borderRadius: BorderRadius.circular(
                                            181.4400024414 * fem),
                                      ),
                                      child: Center(
                                        // autogroupuwtbswo (RQUjjRE37Trk1ANS5cuwtB)
                                        child: SizedBox(
                                          width: 72 * fem,
                                          height: 72 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/auto-group-uwtb.png',
                                            width: 72 * fem,
                                            height: 72 * fem,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // nameandidCDP (314:12242)
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            // namekEu (314:12243)
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem),
                                              width: double.infinity,
                                              child: Text(
                                                'MA Jhone Limon',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 20 * ffem,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.25 * ffem / fem,
                                                  letterSpacing: -0.2 * fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Center(
                                            // idFhT (314:12244)
                                            child: SizedBox(
                                              width: double.infinity,
                                              child: Text(
                                                'ID: 67limon',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  color:
                                                      const Color(0xff686868),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 21 * fem,
                              ),
                              Container(
                                // personalinfovHo (314:12248)
                                width: double.infinity,
                                height: 32 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // captiono6h (I314:12248;162:10895)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 152 * fem, 0 * fem),
                                      child: Text(
                                        'Email :',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          color: const Color(0xff050505),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // infohSy (I314:12248;162:10896)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                      child: Text(
                                        'jhone99@gmail.com',
                                        textAlign: TextAlign.right,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff686868),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 21 * fem,
                              ),
                              Container(
                                // personalinfoQcH (314:12250)
                                width: double.infinity,
                                height: 32 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // captionYiV (I314:12250;162:10895)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 169 * fem, 0 * fem),
                                      child: Text(
                                        'DOB :',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          color: const Color(0xff050505),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // info2tZ (I314:12250;162:10896)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                      child: Text(
                                        '16 December 1994',
                                        textAlign: TextAlign.right,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff686868),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 21 * fem,
                              ),
                              Container(
                                // personalinfowEq (314:12254)
                                width: double.infinity,
                                height: 32 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // captionfwX (I314:12254;162:10895)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 156 * fem, 0 * fem),
                                      child: Text(
                                        'Contact :',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          color: const Color(0xff050505),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      // infobKP (I314:12254;162:10896)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 1 * fem, 0 * fem, 0 * fem),
                                      child: Text(
                                        '+880189685798',
                                        textAlign: TextAlign.right,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff686868),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          // changeoptionJzV (314:12262)
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // changepassword29o (314:12263)
                                padding: EdgeInsets.fromLTRB(
                                    12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                width: double.infinity,
                                height: 64 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // frame1000006292hmj (I314:12263;163:10166)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 125 * fem, 0 * fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // iconqN9 (I314:12263;163:10167)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 8 * fem, 0 * fem),
                                            width: 40 * fem,
                                            height: 40 * fem,
                                            child: Image.asset(
                                              'assets/light-design/images/icon-HMj.png',
                                              width: 40 * fem,
                                              height: 40 * fem,
                                            ),
                                          ),
                                          Text(
                                            // changepassword9dj (I314:12263;163:10169)
                                            'Change Password',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // arrowrightHjw (I314:12263;163:10170)
                                      width: 16 * fem,
                                      height: 16 * fem,
                                      child: Image.asset(
                                        'assets/light-design/images/arrow-right-UpR.png',
                                        width: 16 * fem,
                                        height: 16 * fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16 * fem,
                              ),
                              Container(
                                // supportcGR (314:12264)
                                padding: EdgeInsets.fromLTRB(
                                    12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                width: double.infinity,
                                height: 64 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // frame1000006292sTF (I314:12264;163:10166)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 188 * fem, 0 * fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // iconQTB (I314:12264;163:10167)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 8 * fem, 0 * fem),
                                            width: 40 * fem,
                                            height: 40 * fem,
                                            child: Image.asset(
                                              'assets/light-design/images/icon-1cM.png',
                                              width: 40 * fem,
                                              height: 40 * fem,
                                            ),
                                          ),
                                          Text(
                                            // changepassword8PB (I314:12264;163:10169)
                                            'Support',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // arrowright53X (I314:12264;163:10170)
                                      width: 16 * fem,
                                      height: 16 * fem,
                                      child: Image.asset(
                                        'assets/light-design/images/arrow-right-UrM.png',
                                        width: 16 * fem,
                                        height: 16 * fem,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16 * fem,
                              ),
                              Container(
                                // securityBcM (314:12265)
                                padding: EdgeInsets.fromLTRB(
                                    12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                width: double.infinity,
                                height: 64 * fem,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color(0xfff2f2f2)),
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(12 * fem),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // frame1000006292eVw (I314:12265;163:10166)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 186 * fem, 0 * fem),
                                      height: double.infinity,
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // iconnMF (I314:12265;163:10167)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 8 * fem, 0 * fem),
                                            width: 40 * fem,
                                            height: 40 * fem,
                                            child: Image.asset(
                                              'assets/light-design/images/icon-cDP.png',
                                              width: 40 * fem,
                                              height: 40 * fem,
                                            ),
                                          ),
                                          Text(
                                            // changepasswordugm (I314:12265;163:10169)
                                            'Security',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      // arrowright4Jm (I314:12265;163:10170)
                                      width: 16 * fem,
                                      height: 16 * fem,
                                      child: Image.asset(
                                        'assets/light-design/images/arrow-right-Tbo.png',
                                        width: 16 * fem,
                                        height: 16 * fem,
                                      ),
                                    ),
                                  ],
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
          Container(
            // bottomnavBuB (336:12357)
            margin: EdgeInsets.fromLTRB(20 * fem, 0 * fem, 20 * fem, 0 * fem),
            width: double.infinity,
            height: 48 * fem,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // navmenu7H3 (I336:12357;331:14107)
                  margin:
                      EdgeInsets.fromLTRB(0 * fem, 0 * fem, 36 * fem, 0 * fem),
                  width: 58.33 * fem,
                  height: 48 * fem,
                  child: Image.asset(
                    'assets/light-design/images/nav-menu-tKj.png',
                    width: 58.33 * fem,
                    height: 48 * fem,
                  ),
                ),
                Container(
                  // navmenuzrd (I336:12357;331:14108)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 55.5 * fem, 0 * fem),
                  width: 24 * fem,
                  height: 24 * fem,
                  child: Image.asset(
                    'assets/light-design/images/nav-menu-hYu.png',
                    width: 24 * fem,
                    height: 24 * fem,
                  ),
                ),
                Container(
                  // navmenuKP7 (I336:12357;331:14109)
                  margin: EdgeInsets.fromLTRB(
                      0 * fem, 0 * fem, 37.17 * fem, 0 * fem),
                  width: 24 * fem,
                  height: 24 * fem,
                  child: Image.asset(
                    'assets/light-design/images/nav-menu-5kd.png',
                    width: 24 * fem,
                    height: 24 * fem,
                  ),
                ),
                Container(
                  // navmenuqcM (I336:12357;331:14110)
                  padding: EdgeInsets.fromLTRB(
                      12.5 * fem, 12 * fem, 12.5 * fem, 12 * fem),
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffffc300),
                    borderRadius: BorderRadius.circular(32 * fem),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // profilexgy (I336:12357;331:14110;601:67950)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 10 * fem, 0 * fem),
                        width: 24 * fem,
                        height: 24 * fem,
                        child: Image.asset(
                          'assets/light-design/images/profile-cz5.png',
                          width: 24 * fem,
                          height: 24 * fem,
                        ),
                      ),
                      Text(
                        // home4V7 (I336:12357;331:14110;601:67951)
                        'Profile',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.3846153846 * ffem / fem,
                          color: const Color(0xff050505),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
