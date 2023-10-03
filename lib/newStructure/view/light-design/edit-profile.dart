import 'package:flutter/material.dart';

import '../utils.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // editprofile3Ud (513:7657)
        width: double.infinity,
        height: 975 * fem,
        child: Container(
          // editprofileCMX (311:13969)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarJvM (311:13970)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarcw3 (I311:13970;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeKqT (I311:13970;84:7757)
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
                            // cellularconnectionR7o (I311:13970;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-6nd.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifivqF (I311:13970;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-7sP.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batterynsT (I311:13970;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-bqB.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittletfb (I311:13970;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 118.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconPsF (I311:13970;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 86.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-j2h.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittleXCm (I311:13970;84:7783)
                            'Edit Profile',
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
                  ],
                ),
              ),
              Container(
                // contentFuT (311:13971)
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 13 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24 * fem),
                    topRight: Radius.circular(24 * fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // captionandcarddetailsLR7 (311:13972)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionRxM (311:13973)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Text(
                              'Personal Details',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                letterSpacing: -0.2 * fem,
                                color: const Color(0xff050505),
                              ),
                            ),
                          ),
                          SizedBox(
                            // infoWiu (311:14066)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // imputfill3yj (311:14067)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionCrd (I311:14067;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Full Name',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // info5fX (I311:14067;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textbds (I311:14067;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  200 * fem,
                                                  0 * fem),
                                              child: Text(
                                                'Filllo Design',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // iconJHP (I311:14067;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-mB7.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfilld4m (311:14068)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionYhX (I311:14068;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Email',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // infoU5P (I311:14068;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textKrh (I311:14068;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  121 * fem,
                                                  0 * fem),
                                              child: Text(
                                                'filllodesign@gmail.com',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // iconw7P (I311:14068;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-FEH.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfillG9f (311:14069)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionBnR (I311:14069;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Date Of Birth',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // info6eV (I311:14069;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textDUD (I311:14069;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  152 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '16 December 1994',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // iconYFb (I311:14069;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-Axy.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfillFA1 (311:14070)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionCb3 (I311:14070;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Gender',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // infoW5w (I311:14070;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textq8D (I311:14070;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  252 * fem,
                                                  0 * fem),
                                              child: Text(
                                                'Male',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // iconZ4D (I311:14070;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-n9w.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfill3VB (311:14071)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionPow (I311:14071;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Contact',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // infou1b (I311:14071;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textpPT (I311:14071;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  157 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '+8801740202032',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // icon8f3 (I311:14071;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-efT.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfillExy (311:14072)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionboX (I311:14072;163:10618)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Address',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff686868),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // info4h7 (I311:14072;164:10219)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 16 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // textnND (I311:14072;164:10220)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  155 * fem,
                                                  0 * fem),
                                              child: Text(
                                                'Kumarpara, Sylhet',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color: const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // icon7QV (I311:14072;164:10221)
                                              width: 12 * fem,
                                              height: 12 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-5Xw.png',
                                                width: 12 * fem,
                                                height: 12 * fem,
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
                        ],
                      ),
                    ),
                    SizedBox(
                      // captionandcarddetails3ow (311:14109)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            // captionmV3 (311:14110)
                            width: double.infinity,
                            child: Text(
                              'Connected accounts',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                letterSpacing: -0.2 * fem,
                                color: const Color(0xff050505),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // socialmediaconnectcardfqK (312:12162)
                            padding: EdgeInsets.fromLTRB(
                                18 * fem, 16 * fem, 16 * fem, 16 * fem),
                            width: double.infinity,
                            height: 52 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x0f060714),
                                  offset: Offset(0 * fem, 2 * fem),
                                  blurRadius: 30 * fem,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // nameandicon8D7 (I312:12162;164:10570)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 164 * fem, 0 * fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // component2fD3 (I312:12162;164:10573)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 14 * fem, 0 * fem),
                                        width: 16 * fem,
                                        height: 20 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/component-2-6Fj.png',
                                          width: 16 * fem,
                                          height: 20 * fem,
                                        ),
                                      ),
                                      Text(
                                        // nameyjX (I312:12162;164:10566)
                                        'Apple',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff1e1e1e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // connectbuttonVSy (I312:12162;164:10568)
                                  'Connect',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3333333333 * ffem / fem,
                                    color: const Color(0xff00d555),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // socialmediaconnectcardZhj (312:12168)
                            padding: EdgeInsets.fromLTRB(
                                16 * fem, 16 * fem, 16 * fem, 16 * fem),
                            width: double.infinity,
                            height: 52 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x0f060714),
                                  offset: Offset(0 * fem, 2 * fem),
                                  blurRadius: 30 * fem,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // nameandiconT2R (I312:12168;164:10570)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 136 * fem, 0 * fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // facebook1z2M (I312:12168;164:10573;164:10578)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 12 * fem, 0 * fem),
                                        width: 20 * fem,
                                        height: 20 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/facebook-1-7mT.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        // name6LH (I312:12168;164:10566)
                                        'Facebook ',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff1e1e1e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // connectbuttonqHs (I312:12168;164:10568)
                                  'Connect',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 15 * ffem,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3333333333 * ffem / fem,
                                    color: const Color(0xff00d555),
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
            ],
          ),
        ),
      ),
    );
  }
}
