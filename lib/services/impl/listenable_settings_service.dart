import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../l10n/youtube_strings.dart';
import '../settings_service.dart';

@Singleton(as: SettingsService)
class ListenableSettingsService extends ChangeNotifier
    implements SettingsService {
  static Locale _getInitialLocale() {
    return basicLocaleListResolution(
      WidgetsBinding.instance.platformDispatcher.locales,
      YoutubeStrings.supportedLocales,
    );
  }

  @override
  Brightness brightness;

  @override
  Locale locale;

  ListenableSettingsService()
      : brightness = Brightness.dark,
        locale = _getInitialLocale();

  @override
  void toggleBrightness() {
    if (brightness == Brightness.light) {
      brightness = Brightness.dark;
    } else {
      brightness = Brightness.light;
    }
    notifyListeners();
  }

  @override
  void setLocale(Locale newLocale) {
    locale = newLocale;
    notifyListeners();
  }
}
