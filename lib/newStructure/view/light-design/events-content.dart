import 'package:flutter/material.dart';

import '../utils.dart';

class EventContent extends StatelessWidget {
  const EventContent({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // eventscontenta7B (360:20031)
        width: double.infinity,
        height: 888 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // eventscontentgg1 (319:12891)
          padding: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarNHw (149:10504)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 28 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarVtM (I149:10504;82:7634)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeD3f (I149:10504;82:7650)
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
                            // cellularconnectionHJR (I149:10504;82:7644)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-KYV.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifiAND (I149:10504;82:7640)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-GKj.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batteryFeZ (I149:10504;82:7636)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-jGm.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // nameandiconMSh (I149:10504;84:7713)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      width: double.infinity,
                      height: 47 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // nameandtext3qK (I149:10504;84:7709)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 176 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // filllodesignnH7 (I149:10504;82:7659)
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
                                  // goodmorningeKK (I149:10504;84:7707)
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
                            // iconaTs (I149:10504;84:7712)
                            width: 36 * fem,
                            height: 36 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-ykM.png',
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
                // upcomingevents7Cu (318:12888)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 32 * fem),
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 24 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(24 * fem),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      // captionyW1 (149:10552)
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // textXnR (I149:10552;78:7795)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 115 * fem, 0 * fem),
                            child: Text(
                              'Upcoming Events',
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
                          Text(
                            // seeallSPb (I149:10552;78:7796)
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
                      height: 16 * fem,
                    ),
                    Container(
                      // imageandtexthKX (I184:10395;184:10376)
                      width: double.infinity,
                      height: 180 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-1.951, -0.111),
                          end: Alignment(-0.336, -0.167),
                          colors: <Color>[
                            Color(0xffffffff),
                            Color(0xffffffff),
                            Color(0xffebebeb),
                            Color(0xffeaeaea)
                          ],
                          stops: <double>[0, 0, 0, 1],
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            // image23M9B (I184:10395;184:10380;183:10366)
                            left: 147 * fem,
                            top: 0 * fem,
                            child: Align(
                              child: SizedBox(
                                width: 180 * fem,
                                height: 180 * fem,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(16 * fem),
                                    bottomRight: Radius.circular(16 * fem),
                                  ),
                                  child: Image.asset(
                                    'assets/light-design/images/image-23.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            // buttonandtextBe1 (I184:10395;184:10377)
                            left: 16 * fem,
                            top: 16 * fem,
                            child: SizedBox(
                              width: 152 * fem,
                              height: 146 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // captionandtextUND (I184:10395;184:10373)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 20 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // captionofP (I184:10395;184:10367)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          constraints: BoxConstraints(
                                            maxWidth: 148 * fem,
                                          ),
                                          child: Text(
                                            'Football Tournament 2023',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 17 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.4705882353 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // texthkm (I184:10395;184:10369)
                                          constraints: BoxConstraints(
                                            maxWidth: 152 * fem,
                                          ),
                                          child: RichText(
                                            text: TextSpan(
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 11 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.3636363636 * ffem / fem,
                                                color: const Color(0xff828282),
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      'Last day of registration',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3846153846 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xff828282),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: ' ',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 11 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3636363636 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xff828282),
                                                  ),
                                                ),
                                                TextSpan(
                                                  text: '15 may 2023',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.3846153846 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xff828282),
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
                                    // buttonrJD (I184:10395;184:10375)
                                    width: 87 * fem,
                                    height: 36 * fem,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffc300),
                                      borderRadius:
                                          BorderRadius.circular(8 * fem),
                                    ),
                                    child: Center(
                                      child: Center(
                                        child: Text(
                                          'Explore',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w600,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
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
                    SizedBox(
                      height: 16 * fem,
                    ),
                    Container(
                      // imageandtextJR7 (I318:12868;318:12844)
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 16 * fem, 16 * fem, 18 * fem),
                      width: double.infinity,
                      height: 180 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.514, -0.417),
                          end: Alignment(0.223, 0.689),
                          colors: <Color>[Color(0xff050c14), Color(0x00050d18)],
                          stops: <double>[0, 1],
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/light-design/images/image-21-bg-qE9.png',
                          ),
                        ),
                      ),
                      child: SizedBox(
                        // buttonandtextfQ5 (I318:12868;318:12847)
                        width: 148 * fem,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // captionandtext9q3 (I318:12868;318:12848)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 20 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // captionHAZ (I318:12868;318:12849)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                    constraints: BoxConstraints(
                                      maxWidth: 148 * fem,
                                    ),
                                    child: Text(
                                      'Football Tournament 2023',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 17 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.4705882353 * ffem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // textnd7 (I318:12868;318:12850)
                                    constraints: BoxConstraints(
                                      maxWidth: 138 * fem,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3636363636 * ffem / fem,
                                          color: const Color(0xffcdcdcd),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Last day of registration ',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xffcdcdcd),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '15 may 2023',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xffcdcdcd),
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
                              // buttonogd (I318:12868;318:12851)
                              width: 87 * fem,
                              height: 36 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xffffc300),
                                borderRadius: BorderRadius.circular(8 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Explore',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: const Color(0xff050505),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16 * fem,
                    ),
                    Container(
                      // imageandtextex9 (I318:12878;318:12844)
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 16 * fem, 16 * fem, 18 * fem),
                      width: double.infinity,
                      height: 180 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16 * fem),
                        gradient: const LinearGradient(
                          begin: Alignment(-0.48, -0.361),
                          end: Alignment(0.905, 0.878),
                          colors: <Color>[Color(0xe5140513), Color(0x00140514)],
                          stops: <double>[0, 1],
                        ),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/light-design/images/image-21-bg-rPT.png',
                          ),
                        ),
                      ),
                      child: SizedBox(
                        // buttonandtextqfF (I318:12878;318:12847)
                        width: 148 * fem,
                        height: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // captionandtextacq (I318:12878;318:12848)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 20 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // captionhSZ (I318:12878;318:12849)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                    constraints: BoxConstraints(
                                      maxWidth: 148 * fem,
                                    ),
                                    child: Text(
                                      'Football Tournament 2023',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 17 * ffem,
                                        fontWeight: FontWeight.w600,
                                        height: 1.4705882353 * ffem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // textQrm (I318:12878;318:12850)
                                    constraints: BoxConstraints(
                                      maxWidth: 138 * fem,
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.3636363636 * ffem / fem,
                                          color: const Color(0xffcdcdcd),
                                        ),
                                        children: [
                                          TextSpan(
                                            text: 'Last day of registration ',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xffcdcdcd),
                                            ),
                                          ),
                                          TextSpan(
                                            text: '15 may 2023',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xffcdcdcd),
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
                              // buttonqah (I318:12878;318:12851)
                              width: 87 * fem,
                              height: 36 * fem,
                              decoration: BoxDecoration(
                                color: const Color(0xffffc300),
                                borderRadius: BorderRadius.circular(8 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Explore',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: const Color(0xff050505),
                                    ),
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
              Container(
                // bottomnavXTX (336:12262)
                margin: EdgeInsets.fromLTRB(
                    20 * fem, 0 * fem, 38.33 * fem, 0 * fem),
                width: double.infinity,
                height: 48 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // navmenuEsj (I336:12262;331:14097)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 36 * fem, 0 * fem),
                      width: 58.33 * fem,
                      height: 48 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-Ww3.png',
                        width: 58.33 * fem,
                        height: 48 * fem,
                      ),
                    ),
                    Container(
                      // navmenu7wX (I336:12262;331:14098)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 38.33 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-SiV.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                    Container(
                      // navmenuqsX (I336:12262;331:14099)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 36 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          11.5 * fem, 12 * fem, 11.5 * fem, 12 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(32 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // alarmbold9NR (I336:12262;331:14099;601:67950)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 10 * fem, 0 * fem),
                            width: 24 * fem,
                            height: 24 * fem,
                            child: Image.asset(
                              'assets/light-design/images/alarm-bold-2f3.png',
                              width: 24 * fem,
                              height: 24 * fem,
                            ),
                          ),
                          Text(
                            // homeGC9 (I336:12262;331:14099;601:67951)
                            'Events',
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
                      // navmenuQJM (I336:12262;331:14100)
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-Xbo.png',
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
