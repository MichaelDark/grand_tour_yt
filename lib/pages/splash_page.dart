import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../services/auth_service.dart';
import '../utils/assets.gen.dart';
import 'channels_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Future<String> _nextRouteFuture;

  @override
  void initState() {
    super.initState();
    _navigateAfterInit();
  }

  void _navigateAfterInit() async {
    const splashDuration = Duration(seconds: 4);
    _nextRouteFuture = _getNextRoute();
    await Future.wait([_nextRouteFuture, Future.delayed(splashDuration)]);
    _navigate();
  }

  Future<String> _getNextRoute() async {
    final authService = locator<AuthService>();
    final currentUser = await authService.signInSilently();
    return currentUser == null ? SignInPage.routeName : ChannelsPage.routeName;
  }

  void _navigate() async {
    final nextRoute = await _nextRouteFuture;
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              Assets.lottie.splashVideo,
              height: 400,
              width: 400,
              repeat: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                YoutubeStrings.of(context).splashText,
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
