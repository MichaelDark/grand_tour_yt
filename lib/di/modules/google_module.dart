import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class GoogleModule {
  @lazySingleton
  GoogleSignIn googleSignIn() {
    return GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/youtube.readonly',
      ],
    );
  }
}
