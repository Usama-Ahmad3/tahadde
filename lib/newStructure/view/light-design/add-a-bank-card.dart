import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class AddBankCard extends StatelessWidget {
  const AddBankCard({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // addabankcardRMT (513:7665)
        width: double.infinity,
        height: 942 * fem,
        child: Container(
          // addabankcardZyT (303:12087)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbar5gu (303:12088)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarcwj (I303:12088;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timejFf (I303:12088;84:7757)
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
                            // cellularconnectionPr1 (I303:12088;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-MgD.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifi7GD (I303:12088;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-XJ1.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batteryE5w (I303:12088;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-3VT.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittle7Qd (I303:12088;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 117.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // icond85 (I303:12088;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 85.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-ztR.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittle9MK (I303:12088;84:7783)
                            'Add a Card',
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
                // cardGgq (303:12226)
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
                      'assets/light-design/images/mask-group-9jP.png',
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // autogrouptdeovWV (RQoF2zzwZd21aTXHTMTdEo)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 3 * fem, 28 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // chip3LD (303:12229)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 225.99 * fem, 0 * fem),
                            width: 48 * fem,
                            height: 34 * fem,
                            child: Image.asset(
                              'assets/light-design/images/chip-z5P.png',
                              width: 48 * fem,
                              height: 34 * fem,
                            ),
                          ),
                          Container(
                            // paypassxCH (303:12228)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 0 * fem),
                            width: 18.01 * fem,
                            height: 22.5 * fem,
                            child: Image.asset(
                              'assets/light-design/images/paypass-Beq.png',
                              width: 18.01 * fem,
                              height: 22.5 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // eL1 (303:12230)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 17 * fem, 46 * fem),
                      width: 278 * fem,
                      height: 15 * fem,
                      child: Image.asset(
                        'assets/light-design/images/.png',
                        width: 278 * fem,
                        height: 15 * fem,
                      ),
                    ),
                    SizedBox(
                      // contentYAV (303:12231)
                      width: double.infinity,
                      height: 37 * fem,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // frame1000006277fW1 (303:12232)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 6 * fem, 64 * fem, 6 * fem),
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // jhonelimonm3F (303:12233)
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
                                  // fPX (303:12234)
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
                            // group1000004054DA9 (303:12235)
                            width: 46 * fem,
                            height: 37 * fem,
                            child: Image.asset(
                              'assets/light-design/images/group-1000004054-Jed.png',
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
                // contentXwX (303:12089)
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
                      // captionandcarddetails2tH (303:12244)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // captionNx9 (303:12245)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Text(
                              'Provide Card Details',
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
                            // imputfillTih (303:12246)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // imputfillQdw (303:12247)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionvcH (I303:12247;187:11755)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Card Number',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // nametypingandcancelbuttonqUM (I303:12247;187:11756)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 12 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Text(
                                          '1234 - 5678 - 9000 - 0000',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfillH5T (303:12248)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionSDF (I303:12248;187:11755)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Cardholder Name',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // nametypingandcancelbuttonFAh (I303:12248;187:11756)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 12 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Text(
                                          'Arlene Mccoy',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfill489 (303:12249)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // caption1JH (I303:12249;187:11755)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Expiration Date',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // nametypingandcancelbuttonjVB (I303:12249;187:11756)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 12 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Text(
                                          '20/26',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16 * fem,
                                ),
                                SizedBox(
                                  // imputfillZj7 (303:12250)
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionhKX (I303:12250;187:11755)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'CVV',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff1e1e1e),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // nametypingandcancelbutton2Mo (I303:12250;187:11756)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 12 * fem, 16 * fem),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Text(
                                          '7374',
                                          style: SafeGoogleFont(
                                            'Inter',
                                            fontSize: 15 * ffem,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3333333333 * ffem / fem,
                                            color: const Color(0xff050505),
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
                      // detailssaveoptionVWH (303:12251)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 73 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // vectorDSH (303:12252)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 10 * fem, 0 * fem),
                            width: 20 * fem,
                            height: 20 * fem,
                            child: Image.asset(
                              'assets/light-design/images/vector-zpZ.png',
                              width: 20 * fem,
                              height: 20 * fem,
                            ),
                          ),
                          Text(
                            // savethiscardforafastercheckout (303:12253)
                            'Save this card for a faster checkout.',
                            style: SafeGoogleFont(
                              'Inter',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w500,
                              height: 1.3846153846 * ffem / fem,
                              color: const Color(0xff010101),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24 * fem,
                    ),
                    Container(
                      // buttondW1 (303:12254)
                      width: double.infinity,
                      height: 57 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Done',
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
