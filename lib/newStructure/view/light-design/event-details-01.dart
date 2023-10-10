import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class EditDetail_01 extends StatelessWidget {
  const EditDetail_01({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // eventdetails01SaM (360:20311)
        width: double.infinity,
        height: 923 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // eventdetailskL9 (360:20312)
          width: 420 * fem,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // banners9s (360:20313)
                left: 0 * fem,
                top: 0 * fem,
                child: Container(
                  width: 375 * fem,
                  height: 368.68 * fem,
                  decoration: const BoxDecoration(
                    color: Color(0x99000000),
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/light-design/images/rectangle-40170-bg-Diy.png',
                      ),
                    ),
                  ),
                  child: SizedBox(
                    // toolbarXER (360:20314)
                    width: double.infinity,
                    height: 92 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // topbard2Z (I360:20314;84:7741)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 16 * fem),
                          padding: EdgeInsets.fromLTRB(
                              31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // timeGLR (I360:20314;84:7757)
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
                                // cellularconnectionLbB (I360:20314;84:7751)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                                width: 17 * fem,
                                height: 10.67 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/cellular-connection-1cu.png',
                                  width: 17 * fem,
                                  height: 10.67 * fem,
                                ),
                              ),
                              Container(
                                // wifirJd (I360:20314;84:7747)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                                width: 15.27 * fem,
                                height: 10.96 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/wifi-7tD.png',
                                  width: 15.27 * fem,
                                  height: 10.96 * fem,
                                ),
                              ),
                              Container(
                                // batteryxcZ (I360:20314;84:7743)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/battery-SmF.png',
                                  width: 24.33 * fem,
                                  height: 11.33 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // iconsandtittleGt9 (I360:20314;84:7794)
                          margin: EdgeInsets.fromLTRB(
                              24 * fem, 0 * fem, 24 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 83 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // iconZMT (I360:20314;84:7781)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 51 * fem, 0 * fem),
                                width: 32 * fem,
                                height: 32 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/icon-VZs.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                              Text(
                                // tittleUDX (I360:20314;84:7783)
                                'Tournament Details',
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
                ),
              ),
              Positioned(
                // contentzhf (360:20315)
                left: 0 * fem,
                top: 254 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 0 * fem, 24 * fem),
                  width: 420 * fem,
                  height: 669 * fem,
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
                        // contentRny (360:20316)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 69 * fem, 0 * fem),
                        width: 327 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // autogrouplgohMRj (RQoWCZjNDRij69gcBCLGoH)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 24 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // captionandtextFn1 (360:20317)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 24 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // textAPB (360:20318)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 16 * fem),
                                          constraints: BoxConstraints(
                                            maxWidth: 282 * fem,
                                          ),
                                          child: Text(
                                            'Gol Play Ground Football Tournament 2023',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 24 * ffem,
                                              fontWeight: FontWeight.w700,
                                              height: 1.25 * ffem / fem,
                                              letterSpacing: -0.24 * fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // textTNH (360:20319)
                                          constraints: BoxConstraints(
                                            maxWidth: 299 * fem,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.3333333333 * ffem / fem,
                                                color: const Color(0xff828282),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'The biggest and the most famous national football tournament is The Hover football tournament Cup',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 15 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3333333333 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xff828282),
                                                  ),
                                                ),
                                                const TextSpan(
                                                  text: '. ',
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 15 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3333333333 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xff828282),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: 'See More',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 15 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.3333333333 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xff1e1e1e),
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
                                    // groundnameandlocationzS5 (360:20320)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 83 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 51 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // icon7Wh (360:20321)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 12 * fem, 0 * fem),
                                          width: 32 * fem,
                                          height: 32 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/icon-mrR.png',
                                            width: 32 * fem,
                                            height: 32 * fem,
                                          ),
                                        ),
                                        SizedBox(
                                          // textErD (360:20322)
                                          width: 200 * fem,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // golfgroundPj7 (360:20323)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem),
                                                child: Text(
                                                  'Golf Ground',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 20 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.25 * ffem / fem,
                                                    letterSpacing: -0.2 * fem,
                                                    color:
                                                        const Color(0xff050505),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // locationhzh (360:20324)
                                                padding: EdgeInsets.fromLTRB(
                                                    2.65 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem),
                                                width: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      // walkiconShP (360:20325)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              6.63 * fem,
                                                              0 * fem),
                                                      width: 10.72 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/walk-icon-MP7.png',
                                                        width: 10.72 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // minskumarpara27sylhetjgV (360:20328)
                                                      '5 Mins | Kumarpara,27 Sylhet',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xff505050),
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
                            Container(
                              // frame1000006392Sqo (360:20329)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 24 * fem),
                              width: double.infinity,
                              height: 63 * fem,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xfff2f2f2)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // groundnumbervky (360:20330)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 113 * fem, 0 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // lastdayofregistrationq7F (360:20331)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Last day of Registration',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // may2023YXT (360:20332)
                                          '15 May 2023',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4705882353 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // bookingcodetLR (360:20333)
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // captionandcodeqFf (360:20334)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Entry Fee',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // kdX (360:20335)
                                          '\$120.00',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4705882353 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              // frame1000006393Gbs (360:20336)
                              width: double.infinity,
                              height: 63 * fem,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: const Color(0xfff2f2f2)),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // datea6m (360:20337)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 98 * fem, 0 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // tournamentstart7Mb (360:20338)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Tournament Start ',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // may20232jT (360:20339)
                                          '25 May 2023',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4705882353 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // captionandtimeNYR (360:20340)
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // timeJBB (360:20341)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Time',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // pm10pmpQR (360:20342)
                                          '01 PM - 10 PM',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 17 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.4705882353 * ffem / fem,
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
                      ),
                      SizedBox(
                        height: 24 * fem,
                      ),
                      SizedBox(
                        // memoriesLNm (360:20343)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // text4pZ (360:20344)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              child: Text(
                                'Previous Memory',
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
                            SizedBox(
                              // imagePM3 (360:20345)
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    // rectangle40180wNZ (360:20346)
                                    width: 90 * fem,
                                    height: 90 * fem,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                      child: Image.asset(
                                        'assets/light-design/images/rectangle-40180.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12 * fem,
                                  ),
                                  SizedBox(
                                    // rectangle40181SaD (360:20347)
                                    width: 90 * fem,
                                    height: 90 * fem,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                      child: Image.asset(
                                        'assets/light-design/images/rectangle-40181.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12 * fem,
                                  ),
                                  SizedBox(
                                    // rectangle40182xoT (360:20348)
                                    width: 90 * fem,
                                    height: 90 * fem,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                      child: Image.asset(
                                        'assets/light-design/images/rectangle-40182.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12 * fem,
                                  ),
                                  SizedBox(
                                    // rectangle40183eRP (360:20349)
                                    width: 90 * fem,
                                    height: 90 * fem,
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                      child: Image.asset(
                                        'assets/light-design/images/rectangle-40183.png',
                                        fit: BoxFit.cover,
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
                        height: 24 * fem,
                      ),
                      Container(
                        // buttonjhj (360:20350)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 69 * fem, 0 * fem),
                        width: 327 * fem,
                        height: 57 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc300),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Continue',
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
