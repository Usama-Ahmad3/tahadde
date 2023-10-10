import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class Filter extends StatelessWidget {
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // filterCo3 (360:19921)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // filterimP (360:19922)
          width: 458 * fem,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // toolbarRA1 (360:19923)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: 375 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarwu3 (I360:19923;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // time3BP (I360:19923;84:7757)
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
                            // cellularconnectionuUV (I360:19923;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-mpM.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi23K (I360:19923;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                            width: 15.27 * fem,
                            height: 10.97 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-Mt5.png',
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                            ),
                          ),
                          Container(
                            // battery7qT (I360:19923;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-m1T.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittlebVj (I360:19923;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 142.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // icontzd (I360:19923;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 110.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-Tiq.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittleDX7 (I360:19923;84:7783)
                            'Filter',
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
                // tablistvAd (360:19924)
                margin:
                    EdgeInsets.fromLTRB(24 * fem, 0 * fem, 0 * fem, 24 * fem),
                width: double.infinity,
                height: 34 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // tabqoP (360:19925)
                      width: 49 * fem,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(32 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Any',
                          style: SafeGoogleFont(
                            'Inter',
                            fontSize: 13 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.3846153846 * ffem / fem,
                            color: const Color(0xff050505),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // autogroupynuf1LV (RQoYxeoHdQAmTeWgWyyNUF)
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 5 * fem, 0 * fem, 5 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            // tab7eR (360:19926)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // iconUE5 (I360:19926;87:7640)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/icon-EYq.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // textb3o (I360:19926;87:7612)
                                  'Football',
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
                            width: 16 * fem,
                          ),
                          SizedBox(
                            // tabJyo (360:19927)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // iconU7b (I360:19927;87:7640)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/icon-jbf.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // textaAd (I360:19927;87:7612)
                                  'Volleyball',
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
                            width: 16 * fem,
                          ),
                          SizedBox(
                            // tabuCu (360:19928)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // icon34D (I360:19928;87:7640)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/icon-cad.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // textA8q (I360:19928;87:7612)
                                  'Tennis',
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
                            width: 16 * fem,
                          ),
                          SizedBox(
                            // tabsJ9 (360:19929)
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // iconpz5 (I360:19929;87:7640)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                  width: 24 * fem,
                                  height: 24 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/icon-miR.png',
                                    width: 24 * fem,
                                    height: 24 * fem,
                                  ),
                                ),
                                Text(
                                  // textXdb (I360:19929;87:7612)
                                  'Cricket',
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // content4dX (360:19930)
                padding: EdgeInsets.fromLTRB(
                    24 * fem, 24 * fem, 24 * fem, 136 * fem),
                width: 375 * fem,
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
                      // addresschangeYob (360:19931)
                      padding: EdgeInsets.fromLTRB(
                          12 * fem, 12 * fem, 12 * fem, 12 * fem),
                      width: double.infinity,
                      height: 54 * fem,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffe6e6e6)),
                        color: const Color(0xffffffff),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // addressFT7 (I360:19931;87:7600)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 7 * fem, 148 * fem, 7 * fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // locationboldmwF (I360:19931;78:7749)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 8 * fem, 0 * fem),
                                  width: 16 * fem,
                                  height: 16 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/location-bold-wYd.png',
                                    width: 16 * fem,
                                    height: 16 * fem,
                                  ),
                                ),
                                Text(
                                  // sylhetbangladeshGt1 (I360:19931;78:7750)
                                  'Sylhet, Bangladesh',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 11 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3636363636 * ffem / fem,
                                    color: const Color(0xff9b9b9b),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // iconyGd (I360:19931;78:7751)
                            width: 30 * fem,
                            height: 30 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-5uB.png',
                              width: 30 * fem,
                              height: 30 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24 * fem,
                    ),
                    SizedBox(
                      // pricerangeVVs (360:19932)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionandpriceEyF (360:19933)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // pricerangeyR3 (360:19934)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 86 * fem, 0 * fem),
                                  child: Text(
                                    'Price Range',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 17 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4705882353 * ffem / fem,
                                      color: const Color(0xff050505),
                                    ),
                                  ),
                                ),
                                Text(
                                  // u3o (360:19935)
                                  '\$80.00 - \$150.00',
                                  textAlign: TextAlign.right,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4705882353 * ffem / fem,
                                    color: const Color(0xff9b9b9b),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // sliderCYh (360:19936)
                            width: 327 * fem,
                            height: 12 * fem,
                            child: Image.asset(
                              'assets/light-design/images/slider.png',
                              width: 327 * fem,
                              height: 12 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24 * fem,
                    ),
                    SizedBox(
                      // pricerangevDo (360:19942)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionandpricefhB (360:19943)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // distancecMX (360:19944)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 164 * fem, 0 * fem),
                                  child: Text(
                                    'Distance',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 17 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4705882353 * ffem / fem,
                                      color: const Color(0xff050505),
                                    ),
                                  ),
                                ),
                                Text(
                                  // upto5kmsL2d (360:19945)
                                  'Upto 5Kms',
                                  textAlign: TextAlign.right,
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 17 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.4705882353 * ffem / fem,
                                    color: const Color(0xff9b9b9b),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            // slider1uT (360:19946)
                            width: 327 * fem,
                            height: 12 * fem,
                            child: Image.asset(
                              'assets/light-design/images/slider-Rpm.png',
                              width: 327 * fem,
                              height: 12 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24 * fem,
                    ),
                    Container(
                      // groundtype8DP (360:19951)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 47 * fem, 0 * fem),
                      width: 280 * fem,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // groundtyperfB (360:19952)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            child: Text(
                              'Ground Type',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 17 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.4705882353 * ffem / fem,
                                color: const Color(0xff050505),
                              ),
                            ),
                          ),
                          SizedBox(
                            // typetagNdX (360:19953)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // typetag8ch (360:19954)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  width: double.infinity,
                                  height: 48 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // allTus (360:19955)
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            12 * fem, 16 * fem, 12 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x14060619),
                                              offset: Offset(0 * fem, 12 * fem),
                                              blurRadius: 30 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // selectorgXj (360:19956)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  12 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-UwB.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // allPS9 (360:19957)
                                              'All',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.3333333333 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16 * fem,
                                      ),
                                      Container(
                                        // frame44Wmf (360:19958)
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            12 * fem, 16 * fem, 12 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xfff2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // selectorc41 (360:19959)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  6 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-dAq.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // a7WZ (360:19960)
                                              '5A',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.3333333333 * ffem / fem,
                                                color: const Color(0xff9b9b9b),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16 * fem,
                                      ),
                                      Container(
                                        // frame45R1T (360:19961)
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            12 * fem, 16 * fem, 12 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xfff2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(30 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // selectortfj (360:19962)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  6 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-1nq.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // aR9s (360:19963)
                                              '7A',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 15 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.3333333333 * ffem / fem,
                                                color: const Color(0xff9b9b9b),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // frame46xfb (360:19964)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 175 * fem, 0 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      16 * fem, 12 * fem, 16 * fem, 12 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color(0xfff2f2f2),
                                    borderRadius:
                                        BorderRadius.circular(30 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // selectorfa1 (360:19965)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 6 * fem, 0 * fem),
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-UDP.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                      Text(
                                        // futsaloAR (360:19966)
                                        'Futsal',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 15 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3333333333 * ffem / fem,
                                          color: const Color(0xff9b9b9b),
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
                      // button5Nq (360:19967)
                      width: double.infinity,
                      height: 57 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(12 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Confirm',
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
