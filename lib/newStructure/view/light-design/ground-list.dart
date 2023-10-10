import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class GroundList extends StatelessWidget {
  const GroundList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // groundlistvCH (513:7651)
        width: double.infinity,
        height: 1096 * fem,
        child: Container(
          // groundlistSAd (324:20440)
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
                // toolbarVub (324:20441)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarQWm (I324:20441;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timegjB (I324:20441;84:7757)
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
                            // cellularconnectionwf7 (I324:20441;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-jLV.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi3CM (I324:20441;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                            width: 15.27 * fem,
                            height: 10.97 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-to3.png',
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                            ),
                          ),
                          Container(
                            // battery9mB (I324:20441;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-oNH.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittleeT3 (I324:20441;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 97.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconZ4D (I324:20441;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 65.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-ZdT.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittleFSq (I324:20441;84:7783)
                            'Football Ground',
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
                // searchaV7 (324:20728)
                margin:
                    EdgeInsets.fromLTRB(24 * fem, 0 * fem, 24 * fem, 24 * fem),
                width: double.infinity,
                height: 50 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // searchhJq (I324:20728;97:7840)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 16 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 16 * fem, 179 * fem, 16 * fem),
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xff1e1e1e),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vuesaxlinearsearchnormalATK (I324:20728;97:7820)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 8 * fem, 0 * fem),
                            width: 16 * fem,
                            height: 16 * fem,
                            child: Image.asset(
                              'assets/light-design/images/vuesax-linear-search-normal-WDX.png',
                              width: 16 * fem,
                              height: 16 * fem,
                            ),
                          ),
                          Text(
                            // searchfQ5 (I324:20728;97:7821)
                            'Search',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3846153846 * ffem / fem,
                              color: const Color(0xff686868),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // filterzx9 (I324:20728;97:7822)
                      width: 48 * fem,
                      height: 50 * fem,
                      child: Image.asset(
                        'assets/light-design/images/filter.png',
                        width: 48 * fem,
                        height: 50 * fem,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                // contentvqo (324:20448)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 40 * fem),
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
                    Container(
                      // popularground2P3 (324:20449)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            // captionZNy (324:20450)
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // text7fP (I324:20450;78:7795)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 135 * fem, 0 * fem),
                                  child: Text(
                                    'Popular Ground',
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
                                  // seeallySh (I324:20450;78:7796)
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
                            // autogroupv4vdtJm (RQp32bXizGc2zo1xxgv4Vd)
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 16 * fem, 0 * fem, 0 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // frame1000006397R3o (324:20451)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 1 * fem, 16 * fem),
                                  width: double.infinity,
                                  height: 187 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // populargroundcardex9 (324:20452)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            16 * fem, 22 * fem, 16 * fem),
                                        width: 155 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(15 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x0f050818),
                                              offset:
                                                  Offset(10 * fem, 40 * fem),
                                              blurRadius: 30 * fem,
                                            ),
                                          ],
                                        ),
                                        child: SizedBox(
                                          // iconandcaptionhQd (I324:20452;89:7757)
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                // icone4y (I324:20452;90:7765)
                                                width: 48 * fem,
                                                height: 48 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-bso.png',
                                                  width: 48 * fem,
                                                  height: 48 * fem,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12 * fem,
                                              ),
                                              SizedBox(
                                                // locationandnameWss (I324:20452;89:7721)
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // textrwj (I324:20452;78:7803)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              6 * fem),
                                                      child: Text(
                                                        'Hover Ground',
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
                                                    SizedBox(
                                                      // locationAhX (I324:20452;89:7720)
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationiconvRo (I324:20452;89:7719)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem,
                                                                    0 * fem),
                                                            width: 28 * fem,
                                                            height: 28 * fem,
                                                            child: Image.asset(
                                                              'assets/light-design/images/location-icon-dZ3.png',
                                                              width: 28 * fem,
                                                              height: 28 * fem,
                                                            ),
                                                          ),
                                                          Container(
                                                            // texte6u (I324:20452;78:7804)
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  85 * fem,
                                                            ),
                                                            child: Text(
                                                              '3517 W. Gray \nUSA',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    13 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    1.3846153846 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff9b9b9b),
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
                                                height: 12 * fem,
                                              ),
                                              Container(
                                                // balllistYTB (I324:20452;324:16181)
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      // footballUbj (I324:20452;324:16182)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/football-LJu.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // batmintonbAZ (I324:20452;324:16184)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/batminton-Jc1.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // cricketWoK (I324:20452;324:16183)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/cricket-MBX.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
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
                                        // populargroundcarddsw (324:20453)
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            16 * fem, 18 * fem, 16 * fem),
                                        width: 155 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xfff2f2f2)),
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(15 * fem),
                                        ),
                                        child: SizedBox(
                                          // iconandcaptionx9X (I324:20453;89:7757)
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                // icontos (I324:20453;90:7765)
                                                width: 48 * fem,
                                                height: 48 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-eJM.png',
                                                  width: 48 * fem,
                                                  height: 48 * fem,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12 * fem,
                                              ),
                                              SizedBox(
                                                // locationandname1Nh (I324:20453;89:7721)
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // textMhT (I324:20453;78:7803)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              6 * fem),
                                                      child: Text(
                                                        'Sports Ground',
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
                                                      // location5dT (I324:20453;89:7720)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationiconctH (I324:20453;89:7719)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem,
                                                                    0 * fem),
                                                            width: 28 * fem,
                                                            height: 28 * fem,
                                                            child: Image.asset(
                                                              'assets/light-design/images/location-icon-YUZ.png',
                                                              width: 28 * fem,
                                                              height: 28 * fem,
                                                            ),
                                                          ),
                                                          Container(
                                                            // textYG9 (I324:20453;78:7804)
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  85 * fem,
                                                            ),
                                                            child: Text(
                                                              '3517 W. Gray \nUSA',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    13 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    1.3846153846 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff9b9b9b),
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
                                                height: 12 * fem,
                                              ),
                                              Container(
                                                // balllistCbb (I324:20453;324:16181)
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      // footballA2d (I324:20453;324:16182)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/football-ybo.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // batmintonsxd (I324:20453;324:16184)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/batminton-chF.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // cricket1J9 (I324:20453;324:16183)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/cricket-NEV.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
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
                                Container(
                                  // frame1000006398wBo (324:20750)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 1 * fem, 0 * fem),
                                  width: double.infinity,
                                  height: 199 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // populargroundcard41X (324:20752)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            16 * fem, 22 * fem, 16 * fem),
                                        width: 155 * fem,
                                        height: 187 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xfff2f2f2)),
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(15 * fem),
                                        ),
                                        child: SizedBox(
                                          // iconandcaptionYBb (I324:20752;89:7757)
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                // icon4vd (I324:20752;90:7765)
                                                width: 48 * fem,
                                                height: 48 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-JM7.png',
                                                  width: 48 * fem,
                                                  height: 48 * fem,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12 * fem,
                                              ),
                                              SizedBox(
                                                // locationandnameC1F (I324:20752;89:7721)
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // texthTo (I324:20752;78:7803)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              6 * fem),
                                                      child: Text(
                                                        'Futsal Ground',
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
                                                    SizedBox(
                                                      // locationzho (I324:20752;89:7720)
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationicon9Ko (I324:20752;89:7719)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem,
                                                                    0 * fem),
                                                            width: 28 * fem,
                                                            height: 28 * fem,
                                                            child: Image.asset(
                                                              'assets/light-design/images/location-icon-uAR.png',
                                                              width: 28 * fem,
                                                              height: 28 * fem,
                                                            ),
                                                          ),
                                                          Container(
                                                            // textTbP (I324:20752;78:7804)
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  85 * fem,
                                                            ),
                                                            child: Text(
                                                              '3517 W. Gray \nUSA',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    13 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    1.3846153846 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff9b9b9b),
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
                                                height: 12 * fem,
                                              ),
                                              Container(
                                                // balllistMgm (I324:20752;324:16181)
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      // footballJc1 (I324:20752;324:16182)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/football-Dyj.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // batminton2Y1 (I324:20752;324:16184)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/batminton-gLH.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // cricketZ29 (I324:20752;324:16183)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/cricket-BDb.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
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
                                        // populargroundcardVAh (324:20898)
                                        padding: EdgeInsets.fromLTRB(16 * fem,
                                            16 * fem, 18 * fem, 16 * fem),
                                        width: 155 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xfff2f2f2)),
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(15 * fem),
                                        ),
                                        child: SizedBox(
                                          // iconandcaptionCqo (I324:20898;89:7757)
                                          width: double.infinity,
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                // icon8zM (I324:20898;90:7765)
                                                width: 60 * fem,
                                                height: 60 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-5pM.png',
                                                  width: 60 * fem,
                                                  height: 60 * fem,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 12 * fem,
                                              ),
                                              SizedBox(
                                                // locationandnamer9f (I324:20898;89:7721)
                                                width: double.infinity,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // textPvH (I324:20898;78:7803)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              0 * fem,
                                                              6 * fem),
                                                      child: Text(
                                                        'Sports Ground',
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
                                                      // locationKJ9 (I324:20898;89:7720)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              4 * fem,
                                                              0 * fem),
                                                      width: double.infinity,
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            // locationicon4Fj (I324:20898;89:7719)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem,
                                                                    0 * fem),
                                                            width: 28 * fem,
                                                            height: 28 * fem,
                                                            child: Image.asset(
                                                              'assets/light-design/images/location-icon-g7K.png',
                                                              width: 28 * fem,
                                                              height: 28 * fem,
                                                            ),
                                                          ),
                                                          Container(
                                                            // textZCV (I324:20898;78:7804)
                                                            constraints:
                                                                BoxConstraints(
                                                              maxWidth:
                                                                  85 * fem,
                                                            ),
                                                            child: Text(
                                                              '3517 W. Gray \nUSA',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    13 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                height:
                                                                    1.3846153846 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff9b9b9b),
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
                                                height: 12 * fem,
                                              ),
                                              Container(
                                                // balllistTYm (I324:20898;324:16181)
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      // footballQiu (I324:20898;324:16182)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/football-Akh.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // batmintonvx9 (I324:20898;324:16184)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/batminton-19b.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 12 * fem,
                                                    ),
                                                    SizedBox(
                                                      // cricketrL1 (I324:20898;324:16183)
                                                      width: 16 * fem,
                                                      height: 16 * fem,
                                                      child: Image.asset(
                                                        'assets/light-design/images/cricket-7pu.png',
                                                        width: 16 * fem,
                                                        height: 16 * fem,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      // populargroundBNH (324:20454)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionXww (324:20455)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // textdk5 (I324:20455;78:7795)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 122 * fem, 0 * fem),
                                  child: Text(
                                    'National Stadium',
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
                                  // seeallvz5 (I324:20455;78:7796)
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
                            // nearbyyoucardTz1 (324:20456)
                            padding: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xffffffff),
                              borderRadius: BorderRadius.circular(15 * fem),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0x0f050818),
                                  offset: Offset(10 * fem, 40 * fem),
                                  blurRadius: 30 * fem,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // image3YVf (I324:20456;93:9161;93:9034)
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
                                      'assets/light-design/images/image-3-vsK.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Container(
                                  // groundnameandlocationNjb (I324:20456;93:9163)
                                  margin: EdgeInsets.fromLTRB(
                                      16 * fem, 0 * fem, 16 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // groundname6fb (I324:20456;93:9164)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 8 * fem),
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
                                        // addressanddistancemWq (I324:20456;93:9229)
                                        width: double.infinity,
                                        height: 24 * fem,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // iconandlocationK2Z (I324:20456;93:9165)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  21 * fem,
                                                  0 * fem),
                                              height: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // iconSN5 (I324:20456;93:9166)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem,
                                                        0 * fem),
                                                    width: 24 * fem,
                                                    height: 24 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-4bB.png',
                                                      width: 24 * fem,
                                                      height: 24 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // locationxbK (I324:20456;93:9168)
                                                    '3517 W. Gray USA, Sylhet',
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
                                            Container(
                                              // iconandlocationg1X (I324:20456;93:9217)
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
                                                    // iconcA5 (I324:20456;93:9218)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem,
                                                        0 * fem),
                                                    width: 18 * fem,
                                                    height: 18 * fem,
                                                    child: Image.asset(
                                                      'assets/light-design/images/icon-x6M.png',
                                                      width: 18 * fem,
                                                      height: 18 * fem,
                                                    ),
                                                  ),
                                                  Text(
                                                    // locationKqB (I324:20456;93:9220)
                                                    '6 km away',
                                                    style: SafeGoogleFont(
                                                      'Inter',
                                                      fontSize: 13 * ffem,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      height: 1.3846153846 *
                                                          ffem /
                                                          fem,
                                                      color: const Color(
                                                          0xff050505),
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
              Container(
                // bottomnav2Do (336:12198)
                margin: EdgeInsets.fromLTRB(
                    20 * fem, 0 * fem, 38.33 * fem, 0 * fem),
                width: double.infinity,
                height: 48 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // navmenuLkH (I336:12198;331:14077)
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
                            // homeboldqww (I336:12198;331:14077;601:67950)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 10 * fem, 0 * fem),
                            width: 24 * fem,
                            height: 24 * fem,
                            child: Image.asset(
                              'assets/light-design/images/home-bold-1Ff.png',
                              width: 24 * fem,
                              height: 24 * fem,
                            ),
                          ),
                          Text(
                            // homem4u (I336:12198;331:14077;601:67951)
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
                      // navmenuHZ3 (I336:12198;331:14078)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 54.33 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-31s.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                    Container(
                      // navmenubZj (I336:12198;331:14079)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 54.33 * fem, 0 * fem),
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-MvH.png',
                        width: 24 * fem,
                        height: 24 * fem,
                      ),
                    ),
                    SizedBox(
                      // navmenu6WV (I336:12198;331:14080)
                      width: 24 * fem,
                      height: 24 * fem,
                      child: Image.asset(
                        'assets/light-design/images/nav-menu-5Mj.png',
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
