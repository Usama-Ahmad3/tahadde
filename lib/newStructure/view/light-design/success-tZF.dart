import 'package:flutter/material.dart';

import '../utils.dart';

class SuccessZ extends StatelessWidget {
  const SuccessZ({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: SizedBox(
        // successwTw (513:7664)
        width: double.infinity,
        height: 812 * fem,
        child: Container(
          // successJ3b (305:12294)
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xff050505),
          ),
          child: Stack(
            children: [
              Positioned(
                // toolbarEhw (305:12295)
                left: 0 * fem,
                top: 0 * fem,
                child: SizedBox(
                  width: 375 * fem,
                  height: 92 * fem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // topbarYyX (I305:12295;84:7741)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 16 * fem),
                        padding: EdgeInsets.fromLTRB(
                            31 * fem, 15 * fem, 20.67 * fem, 11 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // timeTah (I305:12295;84:7757)
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
                              // cellularconnectionjo7 (I305:12295;84:7751)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4 * fem),
                              width: 17 * fem,
                              height: 10.67 * fem,
                              child: Image.asset(
                                'assets/light-design/images/cellular-connection-ZXw.png',
                                width: 17 * fem,
                                height: 10.67 * fem,
                              ),
                            ),
                            Container(
                              // wificc1 (I305:12295;84:7747)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 5.03 * fem, 4.38 * fem),
                              width: 15.27 * fem,
                              height: 10.96 * fem,
                              child: Image.asset(
                                'assets/light-design/images/wifi-xKK.png',
                                width: 15.27 * fem,
                                height: 10.96 * fem,
                              ),
                            ),
                            Container(
                              // battery8aM (I305:12295;84:7743)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 4 * fem),
                              width: 24.33 * fem,
                              height: 11.33 * fem,
                              child: Image.asset(
                                'assets/light-design/images/battery-cVw.png',
                                width: 24.33 * fem,
                                height: 11.33 * fem,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // iconsandtittle3BX (I305:12295;84:7794)
                        margin: EdgeInsets.fromLTRB(
                            24 * fem, 0 * fem, 24 * fem, 0 * fem),
                        padding: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 115.5 * fem, 0 * fem),
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // iconsAZ (I305:12295;84:7781)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 83.5 * fem, 0 * fem),
                              width: 32 * fem,
                              height: 32 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-rTB.png',
                                width: 32 * fem,
                                height: 32 * fem,
                              ),
                            ),
                            Text(
                              // tittlenYR (I305:12295;84:7783)
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
              ),
              Positioned(
                // contenttbT (305:12296)
                left: 0 * fem,
                top: 128 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      24 * fem, 24 * fem, 24 * fem, 152 * fem),
                  width: 375 * fem,
                  height: 684 * fem,
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
                        // captionandcarddetailsxbK (305:12297)
                        margin: EdgeInsets.fromLTRB(
                            0 * fem, 0 * fem, 0 * fem, 24 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              // captionGc1 (305:12298)
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
                              // imageLLy (305:12299)
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // image6L9 (305:12300)
                                    margin: EdgeInsets.fromLTRB(
                                        0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                    width: double.infinity,
                                    height: 120 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // group1000006142Qbj (305:12302)
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
                                                'assets/light-design/images/rectangle-40186-bg.png',
                                              ),
                                            ),
                                          ),
                                          child: Align(
                                            // materialsymbolscheckcircleroun (305:12305)
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
                                                  'assets/light-design/images/material-symbols-check-circle-rounded-iXj.png',
                                                  width: 23.33 * fem,
                                                  height: 23.33 * fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // group1000006143gSm (305:12308)
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
                                                'assets/light-design/images/rectangle-40187-bg-QCR.png',
                                              ),
                                            ),
                                          ),
                                          child: Align(
                                            // materialsymbolscheckcircleroun (305:12311)
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
                                                  'assets/light-design/images/material-symbols-check-circle-rounded-16R.png',
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
                                    // imageR2y (305:12313)
                                    width: double.infinity,
                                    height: 120 * fem,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          // group1000006144ZQ5 (305:12315)
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
                                                'assets/light-design/images/rectangle-40188-bg-FiR.png',
                                              ),
                                            ),
                                          ),
                                          child: Align(
                                            // materialsymbolscheckcircleroun (305:12318)
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
                                                  'assets/light-design/images/material-symbols-check-circle-rounded-uFw.png',
                                                  width: 23.33 * fem,
                                                  height: 23.33 * fem,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          // group1000006145Vww (305:12321)
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
                                                'assets/light-design/images/rectangle-40189-bg-dof.png',
                                              ),
                                            ),
                                          ),
                                          child: Align(
                                            // materialsymbolscheckcircleroun (305:12324)
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
                                                  'assets/light-design/images/material-symbols-check-circle-rounded-Lch.png',
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
                              // photoiconandcaptionp73 (305:12326)
                              width: double.infinity,
                              height: 98 * fem,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    // takephotoKJh (305:12327)
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
                                      // cameraiconandcaptionojf (305:12328)
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            // cameraiconvZP (305:12329)
                                            margin: EdgeInsets.fromLTRB(0 * fem,
                                                0 * fem, 0 * fem, 8 * fem),
                                            width: 32 * fem,
                                            height: 32 * fem,
                                            child: Image.asset(
                                              'assets/light-design/images/camera-icon-yR3.png',
                                              width: 32 * fem,
                                              height: 32 * fem,
                                            ),
                                          ),
                                          Center(
                                            // captionqRT (305:12336)
                                            child: Text(
                                              'Take New Photo',
                                              textAlign: TextAlign.center,
                                              style: SafeGoogleFont(
                                                'Inter',
                                                fontSize: 13 * ffem,
                                                fontWeight: FontWeight.w500,
                                                height:
                                                    1.3846153846 * ffem / fem,
                                                color: const Color(0xff050505),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    // albumiconandcaptionL7K (305:12337)
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
                                          // albumiconSAM (305:12338)
                                          margin: EdgeInsets.fromLTRB(0 * fem,
                                              0 * fem, 0 * fem, 8 * fem),
                                          width: 32 * fem,
                                          height: 32 * fem,
                                          child: Image.asset(
                                            'assets/light-design/images/album-icon-rk1.png',
                                            width: 32 * fem,
                                            height: 32 * fem,
                                          ),
                                        ),
                                        Text(
                                          // captionxPb (305:12342)
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
                        // buttonh6H (305:12343)
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
                // rectangle3636PK (305:12371)
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
                // buttoniconandtextzzV (305:12372)
                left: 30 * fem,
                top: 225 * fem,
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      20 * fem, 13 * fem, 20 * fem, 13 * fem),
                  width: 315 * fem,
                  height: 362 * fem,
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(20 * fem),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // confirmicongcR (305:12373)
                        margin: EdgeInsets.fromLTRB(
                            28.5 * fem, 0 * fem, 28.5 * fem, 30 * fem),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // icon1eh (305:12374)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 0 * fem, 40 * fem),
                              width: 163 * fem,
                              height: 159 * fem,
                              child: Image.asset(
                                'assets/light-design/images/icon-bXF.png',
                                width: 163 * fem,
                                height: 159 * fem,
                              ),
                            ),
                            Container(
                              // yourrequesthasbeensentJNu (305:12392)
                              constraints: BoxConstraints(
                                maxWidth: 218 * fem,
                              ),
                              child: Text(
                                'Your request has been sent!',
                                textAlign: TextAlign.center,
                                style: SafeGoogleFont(
                                  'Inter',
                                  fontSize: 20 * ffem,
                                  fontWeight: FontWeight.w600,
                                  height: 1.25 * ffem / fem,
                                  letterSpacing: -0.2 * fem,
                                  color: const Color(0xff1e1e1e),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // smallprimaryBhb (305:12393)
                        width: double.infinity,
                        height: 57 * fem,
                        decoration: BoxDecoration(
                          color: const Color(0xffffc300),
                          borderRadius: BorderRadius.circular(12 * fem),
                        ),
                        child: Center(
                          child: Center(
                            child: Text(
                              'Back to Home',
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
