import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BookingProcess extends StatelessWidget {
  const BookingProcess({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1205;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // bookingprocesseG9 (311:13871)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 836 * fem, 50 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectorj2h (311:13874)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-Qqf.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // bookingprocessSSu (311:13873)
              'BOOKING PROCESS',
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
