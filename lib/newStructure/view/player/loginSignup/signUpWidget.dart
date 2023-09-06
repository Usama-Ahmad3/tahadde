import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/widgets/buttonWidget.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';

import '../../../../constant.dart';
import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../network/network_calls.dart';
import '../HomeScreen/widgets/textFormField.dart';
import 'login.dart';

class SignUpWidget extends StatefulWidget {
  var nameController;
  var lastnameController;
  var emailController;
  var passwordController;
  var phoneController;
  var confirmController;
  var onChanged;
  var onChangedController;
  VoidCallback signUp;
  var player;

  SignUpWidget(
      {super.key,
      required this.signUp,
      required this.player,
      required this.onChangedController,
      required this.lastnameController,
      required this.confirmController,
      required this.phoneController,
      required this.passwordController,
      required this.onChanged,
      required this.emailController,
      required this.nameController});

  @override
  State<SignUpWidget> createState() => SignUpWidgetState();
}

class SignUpWidgetState extends State<SignUpWidget> {
  FocusNode lastnameFocus = FocusNode();
  static FocusNode phoneFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode emailFocus = FocusNode();
  FocusNode confirmFocus = FocusNode();
  String _initialCountry = '+971';
  final NetworkCalls _networkCalls = NetworkCalls();
  static String? player;
  List<String> playerEn = ["player", "Owner"];
  List<String> genderAr = ["ذكر", "أنثى"];

