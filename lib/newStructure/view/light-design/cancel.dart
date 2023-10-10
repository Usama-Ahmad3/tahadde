import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class Cancel extends StatelessWidget {
  const Cancel({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // cancel19T (513:7653)
        width: double.infinity,
        height: 806 * fem,
        child: Container(
          // cancelZRs (310:13584)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // toolbar6Ro (310:13585)
                left: 0 * fem,
                top: 0 * fem,
                child: SizedBox(
                  width: 375 * fem,
                  height: 92 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // topbarcQ9 (I310:13585;84:7741)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        padding: EdgeInsets.fromLTRB(
                            31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // timeFi1 (I310:13585;84:7757)
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
                              // cellularconnectionwKw (I310:13585;84:7751)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                              width: 17 * fem,
                              height: 10.67 * fem,
                              child: Image.asset(
                                'assets/light-design/images/cellular-connection-tW5.png',
                                width: 17 * fem,
                                height: 10.67 * fem,
                              ),
                            ),
                            Container(
                              // wifirSu (I310:13585;84:7747)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4.37 * fem),
                              width: 15.27 * fem,
                              height: 10.97 * fem,
                              child: Image.asset(
                                'assets/light-design/images/wifi-Lzd.png',
                                width: 15.27 * fem,
                                height: 10.97 * fem,
                              ),
                            ),
                            Container(
                              // batterym45 (I310:13585;84:7743)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 4 * fem),
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                              child: Image.asset(
                                'assets/light-design/images/battery-2e5.png',
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // iconsandtittlefQM (I310:13585;84:7794)
                        margin: EdgeInsets.fromLTRB(
                            24 * fem, 0 * fem, 24 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 127 * fem, 0 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // iconYj3 (I310:13585;84:7781)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 95 * fem, 0 * fem),
                              width: 32 * fem,
                              height: 32 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-mUm.png',
                                width: 32 * fem,
                                height: 32 * fem,
                              ),
                            ),
                            Text(
                              // tittlefof (I310:13585;84:7783)
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
                // cardnNV (310:13586)
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
                        'assets/light-design/images/mask-group-dsF.png',
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // autogroupz9cbdtu (RQom1Jj9vWcnGdXN71Z9Cb)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 3 * fem, 28 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // chipWxh (310:13593)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 225.99 * fem, 0 * fem),
                              width: 48 * fem,
                              height: 34 * fem,
                              child: Image.asset(
                                'assets/light-design/images/chip-baZ.png',
                                width: 48 * fem,
                                height: 34 * fem,
                              ),
                            ),
                            Container(
                              // paypassCad (310:13592)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 0.01 * fem),
                              width: 18.01 * fem,
                              height: 22.5 * fem,
                              child: Image.asset(
                                'assets/light-design/images/paypass-e6V.png',
                                width: 18.01 * fem,
                                height: 22.5 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // WrD (310:13594)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 17 * fem, 46 * fem),
                        width: 278 * fem,
                        height: 15 * fem,
                        child: Image.asset(
                          'assets/light-design/images/-FQD.png',
                          width: 278 * fem,
                          height: 15 * fem,
                        ),
                      ),
                      SizedBox(
                        // contentRCV (310:13595)
                        width: double.infinity,
                        height: 37 * fem,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame1000006277ZpV (310:13596)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 6 * fem, 64 * fem, 6 * fem),
                              height: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // jhonelimonJ1P (310:13597)
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
                                    // Nmw (310:13598)
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
                              // group1000004054iqo (310:13599)
                              width: 46 * fem,
                              height: 37 * fem,
                              child: Image.asset(
                                'assets/light-design/images/group-1000004054-w1s.png',
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
                // content3t5 (310:13605)
                left: 0 * fem,
                top: 344 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 24 * fem),
                  width: 375 * fem,
                  height: 462 * fem,
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
                        // captionandcarddetailsijK (310:13606)
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // captionGVw (310:13607)
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
                              // cardYTT (310:13608)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // bankcardselectiongJm (310:13609)
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
                                          // frame1000006383k3j (I310:13609;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 132 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogoUEd (I310:13609;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-sjX.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepayA7T (I310:13609;141:10590)
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
                                          // selectorJDf (I310:13609;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-zDF.png',
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
                                    // bankcardselectionCK3 (310:13610)
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
                                          // frame10000063837S1 (I310:13610;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 160 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogo3qT (I310:13610;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-g5o.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepayN73 (I310:13610;141:10590)
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
                                          // selectorhv1 (I310:13610;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-UBs.png',
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
                                    // bankcardselectionoi9 (310:13611)
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
                                          // frame100000638359s (I310:13611;306:13253)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 113 * fem, 0 * fem),
                                          height: double.infinity,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                // banklogoQC9 (I310:13611;141:10603)
                                                margin: EdgeInsets.fromLTRB(
                                                    0 * fem,
                                                    0 * fem,
                                                    16 * fem,
                                                    0 * fem),
                                                width: 40 * fem,
                                                height: 40 * fem,
                                                child: Image.asset(
                                                  'assets/light-design/images/bank-logo-DSZ.png',
                                                  width: 40 * fem,
                                                  height: 40 * fem,
                                                ),
                                              ),
                                              Text(
                                                // applepay8P3 (I310:13611;141:10590)
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
                                          // selectorSuX (I310:13611;141:10598)
                                          width: 24 * fem,
                                          height: 24 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-qGD.png',
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
                        // detailssaveoptionKiR (310:13612)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 73 * fem, 0 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // vector4AD (310:13613)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 10 * fem, 0 * fem),
                              width: 20 * fem,
                              height: 20 * fem,
                              child: Image.asset(
                                'assets/light-design/images/vector-gq7.png',
                                width: 20 * fem,
                                height: 20 * fem,
                              ),
                            ),
                            Text(
                              // savethiscardforafastercheckout (310:13614)
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
                        // buttonuAq (310:13615)
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
                // rectangle363w7X (310:13616)
                left: 0 * fem,
                top: 0 * fem,
                child: Align(
                  child: SizedBox(
                    width: 375 * fem,
                    height: 806 * fem,
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
                // contentS4H (310:13729)
                left: 0 * fem,
                top: 436 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 24 * fem),
                  width: 375 * fem,
                  height: 370 * fem,
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
                        // captionandcarddetailsj3P (310:13730)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 20 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // frame1000006389Tk5 (310:13777)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 16 * fem),
                              padding: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.42 * fem, 0 * fem),
                              width: double.infinity,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // textmkm (310:13780)
                                    margin: EdgeInsets.fromLTRB(0 * fem,
                                        0 * fem, 133.42 * fem, 0 * fem),
                                    child: Text(
                                      'Reason to cancel?',
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
                                    // canceliconVAy (310:13775)
                                    width: 13.15 * fem,
                                    height: 13.15 * fem,
                                    child: Image.asset(
                                      'assets/light-design/images/cancel-icon-2PT.png',
                                      width: 13.15 * fem,
                                      height: 13.15 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              // contentzdX (310:13782)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // cancelationreasonwYm (310:13783)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 92 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selector1oX (I310:13783;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-TzH.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // text8dF (I310:13783;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'I don’t have enough teammates.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12 * fem,
                                  ),
                                  Container(
                                    // cancelationreasonEAV (310:13784)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 159 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selectorked (I310:13784;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-tWm.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // textSGZ (I310:13784;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'I don’t like the venue.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12 * fem,
                                  ),
                                  Container(
                                    // cancelationreasonYaV (310:13785)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 113 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selectorfv1 (I310:13785;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-iuf.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // textJxy (I310:13785;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'I am shifting to a new venue.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12 * fem,
                                  ),
                                  Container(
                                    // cancelationreasondEZ (310:13786)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 205 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selectoraZ7 (I310:13786;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-Ug9.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // text73F (I310:13786;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'Wrong venue.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12 * fem,
                                  ),
                                  Container(
                                    // cancelationreason2AD (310:13787)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 136 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selector9kd (I310:13787;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-Hzq.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // textH69 (I310:13787;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'I have changed my mind.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 12 * fem,
                                  ),
                                  Container(
                                    // cancelationreasonjiq (310:13788)
                                    padding: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 252 * fem, 0 * fem),
                                    width: double.infinity,
                                    height: 24 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          // selectorUAd (I310:13788;147:9794)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 16 * fem, 0 * fem),
                                          width: 20 * fem,
                                          height: 20 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/selector-YhX.png',
                                            width: 20 * fem,
                                            height: 20 * fem,
                                          ),
                                        ),
                                        Container(
                                          // textzem (I310:13788;147:9795)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              1 * fem, 0 * fem, 0 * fem),
                                          child: Text(
                                            'Other.',
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff828282),
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
                      Container(
                        // buttonKS9 (310:13739)
                        width: double.infinity,
                        height: 57 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc300),
                          borderRadius: BorderRadius.circular(16 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Cancel Booking',
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
