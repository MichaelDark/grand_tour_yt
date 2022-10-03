import 'package:intl/intl.dart' as intl;

import 'youtube_strings.dart';

/// The translations for Ukrainian (`uk`).
class YoutubeStringsUk extends YoutubeStrings {
  YoutubeStringsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Grand Tour YT Демо';

  @override
  String get demoLabel => 'демо';

  @override
  String get errorViewHint => 'Ууупсі, лишенько трапилося';

  @override
  String get errorViewRetryLabel => 'Спробувати ще';

  @override
  String get splashText => 'Запускаємо додаток...';

  @override
  String get signInPageHint => 'Нам потрібен ваш Google акаунт для доступу до Youtube';

  @override
  String get signInPageButtonLabel => 'Увійти';

  @override
  String get channelsPageTitle => 'Мої улюблені YouTube канали';

  @override
  String nSubscribers(num count, String countText) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 підписників',
      one: '$countText підписник',
      other: '$countText підписників',
    );
  }

  @override
  String nVideos(num count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count відео',
    );
  }

  @override
  String get uploadedVideosCaption => 'Завантажені відео';

  @override
  String get playlistsCaption => 'Плейлисти';
}
