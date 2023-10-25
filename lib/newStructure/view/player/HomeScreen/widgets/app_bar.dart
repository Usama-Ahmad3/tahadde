import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../app_colors/app_colors.dart';

PreferredSize appBarWidget(sizeWidth, sizeHeight, context, title, back) {
  return PreferredSize(
      preferredSize: Size(sizeWidth, sizeHeight * 0.105),
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
        leadingWidth: back ? sizeWidth * 0.13 : 0,
        leading: back
            ? InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SizedBox(
                    height: sizeHeight * 0.03,
                    child: Image.asset(
                      'assets/images/back.png',
                      color: AppColors.white,
                    )),
              )
            : null,
      ));
}
