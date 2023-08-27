
import 'dart:ui';

typedef LocaleChangeCallback = void Function(Locale locale);

class LocaleHelper {
  late LocaleChangeCallback onLocaleChanged;

  static final LocaleHelper _helper = LocaleHelper._internal();
  factory LocaleHelper() {
    return _helper;
  }

  LocaleHelper._internal();
}

LocaleHelper helper = LocaleHelper();
