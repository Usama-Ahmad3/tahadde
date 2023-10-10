import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class GroundDetails extends StatelessWidget {
  const GroundDetails({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // grounddetails4oj (360:19917)
        width: double.infinity,
        height: 1509 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // grounddetailsnzd (326:21054)
          width: 438 * fem,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // bannerWfj (326:21055)
                left: 0 * fem,
                top: 0 * fem,
                child: Container(
                  width: 375 * fem,
                  height: 368.68 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16 * fem),
                    color: const Color(0x4c050505),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/light-design/images/rectangle-40173-bg-Jwj.png',
                      ),
                    ),
                  ),
                  child: SizedBox(
                    // toolbarmLm (326:21056)
                    width: double.infinity,
                    height: 92 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // topbarGoK (I326:21056;84:7741)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 16 * fem),
                          padding: EdgeInsets.fromLTRB(
                              31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // timegc9 (I326:21056;84:7757)
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
                                // cellularconnectionkM7 (I326:21056;84:7751)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                                width: 17 * fem,
                                height: 10.67 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/cellular-connection-vKK.png',
                                  width: 17 * fem,
                                  height: 10.67 * fem,
                                ),
                              ),
                              Container(
                                // wifiTWR (I326:21056;84:7747)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                                width: 15.27 * fem,
                                height: 10.97 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/wifi-Lt1.png',
                                  width: 15.27 * fem,
                                  height: 10.97 * fem,
                                ),
                              ),
                              Container(
                                // batterymn1 (I326:21056;84:7743)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/battery-4qf.png',
                                  width: 24.33 * fem,
                                  height: 11.33 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // iconsandtittlefcV (I326:21056;84:7794)
                          margin: EdgeInsets.fromLTRB(
                              24 * fem, 0 * fem, 24 * fem, 0 * fem),
                          padding: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 83 * fem, 0 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // iconYRP (I326:21056;84:7781)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 51 * fem, 0 * fem),
                                width: 32 * fem,
                                height: 32 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/icon-g5w.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                              Text(
                                // tittleTHT (I326:21056;84:7783)
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
                // contentZ5b (326:21057)
                left: 0 * fem,
                top: 294 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 0 * fem, 24 * fem),
                  width: 438 * fem,
                  height: 1214.93 * fem,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24 * fem),
                      topRight: Radius.circular(24 * fem),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // contentkQy (326:21058)
                        width: 327 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // captionandtextfXw (326:21059)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 24 * fem),
                              width: 299 * fem,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // autogroupq4g7MvZ (RQoxVeFY7aMvsRmTVvQ4G7)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // frame1000006400UVP (326:21244)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 16 * fem),
                                          width: 108 * fem,
                                          height: 49 * fem,
                                          decoration: BoxDecoration(
                                            color: const Color(0xfff2f2f2),
                                            borderRadius:
                                                BorderRadius.circular(20 * fem),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '\$600/H',
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
                                        ),
                                        Text(
                                          // textWws (326:21060)
                                          'Sylhet Int City Stadium',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 24 * ffem,
                                            fontWeight: FontWeight.w700,
                                            height: 1.25 * ffem / fem,
                                            letterSpacing: -0.24 * fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // frame10000063992QR (326:21145)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // textBHK (326:21061)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 12 * fem),
                                          child: Text(
                                            'Description',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 15 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3333333333 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // textVoo (326:21144)
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
                                ],
                              ),
                            ),
                            SizedBox(
                              // groundlistHv1 (326:21150)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // captionSY1 (326:21151)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: double.infinity,
                                    child: Text(
                                      'Ground List',
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
                                    // listLtH (326:21152)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // groundlistselectionSgR (326:21153)
                                          padding: EdgeInsets.fromLTRB(12 * fem,
                                              12 * fem, 12 * fem, 12 * fem),
                                          width: double.infinity,
                                          height: 74 * fem,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xfff2f2f2)),
                                            color: const Color(0xffffffff),
                                            borderRadius:
                                                BorderRadius.circular(12 * fem),
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0x1408091e),
                                                offset:
                                                    Offset(0 * fem, 40 * fem),
                                                blurRadius: 30 * fem,
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // imageandtextua1 (I326:21153;137:9503)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    81 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // rectangle40162aRF (I326:21153;137:9506;137:9495)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              8 * fem,
                                                              0 * fem),
                                                      width: 54 * fem,
                                                      height: 50 * fem,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8 * fem),
                                                        child: Image.asset(
                                                          'assets/light-design/images/rectangle-40162-mxV.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // textfxV (I326:21153;137:9498)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              1.5 * fem,
                                                              0 * fem,
                                                              1.5 * fem),
                                                      width: 136 * fem,
                                                      height: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // captionyTP (I326:21153;137:9496)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem),
                                                            child: Text(
                                                              'Main Ground',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    17 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height:
                                                                    1.4705882353 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // frame1000006382gsb (I326:21153;306:12554)
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // clockDcd (I326:21153;306:12476)
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 * fem,
                                                                          0 * fem,
                                                                          4 * fem,
                                                                          0 * fem),
                                                                  width:
                                                                      16 * fem,
                                                                  height:
                                                                      16 * fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/light-design/images/clock-LHo.png',
                                                                    width: 16 *
                                                                        fem,
                                                                    height: 16 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // minimumhours03LSM (I326:21153;137:9497)
                                                                  'Minimum Hours 03',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        13 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.3846153846 *
                                                                            ffem /
                                                                            fem,
                                                                    color: const Color(
                                                                        0xffb4b4b4),
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
                                                // selectorTWy (I326:21153;137:9500)
                                                width: 24 * fem,
                                                height: 24 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/selector-U8h.png',
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
                                          // groundlistselectionARP (326:21154)
                                          padding: EdgeInsets.fromLTRB(12 * fem,
                                              12 * fem, 12 * fem, 12 * fem),
                                          width: double.infinity,
                                          height: 74 * fem,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffe6e6e6)),
                                            borderRadius:
                                                BorderRadius.circular(12 * fem),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // imageandtextGUR (I326:21154;137:9503)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    83 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // rectangle40164Aph (I326:21154;137:9506;137:9510)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              8 * fem,
                                                              0 * fem),
                                                      width: 54 * fem,
                                                      height: 50 * fem,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8 * fem),
                                                        child: Image.asset(
                                                          'assets/light-design/images/rectangle-40164-TBf.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // textH8d (I326:21154;137:9498)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              1.5 * fem,
                                                              0 * fem,
                                                              1.5 * fem),
                                                      width: 134 * fem,
                                                      height: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // captionQyw (I326:21154;137:9496)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem),
                                                            child: Text(
                                                              'Futsal Ground',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    17 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height:
                                                                    1.4705882353 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // frame1000006382ufo (I326:21154;306:12554)
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // clockf9B (I326:21154;306:12476)
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 * fem,
                                                                          0 * fem,
                                                                          4 * fem,
                                                                          0 * fem),
                                                                  width:
                                                                      16 * fem,
                                                                  height:
                                                                      16 * fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/light-design/images/clock-gDP.png',
                                                                    width: 16 *
                                                                        fem,
                                                                    height: 16 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // minimumhours03BdK (I326:21154;137:9497)
                                                                  'Minimum Hours 01',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        13 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.3846153846 *
                                                                            ffem /
                                                                            fem,
                                                                    color: const Color(
                                                                        0xffb4b4b4),
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
                                                // selectoru3X (I326:21154;137:9500)
                                                width: 24 * fem,
                                                height: 24 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/selector-47b.png',
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
                                          // groundlistselectionPzH (326:21155)
                                          padding: EdgeInsets.fromLTRB(12 * fem,
                                              12 * fem, 12 * fem, 12 * fem),
                                          width: double.infinity,
                                          height: 74 * fem,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: const Color(0xffe6e6e6)),
                                            borderRadius:
                                                BorderRadius.circular(12 * fem),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // imageandtextVnR (I326:21155;137:9503)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    81 * fem,
                                                    0 * fem),
                                                height: double.infinity,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      // rectangle40163EV7 (I326:21155;137:9506;137:9509)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              0 * fem,
                                                              8 * fem,
                                                              0 * fem),
                                                      width: 54 * fem,
                                                      height: 50 * fem,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8 * fem),
                                                        child: Image.asset(
                                                          'assets/light-design/images/rectangle-40163-pUZ.png',
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      // textXUD (I326:21155;137:9498)
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              0 * fem,
                                                              1.5 * fem,
                                                              0 * fem,
                                                              1.5 * fem),
                                                      width: 136 * fem,
                                                      height: double.infinity,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            // captionFv1 (I326:21155;137:9496)
                                                            margin: EdgeInsets
                                                                .fromLTRB(
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    0 * fem,
                                                                    4 * fem),
                                                            child: Text(
                                                              'Tennis Ground',
                                                              style:
                                                                  SafeGoogleFont(
                                                                'Inter',
                                                                fontSize:
                                                                    17 * ffem,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                height:
                                                                    1.4705882353 *
                                                                        ffem /
                                                                        fem,
                                                                color: const Color(
                                                                    0xff050505),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            // frame1000006382nYZ (I326:21155;306:12554)
                                                            width:
                                                                double.infinity,
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  // clock8sK (I326:21155;306:12476)
                                                                  margin: EdgeInsets
                                                                      .fromLTRB(
                                                                          0 * fem,
                                                                          0 * fem,
                                                                          4 * fem,
                                                                          0 * fem),
                                                                  width:
                                                                      16 * fem,
                                                                  height:
                                                                      16 * fem,
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/light-design/images/clock-SRP.png',
                                                                    width: 16 *
                                                                        fem,
                                                                    height: 16 *
                                                                        fem,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // minimumhours034W5 (I326:21155;137:9497)
                                                                  'Minimum Hours 03',
                                                                  style:
                                                                      SafeGoogleFont(
                                                                    'Inter',
                                                                    fontSize:
                                                                        13 *
                                                                            ffem,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    height:
                                                                        1.3846153846 *
                                                                            ffem /
                                                                            fem,
                                                                    color: const Color(
                                                                        0xffb4b4b4),
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
                                                // selectorCcH (I326:21155;137:9500)
                                                width: 24 * fem,
                                                height: 24 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/selector-ppq.png',
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
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24 * fem,
                      ),
                      SizedBox(
                        // captionandcarddetails7z9 (326:21204)
                        width: 327 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // captionqv9 (326:21205)
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
                              // autogroupm6ejXHB (RQoyQsDrSoV91EoSQcM6Ej)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 16 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // frame1000006395ech (326:21206)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 70 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 36 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // iconandcaptionB6q (326:21207)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // icontmw (326:21208)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-RNZ.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // parkingsportza5 (326:21210)
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
                                          // iconandcaptionvid (326:21211)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // icon5bX (326:21212)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-STK.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // camerao1j (326:21214)
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
                                    // frame10000063967o7 (326:21215)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 8.02 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 37.93 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // iconandcaptionqj7 (326:21216)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 11 * fem, 1.93 * fem),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconn8Z (326:21217)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 36 * fem,
                                                height: 36 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-uzR.png',
                                                  width: 36 * fem,
                                                  height: 36 * fem,
                                                ),
                                              ),
                                              Text(
                                                // waitingroom6f3 (326:21224)
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
                                          // iconandcaption34V (326:21225)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconbLu (326:21226)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    8 * fem,
                                                    0 * fem),
                                                width: 37.98 * fem,
                                                height: 37.93 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/icon-NyP.png',
                                                  width: 37.98 * fem,
                                                  height: 37.93 * fem,
                                                ),
                                              ),
                                              Text(
                                                // changingroomsK21 (326:21229)
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
                        // captionandcarddetails3Cu (326:21245)
                        width: 327 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // captionxam (326:21246)
                              width: double.infinity,
                              child: Text(
                                'Our Popular Features',
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
                              // autogroupmsrkH7F (RQoz8gMWuAKprVLDqkmSrK)
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 16 * fem, 0 * fem, 0 * fem),
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // frame1000006395PAH (326:21247)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 59 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 20 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // iconandcaptionJHF (326:21248)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // icon1xM (326:21249)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    4 * fem,
                                                    8 * fem,
                                                    4 * fem),
                                                width: 12 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffcdcdcd),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16 * fem),
                                                ),
                                              ),
                                              Text(
                                                // hiringpartnersjdT (326:21251)
                                                'Hiring Partners',
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
                                          // iconandcaptionUb3 (326:21252)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconRmB (326:21253)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    4 * fem,
                                                    8 * fem,
                                                    4 * fem),
                                                width: 12 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffcdcdcd),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16 * fem),
                                                ),
                                              ),
                                              Text(
                                                // miniaturefieldZMb (326:21255)
                                                'Miniature Field',
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
                                  SizedBox(
                                    height: 16 * fem,
                                  ),
                                  Container(
                                    // frame10000063965qj (326:21256)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 56 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 20 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // iconandcaptionBNy (326:21257)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 32 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconiNu (326:21258)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    4 * fem,
                                                    8 * fem,
                                                    4 * fem),
                                                width: 12 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffcdcdcd),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16 * fem),
                                                ),
                                              ),
                                              Text(
                                                // grasspitchqyK (326:21265)
                                                'Grass Pitch',
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
                                          // iconandcaptionnNm (326:21266)
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // iconjJ1 (326:21267)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    4 * fem,
                                                    8 * fem,
                                                    4 * fem),
                                                width: 12 * fem,
                                                height: double.infinity,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffcdcdcd),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16 * fem),
                                                ),
                                              ),
                                              Text(
                                                // outdoorindoorfSZ (326:21270)
                                                'Outdoor / Indoor',
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
                                  SizedBox(
                                    height: 16 * fem,
                                  ),
                                  Container(
                                    // iconandcaptionkiu (326:21283)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 170 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 20 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // iconUeu (326:21284)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              4 * fem, 8 * fem, 4 * fem),
                                          width: 12 * fem,
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffcdcdcd),
                                            borderRadius:
                                                BorderRadius.circular(16 * fem),
                                          ),
                                        ),
                                        Text(
                                          // naturalgrasspitchcFK (326:21285)
                                          'Natural Grass Pitch',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3333333333 * ffem / fem,
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
                        // reviews7Sy (327:21292)
                        width: 327 * fem,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // captionandnumberofreviewsdw7 (327:21293)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // reviewsMs7 (327:21294)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 215 * fem, 0 * fem),
                                    child: Text(
                                      'Reviews',
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
                                    // text5HK (327:21295)
                                    'See All',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.8461538462 * ffem / fem,
                                      color: const Color(0xff686868),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // starandtextpVo (327:21296)
                              width: 136 * fem,
                              height: 25 * fem,
                              child: Stack(
                                children: [
                                  Positioned(
                                    // starmA9 (327:21297)
                                    left: 0 * fem,
                                    top: 0.5 * fem,
                                    child: SizedBox(
                                      width: 136 * fem,
                                      height: 24 * fem,
                                      child: Align(
                                        // star6CR (327:21298)
                                        alignment: Alignment.centerLeft,
                                        child: SizedBox(
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 112 * fem, 0 * fem),
                                            child: Image.asset(
                                              'assets/light-design/images/star-kru.png',
                                              width: 24 * fem,
                                              height: 24 * fem,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    // BDs (327:21303)
                                    left: 32 * fem,
                                    top: 0 * fem,
                                    child: Align(
                                      child: SizedBox(
                                        width: 67 * fem,
                                        height: 25 * fem,
                                        child: RichText(
                                          text: TextSpan(
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 20 * ffem,
                                              fontWeight: FontWeight.w600,
                                              height: 1.25 * ffem / fem,
                                              letterSpacing: -0.2 * fem,
                                              color: const Color(0xff050505),
                                            ),
                                            children: [
                                              const TextSpan(
                                                text: '4.8 ',
                                              ),
                                              TextSpan(
                                                text: '(810)',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 13 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3846153846 * ffem / fem,
                                                  letterSpacing: -0.2 * fem,
                                                  color:
                                                      const Color(0xff9b9b9b),
                                                ),
                                              ),
                                            ],
                                          ),
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
                      SizedBox(
                        height: 24 * fem,
                      ),
                      Container(
                        // profileSZ7 (327:21325)
                        padding: EdgeInsets.fromLTRB(
                            12 * fem, 12 * fem, 0 * fem, 12 * fem),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xfff2f2f2)),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // imageandnameZNq (327:21326)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 99 * fem, 16 * fem),
                              width: double.infinity,
                              height: 44 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // profileV1b (327:21327)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 49 * fem, 0 * fem),
                                    height: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // imageQ8Z (327:21328)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 12 * fem, 0 * fem),
                                          width: 40 * fem,
                                          height: 40 * fem,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20 * fem),
                                            border: Border.all(
                                                color: const Color(0xffffffff)),
                                            image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                'assets/light-design/images/image-bg.png',
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          // nameandprofession3xD (327:21329)
                                          height: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                // lesliealexanderbiq (327:21330)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    0 * fem,
                                                    4 * fem),
                                                child: Text(
                                                  'Leslie Alexander',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 17 * ffem,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.4705882353 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xff050505),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                // uidesigneruUd (327:21331)
                                                'UI Designer',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w400,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xff696969),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    // apr2023FHb (327:21332)
                                    '16 Apr 2023',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 11 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3636363636 * ffem / fem,
                                      color: const Color(0xff696969),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // frame1000006410xSu (390:17039)
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // thegroundwasperfectlyalrightin (327:21333)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    constraints: BoxConstraints(
                                      maxWidth: 250 * fem,
                                    ),
                                    child: Text(
                                      'The ground was perfectly alright, I never seen this type of ground and facilities before in any ground.',
                                      style: SafeGoogleFont(
                                        'Inter',
                                        fontSize: 13 * ffem,
                                        fontWeight: FontWeight.w400,
                                        height: 1.3846153846 * ffem / fem,
                                        color: const Color(0xff696969),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    // starandtexttzm (390:17027)
                                    width: 136 * fem,
                                    height: 26.5 * fem,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          // stardSZ (390:17028)
                                          left: 0 * fem,
                                          top: 2.5 * fem,
                                          child: SizedBox(
                                            width: 136 * fem,
                                            height: 24 * fem,
                                            child: Align(
                                              // starZ5K (390:17029)
                                              alignment: Alignment.topLeft,
                                              child: SizedBox(
                                                width: 13 * fem,
                                                height: 13 * fem,
                                                child: Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      123 * fem,
                                                      11 * fem),
                                                  child: Image.asset(
                                                    'assets/light-design/images/star.png',
                                                    width: 13 * fem,
                                                    height: 13 * fem,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          // rKK (390:17034)
                                          left: 18 * fem,
                                          top: 0 * fem,
                                          child: Align(
                                            child: SizedBox(
                                              width: 20 * fem,
                                              height: 18 * fem,
                                              child: Text(
                                                '4.2',
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
                        height: 24 * fem,
                      ),
                      Container(
                        // button93X (326:21092)
                        width: 327 * fem,
                        height: 57 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc300),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Book Now',
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
