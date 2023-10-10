import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // bookingdetailsx1f (360:20032)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // bookingdetailssPX (360:20172)
          width: double.infinity,
          height: 892 * fem,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // banneroY5 (360:20173)
                left: 0 * fem,
                top: 0 * fem,
                child: Container(
                  width: 375 * fem,
                  height: 368.68 * fem,
                  decoration: const BoxDecoration(
                    color: Color(0x99000000),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/light-design/images/rectangle-40170-bg-JEu.png',
                      ),
                    ),
                  ),
                  child: SizedBox(
                    // toolbar5kV (360:20174)
                    width: double.infinity,
                    height: 92 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // topbarRpM (I360:20174;84:7741)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 16 * fem),
                          padding: EdgeInsets.fromLTRB(
                              31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // timeW57 (I360:20174;84:7757)
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
                                // cellularconnectionMbX (I360:20174;84:7751)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                                width: 17 * fem,
                                height: 10.67 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/cellular-connection-ho7.png',
                                  width: 17 * fem,
                                  height: 10.67 * fem,
                                ),
                              ),
                              Container(
                                // wifisJy (I360:20174;84:7747)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                                width: 15.27 * fem,
                                height: 10.97 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/wifi-vky.png',
                                  width: 15.27 * fem,
                                  height: 10.97 * fem,
                                ),
                              ),
                              Container(
                                // batteryB4m (I360:20174;84:7743)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/battery-6r5.png',
                                  width: 24.33 * fem,
                                  height: 11.33 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // iconsandtittlesyB (I360:20174;84:7794)
                          margin: EdgeInsets.fromLTRB(
                              24 * fem, 0 * fem, 24 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                // iconkn5 (I360:20174;84:7781)
                                width: 32 * fem,
                                height: 32 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/icon-aHX.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                              SizedBox(
                                width: 67.5 * fem,
                              ),
                              Text(
                                // tittleFTw (I360:20174;84:7783)
                                'Booking Details',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 17 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.4705882353 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                              SizedBox(
                                width: 67.5 * fem,
                              ),
                              SizedBox(
                                // iconwbf (I360:20174;84:7784)
                                width: 32 * fem,
                                height: 32 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/icon-7ey.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                // contentg3T (360:20175)
                left: 0 * fem,
                top: 128 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 115.07 * fem),
                  width: 375 * fem,
                  height: 764 * fem,
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
                        // groundnameandlogoXZs (360:20176)
                        margin: EdgeInsets.fromLTRB(
                            71.5 * fem, 0 * fem, 71.5 * fem, 0 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // iconrs3 (360:20177)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: 100 * fem,
                              height: 100 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-yV3.png',
                                width: 100 * fem,
                                height: 100 * fem,
                              ),
                            ),
                            SizedBox(
                              // groundnameandlocationnEu (360:20178)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    // golfgroundL1X (360:20179)
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      child: Text(
                                        'Golf Ground',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 32 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.09375 * ffem / fem,
                                          letterSpacing: -0.32 * fem,
                                          color: const Color(0xff050505),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // locationRof (360:20180)
                                    margin: EdgeInsets.fromLTRB(
                                        4 * fem, 0 * fem, 4 * fem, 0 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        2.65 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // walkiconjJZ (360:20181)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 6.63 * fem, 0 * fem),
                                          width: 10.72 * fem,
                                          height: 16 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/walk-icon-upV.png',
                                            width: 10.72 * fem,
                                            height: 16 * fem,
                                          ),
                                        ),
                                        Text(
                                          // minskumarpara27sylhetd93 (360:20184)
                                          '5 Mins | Kumarpara, 27 Sylhet',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 11 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3636363636 * ffem / fem,
                                            color: const Color(0xff828282),
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
                        height: 24 * fem,
                      ),
                      Container(
                        // grounddetailsKGm (360:20185)
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 16 * fem, 16 * fem, 16 * fem),
                        width: double.infinity,
                        height: 126 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // groundnameanddateQJD (360:20186)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 112 * fem, 0 * fem),
                              width: 78 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // groundnumberXdj (360:20187)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // ground4tZ (360:20188)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Ground',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // ground01ZaR (360:20189)
                                          'Ground 01',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // date4XB (360:20190)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // dateQ5F (360:20191)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Date',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // fri04sepKT7 (360:20192)
                                          'Fri. 04 Sep',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // bookingcodeandtimeFrZ (360:20193)
                              width: 105 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // bookingcodeyGm (360:20194)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // captionandcodeugD (360:20195)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Booking Code',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // gr0175ReZ (360:20196)
                                          'GR0175',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // captionandtimekRw (360:20197)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // timegaV (360:20198)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Time',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // pm02pm16y (360:20199)
                                          '01 PM - 02 PM',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
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
                        height: 24 * fem,
                      ),
                      SizedBox(
                        // captionandcarddetailsL9F (360:20200)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // caption5cd (360:20201)
                              width: double.infinity,
                              child: Text(
                                'Facilities',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25 * ffem / fem,
                                  letterSpacing: -0.2 * fem,
                                  color: const Color(0xff050505),
                                ),
                              ),
                            ),
                            Container(
                              // autogroup3fewP7X (RQooRzBkDZimPw6vM23FEw)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 16 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // frame1000006395htu (360:20202)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 70 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 36 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // iconandcaptionpyX (360:20203)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // icon9ku (360:20204)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-w8D.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // parkingsportUYH (360:20206)
                                                'Parking Sport',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // iconandcaption241 (360:20207)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconZ3w (360:20208)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-hiq.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // cameraUgh (360:20210)
                                                'Camera',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // frame1000006396DuB (360:20211)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 8.02 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 37.93 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // iconandcaptionLiu (360:20212)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11 * fem, 1.93 * fem),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconFqs (360:20213)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-19b-aTb.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // waitingroomat9 (360:20220)
                                                'Waiting room  ',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // iconandcaption6Lh (360:20221)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconrKs (360:20222)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 37.98 * fem,
                                                height: 37.93 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-FiH.png',
                                                  width: 37.98 * fem,
                                                  height: 37.93 * fem,
                                                ),
                                              ),
                                              Text(
                                                // changingroomsmBw (360:20225)
                                                'Changing rooms',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 15 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3333333333 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
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
                        height: 24 * fem,
                      ),
                      SizedBox(
                        // captionandcarddetailstGZ (360:20226)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // captionE5X (360:20227)
                              width: double.infinity,
                              child: Text(
                                'Notify to',
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25 * ffem / fem,
                                  letterSpacing: -0.2 * fem,
                                  color: const Color(0xff050505),
                                ),
                              ),
                            ),
                            Container(
                              // autogroupaq6fj2H (RQop78jBbEscFyPGEkaq6f)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 16 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // profileq5K (360:20228)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 25 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 32 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // profilexvd (360:20229)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 20 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // rectangle11649h7X (I360:20230;119:9900)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 32 * fem,
                                                height: 32 * fem,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48 * fem),
                                                  child: Image.asset(
                                                    'assets/light-design/images/rectangle-11649-A3j.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // namenPs (360:20231)
                                                'Courtney Henry',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // profileK8u (360:20232)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // rectangle11649GZw (I360:20233;119:9900)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 32 * fem,
                                                height: 32 * fem,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48 * fem),
                                                  child: Image.asset(
                                                    'assets/light-design/images/rectangle-11649-Fry.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // name86M (360:20234)
                                                'Leslie Alexander',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // profile51b (360:20235)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 80 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 32 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // profileCM7 (360:20236)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 20 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // rectangle11649jbw (I360:20237;119:9900)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 32 * fem,
                                                height: 32 * fem,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48 * fem),
                                                  child: Image.asset(
                                                    'assets/light-design/images/rectangle-11649-B5K.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // nameAqf (360:20238)
                                                'Jacob Jones',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // profileVN9 (360:20239)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // rectangle11649E4q (I360:20240;119:9900)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 32 * fem,
                                                height: 32 * fem,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          48 * fem),
                                                  child: Image.asset(
                                                    'assets/light-design/images/rectangle-11649.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // name6Mw (360:20241)
                                                'Robert Fox',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
