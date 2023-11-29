import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../homeFile/utility.dart';
import '../../../../app_colors/app_colors.dart';

PreferredSize appBarForCreatingAcademy(
    size, context, title, back,color2,color3, color4, color5) {
  return PreferredSize(
      preferredSize: Size(size.width, size.height * 0.105),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: AppColors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.black,
        leadingWidth: size.width * 0.13,
        leading: back
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: size.height * 0.03,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: AppColors.white,
                    )),
              )
            : null,
        bottom: PreferredSize(
          preferredSize: Size(size.width, 10),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.035),
            child: Row(
              children: [
                Container(
                    height: size.height * .005,
                    width: size.width * .17,
                    color: AppColors.appThemeColor),
                flaxibleGap(1),
                Container(
                  height: size.height * .005,
                  width: size.width * .17,
                  color: color2,
                ),
                flaxibleGap(1),
                Container(
                    height: size.height * .005,
                    width: size.width * .17,
                    color: color3),
                flaxibleGap(1),
                Container(
                  height: size.height * .005,
                  width: size.width * .17,
                  color: color4,
                ),
                flaxibleGap(1),
                Container(
                    height: size.height * .005,
                    width: size.width * .17,
                    color: color5),
              ],
            ),
          ),
        ),
      ));
}
