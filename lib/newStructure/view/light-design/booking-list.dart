import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BookingList extends StatelessWidget {
  const BookingList({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1205;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // bookinglist3H3 (323:13537)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 893 * fem, 50 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vector6FK (323:13540)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-8PK.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // bookinglistMBF (323:13539)
              'BOOKING LIST',
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
