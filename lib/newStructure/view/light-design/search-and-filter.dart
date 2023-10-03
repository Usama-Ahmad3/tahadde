import 'package:flutter/material.dart';

import '../utils.dart';

class SearchFilter extends StatelessWidget {
  const SearchFilter({super.key});

  @override
  Widget build(BuildContext context) {
    double baseWidth = 1620;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return SizedBox(
      width: double.infinity,
      child: Container(
        // searchandfilterKKF (322:14124)
        padding: EdgeInsets.fromLTRB(60 * fem, 49 * fem, 1242 * fem, 50 * fem),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              // vectorP4D (322:14127)
              margin: EdgeInsets.fromLTRB(0 * fem, 1 * fem, 41 * fem, 0 * fem),
              width: 36 * fem,
              height: 36 * fem,
              child: Image.asset(
                'assets/light-design/images/vector-y4m.png',
                width: 36 * fem,
                height: 36 * fem,
              ),
            ),
            Text(
              // searchandfiltereF3 (322:14126)
              'SEARCH AND FILTER',
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
