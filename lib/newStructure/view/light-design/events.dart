import 'package:flutter/material.dart';

import '../utils.dart';

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 1205;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // eventsdEq (319:12928)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 973 * fem, 50 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectorJ65 (319:12931)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-Pyj.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // eventsCx9 (319:12930)
              'EVENTS',
              style: SafeGoogleFont(
                'Google Sans',
                fontSize: 32 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.15625 * ffem / fem,
                color: Color(0xff050505),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
