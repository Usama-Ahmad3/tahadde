import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';

class textFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  InputBorder? border;
  InputBorder? enableBorder;
  FormFieldValidator? onSubmitted;
  FocusNode? focus;
  InputBorder? focusBorder;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? prefixIconColor;
  bool obscure;
  IconData? hideIcon;
  Color? suffixIconColor;
  Color? fillColor;
  Color? textColor;
  FormFieldValidator? onTaped;
  FormFieldValidator? onChanged;

  textFieldWidget(
      {required this.controller,
      required this.hintText,
      this.onTaped,
      this.textColor,
      this.onChanged,
      this.border,
      this.obscure = false,
      this.enableBorder,
      this.suffixIconColor,
      this.hideIcon,
      this.focusBorder,
      this.focus,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconColor,
      this.fillColor});

  @override
  State<textFieldWidget> createState() => _textFieldWidgetState();
}

class _textFieldWidgetState extends State<textFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focus,
      validator: widget.onTaped,
      style: TextStyle(
          color: MyAppState.mode == ThemeMode.light
              ? widget.textColor ?? Colors.black
              : Colors.white),
      cursorColor: MyAppState.mode == ThemeMode.light
          ? widget.textColor ?? Colors.black
          : Colors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scribbleEnabled: false,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          constraints: BoxConstraints(maxHeight: 55, minHeight: 55),
          hintText: widget.hintText,
          hintStyle: TextStyle(
              height: 1.33,
              color: MyAppState.mode == ThemeMode.light
                  ? Colors.grey
                  : Colors.white),
          border: widget.border,
          suffixIcon: widget.suffixIcon != null
              ? widget.hideIcon != null
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          widget.obscure = !widget.obscure;
                        });
                      },
                      child: Icon(
                          widget.obscure ? widget.hideIcon : widget.suffixIcon))
                  : Icon(widget.suffixIcon)
              : null,
          suffixIconColor: widget.suffixIconColor,
          prefixIcon:
              widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
          fillColor: widget.fillColor,
          filled: true,
          enabledBorder: widget.enableBorder,
          focusedBorder: widget.focusBorder,
          prefixIconColor: widget.prefixIconColor),
    );
  }
}
