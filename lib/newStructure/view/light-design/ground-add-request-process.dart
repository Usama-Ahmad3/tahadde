import 'package:flutter/material.dart';

import '../utils.dart';

class GroundAddRequest extends StatelessWidget {
  const GroundAddRequest({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1620;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // groundaddrequestprocessGcy (305:12395)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 1080 * fem, 50 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectorZc5 (305:12398)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-Aqf.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // groundaddrequestprocessPLD (305:12397)
              'GROUND ADD REQUEST PROCESS',
              style: SafeGoogleFont(
                'Google Sans',
                fontSize: 32 * ffem,
                fontWeight: FontWeight.w700,
                height: 1.15625 * ffem / fem,
                color: const Color(0xff050505),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
