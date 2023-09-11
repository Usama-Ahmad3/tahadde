import 'package:flutter/material.dart';

import '../../../../../localizations.dart';
import '../../loginSignup/login.dart';

class ButtonWidget extends StatefulWidget {
  VoidCallback onTaped;
  Widget title;
  bool isLoading;

  ButtonWidget(
      {super.key,
      required this.onTaped,
      required this.title,
      required this.isLoading});

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onTaped,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.01, vertical: height * 0.01),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.yellow, borderRadius: BorderRadius.circular(10)),
          height: height * 0.06,
          child: Center(
              child: widget.isLoading
                  ? const CircularProgressIndicator()
                  : widget.title),
        ),
      ),
    );
  }
}
