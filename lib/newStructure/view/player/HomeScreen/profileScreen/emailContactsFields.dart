import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';

import '../../../../app_colors/app_colors.dart';
import '../widgets/textFormField.dart';

class EmailContactDOB extends StatelessWidget {
  String constant;
  String constantValue;

  EmailContactDOB(
      {super.key, required this.constant, required this.constantValue});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.059, vertical: height * 0.012),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            constant,
            style: TextStyle(
                color: MyAppState.mode == ThemeMode.light
                    ? AppColors.black
                    : AppColors.white),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          SizedBox(
            height: height * 0.062,
            child: TextFieldWidget(
              controller: controller,
              enable: false,
              hintText: constantValue,
              suffixIcon: Icons.edit_outlined,
              fillColor: Colors.transparent,
              suffixIconColor: MyAppState.mode == ThemeMode.light
                  ? AppColors.black
                  : AppColors.white,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(12)),
              enableBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(12)),
              focusBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColors.grey),
                  borderRadius: BorderRadius.circular(12)),
              onSubmitted: (value) {
                // UtilsSign.focusChange(lastFocus, context);
                return null;
              },
              onValidate: (value) {
                if (value.isEmpty) {
                  return AppLocalizations.of(context)!.pleaseenterFirstName;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
