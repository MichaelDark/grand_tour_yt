// ignore_for_file: unnecessary_string_interpolations

import 'package:intl/intl.dart' as intl;

import 'youtube_strings.dart';

/// The translations for French (`fr`).
class YoutubeStringsFr extends YoutubeStrings {
  YoutubeStringsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Grand Tour YT Démo';

  @override
  String get demoLabel => 'démo';

  @override
  String get errorViewHint => 'Oups, on dirait qu\'une erreur s\'est produite';

  @override
  String get errorViewRetryLabel => 'Recommencez';

  @override
  String get splashText => 'Démarrage...';

  @override
  String get signInPageHint => 'Nous avons besoin de votre compte Google pour accéder à Youtube';

  @override
  String get signInPageButtonLabel => 'S\'identifier';

  @override
  String get channelsPageTitle => 'Chaînes préférées';

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
      zero: '0 abonnés',
      one: '$countString abonné',
      other: '$countString abonnés',
    );
  }

  @override
  String nVideos(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 vidéos',
      one: '$countString vidéo',
      other: '$countString vidéos',
    );
  }

  @override
  String nViews(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 vues',
      one: '$countString vue',
      other: '$countString vues',
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
  String get uploadedVideosCaption => 'Vidéos téléchargées';

  @override
  String get playlistsCaption => 'Listes de lecture';

  @override
  String get videoLicencedLabel => 'Autorisé';

  @override
  String get settingsPageTitle => 'Réglages';

  @override
  String get settingsPageThemeTitle => 'Thème';

  @override
  String get settingsPageThemeSubtitle => 'Appuyez pour basculer entre les thèmes sombre et clair';

  @override
  String get settingsPageLanguageSubtitle => 'Appuyez pour changer de langue';

  @override
  String get settingsPageClearSearchHistoryTitle => 'Effacer l\'historique';

  @override
  String get settingsPageClearSearchHistorySubtitle => 'Appuyez pour effacer l\'historique de recherche des vidéos sur tous les canaux';

  @override
  String get searchErrorEmpty => 'Entrez la requête de recherche dans le champ ci-dessus';

  @override
  String get searchErrorMoreThenTwoSymbols => 'Le terme de recherche doit comporter plus de deux lettres';

  @override
  String get clearSearchHistoryDialogTitle => 'Effacer l\'historique';

  @override
  String get clearSearchHistoryDialogPrompt => 'Voulez-vous vraiment effacer l\'historique des recherches ?\n\nCette action est irréversible.';

  @override
  String get clearSearchHistoryDialogPositiveButton => 'Histoire claire';

  @override
  String get clearSearchHistoryDialogNegativeButton => 'Annuler';
}
