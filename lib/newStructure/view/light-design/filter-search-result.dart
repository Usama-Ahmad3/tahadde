import 'package:flutter/material.dart';

import '../utils.dart';

class FilterSearch extends StatelessWidget {
  const FilterSearch({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // filtersearchresultdiH (360:19920)
        width: double.infinity,
        height: 956 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // filtersearchresult8Q9 (320:12932)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarDwP (320:12933)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbar8oT (I320:12933;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timecCq (I320:12933;84:7757)
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
                            // cellularconnectionShf (I320:12933;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-NdF.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifiwPX (I320:12933;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                            width: 15.27 * fem,
                            height: 10.97 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-uLd.png',
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                            ),
                          ),
                          Container(
                            // batteryqUu (I320:12933;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-BtM.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittleLgZ (I320:12933;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 106.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconq7X (I320:12933;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 74.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-qgM.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittleut5 (I320:12933;84:7783)
                            'Search Result',
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
                // contentbF7 (320:12934)
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 29 * fem),
                width: double.infinity,
                height: 828 * fem,
                decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24 * fem),
                    topRight: Radius.circular(24 * fem),
                  ),
                ),
                child: SizedBox(
                  // captionandcarddetailsVLV (320:12935)
                  width: double.infinity,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // captionn4h (320:12936)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        width: double.infinity,
                        child: Text(
                          'Search result',
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
                        // groundlistFU5 (320:13022)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // nearbyyoucardniu (320:13023)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15 * fem),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x14070516),
                                    offset: Offset(0 * fem, 26 * fem),
                                    blurRadius: 30 * fem,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // image2ULq (I320:13023;93:9161;93:9032)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: 327 * fem,
                                    height: 145 * fem,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15 * fem),
                                        topRight: Radius.circular(15 * fem),
                                      ),
                                      child: Image.asset(
                                        'assets/light-design/images/image-2.png',
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // groundnameandlocationY5o (I320:13023;93:9163)
                                    margin: EdgeInsets.fromLTRB(
                                        16 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // groundnameTiZ (I320:13023;93:9164)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Futsal Grow',
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
                                          // addressanddistanceyS1 (I320:13023;93:9229)
                                          width: double.infinity,
                                          height: 24 * fem,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconandlocation7o7 (I320:13023;93:9165)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    65 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconCZf (I320:13023;93:9166)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-NZX.png',
                                                        width: 24 * fem,
                                                        height: 24 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationX69 (I320:13023;93:9168)
                                                      'Kumarpara, Sylhet',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
                                                        color:
                                                            const Color(0xff828282),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // iconandlocationTEh (I320:13023;93:9217)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    3 * fem,
                                                    0 * fem,
                                                    3 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconxx9 (I320:13023;93:9218)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 18 * fem,
                                                      height: 18 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-Ak9.png',
                                                        width: 18 * fem,
                                                        height: 18 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationHUd (I320:13023;93:9220)
                                                      '6 km away',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
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
                              height: 16 * fem,
                            ),
                            Container(
                              // nearbyyoucardB4D (320:13024)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15 * fem),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x14070516),
                                    offset: Offset(0 * fem, 26 * fem),
                                    blurRadius: 30 * fem,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // image34do (I320:13024;93:9161;93:9034)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: 327 * fem,
                                    height: 145 * fem,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15 * fem),
                                        topRight: Radius.circular(15 * fem),
                                      ),
                                      child: Image.asset(
                                        'assets/light-design/images/image-3.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // groundnameandlocationNPb (I320:13024;93:9163)
                                    margin: EdgeInsets.fromLTRB(
                                        16 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // groundnametMw (I320:13024;93:9164)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Futsal Grow',
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
                                          // addressanddistanceYxH (I320:13024;93:9229)
                                          width: double.infinity,
                                          height: 24 * fem,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconandlocationhKP (I320:13024;93:9165)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    71 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconCmw (I320:13024;93:9166)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-19b.png',
                                                        width: 24 * fem,
                                                        height: 24 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationXpD (I320:13024;93:9168)
                                                      'Mirabazar, Sylhet',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
                                                        color:
                                                            const Color(0xff828282),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // iconandlocationsNH (I320:13024;93:9217)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    3 * fem,
                                                    0 * fem,
                                                    3 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconc4y (I320:13024;93:9218)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 18 * fem,
                                                      height: 18 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-Jvm.png',
                                                        width: 18 * fem,
                                                        height: 18 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationWRF (I320:13024;93:9220)
                                                      '7 km away',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
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
                              height: 16 * fem,
                            ),
                            Container(
                              // nearbyyoucard3AH (320:13025)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15 * fem),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0x14070516),
                                    offset: Offset(0 * fem, 26 * fem),
                                    blurRadius: 30 * fem,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // imagewFf (I320:13025;93:9161;78:7859)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: 327 * fem,
                                    height: 145 * fem,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15 * fem),
                                        topRight: Radius.circular(15 * fem),
                                      ),
                                      child: Image.asset(
                                        'assets/light-design/images/image-cL1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // groundnameandlocationEkZ (I320:13025;93:9163)
                                    margin: EdgeInsets.fromLTRB(
                                        16 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // groundname9cd (I320:13025;93:9164)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          child: Text(
                                            'Futsal Grow',
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
                                          // addressanddistanceeJV (I320:13025;93:9229)
                                          width: double.infinity,
                                          height: 24 * fem,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconandlocationzNM (I320:13025;93:9165)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    71 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconKvR (I320:13025;93:9166)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-B5B.png',
                                                        width: 24 * fem,
                                                        height: 24 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationTFw (I320:13025;93:9168)
                                                      'Mirabazar, Sylhet',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
                                                        color:
                                                            const Color(0xff828282),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                // iconandlocationBBw (I320:13025;93:9217)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    3 * fem,
                                                    0 * fem,
                                                    3 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // iconhvy (I320:13025;93:9218)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: 18 * fem,
                                                      height: 18 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/icon-wE1.png',
                                                        width: 18 * fem,
                                                        height: 18 * fem,
                                                      ),
                                                    ),
                                                    Text(
                                                      // locationbmT (I320:13025;93:9220)
                                                      '7 km away',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 13 * ffem,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.3846153846 *
                                                            ffem /
                                                            fem,
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
