import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';

import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../network/network_calls.dart';
import '../HomeScreen/Home/textFormField.dart';
import 'login.dart';

class SignUpWidget extends StatefulWidget {
  var nameController;
  var lastnameController;
  var emailController;
  var passwordController;
  var phoneController;
  var confirmController;
  var onChanged;
  VoidCallback signUp;

  SignUpWidget(
      {super.key,
      required this.signUp,
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
  final NetworkCalls _networkCalls = NetworkCalls();

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
            Text(AppLocalizations.of(context)!.name),
            SizedBox(
              height: height * 0.015,
            ),
            textFieldWidget(
              controller: widget.nameController,
              onSubmitted: (value) {
                FocusScope.of(context).requestFocus(lastnameFocus);
              },
              hintText: 'tahadde',
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(AppLocalizations.of(context)!.lastName),
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(AppLocalizations.of(context)!.email),
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
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(AppLocalizations.of(context)!.password),
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
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20))),
            SizedBox(
              height: height * 0.02,
            ),
            Text(AppLocalizations.of(context)!.confermpassword),
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
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20))),
            SizedBox(
              height: height * 0.02,
            ),
            Text(AppLocalizations.of(context)!.phoneNumber),
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
                        textStyle: const TextStyle(
                            color: Color(0XFF032040),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        onChanged: widget.onChanged,
                        initialSelection: 'ae',
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
                      onchange: widget.onChanged,
                      onSaved: (value) {},
                    ),
                  ),
                ),
                AppLocalizations.of(context)!.locale == "ar"
                    ? CountryCodePicker(
                        padding: const EdgeInsets.only(top: 5),
                        textStyle: const TextStyle(
                            color: Color(0XFF032040),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        onChanged: widget.onChanged,
                        initialSelection: 'ae',
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
            InkWell(
              onTap: widget.signUp,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.01, vertical: height * 0.01),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(10)),
                  height: height * 0.06,
                  child: Center(
                      child: LoginScreenState.isLoading
                          ? const CircularProgressIndicator()
                          : Text(AppLocalizations.of(context)!.signUp)),
                ),
              ),
            ),
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
}
