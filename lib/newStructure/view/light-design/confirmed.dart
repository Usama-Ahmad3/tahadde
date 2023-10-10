import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class Confirmed extends StatelessWidget {
  const Confirmed({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // confirmed1nq (513:7659)
        width: double.infinity,
        height: 812 * fem,
        child: Container(
          // confirmedNNV (310:13489)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // toolbargty (310:13490)
                left: 0 * fem,
                top: 0 * fem,
                child: SizedBox(
                  width: 375 * fem,
                  height: 92 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // topbarCsK (I310:13490;84:7741)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        padding: EdgeInsets.fromLTRB(
                            31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // time6Su (I310:13490;84:7757)
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
                              // cellularconnectionzHP (I310:13490;84:7751)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                              width: 17 * fem,
                              height: 10.67 * fem,
                              child: Image.asset(
                                'assets/light-design/images/cellular-connection-ugD.png',
                                width: 17 * fem,
                                height: 10.67 * fem,
                              ),
                            ),
                            Container(
                              // wifigvu (I310:13490;84:7747)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                              child: Image.asset(
                                'assets/light-design/images/wifi-GVw.png',
                                width: 15.27 * fem,
                                height: 10.96 * fem,
                              ),
                            ),
                            Container(
                              // batteryZjo (I310:13490;84:7743)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 4 * fem),
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                              child: Image.asset(
                                'assets/light-design/images/battery-EoB.png',
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // iconsandtittleT4V (I310:13490;84:7794)
                        margin: EdgeInsets.fromLTRB(
                            24 * fem, 0 * fem, 24 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 127 * fem, 0 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // iconLe5 (I310:13490;84:7781)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 95 * fem, 0 * fem),
                              width: 32 * fem,
                              height: 32 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-J6D.png',
                                width: 32 * fem,
                                height: 32 * fem,
                              ),
                            ),
                            Text(
                              // tittleG1w (I310:13490;84:7783)
                              'Payment',
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
              Positioned(
                // cardo1s (310:13491)
                left: 24 * fem,
                top: 128 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      16 * fem, 16 * fem, 16 * fem, 16 * fem),
                  width: 327 * fem,
                  height: 192 * fem,
                  decoration: BoxDecoration(
                    color: const Color(0xff1e1e1e),
                    borderRadius: BorderRadius.circular(16 * fem),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        'assets/light-design/images/mask-group-FmK.png',
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // autogroupbpm1byK (RQoKxrndUWSqsMj1nkbPM1)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 3 * fem, 28 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // chipj3w (310:13498)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 225.99 * fem, 0 * fem),
                              width: 48 * fem,
                              height: 34 * fem,
                              child: Image.asset(
                                'assets/light-design/images/chip-XLd.png',
                                width: 48 * fem,
                                height: 34 * fem,
                              ),
                            ),
                            Container(
                              // paypassSyw (310:13497)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0 * fem),
                              width: 18.01 * fem,
                              height: 22.5 * fem,
                              child: Image.asset(
                                'assets/light-design/images/paypass-svH.png',
                                width: 18.01 * fem,
                                height: 22.5 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // wfo (310:13499)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 17 * fem, 46 * fem),
                        width: 278 * fem,
                        height: 15 * fem,
                        child: Image.asset(
                          'assets/light-design/images/-pBT.png',
                          width: 278 * fem,
                          height: 15 * fem,
                        ),
                      ),
                      SizedBox(
                        // contentSMf (310:13500)
                        width: double.infinity,
                        height: 37 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame1000006277PGu (310:13501)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 64 * fem, 6 * fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // jhonelimon3sF (310:13502)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                    child: Text(
                                      'Jhone Limon',
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
                                    // Md3 (310:13503)
                                    '12/24',
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 17 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4705882353 * ffem / fem,
                                      color: const Color(0xffffc300),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // group1000004054hgu (310:13504)
                              width: 46 * fem,
                              height: 37 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000004054.png',
                                width: 46 * fem,
                                height: 37 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // content2jB (310:13510)
                left: 0 * fem,
                top: 344 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 30 * fem),
                  width: 375 * fem,
                  height: 468 * fem,
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
                        // captionandcarddetailsHQD (310:13511)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // captionzpR (310:13512)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              width: double.infinity,
                              child: Text(
                                'Select payment method ',
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
                              // card55B (310:13513)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // bankcardselectiond6h (310:13514)
                                    padding: EdgeInsets.fromLTRB(
                                        16 * fem, 16 * fem, 16 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 72 * fem,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffe6e6e6)),
                                      borderRadius:
                                          BorderRadius.circular(16 * fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // frame10000063836FB (I310:13514;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 132 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogo28q (I310:13514;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-d1B.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepayVYD (I310:13514;141:10590)
                                                'Apple Pay',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 17 * ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height:
                                                      1.4705882353 * ffem / fem,
                                                  color:
                                                      const Color(0xff0a0c0e),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // selectorpqP (I310:13514;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-D9j.png',
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
                                    // bankcardselectionwv1 (310:13515)
                                    padding: EdgeInsets.fromLTRB(
                                        16 * fem, 16 * fem, 16 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 72 * fem,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffe6e6e6)),
                                      borderRadius:
                                          BorderRadius.circular(16 * fem),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // frame1000006383Sbs (I310:13515;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 160 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogoBZT (I310:13515;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-ztR.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepay5uj (I310:13515;141:10590)
                                                'Paypal',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 17 * ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height:
                                                      1.4705882353 * ffem / fem,
                                                  color:
                                                      const Color(0xff0a0c0e),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // selector2a5 (I310:13515;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-vCh.png',
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
                                    // bankcardselection8ND (310:13516)
                                    padding: EdgeInsets.fromLTRB(
                                        16 * fem, 16 * fem, 16 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 72 * fem,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius:
                                          BorderRadius.circular(16 * fem),
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
                                          // frame1000006383NXT (I310:13516;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 113 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogouGV (I310:13516;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-kWu.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepayMuB (I310:13516;141:10590)
                                                'Master Card',
                                                style: SafeGoogleFont(
                                                  'Inter',
                                                  fontSize: 17 * ffem,
                                                  fontWeight: FontWeight.w600,
                                                  height:
                                                      1.4705882353 * ffem / fem,
                                                  color:
                                                      const Color(0xff0a0c0e),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          // selectorJJd (I310:13516;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-TMK.png',
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
                      Container(
                        // detailssaveoptionpXs (310:13517)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 73 * fem, 0 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vectorZEZ (310:13518)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 10 * fem, 0 * fem),
                              width: 20 * fem,
                              height: 20 * fem,
                              child: Image.asset(
                                'assets/light-design/images/vector-mkM.png',
                                width: 20 * fem,
                                height: 20 * fem,
                              ),
                            ),
                            Text(
                              // savethiscardforafastercheckout (310:13519)
                              'Save this card for a faster checkout.',
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w500,
                                height: 1.3846153846 * ffem / fem,
                                color: const Color(0xff050505),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24 * fem,
                      ),
                      Container(
                        // buttonCYR (310:13520)
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
              ),
              Positioned(
                // rectangle363Ezu (310:13583)
                left: 0 * fem,
                top: 0 * fem,
                child: Align(
                  child: SizedBox(
                    width: 375 * fem,
                    height: 812 * fem,
                    child: Opacity(
                      opacity: 0.5,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0x7f050505),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                // groundinformation9MB (306:13381)
                left: 18 * fem,
                top: 209 * fem,
                child: Container(
                  padding:
                      EdgeInsets.fromLTRB(6 * fem, 16 * fem, 6 * fem, 16 * fem),
                  width: 339 * fem,
                  height: 389 * fem,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // autogroupojkodn9 (RQoLjvKszmH9ri82E7oJko)
                        margin: EdgeInsets.fromLTRB(
                            73.5 * fem, 0 * fem, 15.42 * fem, 0 * fem),
                        width: double.infinity,
                        height: 174 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // groundnameandlogoxJd (145:9801)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 44.93 * fem, 0 * fem),
                              width: 180 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // iconSjb (145:9802)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: 100 * fem,
                                    height: 100 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/icon-W57.png',
                                      width: 100 * fem,
                                      height: 100 * fem,
                                    ),
                                  ),
                                  SizedBox(
                                    // groundnameandlocationZpD (145:9803)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Center(
                                          // hoverground7aq (145:9804)
                                          child: Container(
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 8 * fem),
                                            child: Text(
                                              'Hover Ground',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 24 * ffem,
                                                fontWeight: FontWeight.w700,
                                                height: 1.25 * ffem / fem,
                                                letterSpacing: -0.24 * fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // locationbW1 (145:9805)
                                          padding: EdgeInsets.fromLTRB(
                                              3.31 * fem,
                                              0 * fem,
                                              0 * fem,
                                              0 * fem),
                                          width: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // walkiconeDP (145:9806)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    7.29 * fem,
                                                    0 * fem),
                                                width: 13.4 * fem,
                                                height: 20 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/walk-icon.png',
                                                  width: 13.4 * fem,
                                                  height: 20 * fem,
                                                ),
                                              ),
                                              RichText(
                                                // minskumarpara27sylhetXHB (145:9809)
                                                text: TextSpan(
                                                  style: SafeGoogleFont(
                                                    'Inter',
                                                    fontSize: 11 * ffem,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.3636363636 *
                                                        ffem /
                                                        fem,
                                                    color:
                                                        const Color(0xff505050),
                                                  ),
                                                  children: [
                                                    const TextSpan(
                                                      text: '5 Mins ',
                                                    ),
                                                    TextSpan(
                                                      text: '|',
                                                      style: SafeGoogleFont(
                                                        'Inter',
                                                        fontSize: 11 * ffem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.3636363636 *
                                                            ffem /
                                                            fem,
                                                        color: const Color(
                                                            0xffb4b4b4),
                                                      ),
                                                    ),
                                                    const TextSpan(
                                                      text:
                                                          ' Kumarpara, 27 Sylhet',
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
                              // canceliconDxd (311:13869)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 5.43 * fem, 0 * fem, 0 * fem),
                              width: 13.15 * fem,
                              height: 13.15 * fem,
                              child: Image.asset(
                                'assets/light-design/images/cancel-icon.png',
                                width: 13.15 * fem,
                                height: 13.15 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16 * fem,
                      ),
                      Container(
                        // grounddetailsKVs (146:9813)
                        padding: EdgeInsets.fromLTRB(
                            16 * fem, 16 * fem, 16 * fem, 16 * fem),
                        width: double.infinity,
                        height: 126 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xfff2f2f2),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // groundnameanddatedmT (146:9814)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 112 * fem, 0 * fem),
                              width: 78 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    // groundnumbery4d (146:9815)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // groundZHj (146:9816)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Ground',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // ground01UQh (146:9817)
                                          'Ground 01',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // dateCLh (146:9818)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // dateLxh (146:9819)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Date',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // fri04sepG5f (146:9820)
                                          'Fri. 04 Sep',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // bookingcodeandtimeCV7 (146:9821)
                              width: 105 * fem,
                              height: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    // bookingcodewSh (146:9822)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // captionandcodeSeM (146:9823)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Booking Code',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // gr0175jtM (146:9824)
                                          'GR0175',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    // captionandtimeV6q (146:9825)
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          // timeSXs (146:9826)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 4 * fem),
                                          child: Text(
                                            'Time',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 11 * ffem,
                                              fontWeight: FontWeight.w400,
                                              height: 1.3636363636 * ffem / fem,
                                              color: const Color(0xff686868),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          // pm02pmAim (146:9827)
                                          '01 PM - 02 PM',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
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
                      Text(
                        // textfvR (310:13428)
                        'Booking Confirmed!!',
                        style: SafeGoogleFont(
                          'Inter',
                          fontSize: 17 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.4705882353 * ffem / fem,
                          color: const Color(0xff050505),
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
