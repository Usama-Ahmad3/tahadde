import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';

import '../../../../localizations.dart';
import '../../../app_colors/app_colors.dart';
import '../HomeScreen/widgets/textFormField.dart';

class LogInWidget extends StatefulWidget {
  var emailController;
  var passwordController;
  VoidCallback onTap;
  VoidCallback forgetTap;
  bool loading;

  LogInWidget(
      {super.key,
      required this.forgetTap,
      required this.loading,
      required this.onTap,
      required this.emailController,
      required this.passwordController});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  FocusNode? focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.01),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: height * 0.02, color: AppColors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.email,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            SizedBox(
              height: height * 0.07,
              child: TextFieldWidget(
                onSubmitted: (value) {
                  UtilsSign.focusChange(focusPassword, context);
                  return null;
                },
                onValidate: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseenterEmail;
                  }
                  return null;
                },
                controller: widget.emailController,
                hintText: 'tahadde@gmail.com',
                focusBorder: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                enableBorder: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.password,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? AppColors.black
                      : AppColors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            SizedBox(
              height: height * 0.07,
              child: TextFieldWidget(
                focus: focusPassword,
                obscure: true,
                onValidate: (value) {
                  if (value.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseenterPassword;
                  }
                  return null;
                },
                controller: widget.passwordController,
                hintText: 'tahadde123456',
                suffixIcon: Icons.visibility_off,
                hideIcon: Icons.visibility,
                suffixIconColor: AppColors.grey,
                focusBorder: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                enableBorder: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderSide: MyAppState.mode == ThemeMode.light
                        ? BorderSide.none
                        : BorderSide(color: AppColors.white, width: 1),
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            InkWell(
              onTap: widget.forgetTap,
              child: Text(AppLocalizations.of(context)!.forgotPassword,
                  style: TextStyle(color: AppColors.red)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            ButtonWidget(
                isLoading: widget.loading,
                onTaped: widget.onTap,
                title: Text(
                  AppLocalizations.of(context)!.login,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: AppColors.white),
                )),
            SizedBox(
              height: height * 0.015,
            ),
            Align(
                alignment: Alignment.center,
                child: Text(
                  AppLocalizations.of(context)!.orSignUpWith,
                  style: TextStyle(
                      color: MyAppState.mode == ThemeMode.light
                          ? AppColors.black
                          : AppColors.white),
                )),
          ],
        ),
      ),
    );
  }
}
