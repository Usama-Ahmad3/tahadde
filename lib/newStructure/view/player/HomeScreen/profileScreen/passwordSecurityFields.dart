import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../app_colors/app_colors.dart';

class PasswordSecurity extends StatelessWidget {
  IconData prefixIcon;
  String title;
  IconData suffixIcon;

  PasswordSecurity(
      {super.key,
      required this.suffixIcon,
      required this.prefixIcon,
      required this.title});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.012),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        width: double.infinity,
        height: height * 0.075,
        decoration: BoxDecoration(
          color: MyAppState.mode == ThemeMode.light
              ? const Color(0xffffffff)
              : AppColors.containerColorB,
          borderRadius: BorderRadius.circular(height * 0.01),
          border: Border.all(
              color: MyAppState.mode == ThemeMode.light
                  ? const Color(0xfff2f2f2)
                  : const Color(0xff050505)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: height * 0.01),
                  child: CircleAvatar(
                    radius: height * 0.023,
                    backgroundColor: MyAppState.mode == ThemeMode.light
                        ? AppColors.grey200
                        : AppColors.grey,
                    child: Icon(
                      prefixIcon,
                      color: MyAppState.mode == ThemeMode.light
                          ? const Color(0xff050505)
                          : AppColors.white,
                    ),
                  ),
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: height * 0.018,
                    color: MyAppState.mode == ThemeMode.light
                        ? const Color(0xff050505)
                        : AppColors.white,
                  ),
                )
              ],
            ),
            Icon(
              (suffixIcon),
              color: MyAppState.mode == ThemeMode.light
                  ? const Color(0xff050505)
                  : AppColors.white,
            )
          ],
        ),
      ),
    );
  }
}
