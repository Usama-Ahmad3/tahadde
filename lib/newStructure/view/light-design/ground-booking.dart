import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class GroundBooking extends StatelessWidget {
  const GroundBooking({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // groundbookingVVb (360:20402)
        width: double.infinity,
        height: 900 * fem,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Container(
          // groundbookingDwP (305:12399)
          width: 377 * fem,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // toolbar9q3 (305:12400)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 36 * fem),
                width: 375 * fem,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarUsK (I305:12400;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timePUV (I305:12400;84:7757)
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
                            // cellularconnectionSxZ (I305:12400;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-YTb.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi84h (I305:12400;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-kSV.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batteryQnu (I305:12400;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-39B.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittleWb3 (I305:12400;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 90 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconBhB (I305:12400;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 58 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-4KK.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittleK2h (I305:12400;84:7783)
                            'Booking a Ground',
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
                // dateRrR (306:13119)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 24 * fem),
                height: 64 * fem,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // calenderxbT (306:13138)
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
                            // daterRw (I306:13138;110:8863)
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
                            // dayLc1 (I306:13138;110:8864)
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
                      // calenderUy7 (306:13121)
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
                            // dateaWM (I306:13121;107:8828)
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
                            // daysVT (I306:13121;107:8829)
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
                      // autogroupsxgfzKB (RQoNvXMbLGQmiEwwTAsxgF)
                      padding: EdgeInsets.fromLTRB(
                          16 * fem, 0.5 * fem, 0 * fem, 0.5 * fem),
                      height: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // calenderiFB (306:13122)
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
                                  // dateRvH (I306:13122;110:8863)
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
                                  // day9bP (I306:13122;110:8864)
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
                            // calenderrkh (306:13123)
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
                                  // datey4d (I306:13123;110:8863)
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
                                  // daygzd (I306:13123;110:8864)
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
                            // calendernGy (306:13124)
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
                                  // dateVSH (I306:13124;110:8863)
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
                                  // daynwB (I306:13124;110:8864)
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
                            // calendergmf (306:13125)
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
                                  // datebtd (I306:13125;110:8863)
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
                                  // dayiiM (I306:13125;110:8864)
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
                // content4GR (305:12401)
                margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 2 * fem, 0 * fem),
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 38 * fem),
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
                    SizedBox(
                      // captionandcarddetailsKCM (305:12402)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionf1K (305:12403)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 24 * fem),
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
                            // frame1000006383K5s (306:12750)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // groundlistselectionFVK (306:12699)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                  width: double.infinity,
                                  height: 74 * fem,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x14070d1c),
                                        offset: Offset(0 * fem, 30 * fem),
                                        blurRadius: 30 * fem,
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // imageandtexthMK (I306:12699;137:9503)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 81 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // rectangle401623AH (I306:12699;137:9506;137:9495)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 54 * fem,
                                              height: 50 * fem,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8 * fem),
                                                child: Image.asset(
                                                  'assets/light-design/images/rectangle-40162-Wp9.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // textLfB (I306:12699;137:9498)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  1.5 * fem,
                                                  0 * fem,
                                                  1.5 * fem),
                                              width: 136 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // captionDys (I306:12699;137:9496)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem),
                                                    child: Text(
                                                      'Main Ground',
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
                                                    // frame1000006382LYh (I306:12699;306:12554)
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // clockVAh (I306:12699;306:12476)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  4 * fem,
                                                                  0 * fem),
                                                          width: 16 * fem,
                                                          height: 16 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/clock-Xmj.png',
                                                            width: 16 * fem,
                                                            height: 16 * fem,
                                                          ),
                                                        ),
                                                        Text(
                                                          // minimumhours03NXK (I306:12699;137:9497)
                                                          'Minimum Hours 03',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 13 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                        // selector4uw (I306:12699;137:9500)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-8qf.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12 * fem,
                                ),
                                Container(
                                  // groundlistselectionBjf (306:12716)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                  width: double.infinity,
                                  height: 74 * fem,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffe6e6e6)),
                                    color: const Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // imageandtext5KF (I306:12716;137:9503)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 81 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // rectangle40162C8y (I306:12716;137:9506;137:9495)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 54 * fem,
                                              height: 50 * fem,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8 * fem),
                                                child: Image.asset(
                                                  'assets/light-design/images/rectangle-40162-ih7.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // texthrR (I306:12716;137:9498)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  1.5 * fem,
                                                  0 * fem,
                                                  1.5 * fem),
                                              width: 136 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // captionSJD (I306:12716;137:9496)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem),
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
                                                    // frame1000006382xnM (I306:12716;306:12554)
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // clock79T (I306:12716;306:12476)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  4 * fem,
                                                                  0 * fem),
                                                          width: 16 * fem,
                                                          height: 16 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/clock-zAu.png',
                                                            width: 16 * fem,
                                                            height: 16 * fem,
                                                          ),
                                                        ),
                                                        Text(
                                                          // minimumhours03b4d (I306:12716;137:9497)
                                                          'Minimum Hours 03',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 13 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                        // selectorHTF (I306:12716;137:9500)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-c89.png',
                                          width: 24 * fem,
                                          height: 24 * fem,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12 * fem,
                                ),
                                Container(
                                  // groundlistselectionCaD (306:12734)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 12 * fem, 12 * fem, 12 * fem),
                                  width: double.infinity,
                                  height: 74 * fem,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffe6e6e6)),
                                    color: const Color(0xffffffff),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // imageandtextW57 (I306:12734;137:9503)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 81 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // rectangle40162zW5 (I306:12734;137:9506;137:9495)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  8 * fem,
                                                  0 * fem),
                                              width: 54 * fem,
                                              height: 50 * fem,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        8 * fem),
                                                child: Image.asset(
                                                  'assets/light-design/images/rectangle-40162-ZaH.png',
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              // text63K (I306:12734;137:9498)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  1.5 * fem,
                                                  0 * fem,
                                                  1.5 * fem),
                                              width: 136 * fem,
                                              height: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    // captionDdj (I306:12734;137:9496)
                                                    margin: EdgeInsets.fromLTRB(
                                                        0 * fem,
                                                        0 * fem,
                                                        0 * fem,
                                                        4 * fem),
                                                    child: Text(
                                                      'Tennis Ground',
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
                                                    // frame10000063828kh (I306:12734;306:12554)
                                                    width: double.infinity,
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          // clocktE5 (I306:12734;306:12476)
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0 * fem,
                                                                  0 * fem,
                                                                  4 * fem,
                                                                  0 * fem),
                                                          width: 16 * fem,
                                                          height: 16 * fem,
                                                          child: Image.asset(
                                                            'assets/light-design/images/clock-F3F.png',
                                                            width: 16 * fem,
                                                            height: 16 * fem,
                                                          ),
                                                        ),
                                                        Text(
                                                          // minimumhours03p7j (I306:12734;137:9497)
                                                          'Minimum Hours 03',
                                                          style: SafeGoogleFont(
                                                            'Inter',
                                                            fontSize: 13 * ffem,
                                                            fontWeight:
                                                                FontWeight.w400,
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
                                        // selectorZ5K (I306:12734;137:9500)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-Swj.png',
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
                    SizedBox(
                      height: 24 * fem,
                    ),
                    SizedBox(
                      // captionandcarddetailsesT (306:12751)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // caption7eZ (306:12752)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 24 * fem),
                            width: double.infinity,
                            child: Text(
                              'Select a Time',
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
                            // frame1000006387CAD (306:13107)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // frame10000063847HB (306:13088)
                                  width: double.infinity,
                                  height: 47 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // timeselectorFeH (306:13080)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            20.75 * fem,
                                            16 * fem,
                                            22 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xfff2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timeMSR (I306:13080;139:9641)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  9.25 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xff9b9b9b),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selector1ms (I306:13080;306:12919)
                                              width: 12.5 * fem,
                                              height: 12.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-GmX.png',
                                                width: 12.5 * fem,
                                                height: 12.5 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // timeselectorvdw (306:13084)
                                        padding: EdgeInsets.fromLTRB(
                                            19.75 * fem,
                                            16 * fem,
                                            19.75 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff050505),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timepzD (I306:13084;139:9653)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selectorwow (I306:13084;306:13010)
                                              width: 15 * fem,
                                              height: 15 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-e2V.png',
                                                width: 15 * fem,
                                                height: 15 * fem,
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
                                SizedBox(
                                  // frame1000006385TXP (306:13089)
                                  width: double.infinity,
                                  height: 47 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // timeselectorAwb (306:13090)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            19.75 * fem,
                                            16 * fem,
                                            19.75 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff050505),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timerZX (I306:13090;139:9653)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xffffffff),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selectorP3f (I306:13090;306:13010)
                                              width: 15 * fem,
                                              height: 15 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-2Fb.png',
                                                width: 15 * fem,
                                                height: 15 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // timeselectorX9s (306:13091)
                                        padding: EdgeInsets.fromLTRB(
                                            19.75 * fem,
                                            16 * fem,
                                            19.75 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x14060a17),
                                              offset: Offset(0 * fem, 30 * fem),
                                              blurRadius: 30 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timeNRP (I306:13091;139:9651)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selectorgws (I306:13091;306:12987)
                                              width: 15 * fem,
                                              height: 15 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-qz1.png',
                                                width: 15 * fem,
                                                height: 15 * fem,
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
                                SizedBox(
                                  // frame1000006386pYH (306:13098)
                                  width: double.infinity,
                                  height: 47 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // timeselectorAMF (306:13099)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            19.75 * fem,
                                            16 * fem,
                                            19.75 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                          boxShadow: [
                                            BoxShadow(
                                              color: const Color(0x14060a17),
                                              offset: Offset(0 * fem, 30 * fem),
                                              blurRadius: 30 * fem,
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timee1X (I306:13099;139:9651)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  10 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xff050505),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selectorJLy (I306:13099;306:12987)
                                              width: 15 * fem,
                                              height: 15 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-EXb.png',
                                                width: 15 * fem,
                                                height: 15 * fem,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // timeselector33f (306:13100)
                                        padding: EdgeInsets.fromLTRB(
                                            20.75 * fem,
                                            16 * fem,
                                            22 * fem,
                                            16 * fem),
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          color: const Color(0xfff2f2f2),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // timevdF (I306:13100;139:9641)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  9.25 * fem,
                                                  0 * fem),
                                              child: Text(
                                                '08:00 - 11:00 AM',
                                                textAlign: TextAlign.center,
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 11 * ffem,
                                                  fontWeight: FontWeight.w500,
                                                  height:
                                                      1.3636363636 * ffem / fem,
                                                  color:
                                                      const Color(0xff9b9b9b),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              // selectornvM (I306:13100;306:12919)
                                              width: 12.5 * fem,
                                              height: 12.5 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/selector-WYH.png',
                                                width: 12.5 * fem,
                                                height: 12.5 * fem,
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
                    Container(
                      // button6g9 (305:12448)
                      width: double.infinity,
                      height: 57 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(16 * fem),
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
