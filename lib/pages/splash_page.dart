import 'package:flutter/material.dart';
import 'package:grandtouryt/services/google_auth_service.dart';

import '../di/locator.dart';
import 'channel_page.dart';
import 'sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = '/';

  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init(context));
  }

  void _init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final authService = locator<GoogleAuthService>();
    if (authService.currentUser == null) {
      Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(ChannelPage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
