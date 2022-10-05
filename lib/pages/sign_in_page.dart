import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../di/locator.dart';
import '../l10n/youtube_strings.dart';
import '../services/auth_service.dart';
import '../utils/assets.gen.dart';
import '../widgets/resources/error_view.dart';
import '../widgets/show_up.dart';
import 'channels_page.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  dynamic _error;

  void _onSignIn() async {
    try {
      await locator<AuthService>().signIn();
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(
        ChannelsPage.routeName,
      );
    } catch (e) {
      setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: UniqueKey(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                Assets.lottie.login,
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
                    YoutubeStrings.of(context).signInPageHint,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
              if (_error == null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShowUp(
                    delay: const Duration(milliseconds: 1750),
                    child: ElevatedButton(
                      onPressed: _onSignIn,
                      child: Text(
                        YoutubeStrings.of(context).signInPageButtonLabel,
                      ),
                    ),
                  ),
                )
              else
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ShowUp(
                    delay: const Duration(milliseconds: 1750),
                    child: ErrorView(
                      _error,
                      retry: _onSignIn,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
