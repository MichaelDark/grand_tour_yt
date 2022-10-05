// ignore_for_file: unnecessary_string_interpolations

import 'package:intl/intl.dart' as intl;

import 'youtube_strings.dart';

/// The translations for Spanish Castilian (`es`).
class YoutubeStringsEs extends YoutubeStrings {
  YoutubeStringsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Grand Tour YT Demostración';

  @override
  String get demoLabel => 'demostración';

  @override
  String get errorViewHint => 'Ups, parece que ocurrió un error';

  @override
  String get errorViewRetryLabel => 'Rever';

  @override
  String get splashText => 'Empezando...';

  @override
  String get signInPageHint => 'Necesitamos tu cuenta de Google para acceder a Youtube';

  @override
  String get signInPageButtonLabel => 'Registrarse';

  @override
  String get channelsPageTitle => 'Canales favoritos';

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
      zero: '0 suscriptores',
      one: '$countString suscriptor',
      other: '$countString suscriptores',
    );
  }

  @override
  String nVideos(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 vídeos',
      one: '$countString vídeo',
      other: '$countString vídeos',
    );
  }

  @override
  String nViews(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.decimalPattern(localeName);
    final String countString = countNumberFormat.format(count);

    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      zero: '0 vistas',
      one: '$countString vista',
      other: '$countString vistas',
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
  String get uploadedVideosCaption => 'Vídeos subidos';

  @override
  String get playlistsCaption => 'Listas de reproducción';

  @override
  String get videoLicencedLabel => 'Con licencia';

  @override
  String get settingsPageTitle => 'Ajustes';

  @override
  String get settingsPageThemeTitle => 'Tema';

  @override
  String get settingsPageThemeSubtitle => 'Toque para alternar el tema claro y oscuro';

  @override
  String get settingsPageLanguageSubtitle => 'Toca para cambiar el idioma';

  @override
  String get settingsPageClearSearchHistoryTitle => 'Limpiar historial de búsqueda';

  @override
  String get settingsPageClearSearchHistorySubtitle => 'Toque para borrar el historial de búsqueda de videos en todos los canales';

  @override
  String get searchErrorEmpty => 'Introduzca la consulta de búsqueda en el campo de arriba';

  @override
  String get searchErrorMoreThenTwoSymbols => 'El término de búsqueda debe tener más de dos letras';

  @override
  String get clearSearchHistoryDialogTitle => 'Limpiar historial de búsqueda';

  @override
  String get clearSearchHistoryDialogPrompt => '¿Está seguro de que desea borrar el historial de búsqueda?\n\nEsta acción no se puede deshacer.';

  @override
  String get clearSearchHistoryDialogPositiveButton => 'Borrar historial';

  @override
  String get clearSearchHistoryDialogNegativeButton => 'Cancelar';
}
