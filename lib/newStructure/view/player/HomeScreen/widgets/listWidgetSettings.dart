import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/app_colors/app_colors.dart';

import '../../../../../localizations.dart';
import '../../../../../main.dart';

class ListWidgetSettings extends StatelessWidget {
  String title;
  IconData icon;
  VoidCallback callback;
  ListWidgetSettings(
      {super.key,
      required this.callback,
      required this.title,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: height * 0.01,
      ),
      child: Container(
        height: height * 0.09,
        decoration: BoxDecoration(
            color: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.containerColorW12,
            borderRadius: BorderRadius.circular(13)),
        child: Center(
          child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            tileColor: MyAppState.mode == ThemeMode.light
                ? AppColors.grey200
                : AppColors.containerColorW12,
            onTap: callback,
            shape: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.containerColorW12),
                borderRadius: BorderRadius.circular(10)),
            leading: Icon(
              icon,
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.black
                  : AppColors.white,
            ),
            titleTextStyle: const TextStyle(
                leadingDistribution: TextLeadingDistribution.even),
            title: Text(
              title,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white,
                  fontSize: 14),
            ),
            trailing: Icon(
              AppLocalizations.of(context)!.locale == 'en'
                  ? Icons.keyboard_arrow_right
                  : Icons.keyboard_arrow_left,
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.black
                  : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
