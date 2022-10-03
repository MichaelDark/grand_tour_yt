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
  /// **'My favourite YouTube channels'**
  String get channelsPageTitle;

  /// No description provided for @nSubscribers.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{0 subscribers} =1{{countText} subscriber} other{{countText} subscribers}}'**
  String nSubscribers(num count, String countText);

  /// No description provided for @nVideos.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{0 videos} =1{{count} video} other{{count} videos}}'**
  String nVideos(num count);

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
