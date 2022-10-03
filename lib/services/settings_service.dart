import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../l10n/youtube_strings.dart';

@singleton
class SettingsService extends ChangeNotifier {
  static Locale _getInitialLocale() {
    return basicLocaleListResolution(
      WidgetsBinding.instance.platformDispatcher.locales,
      YoutubeStrings.supportedLocales,
    );
  }

  Brightness brightness;
  Locale locale;

  SettingsService()
      : brightness = Brightness.dark,
        locale = _getInitialLocale();

  void toggleBrightness() {
    if (brightness == Brightness.light) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }
    notifyListeners();
  }

  void setLocale(Locale newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}
