import 'package:flutter/material.dart';
import 'package:flutter_tahaddi/main.dart';
import 'package:flutter_tahaddi/newStructure/view/player/HomeScreen/Home/home-screen.dart';

import '../../../../app_colors/app_colors.dart';

class TextFieldWidget extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  InputBorder? border;
  Widget? suffix;
  Widget? prefix;
  bool enable;
  TextInputType type;
  InputBorder? enableBorder;
  FormFieldValidator? onSubmitted;
  FocusNode? focus;
  InputBorder? focusBorder;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? prefixIconColor;
  bool obscure;
  bool searchTag;
  IconData? hideIcon;
  Color? suffixIconColor;
  Color? fillColor;
  Color? textColor;
  FormFieldValidator? onValidate;
  FormFieldValidator? onChanged;
  VoidCallback? onTap;
  Widget? searchTap;

  TextFieldWidget(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onValidate,
      this.onTap,
      this.searchTag = false,
      this.enable = true,
      this.textColor,
      this.suffix,
      this.prefix,
      this.onChanged,
      this.border,
      this.searchTap,
      this.obscure = false,
      this.enableBorder,
      this.suffixIconColor,
      this.hideIcon,
      this.focusBorder,
      this.type = TextInputType.text,
      this.focus,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconColor,
      this.fillColor});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focus,
      validator: widget.onValidate,
      enabled: widget.enable,
      onTap: widget.onTap,
      keyboardType: widget.type,
      style: TextStyle(
          fontSize: widget.controller.text.length > 8 ? 12 : 14,
          color: MyAppState.mode == ThemeMode.light
              ? widget.textColor ?? AppColors.black
              : AppColors.white),
      cursorColor: MyAppState.mode == ThemeMode.light
          ? widget.textColor ?? AppColors.black
          : AppColors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          suffix: widget.suffix,
          prefix: widget.prefix,
          hintText: widget.hintText,
          errorStyle: const TextStyle(fontSize: 13, height: 0.09),
          hintStyle: TextStyle(
              height: 1,
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.grey
                  : AppColors.white),
          border: widget.border,
          suffixIcon: widget.searchTag
              ? widget.searchTap
              : widget.suffixIcon != null
                  ? widget.hideIcon != null
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              widget.obscure = !widget.obscure;
                            });
                          },
                          child: Icon(widget.obscure
                              ? widget.hideIcon
                              : widget.suffixIcon))
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

class textFieldWidgetMulti extends StatefulWidget {
  TextEditingController controller;
  String hintText;
  InputBorder? border;
  Widget? suffix;
  Widget? prefix;
  bool enable;
  TextInputType? type;
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
  FormFieldValidator? onValidate;
  FormFieldValidator? onChanged;
  VoidCallback? onTap;
  int? maxLines;

  textFieldWidgetMulti(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onValidate,
      this.onTap,
      this.maxLines,
      this.enable = true,
      this.textColor,
      this.suffix,
      this.prefix,
      this.onChanged,
      this.border,
      this.obscure = false,
      this.enableBorder,
      this.suffixIconColor,
      this.hideIcon,
      this.focusBorder,
      this.type,
      this.focus,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.prefixIconColor,
      this.fillColor});

  @override
  State<textFieldWidgetMulti> createState() => _textFieldWidgetMultiState();
}

class _textFieldWidgetMultiState extends State<textFieldWidgetMulti> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.obscure,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focus,
      validator: widget.onValidate,
      enabled: widget.enable,
      onTap: widget.onTap,
      keyboardType: widget.type,
      style: TextStyle(
          fontSize: widget.controller.text.length > 8 ? 12 : 14,
          color: MyAppState.mode == ThemeMode.light
              ? widget.textColor ?? AppColors.black
              : AppColors.white),
      cursorColor: MyAppState.mode == ThemeMode.light
          ? widget.textColor ?? AppColors.black
          : AppColors.white,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      textAlign: TextAlign.start,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
          suffix: widget.suffix,
          prefix: widget.prefix,
          hintText: widget.hintText,
          errorStyle: const TextStyle(fontSize: 13, height: 0.09),
          hintStyle: TextStyle(
              height: 1,
              color: MyAppState.mode == ThemeMode.light
                  ? AppColors.grey
                  : AppColors.white),
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
