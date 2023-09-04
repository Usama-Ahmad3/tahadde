import 'package:flutter/material.dart';

class UtilsSign {
  static focusChange(next, context) {
    FocusScope.of(context).requestFocus(next);
  }

}