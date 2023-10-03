import 'package:flutter/material.dart';

import '../utils.dart';

class EditDetail_02 extends StatelessWidget {
  const EditDetail_02({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // eventdetails02KTw (513:7656)
        width: double.infinity,
        height: 892 * fem,
        child: Container(
          // eventdetails023Pw (316:12467)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // bannerBW9 (316:12559)
                left: 0 * fem,
                top: 0 * fem,
                child: Container(
                  width: 375 * fem,
                  height: 368.68 * fem,
                  decoration: const BoxDecoration(
                    color: Color(0x99000000),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/light-design/images/rectangle-40170-bg-Afs.png',
                      ),
                    ),
                  ),
                  child: SizedBox(
                    // toolbaro1j (316:12468)
                    width: double.infinity,
                    height: 92 * fem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          // topbarjRB (I316:12468;84:7741)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 16 * fem),
                          padding: EdgeInsets.fromLTRB(
                              31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // timepxR (I316:12468;84:7757)
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
                                // cellularconnectioni2D (I316:12468;84:7751)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                                width: 17 * fem,
                                height: 10.67 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/cellular-connection-v6d.png',
                                  width: 17 * fem,
                                  height: 10.67 * fem,
                                ),
                              ),
                              Container(
                                // wifipb3 (I316:12468;84:7747)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                                width: 15.27 * fem,
                                height: 10.96 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/wifi-8kR.png',
                                  width: 15.27 * fem,
                                  height: 10.96 * fem,
                                ),
                              ),
                              Container(
                                // batteryJm7 (I316:12468;84:7743)
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 0 * fem, 4 * fem),
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                                child: Image.asset(
                                  'assets/light-design/images/battery-Wcq.png',
                                  width: 24.33 * fem,
                                  height: 11.33 * fem,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          // iconsandtittleztq (I316:12468;84:7794)
                          margin: EdgeInsets.fromLTRB(
                              24 * fem, 0 * fem, 24 * fem, 0 * fem),
                          width: double.infinity,
                          child: Align(
                            // iconw3P (I316:12468;84:7781)
                            alignment: Alignment.centerLeft,
                            child: SizedBox(
                              width: 32 * fem,
                              height: 32 * fem,
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    0 * fem, 0 * fem, 295 * fem, 0 * fem),
                                child: Image.asset(
                                  'assets/light-design/images/icon-UrM.png',
                                  width: 32 * fem,
                                  height: 32 * fem,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                // content13F (316:12469)
                left: 0 * fem,
                top: 128 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 26 * fem),
                  width: 375 * fem,
                  height: 764 * fem,
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
                        // groundnameandlogoFCV (316:12562)
                        margin: EdgeInsets.fromLTRB(
                            71.5 * fem, 0 * fem, 71.5 * fem, 0 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // iconjtM (316:12563)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: 100 * fem,
                              height: 100 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-bPo.png',
                                width: 100 * fem,
                                height: 100 * fem,
                              ),
                            ),
                            SizedBox(
                              // groundnameandlocationTZT (316:12564)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    // golfgroundodK (316:12565)
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                      child: Text(
                                        'Golf Ground',
                                        textAlign: TextAlign.center,
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 32 * ffem,
                                          fontWeight: FontWeight.w600,
                                          height: 1.09375 * ffem / fem,
                                          letterSpacing: -0.32 * fem,
                                          color: const Color(0xff050505),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // locationJa5 (316:12566)
                                    margin: EdgeInsets.fromLTRB(
                                        4 * fem, 0 * fem, 4 * fem, 0 * fem),
                                    padding: EdgeInsets.fromLTRB(
                                        2.65 * fem, 0 * fem, 0 * fem, 0 * fem),
                                    width: double.infinity,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // walkiconzxh (316:12567)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 6.63 * fem, 0 * fem),
                                          width: 10.72 * fem,
                                          height: 16 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/walk-icon-fo7.png',
                                            width: 10.72 * fem,
                                            height: 16 * fem,
                                          ),
                                        ),
                                        Text(
                                          // minskumarpara27sylhet5z9 (316:12570)
                                          '5 Mins | Kumarpara, 27 Sylhet',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 11 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3636363636 * ffem / fem,
                                            color: const Color(0xff828282),
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
                        // frame1000006391Pjw (316:12703)
                        margin: EdgeInsets.fromLTRB(
                            4.5 * fem, 0 * fem, 4.5 * fem, 0 * fem),
                        width: double.infinity,
                        height: 115 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // tournamentcardiGR (316:12595)
                              padding: EdgeInsets.fromLTRB(
                                  15 * fem, 12 * fem, 15 * fem, 12 * fem),
                              width: 98 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tournamentlogop4Z (I316:12595;316:14777)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                    width: 36 * fem,
                                    height: 36 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/tournament-logo-yiZ.png',
                                      width: 36 * fem,
                                      height: 36 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    // teamnumberWxy (I316:12595;156:10175)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // numberf5B (I316:12595;156:10173)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            '32',
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
                                        Text(
                                          // textwYV (I316:12595;156:10174)
                                          'Total Team',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 13 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3846153846 * ffem / fem,
                                            color: const Color(0xffb4b4b4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12 * fem,
                            ),
                            Container(
                              // tournamentcardRyT (316:12631)
                              padding: EdgeInsets.fromLTRB(
                                  12.5 * fem, 12 * fem, 12.5 * fem, 12 * fem),
                              width: 98 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tournamentlogo7E1 (I316:12631;316:14777)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                    width: 36 * fem,
                                    height: 36 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/tournament-logo-qhB.png',
                                      width: 36 * fem,
                                      height: 36 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    // teamnumberQD7 (I316:12631;156:10175)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // numberM8M (I316:12631;156:10173)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            '64',
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
                                        Text(
                                          // text31B (I316:12631;156:10174)
                                          'Total Match',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 13 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3846153846 * ffem / fem,
                                            color: const Color(0xffb4b4b4),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 12 * fem,
                            ),
                            Container(
                              // tournamentcardmC5 (316:12667)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0.17 * fem, 0 * fem, 0.17 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  10.5 * fem, 12 * fem, 10.5 * fem, 12 * fem),
                              width: 98 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // tournamentlogoqhj (I316:12667;316:14777)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                    width: 36 * fem,
                                    height: 35.66 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/tournament-logo-ks3.png',
                                      width: 36 * fem,
                                      height: 35.66 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    // teamnumber9iR (I316:12667;156:10175)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // numberuhb (I316:12667;156:10173)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            '\$25K',
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
                                        Text(
                                          // textb4d (I316:12667;156:10174)
                                          'Price Money',
                                          textAlign: TextAlign.center,
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 13 * ffem,
                                            fontWeight: FontWeight.w400,
                                            height: 1.3846153846 * ffem / fem,
                                            color: const Color(0xffb4b4b4),
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
                        // captionandcarddetailsVQu (316:12479)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              // captionE7b (316:12480)
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
                              height: 16 * fem,
                            ),
                            Container(
                              // groundlistselection7BP (316:12481)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 11.5 * fem, 12 * fem, 11.5 * fem),
                              width: double.infinity,
                              height: 74 * fem,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: SizedBox(
                                // imageandtextcP3 (I316:12481;137:9503)
                                width: 188 * fem,
                                height: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // rectangle40162YnV (I316:12481;137:9506;137:9495)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 12 * fem, 0 * fem),
                                      width: 54 * fem,
                                      height: 50 * fem,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                        child: Image.asset(
                                          'assets/light-design/images/rectangle-40162-HhT.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // textQph (I316:12481;137:9498)
                                      width: 122 * fem,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // captionMjw (I316:12481;137:9496)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 8 * fem),
                                            child: Text(
                                              'Main Ground',
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
                                            // frame1000006382FKX (I316:12481;306:12554)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 29 * fem, 0 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // clockymK (I316:12481;306:12476)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 16 * fem,
                                                  height: 16 * fem,
                                                  child: Image.asset(
                                                    'assets/light-design/images/clock-dku.png',
                                                    width: 16 * fem,
                                                    height: 16 * fem,
                                                  ),
                                                ),
                                                Text(
                                                  // minimumhours03hSR (I316:12481;137:9497)
                                                  '24 Matches',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3846153846 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xffb4b4b4),
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
                            SizedBox(
                              height: 16 * fem,
                            ),
                            Container(
                              // groundlistselectionpX3 (316:12729)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 11.5 * fem, 12 * fem, 11.5 * fem),
                              width: double.infinity,
                              height: 74 * fem,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: SizedBox(
                                // imageandtextULh (I316:12729;137:9503)
                                width: 184 * fem,
                                height: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // rectangle40162C1o (I316:12729;137:9506;137:9495)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 12 * fem, 0 * fem),
                                      width: 54 * fem,
                                      height: 50 * fem,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                        child: Image.asset(
                                          'assets/light-design/images/rectangle-40162-4zm.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // textVmb (I316:12729;137:9498)
                                      width: 118 * fem,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // captioneeV (I316:12729;137:9496)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 8 * fem),
                                            child: Text(
                                              'Side Ground',
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
                                            // frame1000006382kSd (I316:12729;306:12554)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 27 * fem, 0 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // clockV9K (I316:12729;306:12476)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 16 * fem,
                                                  height: 16 * fem,
                                                  child: Image.asset(
                                                    'assets/light-design/images/clock-NzM.png',
                                                    width: 16 * fem,
                                                    height: 16 * fem,
                                                  ),
                                                ),
                                                Text(
                                                  // minimumhours03k5F (I316:12729;137:9497)
                                                  '16 Matches',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3846153846 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xffb4b4b4),
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
                            SizedBox(
                              height: 16 * fem,
                            ),
                            Container(
                              // groundlistselectionrty (316:12744)
                              padding: EdgeInsets.fromLTRB(
                                  12 * fem, 11.5 * fem, 12 * fem, 11.5 * fem),
                              width: double.infinity,
                              height: 74 * fem,
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color(0xfff2f2f2)),
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: SizedBox(
                                // imageandtextAem (I316:12744;137:9503)
                                width: 189 * fem,
                                height: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      // rectangle40162Tds (I316:12744;137:9506;137:9495)
                                      margin: EdgeInsets.fromLTRB(
                                          0 * fem, 0 * fem, 12 * fem, 0 * fem),
                                      width: 54 * fem,
                                      height: 50 * fem,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(12 * fem),
                                        child: Image.asset(
                                          'assets/light-design/images/rectangle-40162.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      // text9mb (I316:12744;137:9498)
                                      width: 123 * fem,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // captionho7 (I316:12744;137:9496)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 8 * fem),
                                            child: Text(
                                              'View Ground',
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
                                            // frame1000006382ByB (I316:12744;306:12554)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 30 * fem, 0 * fem),
                                            width: double.infinity,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  // clockvQy (I316:12744;306:12476)
                                                  margin: EdgeInsets.fromLTRB(
                                                      0 * fem,
                                                      0 * fem,
                                                      4 * fem,
                                                      0 * fem),
                                                  width: 16 * fem,
                                                  height: 16 * fem,
                                                  child: Image.asset(
                                                    'assets/light-design/images/clock-Q9f.png',
                                                    width: 16 * fem,
                                                    height: 16 * fem,
                                                  ),
                                                ),
                                                Text(
                                                  // minimumhours03FCM (I316:12744;137:9497)
                                                  '24 Matches',
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 13 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3846153846 *
                                                        ffem /
                                                        fem,
                                                    color: const Color(0xffb4b4b4),
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
                      SizedBox(
                        height: 24 * fem,
                      ),
                      Container(
                        // buttonmRb (316:12759)
                        width: double.infinity,
                        height: 57 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc300),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Registration Now',
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
