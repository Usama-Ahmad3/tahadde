import 'package:flutter/material.dart';

import '../utils.dart';

class AddBankCard2 extends StatelessWidget {
  const AddBankCard2({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1205;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // addbankcardEkZ (303:12467)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 861 * fem, 50 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectoreJV (303:12470)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-pbK.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // addbankcard9m3 (303:12469)
              'ADD BANK CARD',
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
