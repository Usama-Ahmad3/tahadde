import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/localizations.dart';
import 'package:flutter_tahaddi/main.dart';

import '../../../../app_colors/app_colors.dart';
import '../widgets/textFormField.dart';

class EmailContactDOB extends StatelessWidget {
  String constant;
  String constantValue;
  bool slotNavigate;
  VoidCallback? onTap;
  TextEditingController? price;

  EmailContactDOB(
      {super.key,
      this.onTap,
      this.price,
      required this.constant,
      required this.constantValue,
      this.slotNavigate = false});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: slotNavigate
          ? () {
              showDialog(
                  context: context,
                  builder: (BuildContext cntext) {
                    return SizedBox(
                      height: height * 0.3,
                      child: AlertDialog(
                        elevation: 2,
                        backgroundColor: MyAppState.mode == ThemeMode.light
                            ? AppColors.grey200
                            : AppColors.darkTheme,
                        shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text(
                          AppLocalizations.of(context)!.price,
                          style: TextStyle(
                              color: MyAppState.mode == ThemeMode.light
                                  ? AppColors.black
                                  : AppColors.white),
                        ),
                        content: SizedBox(
                          height: height * 0.12,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.pricePerPlayer,
                                style: TextStyle(
                                    color: MyAppState.mode == ThemeMode.light
                                        ? AppColors.themeColor
                                        : AppColors.white),
                              ),
                              SizedBox(
                                height: height * 0.01,
                              ),
                              TextFieldWidget(
                                  controller: price!,
                                  hintText: '',
                                  type: TextInputType.number,
                                  prefix: const Text(
                                    "Amount: ",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  suffix: const Text(
                                    " AED",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onSubmitted: (value) {
                                    // FocusScope.of(context).requestFocus(arabicFocus);
                                    return null;
                                  },
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  enableBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  focusBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: AppColors.grey),
                                      borderRadius: BorderRadius.circular(12))),
                            ],
                          ),
                        ),
                        actions: [
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop(false);
                              },
                              child: Center(
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.appThemeColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.no,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: AppColors.white),
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: onTap,
                            child: Center(
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.appThemeColor,
                                  border: Border.all(
                                      width: 1, color: AppColors.white),
                                ),
                                child: Center(
                                  child: Text(
                                    AppLocalizations.of(context)!.saveChanges,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: AppColors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          : () {},
      child: Padding(
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
                suffixIcon: slotNavigate ? Icons.edit_outlined : null,
                fillColor: AppColors.containerColorW12,
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
      ),
    );
  }
}
