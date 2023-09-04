import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/newStructure/view/player/loginSignup/UtilsSignin.dart';

import '../../../../homeFile/utility.dart';
import '../../../../localizations.dart';
import '../../../../network/network_calls.dart';
import '../HomeScreen/Home/textFormField.dart';
import 'login.dart';

class LogInWidget extends StatefulWidget {
  var emailController;
  var passwordController;
  VoidCallback onTap;
  VoidCallback forgetTap;

  LogInWidget(
      {super.key,
      required this.forgetTap,
      required this.onTap,
      required this.emailController,
      required this.passwordController});

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  FocusNode? focusPassword = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final NetworkCalls _networkCalls = NetworkCalls();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.06, vertical: height * 0.01),
      child: DefaultTextStyle(
        style: TextStyle(fontSize: height * 0.02, color: Colors.black),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppLocalizations.of(context)!.login),
              SizedBox(
                height: height * 0.015,
              ),
              textFieldWidget(
                onSubmitted: (value) {
                  UtilsSign.focusChange(focusPassword, context);
                },
                onTaped: (value) {
                  return AppLocalizations.of(context)!.pleaseenterEmail;
                },
                controller: widget.emailController,
                hintText: 'tahadde@gmail.com',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              Text(AppLocalizations.of(context)!.password),
              SizedBox(
                height: height * 0.015,
              ),
              textFieldWidget(
                  focus: focusPassword,
                  obscure: true,
                  onTaped: (value) {
                    return AppLocalizations.of(context)!.pleaseenterPassword;
                  },
                  controller: widget.passwordController,
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
              InkWell(
                onTap: widget.forgetTap,
                child: Text(AppLocalizations.of(context)!.forgotPassword,
                    style: const TextStyle(color: Colors.red)),
              ),
              SizedBox(
                height: height * 0.02,
              ),
              InkWell(
                onTap: widget.onTap,
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
                            : Text(AppLocalizations.of(context)!.login)),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(AppLocalizations.of(context)!.orSignUpWith)),
            ],
          ),
        ),
      ),
    );
  }
}
