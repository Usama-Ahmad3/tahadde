import 'package:flutter/material.dart';

import '../utils.dart';

class NotificationH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Container(
      width: double.infinity,
      child: Container(
        // notificationYyf (303:12083)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 70 * fem, 50 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectorz4y (303:12086)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // notification6do (303:12085)
              'NOTIFICATION',
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
