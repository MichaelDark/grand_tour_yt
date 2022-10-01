import 'package:flutter/material.dart';

import 'di/locator.dart';
import 'pages/channel_page.dart';
import 'pages/playlist_page.dart';
import 'pages/sign_in_page.dart';
import 'pages/splash_page.dart';

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
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      routes: {
        SplashPage.routeName: (_) => const SplashPage(),
        SignInPage.routeName: (_) => const SignInPage(),
        ChannelPage.routeName: (_) => const ChannelPage(),
        PlaylistPage.routeName: (_) => const PlaylistPage(),
      },
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
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
      },
    );
  }
}

class CustomScrollBehavior extends ScrollBehavior {
  const CustomScrollBehavior();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}
