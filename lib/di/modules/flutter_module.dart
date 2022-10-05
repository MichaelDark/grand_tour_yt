import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../l10n/youtube_strings.dart';

@module
abstract class FlutterModule {
  @lazySingleton
  PlatformDispatcher platformDispatcher() {
    return WidgetsBinding.instance.platformDispatcher;
  }

  @lazySingleton
  @Named('defaultLocale')
  Locale defaultLocale(PlatformDispatcher platformDispatcher) {
    return basicLocaleListResolution(
      platformDispatcher.locales,
      YoutubeStrings.supportedLocales,
    );
  }
}
