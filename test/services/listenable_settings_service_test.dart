import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:grandtouryt/di/modules/flutter_module.dart';
import 'package:grandtouryt/l10n/youtube_strings.dart';
import 'package:grandtouryt/services/impl/listenable_settings_service.dart';
import 'package:grandtouryt/services/settings_service.dart';

import 'utils/general_mocks.dart';

class MockFlutterModule extends FlutterModule {}

/// [testWidgets] is used instead of [test]
/// because we also would like to test locale resolution,
/// that relies on [WidgetsFlutterBinding]
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ListenableSettingsService', () {
    testWidgets('#toggleBrightness', (_) async {
      final SettingsService service = ListenableSettingsService(
        MockLogger(),
        const Locale('en'),
      );

      // Check default brightness
      expect(service.brightness, equals(Brightness.dark));

      // Toggle couple times
      service.toggleBrightness();
      expect(service.brightness, equals(Brightness.light));
      service.toggleBrightness();
      expect(service.brightness, equals(Brightness.dark));
    });

    testWidgets('#setLocale', (_) async {
      final bindings = TestWidgetsFlutterBinding.instance;
      final platformDispatcher = bindings.platformDispatcher;
      final testPlatformDispatcher = TestPlatformDispatcher(
        platformDispatcher: platformDispatcher,
      );

      // Test locale initialization using test platform dispatcher
      for (final locale in YoutubeStrings.supportedLocales) {
        testPlatformDispatcher.localesTestValue = [locale];
        final resolvedLocale = MockFlutterModule().defaultLocale(
          testPlatformDispatcher,
        );
        final SettingsService service = ListenableSettingsService(
          MockLogger(),
          resolvedLocale,
        );
        expect(service.locale, equals(locale));
      }

      // Reset locale in platform dispatcher to default
      final defaultLocale = YoutubeStrings.supportedLocales.first;
      testPlatformDispatcher.localesTestValue = [defaultLocale];
      final resolvedLocale = MockFlutterModule().defaultLocale(
        testPlatformDispatcher,
      );
      final SettingsService service = ListenableSettingsService(
        MockLogger(),
        resolvedLocale,
      );
      expect(service.locale, equals(resolvedLocale));

      // Trying to set supported locale
      for (final locale in YoutubeStrings.supportedLocales) {
        service.setLocale(locale);
        expect(service.locale, equals(locale));
      }

      // Reset locale to default
      service.setLocale(defaultLocale);
      expect(service.locale, equals(defaultLocale));

      // Trying to set unsupported locale
      service.setLocale(const Locale('zh'));
      expect(service.locale, equals(defaultLocale));
    });
  });
}
