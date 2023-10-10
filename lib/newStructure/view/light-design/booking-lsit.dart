import 'package:flutter/material.dart';
import '../../utils/utils.dart';

class BookingList2 extends StatelessWidget {
  const BookingList2({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // bookinglsitQZP (360:19919)
        width: double.infinity,
        height: 1059 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // bookinglsitWMX (323:12112)
          padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
          width: 377 * fem,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarQho (323:12113)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 36 * fem),
                width: 375 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarLLZ (I323:12113;82:7634)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timee6M (I323:12113;82:7650)
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
                            // cellularconnectionuHB (I323:12113;82:7644)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-zem.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi1r1 (I323:12113;82:7640)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                            width: 15.27 * fem,
                            height: 10.97 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-8TB.png',
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                            ),
                          ),
                          Container(
                            // batteryWXs (I323:12113;82:7636)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-p25.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // nameandiconygM (I323:12113;84:7713)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      width: double.infinity,
                      height: 47 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // nameandtextuK7 (I323:12113;84:7709)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 176 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // filllodesignD4u (I323:12113;82:7659)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    'Filllo Design',
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
                                Text(
                                  // goodmorninggjB (I323:12113;84:7707)
                                  'Good Morning',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // iconDj7 (I323:12113;84:7712)
                            width: 36 * fem,
                            height: 36 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-3yK.png',
                              width: 36 * fem,
                              height: 36 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // dateXE1 (323:12114)
                margin:
                    EdgeInsets.fromLTRB(13 * fem, 0 * fem, 0 * fem, 24 * fem),
                height: 64 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // calenderrGH (323:12115)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0.5 * fem, 16 * fem, 0.5 * fem),
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 8 * fem, 10 * fem, 8 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff1e1e1e),
                        borderRadius: BorderRadius.circular(32 * fem),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // datex4R (I323:12115;110:8863)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 1 * fem, 4 * fem),
                            child: Text(
                              '3',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                letterSpacing: -0.2 * fem,
                                color: const Color(0xff999999),
                              ),
                            ),
                          ),
                          Text(
                            // dayehw (I323:12115;110:8864)
                            'Wed',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3846153846 * ffem / fem,
                              color: const Color(0xff999999),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // calendernp9 (323:12116)
                      padding: EdgeInsets.fromLTRB(
                          10 * fem, 8 * fem, 10 * fem, 9 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(32 * fem),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // dateuds (I323:12116;107:8828)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            child: Text(
                              '4',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w700,
                                height: 1.25 * ffem / fem,
                                letterSpacing: -0.2 * fem,
                                color: const Color(0xff1e1e1e),
                              ),
                            ),
                          ),
                          Text(
                            // dayzfK (I323:12116;107:8829)
                            'Thu',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3846153846 * ffem / fem,
                              color: const Color(0xff1e1e1e),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // autogroupy38buGV (RQoqPgRJZwVaHUQmUjY38B)
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 0.5 * fem, 0 * fem, 0.5 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // calenderRVj (323:12117)
                            padding: EdgeInsets.fromLTRB(
                                16 * fem, 8 * fem, 16 * fem, 8 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff1e1e1e),
                              borderRadius: BorderRadius.circular(32 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // dateJpR (I323:12117;110:8863)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    '5',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25 * ffem / fem,
                                      letterSpacing: -0.2 * fem,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Text(
                                  // day2VX (I323:12117;110:8864)
                                  'Fri',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16 * fem,
                          ),
                          Container(
                            // calenderx8H (323:12118)
                            padding: EdgeInsets.fromLTRB(
                                13.5 * fem, 8 * fem, 13.5 * fem, 8 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff1e1e1e),
                              borderRadius: BorderRadius.circular(32 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // dateG8y (I323:12118;110:8863)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    '6',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25 * ffem / fem,
                                      letterSpacing: -0.2 * fem,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Text(
                                  // dayxGh (I323:12118;110:8864)
                                  'Sat',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16 * fem,
                          ),
                          Container(
                            // calenderseZ (323:12119)
                            padding: EdgeInsets.fromLTRB(
                                12 * fem, 8 * fem, 12 * fem, 8 * fem),
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff1e1e1e),
                              borderRadius: BorderRadius.circular(32 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // dateo2R (I323:12119;110:8863)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    '7',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25 * ffem / fem,
                                      letterSpacing: -0.2 * fem,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Text(
                                  // dayJzm (I323:12119;110:8864)
                                  'Sun',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 16 * fem,
                          ),
                          Container(
                            // calenderDbw (323:12120)
                            padding: EdgeInsets.fromLTRB(
                                10.5 * fem, 8 * fem, 10.5 * fem, 8 * fem),
                            width: 48 * fem,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xff1e1e1e),
                              borderRadius: BorderRadius.circular(32 * fem),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // datew29 (I323:12120;110:8863)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                  child: Text(
                                    '8',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 20 * ffem,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25 * ffem / fem,
                                      letterSpacing: -0.2 * fem,
                                      color: const Color(0xff999999),
                                    ),
                                  ),
                                ),
                                Text(
                                  // dayr97 (I323:12120;110:8864)
                                  'Mun',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff999999),
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
                // contentPPw (323:12121)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 40 * fem),
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 24 * fem),
                width: 375 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(24 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // captionandcarddetailsE9f (323:12122)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionLCh (323:12123)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 24 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // text3N1 (I323:12123;78:7795)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 167 * fem, 0 * fem),
                                  child: Text(
                                    'Booking List',
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
                                Text(
                                  // seeallYpZ (I323:12123;78:7796)
                                  'See All',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff686868),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // frame1000006394gvm (323:12887)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // bookingcarddr1 (323:12693)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // groundnametimeandlocationLVX (I323:12693;113:9095)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        height: 161 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff7b61ff)),
                                          color: const Color(0xffffffff),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20 * fem),
                                            topRight: Radius.circular(20 * fem),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // groundnameiconRms (I323:12693;113:9091)
                                              left: 11.5 * fem,
                                              top: 16 * fem,
                                              child: SizedBox(
                                                width: 244 * fem,
                                                height: 129 * fem,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // iconX4D (I323:12693;113:9050)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              16 * fem),
                                                      width: 60 * fem,
                                                      height: 60 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-HVT.png',
                                                        width: 60 * fem,
                                                        height: 60 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      // nameandlocetione8q (I323:12693;113:9051)
                                                      width: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // textCRF (I323:12693;113:9052)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem),
                                                            child: Text(
                                                              'Golf Ground',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    20 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 1.25 *
                                                                    ffem /
                                                                    fem,
                                                                letterSpacing:
                                                                    -0.2 * fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // locationh77 (I323:12693;113:9053)
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // locationicon2fB (I323:12693;113:9054)
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 * fem,
                                                                          0 * fem,
                                                                          4 * fem,
                                                                          0 * fem),
                                                                  width:
                                                                      24 * fem,
                                                                  height:
                                                                      24 * fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/light-design/images/location-icon-2XK.png',
                                                                    width: 24 *
                                                                        fem,
                                                                    height: 24 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // textMSZ (I323:12693;113:9056)
                                                                  'Kumarpara, Sylhet | Ground 01',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        15 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.3333333333 *
                                                                            ffem /
                                                                            fem,
                                                                    color: const Color(
                                                                        0xff686868),
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
                                            Positioned(
                                              // timeanddateVof (I323:12693;113:9058)
                                              left: 238.5 * fem,
                                              top: 16 * fem,
                                              child: SizedBox(
                                                width: 81 * fem,
                                                height: 42 * fem,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      // pmmFP (I323:12693;113:9059)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              2 * fem),
                                                      child: Text(
                                                        '01.00 PM ',
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 17 * ffem,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.4705882353 *
                                                              ffem /
                                                              fem,
                                                          color: const Color(
                                                              0xff050505),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // fri04sepeKB (I323:12693;113:9060)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      child: Text(
                                                        'Fri. 04 Sep',
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 11 * ffem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3636363636 *
                                                              ffem /
                                                              fem,
                                                          color: const Color(
                                                              0xff686868),
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
                                      Container(
                                        // tokennoxKs (I323:12693;113:9102)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        height: 58 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff7b61ff),
                                          borderRadius: BorderRadius.only(
                                            bottomRight:
                                                Radius.circular(20 * fem),
                                            bottomLeft:
                                                Radius.circular(20 * fem),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // polygon1whb (I323:12693;113:9100)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-1-jAZ.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon2TR3 (I323:12693;113:9101)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-2-UZo.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon3vJd (I323:12693;113:9103)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-3-qcm.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon4cSM (I323:12693;113:9104)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-4-y61.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon5Jpy (I323:12693;113:9105)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-5-Gz5.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon6AsB (I323:12693;113:9106)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-6-bFX.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon7g4q (I323:12693;113:9107)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-7-dVj.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon8Cos (I323:12693;113:9108)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-8-Dxu.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon9Kdb (I323:12693;113:9109)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-9-wHT.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon10d8V (I323:12693;113:9110)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-10-6A5.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon11YmF (I323:12693;113:9111)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-11-zky.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon12r1F (I323:12693;113:9112)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-12-KxD.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon13ybf (I323:12693;113:9113)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-13-6zd.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon1435j (I323:12693;113:9114)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-14-CsT.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon15jjF (I323:12693;113:9115)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-15-ZSh.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon164mX (I323:12693;113:9116)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-16-Mvq.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon17aE5 (I323:12693;113:9117)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-17-2tq.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon18Vrq (I323:12693;113:9118)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-18-E6m.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon191KP (I323:12693;113:9119)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-19-No3.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // autogroup4rhuY4R (RQosKHszpqtKLh5xXr4rHu)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 98.14 * fem,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupohxjThB (RQosscHUvtbBYsrYixohxj)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        9.5 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // polygon20KUV (I323:12693;113:9120)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-20-mXF.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon21R1j (I323:12693;113:9121)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-21-gem.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon22wEy (I323:12693;113:9122)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-22-sQV.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon23fRs (I323:12693;113:9123)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-23-6GZ.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon24aoj (I323:12693;113:9124)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-24-sfw.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon256GH (I323:12693;113:9125)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-25-pfK.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon26Dbo (I323:12693;113:9126)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-26-vFb.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon27Kuj (I323:12693;113:9127)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-27-pTs.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon2846d (I323:12693;113:9128)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-28-ya1.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon29MbX (I323:12693;113:9129)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-29-SjK.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon30s45 (I323:12693;113:9130)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-30-r2V.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon31C6M (I323:12693;113:9131)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-31-Wws.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon32JQH (I323:12693;113:9132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-32-usw.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon332bB (I323:12693;113:9133)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-33-23s.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon34Lbs (I323:12693;113:9134)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-34-cKT.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          // polygon353mB (I323:12693;113:9135)
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-35-QDo.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Center(
                                                    // gr0175zRX (I323:12693;113:9047)
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              1.41 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      child: Text(
                                                        'GR0175',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 24 * ffem,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height:
                                                              1.25 * ffem / fem,
                                                          letterSpacing:
                                                              -0.24 * fem,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // polygon36Ubb (I323:12693;113:9136)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-36-tND.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon37CnV (I323:12693;113:9137)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-37-e2u.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon38hjF (I323:12693;113:9138)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-38-D8D.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon392Wd (I323:12693;113:9139)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-39-G3T.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon40Yjs (I323:12693;113:9140)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-40-V4u.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon41FPP (I323:12693;113:9141)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-41-QcR.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon42VoX (I323:12693;113:9142)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-42-oKf.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon43oJR (I323:12693;113:9143)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-43-wpM.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon44iwB (I323:12693;113:9144)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-44-BS1.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon45f5j (I323:12693;113:9145)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-45-5pu.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon46PnR (I323:12693;113:9146)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-46-5Aq.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon475QM (I323:12693;113:9147)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-47-Dey.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon481J1 (I323:12693;113:9148)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-48-Z7F.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon49Y33 (I323:12693;113:9149)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-49-X5B.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon50CdP (I323:12693;113:9150)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-50-6Hf.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon51X9s (I323:12693;113:9151)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-51-5sw.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon52pem (I323:12693;113:9152)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-52-fER.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            SizedBox(
                                              // polygon53kYR (I323:12693;113:9156)
                                              width: 4.8 * fem,
                                              height: 4 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-53-bFX.png',
                                                width: 4.8 * fem,
                                                height: 4 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // bookingcardted (323:12790)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // groundnametimeandlocationqZs (I323:12790;113:9095)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        height: 161 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xff050505)),
                                          color: const Color(0xffffffff),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20 * fem),
                                            topRight: Radius.circular(20 * fem),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              // groundnameiconKzq (I323:12790;113:9091)
                                              left: 11.5 * fem,
                                              top: 16 * fem,
                                              child: SizedBox(
                                                width: 244 * fem,
                                                height: 129 * fem,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // iconzr5 (I323:12790;113:9050)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              16 * fem),
                                                      width: 60 * fem,
                                                      height: 60 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-KsF.png',
                                                        width: 60 * fem,
                                                        height: 60 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      // nameandlocetionUmF (I323:12790;113:9051)
                                                      width: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // textccZ (I323:12790;113:9052)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem),
                                                            child: Text(
                                                              'Sports Ground',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    20 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height: 1.25 *
                                                                    ffem /
                                                                    fem,
                                                                letterSpacing:
                                                                    -0.2 * fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // location7pD (I323:12790;113:9053)
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // locationiconU8y (I323:12790;113:9054)
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 * fem,
                                                                          0 * fem,
                                                                          4 * fem,
                                                                          0 * fem),
                                                                  width:
                                                                      24 * fem,
                                                                  height:
                                                                      24 * fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/light-design/images/location-icon-Y2V.png',
                                                                    width: 24 *
                                                                        fem,
                                                                    height: 24 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // textyLd (I323:12790;113:9056)
                                                                  'Kumarpara, Sylhet | Ground 01',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        15 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.3333333333 *
                                                                            ffem /
                                                                            fem,
                                                                    color: const Color(
                                                                        0xff686868),
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
                                            Positioned(
                                              // timeanddatei3K (I323:12790;113:9058)
                                              left: 238.5 * fem,
                                              top: 16 * fem,
                                              child: SizedBox(
                                                width: 81 * fem,
                                                height: 42 * fem,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      // pmRiR (I323:12790;113:9059)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              2 * fem),
                                                      child: Text(
                                                        '01.00 PM ',
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 17 * ffem,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          height: 1.4705882353 *
                                                              ffem /
                                                              fem,
                                                          color: const Color(
                                                              0xff050505),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // fri04sepWjs (I323:12790;113:9060)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      child: Text(
                                                        'Fri. 04 Sep',
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 11 * ffem,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.3636363636 *
                                                              ffem /
                                                              fem,
                                                          color: const Color(
                                                              0xff686868),
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
                                      Container(
                                        // tokennodJh (I323:12790;113:9102)
                                        padding: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 0 * fem),
                                        width: double.infinity,
                                        height: 58 * fem,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff050505),
                                          borderRadius: BorderRadius.only(
                                            bottomRight:
                                                Radius.circular(20 * fem),
                                            bottomLeft:
                                                Radius.circular(20 * fem),
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // polygon1RkM (I323:12790;113:9100)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-1-y8V.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon2Bd3 (I323:12790;113:9101)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-2-Lem.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon37Wh (I323:12790;113:9103)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-3-1pD.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon4qhb (I323:12790;113:9104)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-4-fYm.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon5Z7o (I323:12790;113:9105)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-5-eZw.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon6V1T (I323:12790;113:9106)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-6-DBw.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon7ziu (I323:12790;113:9107)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-7-hTo.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon8vcZ (I323:12790;113:9108)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-8-Jho.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon9Feq (I323:12790;113:9109)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-9-dWh.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon10AG1 (I323:12790;113:9110)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-10-iQh.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon11gVF (I323:12790;113:9111)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-11-r57.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon12p5f (I323:12790;113:9112)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-12-djP.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon13wvy (I323:12790;113:9113)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-13-bVb.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon145XP (I323:12790;113:9114)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-14-wKF.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon151fw (I323:12790;113:9115)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-15-bD3.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon16HdT (I323:12790;113:9116)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-16-2nD.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon17Qxy (I323:12790;113:9117)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-17-mMB.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon1899s (I323:12790;113:9118)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-18-Jdw.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon19sbf (I323:12790;113:9119)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-19-Y8Z.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // autogroupcstdCtq (RQoustH55VS9qDU1UYcsTD)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 98.14 * fem,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // autogroupw7ksHQV (RQovT7phJauXZwdgpeW7ks)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        9.5 * fem),
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // polygon20YrD (I323:12790;113:9120)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-20-U73.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon21rru (I323:12790;113:9121)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-21-D7P.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon22nkZ (I323:12790;113:9122)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-22-Ct1.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon23WRf (I323:12790;113:9123)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-23-ECh.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon24cjb (I323:12790;113:9124)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-24-ZbF.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon25Yt9 (I323:12790;113:9125)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-25-fsF.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon26gDf (I323:12790;113:9126)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-26-Grd.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon27nXb (I323:12790;113:9127)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-27-uku.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon287Zs (I323:12790;113:9128)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-28-6hP.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon29dHK (I323:12790;113:9129)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-29-wf7.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon30ZAy (I323:12790;113:9130)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-30-J3s.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon315f7 (I323:12790;113:9131)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-31-AUZ.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon321Ym (I323:12790;113:9132)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-32-8N5.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon33ixy (I323:12790;113:9133)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-33-dNq.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        Container(
                                                          // polygon34c2m (I323:12790;113:9134)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  1 * fem,
                                                                  0 * fem),
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-34-EDf.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          // polygon35XfX (I323:12790;113:9135)
                                                          width: 5.2 * fem,
                                                          height: 4.5 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/polygon-35-how.png',
                                                            width: 5.2 * fem,
                                                            height: 4.5 * fem,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Center(
                                                    // gr01755BF (I323:12790;113:9047)
                                                    child: Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              1.41 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem),
                                                      child: Text(
                                                        'GR0175',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: SafeGoogleFont(
                                                          'Inter',
                                                          fontSize: 24 * ffem,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          height:
                                                              1.25 * ffem / fem,
                                                          letterSpacing:
                                                              -0.24 * fem,
                                                          color: const Color(
                                                              0xffffffff),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // polygon36yXX (I323:12790;113:9136)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-36-kfj.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon374os (I323:12790;113:9137)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-37-VEq.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon38CQH (I323:12790;113:9138)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-38-S6D.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon39uJh (I323:12790;113:9139)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-39-hoX.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon40ELy (I323:12790;113:9140)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-40-r41.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon41xGy (I323:12790;113:9141)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-41-eGZ.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon424qo (I323:12790;113:9142)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-42-P5K.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon43bqj (I323:12790;113:9143)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-43-Nsb.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon44L2d (I323:12790;113:9144)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-44-HuK.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon45FvH (I323:12790;113:9145)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-45-QVo.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon46Zg5 (I323:12790;113:9146)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-46-QGH.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon47Uo3 (I323:12790;113:9147)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-47-j6Z.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon48zFb (I323:12790;113:9148)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-48-321.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon49Wzd (I323:12790;113:9149)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-49-Zoo.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon50StH (I323:12790;113:9150)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-50-jmK.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon51xbj (I323:12790;113:9151)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-51-qPX.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            Container(
                                              // polygon52h3X (I323:12790;113:9152)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  1 * fem,
                                                  0 * fem),
                                              width: 5.2 * fem,
                                              height: 4.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-52-oKo.png',
                                                width: 5.2 * fem,
                                                height: 4.5 * fem,
                                              ),
                                            ),
                                            SizedBox(
                                              // polygon53bPo (I323:12790;113:9156)
                                              width: 4.8 * fem,
                                              height: 4 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/polygon-53-udj.png',
                                                width: 4.8 * fem,
                                                height: 4 * fem,
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
                      // captionandcardLMP (323:12891)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 0 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // caption545 (323:12892)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // textnDP (I323:12892;78:7795)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 127 * fem, 0 * fem),
                                  child: Text(
                                    'Previous History',
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
                                Text(
                                  // seealltnD (I323:12892;78:7796)
                                  'See All',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xff686868),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // bannerhistoryofbookingdjo (323:12893)
                            padding: EdgeInsets.fromLTRB(
                                12 * fem, 12 * fem, 12 * fem, 12 * fem),
                            width: double.infinity,
                            height: 112 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(16 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x14050513),
                                  offset: Offset(0 * fem, 30 * fem),
                                  blurRadius: 30 * fem,
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // imageJ5F (I323:12893;112:8952)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 12 * fem, 0 * fem),
                                  width: 80 * fem,
                                  height: 88 * fem,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                    child: Image.asset(
                                      'assets/light-design/images/image-cPT.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  // textzyf (I323:12893;112:8953)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 38 * fem, 3 * fem),
                                  width: 121 * fem,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // nameandlocationLGq (I323:12893;112:8954)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 10 * fem),
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              // textpho (I323:12893;112:8955)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  0 * fem,
                                                  4 * fem),
                                              child: Text(
                                                'Sports Ground',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 17 * ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height:
                                                      1.4705882353 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // location5td (I323:12893;112:8956)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  48 * fem,
                                                  0 * fem),
                                              width: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // locationiconQAD (I323:12893;112:8957)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        6 * fem,
                                                        0 * fem),
                                                    width: 28 * fem,
                                                    height: 28 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/location-icon-nad.png',
                                                      width: 28 * fem,
                                                      height: 28 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // textVxM (I323:12893;112:8959)
                                                    'Sylhet',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: const Color(
                                                          0xff686868),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        // timeSMo (I323:12893;112:8960)
                                        '10 PM | Fri. 01 Sep',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 13 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3846153846 * ffem / fem,
                                          color: const Color(0xff1e1e1e),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // pricePH3 (I323:12893;112:8961)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 18 * fem, 0 * fem, 18 * fem),
                                  width: 52 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff2f2f2),
                                    borderRadius:
                                        BorderRadius.circular(28 * fem),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '\$90',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 15 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.3333333333 * ffem / fem,
                                        color: const Color(0xff1e1e1e),
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
                  ],
                ),
              ),
              Container(
                // bottomnavQT3 (336:12230)
                margin: EdgeInsets.fromLTRB(
                    20 * fem, 0 * fem, 40.33 * fem, 0 * fem),
                width: double.infinity,
                height: 48 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // navmenuVjP (I336:12230;331:14077)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 36 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          14.5 * fem, 12 * fem, 14.5 * fem, 12 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(32 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // homeboldCNu (I336:12230;331:14077;601:67950)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 10 * fem, 0 * fem),
                            width: 24 * fem,
                            height: 24 * fem,
                            child: Image.asset(
                              'assets/light-design/images/home-bold-hRs.png',
                              width: 24 * fem,
                              height: 24 * fem,
                            ),
                          ),
                          Text(
                            // homeWuP (I336:12230;331:14077;601:67951)
                            'Home',
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
                    Container(
                      // navmenuriM (I336:12230;331:14078)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 54.33 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-gV7.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                    Container(
                      // navmenuxWV (I336:12230;331:14079)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 54.33 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-NPK.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                    SizedBox(
                      // navmenut9F (I336:12230;331:14080)
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-2Qq.png',
                        width: 24 * fem,
                        height: 24 * fem,
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
