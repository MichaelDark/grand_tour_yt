import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  final Logger _logger;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: _oauthScopes);

  GoogleAuthService(this._logger);

  @override
  Future<String?> signInSilently() async {
    try {
      final account = await _googleSignIn.signInSilently();
      _logger.d('Signed in with email: ${account?.email} ');
      return account?.email;
    } catch (e, s) {
      _logger.d('Sign in silently failed', e, s);
      rethrow;
    }
  }

  @override
  Future<void> signIn() async {
    try {
      final account = await _googleSignIn.signIn();
      _logger.d('Signed in with email: ${account?.email} ');
    } catch (e, s) {
      _logger.d('Sign in failed', e, s);
      rethrow;
    }
  }

  @override
  Future<http.Client?> createAuthenticatedHttpClient() async {
    try {
      return await _googleSignIn.authenticatedClient();
    } catch (e, s) {
      _logger.e('Error creating HTTP Client for Youtube API', e, s);
      rethrow;
    }
  }
}
