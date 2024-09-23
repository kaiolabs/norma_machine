import 'package:flutter/cupertino.dart';

class PreferencesTheme {
  static ValueNotifier<Brightness> brightness = ValueNotifier<Brightness>(Brightness.light);

  static setTheme(Brightness value) {
    brightness.value = value;
  }

  static toggleTheme() {
    brightness.value = brightness.value == Brightness.light ? Brightness.dark : Brightness.light;
  }
}
