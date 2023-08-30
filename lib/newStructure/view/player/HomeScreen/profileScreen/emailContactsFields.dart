import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';

import '../../../utils.dart';

class EmailContactDOB extends StatelessWidget {
  String constant;
  String constantValue;

  EmailContactDOB(
      {super.key, required this.constant, required this.constantValue});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.012),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        width: double.infinity,
        height: height * 0.05,
        decoration: BoxDecoration(
          border: Border.all(
              color: MyAppState.mode == ThemeMode.light
                  ? Color(0xfff2f2f2)
                  : Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              constant,
              overflow: TextOverflow.ellipsis,
              style: SafeGoogleFont(
                'Inter',
                fontSize: height * 0.02,
                fontWeight: FontWeight.w500,
                color: MyAppState.mode == ThemeMode.light
                    ? Color(0xff050505)
                    : Colors.white,
              ),
            ),
            Text(
              constantValue,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: SafeGoogleFont(
                'Inter',
                fontSize: height * 0.017,
                fontWeight: FontWeight.w500,
                color: MyAppState.mode == ThemeMode.light
                    ? Color(0xff686868)
                    : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
