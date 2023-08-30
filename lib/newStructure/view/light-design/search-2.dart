import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import '../utils.dart';

class Search2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // search2NTs (513:7655)
        width: double.infinity,
        height: 812*fem,
        child: Container(
          // search2tx1 (322:13316)
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration (
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarpKs (322:13317)
                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 36*fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarucD (I322:13317;84:7741)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 16*fem),
                      padding: EdgeInsets.fromLTRB(31*fem, 15*fem, 20.67*fem, 11*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timez7s (I322:13317;84:7757)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 224.67*fem, 0*fem),
                            child: Text(
                              '10:55',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont (
                                'SF Pro Text',
                                fontSize: 14*ffem,
                                fontWeight: FontWeight.w600,
                                height: 1.2575*ffem/fem,
                                letterSpacing: -0.2800000012*fem,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                          Container(
                            // cellularconnectionU33 (I322:13317;84:7751)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.03*fem, 4*fem),
                            width: 17*fem,
                            height: 10.67*fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-eFs.png',
                              width: 17*fem,
                              height: 10.67*fem,
                            ),
                          ),
                          Container(
                            // wifiNeD (I322:13317;84:7747)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.03*fem, 4.37*fem),
                            width: 15.27*fem,
                            height: 10.97*fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-JKB.png',
                              width: 15.27*fem,
                              height: 10.97*fem,
                            ),
                          ),
                          Container(
                            // batteryVTw (I322:13317;84:7743)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 4*fem),
                            width: 24.33*fem,
                            height: 11.33*fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-oLm.png',
                              width: 24.33*fem,
                              height: 11.33*fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittleQ57 (I322:13317;84:7794)
                      margin: EdgeInsets.fromLTRB(24*fem, 0*fem, 24*fem, 0*fem),
                      padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 134.5*fem, 0*fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconh4D (I322:13317;84:7781)
                            margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 102.5*fem, 0*fem),
                            width: 32*fem,
                            height: 32*fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-jy3.png',
                              width: 32*fem,
                              height: 32*fem,
                            ),
                          ),
                          Text(
                            // tittle1Ko (I322:13317;84:7783)
                            'Search',
                            textAlign: TextAlign.center,
                            style: SafeGoogleFont (
                              'Inter',
                              fontSize: 17*ffem,
                              fontWeight: FontWeight.w600,
                              height: 1.4705882353*ffem/fem,
                              color: Color(0xffffffff),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // frame3jmb (I322:13419;126:10005)
                margin: EdgeInsets.fromLTRB(24*fem, 0*fem, 24*fem, 24*fem),
                padding: EdgeInsets.fromLTRB(16*fem, 19*fem, 21.42*fem, 19*fem),
                width: double.infinity,
                decoration: BoxDecoration (
                  border: Border.all(color: Color(0xffffffff)),
                  borderRadius: BorderRadius.circular(16*fem),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // typeETT (I322:13419;126:10006)
                      margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 222.43*fem, 0*fem),
                      child: Text(
                        'Ground |',
                        style: SafeGoogleFont (
                          'Inter',
                          fontSize: 13*ffem,
                          fontWeight: FontWeight.w500,
                          height: 1.3846153846*ffem/fem,
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                    Container(
                      // materialsymbolscloseroundedwMs (I322:13419;126:10010)
                      width: 13.15*fem,
                      height: 13.15*fem,
                      child: Image.asset(
                        'assets/light-design/images/material-symbols-close-rounded-ifB.png',
                        width: 13.15*fem,
                        height: 13.15*fem,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // contente1P (322:13324)
                padding: EdgeInsets.fromLTRB(0*fem, 24*fem, 0*fem, 0.14*fem),
                width: double.infinity,
                decoration: BoxDecoration (
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.only (
                    topLeft: Radius.circular(24*fem),
                    topRight: Radius.circular(24*fem),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // searchsuggessionjww (322:13490)
                      margin: EdgeInsets.fromLTRB(24*fem, 0*fem, 24*fem, 191*fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // recentsearchs2Z (322:13491)
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.42*fem, 0*fem),
                            width: double.infinity,
                            height: 25*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame38ZRB (322:13492)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 150.43*fem, 0*fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // searchnormal6R7 (322:13493)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                        width: 20*fem,
                                        height: 20*fem,
                                        child: Image.asset(
                                          'assets/light-design/images/search-normal-rb3.png',
                                          width: 20*fem,
                                          height: 20*fem,
                                        ),
                                      ),
                                      Text(
                                        // cricketgroundbcm (322:13494)
                                        'Cricket Ground',
                                        style: SafeGoogleFont (
                                          'Inter',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4705882353*ffem/fem,
                                          color: Color(0xff050505),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // materialsymbolscloseroundedYH7 (322:13495)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                  width: 13.15*fem,
                                  height: 13.15*fem,
                                  child: Image.asset(
                                    'assets/light-design/images/material-symbols-close-rounded-gYq.png',
                                    width: 13.15*fem,
                                    height: 13.15*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20*fem,
                          ),
                          Container(
                            // recentsearch7zR (322:13497)
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.42*fem, 0*fem),
                            width: double.infinity,
                            height: 25*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame38rBK (322:13498)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 154.43*fem, 0*fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // searchnormalPS9 (322:13499)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                        width: 20*fem,
                                        height: 20*fem,
                                        child: Image.asset(
                                          'assets/light-design/images/search-normal.png',
                                          width: 20*fem,
                                          height: 20*fem,
                                        ),
                                      ),
                                      Text(
                                        // sportsground6LZ (322:13500)
                                        'Sports Ground',
                                        style: SafeGoogleFont (
                                          'Inter',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4705882353*ffem/fem,
                                          color: Color(0xff050505),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // materialsymbolscloseroundedRdj (322:13501)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                  width: 13.15*fem,
                                  height: 13.15*fem,
                                  child: Image.asset(
                                    'assets/light-design/images/material-symbols-close-rounded-7AH.png',
                                    width: 13.15*fem,
                                    height: 13.15*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20*fem,
                          ),
                          Container(
                            // recentsearch4Ro (322:13503)
                            padding: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.42*fem, 0*fem),
                            width: double.infinity,
                            height: 25*fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // frame38ADw (322:13504)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 160.43*fem, 0*fem),
                                  height: double.infinity,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // searchnormal6NV (322:13505)
                                        margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 16*fem, 0*fem),
                                        width: 20*fem,
                                        height: 20*fem,
                                        child: Image.asset(
                                          'assets/light-design/images/search-normal-qpV.png',
                                          width: 20*fem,
                                          height: 20*fem,
                                        ),
                                      ),
                                      Text(
                                        // futsalground1VT (322:13506)
                                        'Futsal Ground',
                                        style: SafeGoogleFont (
                                          'Inter',
                                          fontSize: 17*ffem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.4705882353*ffem/fem,
                                          color: Color(0xff050505),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // materialsymbolscloseroundedwP7 (322:13507)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 1*fem),
                                  width: 13.15*fem,
                                  height: 13.15*fem,
                                  child: Image.asset(
                                    'assets/light-design/images/material-symbols-close-rounded-3wP.png',
                                    width: 13.15*fem,
                                    height: 13.15*fem,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // keyboarddefault3BF (322:13717)
                      width: double.infinity,
                      decoration: BoxDecoration (
                        color: Color(0xffd4d6dc),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // autogroupzcuxwGd (RQocA9JYbLG1o4emRizCUX)
                            padding: EdgeInsets.fromLTRB(2.86*fem, 6.68*fem, 2.86*fem, 0*fem),
                            width: double.infinity,
                            height: 149.81*fem,
                            child: Container(
                              // keyboardlayoutsAH (I322:13717;322:13535)
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // strow1GV (I322:13717;322:13535;3:11108)
                                    margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 11.45*fem),
                                    width: double.infinity,
                                    height: 40.08*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyletterUQy (I322:13717;322:13535;3:11109)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'q',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterJeu (I322:13717;322:13535;3:11110)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'w',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterwSy (I322:13717;322:13535;3:11111)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'e',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterN2V (I322:13717;322:13535;3:11112)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'r',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterz3s (I322:13717;322:13535;3:11113)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              't',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterqaH (I322:13717;322:13535;3:11114)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'y',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterFtu (I322:13717;322:13535;3:11115)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'u',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keylettertgy (I322:13717;322:13535;3:11116)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'i',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterury (I322:13717;322:13535;3:11117)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'o',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.73*fem,
                                        ),
                                        Container(
                                          // keyletterx4Z (I322:13717;322:13535;3:11118)
                                          width: 31.77*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'p',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // ndrowE25 (I322:13717;322:13535;3:11119)
                                    margin: EdgeInsets.fromLTRB(15.27*fem, 0*fem, 15.27*fem, 11.45*fem),
                                    width: double.infinity,
                                    height: 40.08*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyletterjUd (I322:13717;322:13535;3:11120)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'a',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterN1o (I322:13717;322:13535;3:11121)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              's',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keylettercgq (I322:13717;322:13535;3:11122)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'd',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterUU9 (I322:13717;322:13535;3:11123)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'f',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterWvd (I322:13717;322:13535;3:11124)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'g',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterMgM (I322:13717;322:13535;3:11125)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'h',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterMZs (I322:13717;322:13535;3:11126)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'j',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterwY5 (I322:13717;322:13535;3:11127)
                                          margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'k',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // keyletterQAm (I322:13717;322:13535;3:11128)
                                          width: 32.55*fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration (
                                            color: Color(0xffffffff),
                                            borderRadius: BorderRadius.circular(4.389313221*fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color(0x59000000),
                                                offset: Offset(0*fem, 1*fem),
                                                blurRadius: 0*fem,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'l',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont (
                                                'SF Pro Text',
                                                fontSize: 21.4694671631*ffem,
                                                fontWeight: FontWeight.w400,
                                                height: 1.2575*ffem/fem,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    // rdrowT93 (I322:13717;322:13535;3:11129)
                                    width: double.infinity,
                                    height: 40.08*fem,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // keyshiftPYV (I322:13717;322:13535;3:11130)
                                          width: 40.08*fem,
                                          height: 40.08*fem,
                                          child: Image.asset(
                                            'assets/light-design/images/key-shift-wgV.png',
                                            width: 40.08*fem,
                                            height: 40.08*fem,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 13.36*fem,
                                        ),
                                        Container(
                                          // centeruWq (I322:13717;322:13535;3:11131)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // keyletter48q (I322:13717;322:13535;3:11132)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'z',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keylettergg1 (I322:13717;322:13535;3:11133)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'x',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keylettergZX (I322:13717;322:13535;3:11134)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'c',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletterYrd (I322:13717;322:13535;3:11135)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'v',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletteraYR (I322:13717;322:13535;3:11136)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'b',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keyletter3S1 (I322:13717;322:13535;3:11137)
                                                margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 5.73*fem, 0*fem),
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'n',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                // keylettergjs (I322:13717;322:13535;3:11138)
                                                width: 32.58*fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration (
                                                  color: Color(0xffffffff),
                                                  borderRadius: BorderRadius.circular(4.389313221*fem),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x59000000),
                                                      offset: Offset(0*fem, 1*fem),
                                                      blurRadius: 0*fem,
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'm',
                                                    textAlign: TextAlign.center,
                                                    style: SafeGoogleFont (
                                                      'SF Pro Text',
                                                      fontSize: 21.4694671631*ffem,
                                                      fontWeight: FontWeight.w400,
                                                      height: 1.2575*ffem/fem,
                                                      color: Color(0xff000000),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 13.36*fem,
                                        ),
                                        Container(
                                          // keysecondaryhey (I322:13717;322:13535;3:11139)
                                          width: 40.08*fem,
                                          height: 40.08*fem,
                                          child: Image.asset(
                                            'assets/light-design/images/key-secondary-LSM.png',
                                            width: 40.08*fem,
                                            height: 40.08*fem,
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
                            // autogroup6q8fRqs (RQodn6bzgxE34kvnmV6Q8f)
                            padding: EdgeInsets.fromLTRB(2.86*fem, 12.4*fem, 2.86*fem, 6.25*fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // keyboardinputtype9Wy (I322:13717;322:13537)
                                  margin: EdgeInsets.fromLTRB(0*fem, 0*fem, 0*fem, 19.14*fem),
                                  width: double.infinity,
                                  height: 40.08*fem,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // keysecondaryGbb (I322:13717;322:13537;3:11305)
                                        width: 86.83*fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration (
                                          color: Color(0xffaeb3be),
                                          borderRadius: BorderRadius.circular(4.389313221*fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0*fem, 1*fem),
                                              blurRadius: 0*fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '123',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'SF Pro Text',
                                              fontSize: 15.2671766281*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575*ffem/fem,
                                              letterSpacing: -0.3053435326*fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.73*fem,
                                      ),
                                      Container(
                                        // keyspace4XT (I322:13717;322:13537;3:11307)
                                        width: 184.16*fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration (
                                          color: Color(0xffffffff),
                                          borderRadius: BorderRadius.circular(4.389313221*fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0*fem, 1*fem),
                                              blurRadius: 0*fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'space',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'SF Pro Text',
                                              fontSize: 14.7900772095*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575*ffem/fem,
                                              letterSpacing: -0.0954198539*fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5.73*fem,
                                      ),
                                      Container(
                                        // keyreturnWPT (I322:13717;322:13537;3:11308)
                                        width: 86.83*fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration (
                                          color: Color(0xffaeb3be),
                                          borderRadius: BorderRadius.circular(4.389313221*fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0x59000000),
                                              offset: Offset(0*fem, 1*fem),
                                              blurRadius: 0*fem,
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            'return',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont (
                                              'SF Pro Text',
                                              fontSize: 15.2671766281*ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.2575*ffem/fem,
                                              letterSpacing: -0.3053435326*fem,
                                              color: Color(0xff000000),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  // keyboardhomebarAiu (I322:13717;322:13538)
                                  margin: EdgeInsets.fromLTRB(24.49*fem, 0*fem, 28.21*fem, 0*fem),
                                  padding: EdgeInsets.fromLTRB(93.83*fem, 41.41*fem, 90.11*fem, 0*fem),
                                  width: double.infinity,
                                  child: Align(
                                    // homebarprosNR (I322:13717;322:13538;3:11099)
                                    alignment: Alignment.bottomCenter,
                                    child: SizedBox(
                                      width: 132.63*fem,
                                      height: 4.77*fem,
                                      child: Image.asset(
                                        'assets/light-design/images/home-bar-pro-Wrm.png',
                                        width: 132.63*fem,
                                        height: 4.77*fem,
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