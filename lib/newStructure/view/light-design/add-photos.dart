import 'package:flutter/material.dart';

import '../utils.dart';

class AddPhotos extends StatelessWidget {
  const AddPhotos({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // addphotosbAq (513:7663)
        width: double.infinity,
        height: 812 * fem,
        child: Container(
          // addphotosKMj (305:12135)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // toolbarFmB (305:12136)
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 36 * fem),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // topbarb4M (I305:12136;84:7741)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 16 * fem),
                      padding: EdgeInsets.fromLTRB(
                          31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // timeh7P (I305:12136;84:7757)
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
                            // cellularconnectionBYM (I305:12136;84:7751)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                            width: 17 * fem,
                            height: 10.67 * fem,
                            child: Image.asset(
                              'assets/light-design/images/cellular-connection-sFw.png',
                              width: 17 * fem,
                              height: 10.67 * fem,
                            ),
                          ),
                          Container(
                            // wifiH5b (I305:12136;84:7747)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                            width: 15.27 * fem,
                            height: 10.96 * fem,
                            child: Image.asset(
                              'assets/light-design/images/wifi-K2H.png',
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                            ),
                          ),
                          Container(
                            // batterybc5 (I305:12136;84:7743)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 4 * fem),
                            width: 24.33 * fem,
                            height: 11.33 * fem,
                            child: Image.asset(
                              'assets/light-design/images/battery-2CH.png',
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // iconsandtittlehv1 (I305:12136;84:7794)
                      margin: EdgeInsets.fromLTRB(
                          24 * fem, 0 * fem, 24 * fem, 0 * fem),
                      padding: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 115.5 * fem, 0 * fem),
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // iconQpR (I305:12136;84:7781)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 83.5 * fem, 0 * fem),
                            width: 32 * fem,
                            height: 32 * fem,
                            child: Image.asset(
                              'assets/light-design/images/icon-uNq.png',
                              width: 32 * fem,
                              height: 32 * fem,
                            ),
                          ),
                          Text(
                            // tittle8kR (I305:12136;84:7783)
                            'Add Photos',
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
                // contentU3b (305:12137)
                padding: EdgeInsets.fromLTRB(
                    24 * fem, 24 * fem, 24 * fem, 152 * fem),
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
                    Container(
                      // captionandcarddetailsiTj (305:12138)
                      margin: EdgeInsets.fromLTRB(
                          0 * fem, 0 * fem, 0 * fem, 24 * fem),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            // captionzg9 (305:12139)
                            width: 257.5 * fem,
                            child: Text(
                              'Add Ground Photos',
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
                          SizedBox(
                            height: 24 * fem,
                          ),
                          SizedBox(
                            // imageqgm (305:12250)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // imagezpZ (305:12251)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  width: double.infinity,
                                  height: 120 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // group1000006142Krq (305:12253)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            14.33 * fem,
                                            82.33 * fem,
                                            14.33 * fem,
                                            14.33 * fem),
                                        width: 155 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: const Color(0x4c000000),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/light-design/images/rectangle-40186-bg-waR.png',
                                            ),
                                          ),
                                        ),
                                        child: Align(
                                          // materialsymbolscheckcircleroun (305:12256)
                                          alignment: Alignment.bottomLeft,
                                          child: SizedBox(
                                            width: 23.33 * fem,
                                            height: 23.33 * fem,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  103 * fem,
                                                  0 * fem),
                                              child: Image.asset(
                                                'assets/light-design/images/material-symbols-check-circle-rounded-eoB.png',
                                                width: 23.33 * fem,
                                                height: 23.33 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // group100000614328y (305:12259)
                                        padding: EdgeInsets.fromLTRB(
                                            14.33 * fem,
                                            82.33 * fem,
                                            14.33 * fem,
                                            14.33 * fem),
                                        width: 156 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: const Color(0x4c000000),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/light-design/images/rectangle-40187-bg.png',
                                            ),
                                          ),
                                        ),
                                        child: Align(
                                          // materialsymbolscheckcircleroun (305:12262)
                                          alignment: Alignment.bottomLeft,
                                          child: SizedBox(
                                            width: 23.33 * fem,
                                            height: 23.33 * fem,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  104 * fem,
                                                  0 * fem),
                                              child: Image.asset(
                                                'assets/light-design/images/material-symbols-check-circle-rounded.png',
                                                width: 23.33 * fem,
                                                height: 23.33 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  // imagejxV (305:12264)
                                  width: double.infinity,
                                  height: 120 * fem,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // group100000614462M (305:12266)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 16 * fem, 0 * fem),
                                        padding: EdgeInsets.fromLTRB(
                                            14.33 * fem,
                                            82.33 * fem,
                                            14.33 * fem,
                                            14.33 * fem),
                                        width: 155 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: const Color(0x4c000000),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/light-design/images/rectangle-40188-bg.png',
                                            ),
                                          ),
                                        ),
                                        child: Align(
                                          // materialsymbolscheckcircleroun (305:12269)
                                          alignment: Alignment.bottomLeft,
                                          child: SizedBox(
                                            width: 23.33 * fem,
                                            height: 23.33 * fem,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  103 * fem,
                                                  0 * fem),
                                              child: Image.asset(
                                                'assets/light-design/images/material-symbols-check-circle-rounded-xxH.png',
                                                width: 23.33 * fem,
                                                height: 23.33 * fem,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // group1000006145yEZ (305:12272)
                                        padding: EdgeInsets.fromLTRB(
                                            14.33 * fem,
                                            82.33 * fem,
                                            14.33 * fem,
                                            14.33 * fem),
                                        width: 156 * fem,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8 * fem),
                                          color: const Color(0x4c000000),
                                          image: const DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/light-design/images/rectangle-40189-bg.png',
                                            ),
                                          ),
                                        ),
                                        child: Align(
                                          // materialsymbolscheckcircleroun (305:12275)
                                          alignment: Alignment.bottomLeft,
                                          child: SizedBox(
                                            width: 23.33 * fem,
                                            height: 23.33 * fem,
                                            child: Container(
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  0 * fem,
                                                  104 * fem,
                                                  0 * fem),
                                              child: Image.asset(
                                                'assets/light-design/images/material-symbols-check-circle-rounded-kg9.png',
                                                width: 23.33 * fem,
                                                height: 23.33 * fem,
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
                          SizedBox(
                            // photoiconandcaptionsz9 (305:12277)
                            width: double.infinity,
                            height: 98 * fem,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // takephotobQM (305:12278)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 16 * fem, 0 * fem),
                                  padding: EdgeInsets.fromLTRB(
                                      27 * fem, 20 * fem, 27 * fem, 20 * fem),
                                  width: 155 * fem,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffcdcdcd)),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: SizedBox(
                                    // cameraiconandcaptionFE1 (305:12279)
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // cameraiconbHs (305:12280)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          width: 32 * fem,
                                          height: 32 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/camera-icon.png',
                                            width: 32 * fem,
                                            height: 32 * fem,
                                          ),
                                        ),
                                        Center(
                                          // caption5Tw (305:12287)
                                          child: Text(
                                            'Take New Photo',
                                            textAlign: TextAlign.center,
                                            style: SafeGoogleFont(
                                              'Inter',
                                              fontSize: 13 * ffem,
                                              fontWeight: FontWeight.w500,
                                              height: 1.3846153846 * ffem / fem,
                                              color: const Color(0xff050505),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // albumiconandcaption16h (305:12288)
                                  padding: EdgeInsets.fromLTRB(20.5 * fem,
                                      20 * fem, 20.5 * fem, 20 * fem),
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffcdcdcd)),
                                    borderRadius:
                                        BorderRadius.circular(8 * fem),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // albumiconuxm (305:12289)
                                        margin: EdgeInsets.fromLTRB(
                                            0 * fem, 0 * fem, 0 * fem, 8 * fem),
                                        width: 32 * fem,
                                        height: 32 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/album-icon.png',
                                          width: 32 * fem,
                                          height: 32 * fem,
                                        ),
                                      ),
                                      Text(
                                        // captionSSu (305:12293)
                                        'From Photo Album',
                                        textAlign: TextAlign.center,
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
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // buttonZ1j (305:12146)
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
