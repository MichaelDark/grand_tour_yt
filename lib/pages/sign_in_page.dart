import 'package:flutter/material.dart';
import 'package:grandtouryt/services/google_auth_service.dart';

import '../di/locator.dart';
import 'channel_page.dart';

class SignInPage extends StatefulWidget {
  static const routeName = '/sign_in';

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authorization'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await locator<GoogleAuthService>().signIn();
            if (!mounted) return;
            Navigator.of(context).pushReplacementNamed(ChannelPage.routeName);
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}
