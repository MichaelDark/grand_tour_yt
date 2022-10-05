import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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

  final Logger _logger;

  @override
  Brightness brightness;

  @override
  Locale locale;

  ListenableSettingsService(this._logger)
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
    if (YoutubeStrings.supportedLocales.contains(newLocale)) {
      _logger.e(
        'Trying to set locale that is not in the list of supported locales: '
        '${newLocale.toLanguageTag()} not in '
        '${YoutubeStrings.supportedLocales.map((l) => l.toLanguageTag()).toList()}',
      );
    }
    locale = newLocale;
    notifyListeners();
  }
}
