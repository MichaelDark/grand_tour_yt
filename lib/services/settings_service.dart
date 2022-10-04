import 'package:flutter/material.dart' show Locale, Listenable, Brightness;

abstract class SettingsService implements Listenable {
  Brightness get brightness;
  Locale get locale;

  /// Switch between dark and list brightness
  void toggleBrightness();

  /// Set new app locale
  void setLocale(Locale newLocale);
}
