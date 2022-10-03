import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../di/locator.dart';
import '../models/youtube/youtube_channel.dart';
import '../services/google_auth_service.dart';
import '../widgets/show_up.dart';
import 'channel_page.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _onSignIn() async {
    await locator<GoogleAuthService>().signIn();
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed(
      ChannelPage.routeName,
      arguments: const ChannelPageArguments(
        channelId: YoutubeChannel.grandTourChannelId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: UniqueKey(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              'assets/lottie/login.json',
              height: 400,
              width: 400,
              repeat: false,
              animate: true,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowUp(
                delay: const Duration(milliseconds: 1500),
                child: Text(
                  'We need your Google Account to access Youtube',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ShowUp(
                delay: const Duration(milliseconds: 2000),
                child: ElevatedButton(
                  onPressed: _onSignIn,
                  child: const Text('Sign In'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
