import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../di/locator.dart';
import '../models/youtube/youtube_channel.dart';
import '../services/google_auth_service.dart';
import '../utils/assets.gen.dart';
import 'channel_page.dart';
import 'channels_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _NextRoute {
  final String path;
  final Object? arguments;

  const _NextRoute(this.path, {this.arguments});
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late Future<_NextRoute> _nextRouteFuture;

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

  Future<_NextRoute> _getNextRoute() async {
    final authService = locator<GoogleAuthService>();
    final currentUser = await authService.signInSilently();
    return currentUser == null
        ? const _NextRoute(SignInPage.routeName)
        : const _NextRoute(
            ChannelsPage.routeName,
            arguments: ChannelPageArguments(
              channelId: YoutubeChannel.grandTourChannelId,
            ),
          );
  }

  void _navigate() async {
    final nextRoute = await _nextRouteFuture;
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      nextRoute.path,
      arguments: nextRoute.arguments,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
              'Starting up...',
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ],
      ),
    );
  }
}
