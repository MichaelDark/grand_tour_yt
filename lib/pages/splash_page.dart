import 'package:flutter/material.dart';
import 'package:grandtouryt/services/google_auth_service.dart';
import 'package:lottie/lottie.dart';

import '../di/locator.dart';
import 'channel_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Future<String> _nextRouteFuture;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _nextRouteFuture = _getNextRoute();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigate();
      }
    });
    _controller.forward();
  }

  Future<String> _getNextRoute() async {
    final authService = locator<GoogleAuthService>();
    return authService.currentUser == null
        ? SignInPage.routeName
        : ChannelPage.routeName;
  }

  void _navigate() async {
    final nextRoute = await _nextRouteFuture;
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(nextRoute);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            'assets/lottie/splash.json',
            controller: _controller,
            height: 400,
            width: 400,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Starting up...',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
