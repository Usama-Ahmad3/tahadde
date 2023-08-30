import 'package:flutter/material.dart';

import '../utils.dart';

class HomeScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 1211;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // homescreens9bP (327:21338)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 984 * fem, 50 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectoryKX (327:21341)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-c4y.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // homeeAm (327:21340)
              'HOME ',
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
