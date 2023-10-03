import 'package:flutter/material.dart';

import '../utils.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // signupsuB (331:12191)
        width: double.infinity,
        height: 812 * fem,
        decoration: const BoxDecoration(
          color: Color(0xff050505),
        ),
        child: Stack(
          children: [
            Positioned(
              // imageDCM (331:12192)
              left: 0 * fem,
              top: 0 * fem,
              child: Align(
                child: SizedBox(
                  width: 375 * fem,
                  height: 333 * fem,
                  child: Image.asset(
                    'assets/light-design/images/image-ZcD.png',
                  ),
                ),
              ),
            ),
            Positioned(
              // frame1000006404Xiq (331:12193)
              left: 0 * fem,
              top: 189 * fem,
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(24 * fem, 24 * fem, 24 * fem, 24 * fem),
                width: 375 * fem,
                height: 625 * fem,
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
                      // chooseoptionMC5 (331:12194)
                      padding: EdgeInsets.fromLTRB(
                          4 * fem, 4 * fem, 4 * fem, 4 * fem),
                      width: double.infinity,
                      height: 60 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xfff6f5ff),
                        borderRadius: BorderRadius.circular(16 * fem),
                      ),
                      child: SizedBox(
                        // frame1000006401585 (331:12195)
                        width: double.infinity,
                        height: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              // signinDVB (331:12198)
                              margin: EdgeInsets.fromLTRB(
                                  0 * fem, 0 * fem, 8 * fem, 0 * fem),
                              width: 155.5 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
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
                                      fontWeight: FontWeight.w500,
                                      height: 1.3333333333 * ffem / fem,
                                      color: const Color(0xff050505),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              // signinrHF (331:12196)
                              width: 155.5 * fem,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff7b61ff),
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
                                      fontWeight: FontWeight.w600,
                                      height: 1.3333333333 * ffem / fem,
                                      color: const Color(0xffffffff),
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
                      // frame1000006403tDw (331:12200)
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            // imputfilldBX (331:12201)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // captionAx9 (I331:12201;187:11755)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                  child: Text(
                                    'Full Name',
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
                                  // nametypingandcancelbuttonfP7 (I331:12201;187:11756)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 14 * fem, 12 * fem, 14 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffcdcdcd)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Text(
                                    'Filllo Design',
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
                            // imputfill8Gh (331:12256)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // caption4RF (I331:12256;187:11755)
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
                                  // nametypingandcancelbuttonYLR (I331:12256;187:11756)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 14 * fem, 12 * fem, 14 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffcdcdcd)),
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
                            height: 16 * fem,
                          ),
                          SizedBox(
                            // imputfillmU5 (331:12260)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // captionXCM (I331:12260;187:11755)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                  child: Text(
                                    'Phone Number',
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
                                  // nametypingandcancelbuttondmB (I331:12260;187:11756)
                                  padding: EdgeInsets.fromLTRB(
                                      12 * fem, 14 * fem, 12 * fem, 14 * fem),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: const Color(0xffcdcdcd)),
                                    borderRadius:
                                        BorderRadius.circular(12 * fem),
                                  ),
                                  child: Text(
                                    '+99 0909 7655',
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
                            // password4rV (331:12202)
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  // imputfillct1 (331:12203)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 0 * fem, 12 * fem),
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        // captionYWm (I331:12203;187:11782)
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
                                        // nametypingandcancelbutton3TX (I331:12203;187:11783)
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
                                              // passwordMDK (I331:12203;187:11702)
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
                                                    // ellipse11fUu (I331:12203;187:11703)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse12mnq (I331:12203;187:11704)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse13Vyj (I331:12203;187:11705)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse14dq3 (I331:12203;187:11706)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse15wqj (I331:12203;187:11707)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse164QZ (I331:12203;187:11708)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse17NAM (I331:12203;187:11709)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse18uAH (I331:12203;187:11710)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5 * fem,
                                                  ),
                                                  Container(
                                                    // ellipse191UD (I331:12203;187:11711)
                                                    width: 6 * fem,
                                                    height: 6 * fem,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3 * fem),
                                                      color: const Color(0xff010101),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              // eyex8Z (I331:12203;187:11712)
                                              width: 16 * fem,
                                              height: 16 * fem,
                                              child: Image.asset(
                                                'assets/light-design/images/eye-UBb.png',
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
                                Container(
                                  // termsandconditionHgd (331:12294)
                                  margin: EdgeInsets.fromLTRB(
                                      0 * fem, 0 * fem, 153 * fem, 0 * fem),
                                  width: double.infinity,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // vectorzqw (331:12295)
                                        margin: EdgeInsets.fromLTRB(0 * fem,
                                            0 * fem, 10 * fem, 0 * fem),
                                        width: 20 * fem,
                                        height: 20 * fem,
                                        child: Image.asset(
                                          'assets/light-design/images/vector-mxu.png',
                                          width: 20 * fem,
                                          height: 20 * fem,
                                        ),
                                      ),
                                      Text(
                                        // iaccepttermsconditionsVnh (331:12296)
                                        'I accept terms & conditions',
                                        style: SafeGoogleFont(
                                          'Inter',
                                          fontSize: 11 * ffem,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3636363636 * ffem / fem,
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
                      height: 30 * fem,
                    ),
                    Container(
                      // buttonccR (331:12206)
                      width: double.infinity,
                      height: 57 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffffc300),
                        borderRadius: BorderRadius.circular(12 * fem),
                      ),
                      child: Center(
                        child: Text(
                          'Sign-up',
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
    );
  }
}
