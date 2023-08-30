import 'package:flutter/material.dart';

import '../utils.dart';

class Search1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // search1XS1 (513:7654)
        width: double.infinity,
        height: 812 * fem,
        child: Container(
          // search1dzq (322:13880)
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbar8wb (322:13881)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbar4qF (I322:13881;82:7634)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 12 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timexvd (I322:13881;82:7650)
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
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // cellularconnection1e1 (I322:13881;82:7644)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-JrM.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifiKeh (I322:13881;82:7640)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                            width: 15.27 * fem,
                            height: 10.97 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-vho.png',
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                            ),
                          ),
                          Container(
                            // batteryp5f (I322:13881;82:7636)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-upd.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // nameandiconiB3 (I322:13881;84:7713)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      width: double.infinity,
                      height: 47 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // nameandtext2xR (I322:13881;84:7709)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 176 * fem, 0 * fem),
                            height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // filllodesignAHw (I322:13881;82:7659)
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
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ),
                                Text(
                                  // goodmorningorh (I322:13881;84:7707)
                                  'Good Morning',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.3846153846 * ffem / fem,
                                    color: Color(0xff999999),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // iconwT7 (I322:13881;84:7712)
                            width: 36 * fem,
                            height: 36 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-Wxy.png',
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
                // searchEh7 (322:13882)
                margin:
                    EdgeInsets.fromLTRB(24 * fem, 0 * fem, 24 * fem, 24 * fem),
                width: double.infinity,
                height: 50 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // frame3jtm (I322:13882;97:7840)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 16 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 16 * fem, 179 * fem, 16 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff1e1e1e),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vuesaxlinearsearchnormaldz9 (I322:13882;97:7820)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 8 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Image.asset(
                              'assets/light-design/images/vuesax-linear-search-normal-CL9.png',
                              width: 16 * fem,
                              height: 16 * fem,
                            ),
                          ),
                          Text(
                            // searchL7s (I322:13882;97:7821)
                            'Search',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3846153846 * ffem / fem,
                              color: Color(0xff686868),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // group45GGR (I322:13882;97:7822)
                      width: 48 * fem,
                      height: 48 * fem,
                      child: Image.asset(
                        'assets/light-design/images/group-45-qxM.png',
                        width: 48 * fem,
                        height: 48 * fem,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // contentQ7j (322:13883)
                padding:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 0.14 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24 * fem),
                    topRight: Radius.circular(24 * fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroup1vyvfJZ (RQofqNWb45DahxZzkf1vyV)
                      padding: EdgeInsets.fromLTRB(
                          24 * fem, 24 * fem, 17 * fem, 100 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            // textPVT (322:14050)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 24 * fem),
                            child: Text(
                              'Popular Searches',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 20 * ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.25 * ffem / fem,
                                letterSpacing: -0.2 * fem,
                                color: Color(0xff050505),
                              ),
                            ),
                          ),
                          Container(
                            // popularsearchesJcR (322:14061)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // autogrouphrvfTVK (RQofzsEmQPMQM2LBzghRvF)
                                  padding: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // tagZoF (322:14062)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 15 * fem, 16 * fem),
                                        width: double.infinity,
                                        height: 40 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // tab6YH (322:14063)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  8 * fem,
                                                  12 * fem,
                                                  8 * fem),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffe6e6e6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32 * fem),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // iconaTT (I322:14063;87:7636)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-isb.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // textfUu (I322:14063;87:7608)
                                                    'Football Ground',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: Color(0xff050505),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // tabPA1 (322:14064)
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  8 * fem,
                                                  12 * fem,
                                                  8 * fem),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffe6e6e6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32 * fem),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // icon6KK (I322:14064;87:7636)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-qiR.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // textpFK (I322:14064;87:7608)
                                                    'Cricket Ground',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: Color(0xff050505),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // tagkuf (322:14065)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 39 * fem, 0 * fem),
                                        width: double.infinity,
                                        height: 40 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // tab6Cq (322:14066)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  8 * fem,
                                                  12 * fem,
                                                  8 * fem),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffe6e6e6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32 * fem),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // iconmpm (I322:14066;87:7636)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-XvH.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // textteV (I322:14066;87:7608)
                                                    'Volleyball',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: Color(0xff050505),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              // tabSR7 (322:14067)
                                              padding: EdgeInsets.fromLTRB(
                                                  12 * fem,
                                                  8 * fem,
                                                  12 * fem,
                                                  8 * fem),
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Color(0xffe6e6e6)),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32 * fem),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // iconN3s (I322:14067;87:7636)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        8 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-AkZ.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // text5ys (I322:14067;87:7608)
                                                    'Volleyball Ground',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: Color(0xff050505),
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
                                  // tagpwT (322:14068)
                                  width: double.infinity,
                                  height: 40 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // tab8hF (322:14069)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            8 * fem, 12 * fem, 8 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffe6e6e6)),
                                          borderRadius:
                                              BorderRadius.circular(32 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // icon4au (I322:14069;87:7636)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-wEZ.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // textaZF (I322:14069;87:7608)
                                              'Football',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 13 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.3846153846 * ffem / fem,
                                                color: Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16 * fem,
                                      ),
                                      Container(
                                        // tabuLd (322:14070)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            8 * fem, 12 * fem, 8 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffe6e6e6)),
                                          borderRadius:
                                              BorderRadius.circular(32 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconpyP (I322:14070;87:7636)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-fL5.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // texti3B (I322:14070;87:7608)
                                              'Cricket',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 13 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.3846153846 * ffem / fem,
                                                color: Color(0xff050505),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 16 * fem,
                                      ),
                                      Container(
                                        // tabEnD (322:14071)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            8 * fem, 12 * fem, 8 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xffe6e6e6)),
                                          borderRadius:
                                              BorderRadius.circular(32 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconK2y (I322:14071;87:7636)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 24 * fem,
                                              height: 24 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/icon-6H7.png',
                                                width: 24 * fem,
                                                height: 24 * fem,
                                              ),
                                            ),
                                            Text(
                                              // textRrh (I322:14071;87:7608)
                                              'Tennis',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 13 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height:
                                                    1.3846153846 * ffem / fem,
                                                color: Color(0xff050505),
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
                      // keyboarddefaulty7X (322:13903)
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xffd4d6dc),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroupq3s5He1 (RQohGFJAQfMp4k88K3q3s5)
                            padding: EdgeInsets.fromLTRB(
                                2.86 * fem, 6.68 * fem, 2.86 * fem, 0 * fem),
                            width: double.infinity,
                            height: 149.81 * fem,
                            child: Container(
                              // keyboardlayoutQyX (I322:13903;322:13535)
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // strowknV (I322:13903;322:13535;3:11108)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 11.45 * fem),
                                    width: double.infinity,
                                    height: 40.08 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyletterGVw (I322:13903;322:13535;3:11109)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'q',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterfHB (I322:13903;322:13535;3:11110)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'w',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterhUm (I322:13903;322:13535;3:11111)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'e',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterkhw (I322:13903;322:13535;3:11112)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'r',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keylettermsw (I322:13903;322:13535;3:11113)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              't',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterp5X (I322:13903;322:13535;3:11114)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'y',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletter3ys (I322:13903;322:13535;3:11115)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'u',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterQhw (I322:13903;322:13535;3:11116)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'i',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterqHT (I322:13903;322:13535;3:11117)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'o',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterV77 (I322:13903;322:13535;3:11118)
                                          width: 31.77 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'p',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // ndrowLNd (I322:13903;322:13535;3:11119)
                                    margin: EdgeInsets.fromLTRB(15.27 * fem,
                                        0 * fem, 15.27 * fem, 11.45 * fem),
                                    width: double.infinity,
                                    height: 40.08 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyletterzTB (I322:13903;322:13535;3:11120)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'a',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletter4C9 (I322:13903;322:13535;3:11121)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              's',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterJ6V (I322:13903;322:13535;3:11122)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'd',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keylettervdf (I322:13903;322:13535;3:11123)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'f',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletteray7 (I322:13903;322:13535;3:11124)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'g',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterEXs (I322:13903;322:13535;3:11125)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'h',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletteroUV (I322:13903;322:13535;3:11126)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'j',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterSXT (I322:13903;322:13535;3:11127)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 5.73 * fem, 0 * fem),
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'k',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletteruR3 (I322:13903;322:13535;3:11128)
                                          width: 32.55 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(
                                                4.389313221 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset:
                                                    Offset(0 * fem, 1 * fem),
                                                blurRadius: 0 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'l',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'SF Pro Text',
                                                fontSize: 21.4694671631 * ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575 * ffem / fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // rdrowYD7 (I322:13903;322:13535;3:11129)
                                    width: double.infinity,
                                    height: 40.08 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyshiftHAh (I322:13903;322:13535;3:11130)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 13.36 * fem, 0 * fem),
                                          width: 40.08 * fem,
                                          height: 40.08 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/key-shift-cau.png',
                                            width: 40.08 * fem,
                                            height: 40.08 * fem,
                                          ),
                                        ),
                                        Container(
                                          // centerbBP (I322:13903;322:13535;3:11131)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 13.36 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // keyletterWZF (I322:13903;322:13535;3:11132)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'z',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterxAM (I322:13903;322:13535;3:11133)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'x',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterZR3 (I322:13903;322:13535;3:11134)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'c',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterpbs (I322:13903;322:13535;3:11135)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'v',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterFBP (I322:13903;322:13535;3:11136)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'b',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterhZB (I322:13903;322:13535;3:11137)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    5.73 * fem,
                                                    0 * fem),
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'n',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterF6q (I322:13903;322:13535;3:11138)
                                                width: 32.58 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Color(0xffffffff),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.389313221 * fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(
                                                          0 * fem, 1 * fem),
                                                      blurRadius: 0 * fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'm',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont(
                                                      'SF Pro Text',
                                                      fontSize:
                                                          21.4694671631 * ffem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height:
                                                          1.2575 * ffem / fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // keysecondary67T (I322:13903;322:13535;3:11139)
                                          width: 40.08 * fem,
                                          height: 40.08 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/key-secondary-fcV.png',
                                            width: 40.08 * fem,
                                            height: 40.08 * fem,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            // autogrouplxbdDC5 (RQoikxJgpMoSiXAGLULXbD)
                            padding: EdgeInsets.fromLTRB(
                                2.86 * fem, 12.4 * fem, 2.86 * fem, 6.25 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // keyboardinputtypeXyT (I322:13903;322:13537)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 19.14 * fem),
                                  width: double.infinity,
                                  height: 40.08 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // keysecondaryrF3 (I322:13903;322:13537;3:11305)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 5.73 * fem, 0 * fem),
                                        width: 86.83 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xffaeb3be),
                                          borderRadius: BorderRadius.circular(
                                              4.389313221 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0 * fem, 1 * fem),
                                              blurRadius: 0 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '123',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'SF Pro Text',
                                              fontSize: 15.2671766281 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575 * ffem / fem,
                                              letterSpacing:
                                                  -0.3053435326 * fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // keyspacebM3 (I322:13903;322:13537;3:11307)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 5.73 * fem, 0 * fem),
                                        width: 184.16 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius: BorderRadius.circular(
                                              4.389313221 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0 * fem, 1 * fem),
                                              blurRadius: 0 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'space',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'SF Pro Text',
                                              fontSize: 14.7900772095 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575 * ffem / fem,
                                              letterSpacing:
                                                  -0.0954198539 * fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // keyreturnPnh (I322:13903;322:13537;3:11308)
                                        width: 86.83 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Color(0xffaeb3be),
                                          borderRadius: BorderRadius.circular(
                                              4.389313221 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0 * fem, 1 * fem),
                                              blurRadius: 0 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'return',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'SF Pro Text',
                                              fontSize: 15.2671766281 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575 * ffem / fem,
                                              letterSpacing:
                                                  -0.3053435326 * fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // keyboardhomebarpt1 (I322:13903;322:13538)
                                  margin: EdgeInsets.fromLTRB(24.49 * fem,
                                      0 * fem, 28.21 * fem, 0 * fem),
                                  padding: EdgeInsets.fromLTRB(93.83 * fem,
                                      41.41 * fem, 90.11 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Align(
                                    // homebarprowhj (I322:13903;322:13538;3:11099)
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: 132.63 * fem,
                                      height: 4.77 * fem,
                                      child: Image.asset(
                                        'assets/light-design/images/home-bar-pro-f7P.png',
                                        width: 132.63 * fem,
                                        height: 4.77 * fem,
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
            ],
          ),
        ),
      ),
    );
  }
}
