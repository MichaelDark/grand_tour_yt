// ignore_for_file: unnecessary_string_interpolations

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
  String get channelsPageTitle => 'Улюблені канали';

  @override
  String nSubscribers(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compactCurrency(
      locale: localeName,
      symbol: ''
    );
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 підписників',
      one: '$countString підписник',
      other: '$countString підписників',
    );
  }

  @override
  String nVideos(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString відео',
    );
  }

  @override
  String nViews(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 переглядів',
      one: '$countString перегляд',
      other: '$countString переглядів',
    );
  }

  @override
  String numberWithDecimalPattern(int number) {
    final intl.NumberFormat numberNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String numberString = numberNumberFormat.format(number);

    return '$numberString';
  }

  @override
  String videoDate(DateTime date, String ago) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return '$dateString ($ago)';
  }

  @override
  String get uploadedVideosCaption => 'Завантажені відео';

  @override
  String get playlistsCaption => 'Плейлисти';

  @override
  String get videoLicencedLabel => 'Ліцензоване';

  @override
  String get settingsPageTitle => 'Налаштування';

  @override
  String get settingsPageThemeTitle => 'Тема';

  @override
  String get settingsPageThemeSubtitle => 'Натисніть аби перемкнути тему';

  @override
  String get settingsPageLanguageSubtitle => 'Натисніть аби змінити мову застосунку';

  @override
  String get settingsPageClearSearchHistoryTitle => 'Видалити історію пошуку';

  @override
  String get settingsPageClearSearchHistorySubtitle => 'Натисніть аби видалити історію пошуку відео по каналах';

  @override
  String get searchErrorEmpty => 'Введіть пошуковий запит у поле вище';

  @override
  String get searchErrorMoreThenTwoSymbols => 'Пошуковий запит повинен бути довший за два символи';

  @override
  String get clearSearchHistoryDialogTitle => 'Видалення історії пошуку';

  @override
  String get clearSearchHistoryDialogPrompt => 'Вви впевнені, що ви хочете видалити історію пошуку?\n\nЦя дія не може бути скасована.';

  @override
  String get clearSearchHistoryDialogPositiveButton => 'Видалити історію';

  @override
  String get clearSearchHistoryDialogNegativeButton => 'Відмінити';
}
