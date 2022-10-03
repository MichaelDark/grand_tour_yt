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
  String get channelsPageTitle => 'My favourite YouTube channels';

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
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 views',
      one: '$count view',
      other: '$count views',
    );
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
}
