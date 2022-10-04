import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'di/locator.dart';
import 'l10n/youtube_strings.dart';
import 'pages/channel_page.dart';
import 'pages/channels_page.dart';
import 'pages/playlist_page.dart';
import 'pages/settings_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/splash_page.dart';
import 'pages/video_page.dart';
import 'services/settings_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await configureDependencies();

  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('uk', timeago.UkMessages());
  timeago.setDefaultLocale('en');

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsService = locator<SettingsService>();

    return AnimatedBuilder(
      animation: settingsService,
      builder: (context, _) {
        return MaterialApp(
          onGenerateTitle: (context) => YoutubeStrings.of(context).appName,
          debugShowCheckedModeBanner: false,
          theme: _buildTheme(settingsService.brightness),
          localizationsDelegates: const [
            ...YoutubeStrings.localizationsDelegates,
            LocaleNamesLocalizationsDelegate(),
          ],
          supportedLocales: YoutubeStrings.supportedLocales,
          locale: settingsService.locale,
          onGenerateRoute: (settings) {
            final Map<String, WidgetBuilder> routes = {
              SplashPage.routeName: (_) => const SplashPage(),
              SignInPage.routeName: (_) => const SignInPage(),
              ChannelsPage.routeName: (_) => const ChannelsPage(),
              ChannelPage.routeName: (_) => const ChannelPage(),
              PlaylistPage.routeName: (_) => const PlaylistPage(),
              VideoPage.routeName: (_) => const VideoPage(),
              SettingsPage.routeName: (_) => const SettingsPage(),
            };

            final builder = routes[settings.name];

            if (builder != null) {
              return CupertinoPageRoute(builder: builder, settings: settings);
            }

            // return MaterialPageRoute(builder: (_) => UnknownPage());
            throw 'Unknown route';
          },
          builder: _buildApp,
        );
      },
    );
  }

  ThemeData _buildTheme(Brightness brigtness) {
    ThemeData baseTheme;

    switch (brigtness) {
      case Brightness.dark:
        baseTheme = ThemeData.dark();
        break;
      case Brightness.light:
        baseTheme = ThemeData.light();
        break;
    }

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: Colors.redAccent,
      ),
      textTheme: GoogleFonts.playTextTheme(baseTheme.textTheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    Widget app = child!;

    app = ScrollConfiguration(
      behavior: const _CustomScrollBehavior(),
      child: app,
    );

    app = Banner(
      message: YoutubeStrings.of(context).demoLabel,
      location: BannerLocation.bottomEnd,
      child: app,
    );

    return app;
  }
}

class _CustomScrollBehavior extends ScrollBehavior {
  const _CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
