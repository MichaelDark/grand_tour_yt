import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grandtouryt/services/logging_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoogleAuthService {
  final LoggingService _log;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/youtube',
      'https://www.googleapis.com/auth/youtube.readonly',
    ],
  );

  GoogleAuthService(this._log);

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn();
    } on PlatformException {
      _log.d('Sign in failed :(');
      rethrow;
    }
  }
}
