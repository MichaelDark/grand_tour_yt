import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'di/locator.dart';
import 'pages/channel_page.dart';
import 'pages/playlist_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/splash_page.dart';
import 'pages/video_page.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grand Tour YT Demo',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      onGenerateRoute: (settings) {
        final Map<String, WidgetBuilder> routes = {
          SplashPage.routeName: (_) => const SplashPage(),
          SignInPage.routeName: (_) => const SignInPage(),
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
    ThemeData baseTheme = ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: Colors.red.shade50,
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
      textTheme: GoogleFonts.abelTextTheme(baseTheme.textTheme),
    );
  }

  Widget _buildApp(BuildContext context, Widget? child) {
    Widget app = child!;

    app = ScrollConfiguration(
      behavior: const CustomScrollBehavior(),
      child: app,
    );

    app = Banner(
      message: 'demo',
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