  privacyPolicy(String text) async {
    _networkCalls.privacyPolicy(
      onSuccess: (msg) {
        launchInBrowser(msg[text]);
      },
      onFailure: (msg) {
        showMessage(msg);
      },
      tokenExpire: () {
        if (mounted) on401(context);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    LoginScreenState.isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.01),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: height * 0.02, color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.name,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            textFieldWidget(
              controller: widget.nameController,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(lastnameFocus);
              },
              hintText: 'tahadde',
              enableBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              focusBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.lastName,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            textFieldWidget(
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(emailFocus);
              },
              focus: lastnameFocus,
              controller: widget.lastnameController,
              hintText: 'MobileApp',
              focusBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              enableBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.email,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            textFieldWidget(
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(passwordFocus);
              },
              focus: emailFocus,
              controller: widget.emailController,
              onTaped: (value) {
                var msg;
                if (!isMail(value!.trim())) {
                  msg = AppLocalizations.of(context)!.invalidEmail;
                }
                return msg;
              },
              hintText: 'tahadde@gmail.com',
              enableBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              focusBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.password,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            textFieldWidget(
              onSubmitted: (value) {
                UtilsSign.focusChange(confirmFocus, context);
              },
              focus: passwordFocus,
              controller: widget.passwordController,
              hintText: 'tahadde123456',
              obscure: true,
              suffixIcon: Icons.visibility_off,
              hideIcon: Icons.visibility,
              suffixIconColor: Colors.grey,
              onTaped: (e) {
                validatePassword(e.toString());
              },
              enableBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              focusBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.confermpassword,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            textFieldWidget(
              onSubmitted: (value) {
                UtilsSign.focusChange(phoneFocus, context);
              },
              focus: confirmFocus,
              obscure: true,
              controller: widget.confirmController,
              hintText: 'tahadde123456',
              suffixIcon: Icons.visibility_off,
              hideIcon: Icons.visibility,
              suffixIconColor: Colors.grey,
              focusBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              enableBorder: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
              border: OutlineInputBorder(
                  borderSide: MyAppState.mode == ThemeMode.light
                      ? BorderSide.none
                      : const BorderSide(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              AppLocalizations.of(context)!.phoneNumber,
              style: TextStyle(
                  color: MyAppState.mode == ThemeMode.light
                      ? Colors.black
                      : Colors.white),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AppLocalizations.of(context)!.locale == "en"
                    ? CountryCodePicker(
                        padding: const EdgeInsets.only(top: 5),
                        textStyle: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? const Color(0XFF032040)
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        onChanged: widget.onChanged,
                        initialSelection: _initialCountry,
                        favorite: const [
                          '+971',
                          'ae',
                        ],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    width: width * .5,
                    alignment: Alignment.topCenter,
                    child: textField(
                      testAlignment:
                          AppLocalizations.of(context)!.locale == "en"
                              ? true
                              : false,
                      node: phoneFocus,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return AppLocalizations.of(context)!
                              .pleaseenterPhoneNumber;
                        }
                        return '';
                      },
                      controller: widget.phoneController,
                      text: false,
                      text1: true,
                      keybordType: false,
                      name: "",
                      onchange: widget.onChangedController,
                      onSaved: (value) {},
                    ),
                  ),
                ),
                AppLocalizations.of(context)!.locale == "ar"
                    ? CountryCodePicker(
                        padding: const EdgeInsets.only(top: 5),
                        textStyle: TextStyle(
                            color: MyAppState.mode == ThemeMode.light
                                ? const Color(0XFF032040)
                                : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        onChanged: widget.onChanged,
                        initialSelection: _initialCountry,
                        favorite: const [
                          '+971',
                          'ae',
                        ],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        alignLeft: false,
                      )
                    : Container(),
              ],
            ),
            SizedBox(
              height: height * 0.02,
            ),
            AppLocalizations.of(context)!.locale == "en"
                ? SizedBox(
                    height: height * .07,
                    width: width,
                    child: Center(
                      child: DropdownButton<String>(
                          underline: Container(
                            height: 1,
                            color: const Color(0XFF9F9F9F),
                          ),
                          dropdownColor: Colors.blueGrey,
                          iconEnabledColor: const Color(0XFF9B9B9B),
                          focusColor: const Color(0XFF9B9B9B),
                          isExpanded: true,
                          value: player,
                          hint: Text(
                            AppLocalizations.of(context)!.chooseAccount,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          items: playerEn
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))
                              .toList(),
                          onChanged: widget.player),
                    ),
                  )
                : SizedBox(
                    height: height * .07,
                    width: width,
                    child: Center(
                      child: DropdownButton<String>(
                          underline: Container(
                            height: 1,
                            color: const Color(0XFF9F9F9F),
                          ),
                          iconEnabledColor: const Color(0XFF9B9B9B),
                          focusColor: const Color(0XFF9B9B9B),
                          isExpanded: true,
                          value: player,
                          hint: Text(
                            AppLocalizations.of(context)!.gender,
                            style: TextStyle(
                                color: MyAppState.mode == ThemeMode.light
                                    ? const Color(0XFF032040)
                                    : Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          items: genderAr
                              .map((value) => DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(
                                          color:
                                              MyAppState.mode == ThemeMode.light
                                                  ? const Color(0XFF032040)
                                                  : Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12),
                                    ),
                                  ))
                              .toList(),
                          onChanged: widget.player),
                    ),
                  ),
            ButtonWidget(
                onTaped: widget.signUp,
                title: Text(AppLocalizations.of(context)!.signUp)),
            SizedBox(
              height: height * 0.015,
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: RichText(
                  text: TextSpan(
                    text:
                        '${AppLocalizations.of(context)!.bysigningupTahaddi} ',
                    style:
                        const TextStyle(fontSize: 12, color: Color(0XFF7A7A7A)),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(context)!.termsofUse,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            privacyPolicy("terms_and_conditions_url");
                          },
                        style: const TextStyle(
                          color: Color(0XFF25A163),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' ${AppLocalizations.of(context)!.and} ',
                      ),
                      TextSpan(
                          text: AppLocalizations.of(context)!.privacyPolicy,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              privacyPolicy("privacy_policy_url");
                            },
                          style: const TextStyle(
                            color: Color(0XFF25A163),
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return AppLocalizations.of(context)!.minimumMaximum14Characters;
    }
    return '';
  }
}
