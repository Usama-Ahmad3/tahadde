import 'package:flutter/material.dart';

import '../utils.dart';

class Payment extends StatelessWidget {
  const Payment({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // paymentfE1 (513:7658)
        width: double.infinity,
        height: 806 * fem,
        child: Container(
          // paymentbdT (306:13141)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbar87b (306:13142)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbar3kM (I306:13142;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeW89 (I306:13142;84:7757)
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
                            // cellularconnectionynR (I306:13142;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-q4M.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifiHo7 (I306:13142;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-cDP.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batteryQcq (I306:13142;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-qZK.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittle6Em (I306:13142;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 127 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconPDs (I306:13142;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 95 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-1Hj.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittle79s (I306:13142;84:7783)
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
              Container(
                // cardDih (306:13143)
                margin:
                    EdgeInsets.fromLTRB(24 * fem, 0 * fem, 24 * fem, 24 * fem),
                padding:
                    EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xff1e1e1e),
                  borderRadius: BorderRadius.circular(16 * fem),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      'assets/light-design/images/mask-group-qPP.png',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogroupsgd561o (RQoMmomm2hcyTYn6zLSGd5)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 3 * fem, 28 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // chipbDT (306:13150)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 225.99 * fem, 0 * fem),
                            width: 48 * fem,
                            height: 34 * fem,
                            child: Image.asset(
                              'assets/light-design/images/chip-rRo.png',
                              width: 48 * fem,
                              height: 34 * fem,
                            ),
                          ),
                          Container(
                            // paypassV3w (306:13149)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: 18.01 * fem,
                            height: 22.5 * fem,
                            child: Image.asset(
                              'assets/light-design/images/paypass-TLV.png',
                              width: 18.01 * fem,
                              height: 22.5 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // Cj3 (306:13151)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 17 * fem, 46 * fem),
                      width: 278 * fem,
                      height: 15 * fem,
                      child: Image.asset(
                        'assets/light-design/images/-GCy.png',
                        width: 278 * fem,
                        height: 15 * fem,
                      ),
                    ),
                    SizedBox(
                      // content8Mo (306:13152)
                      width: double.infinity,
                      height: 37 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame1000006277URf (306:13153)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 6 * fem, 64 * fem, 6 * fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // jhonelimonoTw (306:13154)
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
                                  // WNM (306:13155)
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
                            // group1000004054zYR (306:13156)
                            width: 46 * fem,
                            height: 37 * fem,
                            child: Image.asset(
                              'assets/light-design/images/group-1000004054-GpZ.png',
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
              Container(
                // contentSQR (306:13162)
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 24 * fem),
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
                    SizedBox(
                      // captionandcarddetailsw6H (306:13163)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionkpR (306:13164)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Text(
                              'Choose payment method ',
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
                            // cardzyf (306:13216)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // bankcardselectionx9o (306:13217)
                                  padding: EdgeInsets.fromLTRB(
                                      16 * fem, 16 * fem, 16 * fem, 16 * fem),
                                  width: double.infinity,
                                  height: 72 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffe6e6e6)),
                                    borderRadius:
                                        BorderRadius.circular(16 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // frame1000006383DrR (I306:13217;306:13253)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 132 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // banklogox3K (I306:13217;141:10603)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/bank-logo-Yx9.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // applepayGJu (I306:13217;141:10590)
                                              'Apple Pay',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff0a0c0e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectorc7s (I306:13217;141:10598)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-ExH.png',
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
                                  // bankcardselectionvPT (306:13218)
                                  padding: EdgeInsets.fromLTRB(
                                      16 * fem, 16 * fem, 16 * fem, 16 * fem),
                                  width: double.infinity,
                                  height: 72 * fem,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffe6e6e6)),
                                    borderRadius:
                                        BorderRadius.circular(16 * fem),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // frame1000006383CLy (I306:13218;306:13253)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 160 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // banklogoXPF (I306:13218;141:10603)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/bank-logo-6bs.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // applepayEoT (I306:13218;141:10590)
                                              'Paypal',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff0a0c0e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectoryW9 (I306:13218;141:10598)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-oYd.png',
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
                                  // bankcardselectionhBF (306:13219)
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
                                        // frame1000006383ZDT (I306:13219;306:13253)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 113 * fem, 0 * fem),
                                        height: double.infinity,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // banklogohKf (I306:13219;141:10603)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  16 * fem,
                                                  0 * fem),
                                              width: 40 * fem,
                                              height: 40 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/bank-logo-ukD.png',
                                                width: 40 * fem,
                                                height: 40 * fem,
                                              ),
                                            ),
                                            Text(
                                              // applepaycxR (I306:13219;141:10590)
                                              'Master Card',
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 17 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height:
                                                    1.4705882353 * ffem / fem,
                                                color: const Color(0xff0a0c0e),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        // selectorMv1 (I306:13219;141:10598)
                                        width: 24 * fem,
                                        height: 24 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/selector-h2h.png',
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
                      // detailssaveoptionTTF (306:13170)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 73 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vectorZmB (306:13171)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 10 * fem, 0 * fem),
                            width: 20 * fem,
                            height: 20 * fem,
                            child: Image.asset(
                              'assets/light-design/images/vector-oiH.png',
                              width: 20 * fem,
                              height: 20 * fem,
                            ),
                          ),
                          Text(
                            // savethiscardforafastercheckout (306:13172)
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
                      // buttonzbb (306:13173)
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
