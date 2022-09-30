import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grandtouryt/services/logging_service.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleAuthService {
  static const _oauthScopes = [
    'email',
    'https://www.googleapis.com/auth/youtube',
    'https://www.googleapis.com/auth/youtube.readonly',
  ];

  final LoggingService _log;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _oauthScopes);

  GoogleAuthService(this._log);

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } on PlatformException {
      _log.d('Sign in failed :(');
      rethrow;
    }
  }

  GoogleSignInAccount? get currentUser => _googleSignIn.currentUser;

  Future<http.Client?> createAuthenticatedHttpClient() async {
    return await _googleSignIn.authenticatedClient();
  }
}
