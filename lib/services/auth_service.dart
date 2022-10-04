// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

abstract class AuthService {
  /// Sign in silently.
  /// That is, retrieve previously authorized account.
  Future<String?> signInSilently();

  /// Interactive sign in
  Future<void> signIn();

  /// Create HTTP client for Google APIs
  Future<http.Client?> createAuthenticatedHttpClient();
}
