// ignore_for_file: unnecessary_string_interpolations

import 'package:intl/intl.dart' as intl;

import 'youtube_strings.dart';

/// The translations for English (`en`).
class YoutubeStringsEn extends YoutubeStrings {
  YoutubeStringsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Grand Tour YT Demo';

  @override
  String get demoLabel => 'demo';

  @override
  String get errorViewHint => 'Ooopsy, looks like an error occured';

  @override
  String get errorViewRetryLabel => 'Retry';

  @override
  String get splashText => 'Starting up...';

  @override
  String get signInPageHint => 'We need your Google Account to access Youtube';

  @override
  String get signInPageButtonLabel => 'Sign In';

  @override
  String get channelsPageTitle => 'Favourite channels';

  @override
  String nSubscribers(num count, String countText) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 subscribers',
      one: '$countText subscriber',
      other: '$countText subscribers',
    );
  }

  @override
  String nVideos(num count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 videos',
      one: '$count video',
      other: '$count videos',
    );
  }

  @override
  String nViews(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 views',
      one: '$countString view',
      other: '$countString views',
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
  String get uploadedVideosCaption => 'Uploaded videos';

  @override
  String get playlistsCaption => 'Playlists';

  @override
  String get videoLicencedLabel => 'Licenced';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String get settingsPageThemeTitle => 'Theme';

  @override
  String get settingsPageThemeSubtitle => 'Tap to toggle dark and light theme';

  @override
  String get settingsPageLanguageSubtitle => 'Tap to change language';
}
