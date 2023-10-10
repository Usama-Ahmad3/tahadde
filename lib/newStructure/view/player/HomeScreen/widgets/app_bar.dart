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
        leadingWidth: back ? sizeWidth * 0.18 : 0,
        leading: back
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      padding: EdgeInsets.all(sizeHeight * 0.008),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey),
                          shape: BoxShape.circle),
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.close,
                          color: AppColors.white,
                        ),
                      )),
                ),
              )
            : null,
      ));
}
