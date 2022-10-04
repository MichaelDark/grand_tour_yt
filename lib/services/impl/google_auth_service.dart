import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

import '../auth_service.dart';

@LazySingleton(as: AuthService)
class GoogleAuthService implements AuthService {
  static const _oauthScopes = [
    'email',
    'https://www.googleapis.com/auth/youtube.readonly',
  ];

  final Logger _log;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _oauthScopes);

  GoogleAuthService(this._log);

  @override
  Future<String?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      _log.d('Signed in with email: ${account?.email} ');
      return account?.email;
    } on PlatformException {
      _log.d('Sign in silently failed :(');
      rethrow;
    }
  }

  @override
  Future<void> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _log.d('Signed in with email: ${account?.email} ');
    } on PlatformException {
      _log.d('Sign in failed :(');
      rethrow;
    }
  }

  @override
  Future<http.Client?> createAuthenticatedHttpClient() async {
    return await _googleSignIn.authenticatedClient();
  }
}
