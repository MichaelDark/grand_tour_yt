import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'logging_service.dart';

@lazySingleton
class GoogleAuthService {
  static const _oauthScopes = [
    'email',
    'https://www.googleapis.com/auth/youtube.readonly',
  ];

  final LoggingService _log;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _oauthScopes);

  GoogleAuthService(this._log);

  Future<GoogleSignInAccount?> signInSilently() async {
    try {
      return await _googleSignIn.signInSilently();
    } on PlatformException {
      _log.d('Sign in silently failed :(');
      rethrow;
    }
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } on PlatformException {
      _log.d('Sign in failed :(');
      rethrow;
    }
  }

  Future<http.Client?> createAuthenticatedHttpClient() async {
    return await _googleSignIn.authenticatedClient();
  }
}
