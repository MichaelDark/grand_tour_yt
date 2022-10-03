import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'di/locator.dart';
import 'l10n/youtube_strings.dart';
import 'pages/channel_page.dart';
import 'pages/channels_page.dart';
import 'pages/playlist_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/splash_page.dart';
import 'pages/video_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();

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
    return MaterialApp(
      onGenerateTitle: (context) => YoutubeStrings.of(context).appName,
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      localizationsDelegates: YoutubeStrings.localizationsDelegates,
      supportedLocales: YoutubeStrings.supportedLocales,
      onGenerateRoute: (settings) {
        final Map<String, WidgetBuilder> routes = {
          SplashPage.routeName: (_) => const SplashPage(),
          SignInPage.routeName: (_) => const SignInPage(),
          ChannelsPage.routeName: (_) => const ChannelsPage(),
          ChannelPage.routeName: (_) => const ChannelPage(),
          PlaylistPage.routeName: (_) => const PlaylistPage(),
          VideoPage.routeName: (_) => const VideoPage(),
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
  }

  ThemeData _buildTheme() {
    // ThemeData baseTheme = ThemeData.light().copyWith(
    ThemeData baseTheme = ThemeData.dark().copyWith(
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

    return baseTheme.copyWith(
      colorScheme: baseTheme.colorScheme.copyWith(
        secondary: Colors.redAccent,
      ),
      textTheme: GoogleFonts.playTextTheme(baseTheme.textTheme),
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    Widget app = child!;

    app = ScrollConfiguration(
      behavior: const CustomScrollBehavior(),
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

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
