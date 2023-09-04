import 'package:flutter/material.dart';

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
  FormFieldValidator? onTaped;

  textFieldWidget(
      {required this.controller,
      required this.hintText,
      this.onTaped,
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
      onChanged: (e) {
        setState(() {});
      },
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focus,
      validator: widget.onTaped,
      style: const TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      scribbleEnabled: false,
      decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: widget.border,
          suffixIcon: InkWell(
              onTap: () {
                setState(() {
                  widget.obscure = !widget.obscure;
                });
              },
              child:
                  Icon(widget.obscure ? widget.hideIcon : widget.suffixIcon)),
          suffixIconColor: widget.suffixIconColor,
          prefixIcon: Icon(widget.prefixIcon),
          fillColor: widget.fillColor,
          filled: true,
          enabledBorder: widget.enableBorder,
          focusedBorder: widget.focusBorder,
          prefixIconColor: widget.prefixIconColor),
    );
  }
}
