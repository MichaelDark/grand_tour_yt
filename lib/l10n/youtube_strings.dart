// ignore_for_file: unnecessary_string_interpolations
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'youtube_strings_en.dart';
import 'youtube_strings_uk.dart';

/// Callers can lookup localized strings with an instance of YoutubeStrings
/// returned by `YoutubeStrings.of(context)`.
///
/// Applications need to include `YoutubeStrings.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/youtube_strings.dart';
///
/// return MaterialApp(
///   localizationsDelegates: YoutubeStrings.localizationsDelegates,
///   supportedLocales: YoutubeStrings.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the YoutubeStrings.supportedLocales
/// property.
abstract class YoutubeStrings {
  YoutubeStrings(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static YoutubeStrings of(BuildContext context) {
    return Localizations.of<YoutubeStrings>(context, YoutubeStrings)!;
  }

  static const LocalizationsDelegate<YoutubeStrings> delegate = _YoutubeStringsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('uk')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Grand Tour YT Demo'**
  String get appName;

  /// No description provided for @demoLabel.
  ///
  /// In en, this message translates to:
  /// **'demo'**
  String get demoLabel;

  /// No description provided for @errorViewHint.
  ///
  /// In en, this message translates to:
  /// **'Ooopsy, looks like an error occured'**
  String get errorViewHint;

  /// No description provided for @errorViewRetryLabel.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get errorViewRetryLabel;

  /// No description provided for @splashText.
  ///
  /// In en, this message translates to:
  /// **'Starting up...'**
  String get splashText;

  /// No description provided for @signInPageHint.
  ///
  /// In en, this message translates to:
  /// **'We need your Google Account to access Youtube'**
  String get signInPageHint;

  /// No description provided for @signInPageButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInPageButtonLabel;

  /// No description provided for @channelsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Favourite channels'**
  String get channelsPageTitle;

  /// No description provided for @nSubscribers.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{0 subscribers} =1{{count} subscriber} other{{count} subscribers}}'**
  String nSubscribers(num count);

  /// No description provided for @nVideos.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{0 videos} =1{{count} video} other{{count} videos}}'**
  String nVideos(num count);

  /// No description provided for @nViews.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{0 views} =1{{count} view} other{{count} views}}'**
  String nViews(num count);

  /// No description provided for @numberWithDecimalPattern.
  ///
  /// In en, this message translates to:
  /// **'{number}'**
  String numberWithDecimalPattern(int number);

  /// No description provided for @videoDate.
  ///
  /// In en, this message translates to:
  /// **'{date} ({ago})'**
  String videoDate(DateTime date, String ago);

  /// No description provided for @uploadedVideosCaption.
  ///
  /// In en, this message translates to:
  /// **'Uploaded videos'**
  String get uploadedVideosCaption;

  /// No description provided for @playlistsCaption.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlistsCaption;

  /// No description provided for @videoLicencedLabel.
  ///
  /// In en, this message translates to:
  /// **'Licenced'**
  String get videoLicencedLabel;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsPageThemeTitle.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsPageThemeTitle;

  /// No description provided for @settingsPageThemeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to toggle dark and light theme'**
  String get settingsPageThemeSubtitle;

  /// No description provided for @settingsPageLanguageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to change language'**
  String get settingsPageLanguageSubtitle;

  /// No description provided for @settingsPageClearSearchHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Search History'**
  String get settingsPageClearSearchHistoryTitle;

  /// No description provided for @settingsPageClearSearchHistorySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to clear search history across for videos across all channels'**
  String get settingsPageClearSearchHistorySubtitle;

  /// No description provided for @searchErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter search query in the field above'**
  String get searchErrorEmpty;

  /// No description provided for @searchErrorMoreThenTwoSymbols.
  ///
  /// In en, this message translates to:
  /// **'Search term must be longer than two letters'**
  String get searchErrorMoreThenTwoSymbols;

  /// No description provided for @clearSearchHistoryDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Clear Search History'**
  String get clearSearchHistoryDialogTitle;

  /// No description provided for @clearSearchHistoryDialogPrompt.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear search history?\n\nThis action cannot be undone.'**
  String get clearSearchHistoryDialogPrompt;

  /// No description provided for @clearSearchHistoryDialogPositiveButton.
  ///
  /// In en, this message translates to:
  /// **'Clear history'**
  String get clearSearchHistoryDialogPositiveButton;

  /// No description provided for @clearSearchHistoryDialogNegativeButton.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get clearSearchHistoryDialogNegativeButton;
}

class _YoutubeStringsDelegate extends LocalizationsDelegate<YoutubeStrings> {
  const _YoutubeStringsDelegate();

  @override
  Future<YoutubeStrings> load(Locale locale) {
    return SynchronousFuture<YoutubeStrings>(lookupYoutubeStrings(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_YoutubeStringsDelegate old) => false;
}

YoutubeStrings lookupYoutubeStrings(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return YoutubeStringsEn();
    case 'uk': return YoutubeStringsUk();
  }

  throw FlutterError(
    'YoutubeStrings.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
