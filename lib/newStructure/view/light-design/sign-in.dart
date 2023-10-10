import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // signinWkh (204:11588)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xff050505),
        ),
        child: Stack(
          children: [
            Positioned(
              // imageSuF (204:11589)
              left: 0 * fem,
              top: 0 * fem,
              child: Align(
                child: SizedBox(
                  width: 375 * fem,
                  height: 333 * fem,
                  child: Image.asset(
                    'assets/light-design/images/image-bzH.png',
                  ),
                ),
              ),
            ),
            Positioned(
              // frame1000006404wLD (331:12190)
              left: 0 * fem,
              top: 289 * fem,
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 24 * fem),
                width: 375 * fem,
                height: 523 * fem,
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
                      // chooseoptionNRX (209:11783)
                      padding: EdgeInsets.fromLTRB(
                          4 * fem, 4 * fem, 4 * fem, 4 * fem),
                      width: double.infinity,
                      height: 60 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f5ff),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: SizedBox(
                        // frame1000006401GWu (331:12155)
                        width: double.infinity,
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // signincam (209:11781)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 8 * fem, 0 * fem),
                              width: 155.5 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff7b61ff),
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Log In',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // signinUN5 (331:12153)
                              width: 155.5 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12 * fem),
                              ),
                              child: Center(
                                child: Center(
                                  child: Text(
                                    'Create Account',
                                    textAlign: TextAlign.center,
                                    style: SafeGoogleFont(
                                      'Inter',
                                      fontSize: 15 * ffem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.3333333333 * ffem / fem,
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
                    SizedBox(
                      height: 30 * fem,
                    ),
                    SizedBox(
                      // frame10000064038Sd (331:12189)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // imputfillGoj (204:11595)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 0 * fem, 0 * fem, 16 * fem),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // captionzUq (I204:11595;187:11755)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                  child: Text(
                                    'Email',
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
                                  // nametypingandcancelbuttontKK (I204:11595;187:11756)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 14 * fem, 12 * fem, 14 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffcdcdcd)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Text(
                                    'hello@filllo.com',
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
                            // passwordLh7 (331:12156)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // imputfillhGm (204:11602)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 16 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captiondAR (I204:11602;187:11782)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 0 * fem, 12 * fem),
                                        child: Text(
                                          'Password',
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
                                        // nametypingandcancelbutton9Pf (I204:11602;187:11783)
                                        padding: EdgeInsets.fromLTRB(12 * fem,
                                            16 * fem, 12 * fem, 16 * fem),
                                        width: double.infinity,
                                        height: 48 * fem,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xffcdcdcd)),
                                          borderRadius:
                                              BorderRadius.circular(12 * fem),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              // passwordBLM (I204:11602;187:11702)
                                              margin: EdgeInsets.fromLTRB(
                                                  0 * fem,
                                                  5 * fem,
                                                  193 * fem,
                                                  5 * fem),
                                              height: double.infinity,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    // ellipse11u1T (I204:11602;187:11703)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse12pPK (I204:11602;187:11704)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse13LsT (I204:11602;187:11705)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse14ssP (I204:11602;187:11706)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse15SJD (I204:11602;187:11707)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse16Mvy (I204:11602;187:11708)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse175MB (I204:11602;187:11709)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse18bKX (I204:11602;187:11710)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse198KT (I204:11602;187:11711)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(
                                                          0xff010101),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              // eyeEtH (I204:11602;187:11712)
                                              width: 16 * fem,
                                              height: 16 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/eye-wWR.png',
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
                                Text(
                                  // forgotpasswordZff (204:11632)
                                  'Forgot Password?',
                                  style: SafeGoogleFont(
                                    'Inter',
                                    fontSize: 13 * ffem,
                                    fontWeight: FontWeight.w500,
                                    height: 1.3846153846 * ffem / fem,
                                    color: const Color(0xffff0d0d),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30 * fem,
                    ),
                    SizedBox(
                      // frame1000006402tC9 (331:12188)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            // button2JM (204:11633)
                            width: double.infinity,
                            height: 57 * fem,
                            decoration: BoxDecoration(
                              color: const Color(0xffffc300),
                              borderRadius: BorderRadius.circular(12 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'Log In',
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
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Center(
                            // or5XX (204:11659)
                            child: Text(
                              'OR',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Inter',
                                fontSize: 15 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3333333333 * ffem / fem,
                                color: const Color(0xff696969),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16 * fem,
                          ),
                          Container(
                            // group1000006151Aos (331:12160)
                            margin: EdgeInsets.fromLTRB(
                                97.5 * fem, 0 * fem, 97.5 * fem, 0 * fem),
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  // appleV5T (331:12161)
                                  width: 36 * fem,
                                  height: 36 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/apple.png',
                                    width: 36 * fem,
                                    height: 36 * fem,
                                  ),
                                ),
                                SizedBox(
                                  width: 12 * fem,
                                ),
                                SizedBox(
                                  // facebookorq (331:12167)
                                  width: 36 * fem,
                                  height: 36 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/facebook.png',
                                    width: 36 * fem,
                                    height: 36 * fem,
                                  ),
                                ),
                                SizedBox(
                                  width: 12 * fem,
                                ),
                                SizedBox(
                                  // googleXnq (331:12171)
                                  width: 36 * fem,
                                  height: 36 * fem,
                                  child: Image.asset(
                                    'assets/light-design/images/google.png',
                                    width: 36 * fem,
                                    height: 36 * fem,
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
    );
  }
}
