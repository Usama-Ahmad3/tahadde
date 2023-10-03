import 'package:flutter/material.dart';

import '../utils.dart';

class GroundCategory extends StatelessWidget {
  const GroundCategory({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // groundcategoryjoF (513:7662)
        width: double.infinity,
        height: 812 * fem,
        child: Container(
          // groundcategory681 (303:12546)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbar2GZ (303:12547)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarL2M (I303:12547;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeqE1 (I303:12547;84:7757)
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
                            // cellularconnectionhGD (I303:12547;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-2zD.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi121 (I303:12547;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-Ruj.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batteryih7 (I303:12547;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-Tey.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittleCcH (I303:12547;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 125 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconuWh (I303:12547;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 93 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-DbF.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittle13w (I303:12547;84:7783)
                            'Category',
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
                // contentXny (303:12548)
                padding: EdgeInsets.fromLTRB(
                    24 * fem, 24 * fem, 24 * fem, 186 * fem),
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
                      // captionandcarddetailsESV (303:12549)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            // captionYxy (303:12550)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 24 * fem),
                            width: 246.5 * fem,
                            child: Text(
                              'Ground Category',
                              textAlign: TextAlign.center,
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
                            // groundlistQkH (305:12051)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // groundcategorycardZ7P (305:12052)
                                  padding: EdgeInsets.fromLTRB(
                                      8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x1408091f),
                                        offset: Offset(0 * fem, 40 * fem),
                                        blurRadius: 30 * fem,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // iconandcaptionbZs (I305:12052;188:10844)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 105 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconKVs (I305:12052;188:10840)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-Kxm.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // captionqj7 (I305:12052;187:11919)
                                              'Football Ground',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectorx33 (I305:12052;187:11920)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-qZb.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // groundcategorycardsA1 (305:12053)
                                  padding: EdgeInsets.fromLTRB(
                                      8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xfff2f2f2)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // iconandcaptionkUh (I305:12053;188:10844)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 112 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconHUd (I305:12053;188:10840)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-91K.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // captionmub (I305:12053;187:11919)
                                              'Cricket Ground',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectortzD (I305:12053;187:11920)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-ySq.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // groundcategorycard1Z3 (305:12054)
                                  padding: EdgeInsets.fromLTRB(
                                      8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xfff2f2f2)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // iconandcaption6Kb (I305:12054;188:10844)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 181 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconpmP (I305:12054;188:10840)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-Tj7.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // captionLjj (I305:12054;187:11919)
                                              'Tennis',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectorszZ (I305:12054;187:11920)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-g8R.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // groundcategorycard1L5 (305:12055)
                                  padding: EdgeInsets.fromLTRB(
                                      8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xfff2f2f2)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // iconandcaptionsdB (I305:12055;188:10844)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 157 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconomj (I305:12055;188:10840)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-BXf.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // captionvbT (I305:12055;187:11919)
                                              'Volleyball',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selector3AH (I305:12055;187:11920)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-Mms.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                Container(
                                  // groundcategorycardy3w (305:12056)
                                  padding: EdgeInsets.fromLTRB(
                                      8 * fem, 8 * fem, 8 * fem, 8 * fem),
                                  width: double.infinity,
                                  height: 56 * fem,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x1408091f),
                                        offset: Offset(0 * fem, 40 * fem),
                                        blurRadius: 30 * fem,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // iconandcaption3Zb (I305:12056;188:10844)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 147 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconyy3 (I305:12056;188:10840)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-irm.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // captionWCH (I305:12056;187:11919)
                                              'Badminton',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectorFff (I305:12056;187:11920)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-xTj.png',
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
                        ],
                      ),
                    ),
                    Container(
                      // buttonZgM (303:12557)
                      width: double.infinity,
                      height: 57 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(16 * fem),
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
            ],
          ),
        ),
      ),
    );
  }
}
