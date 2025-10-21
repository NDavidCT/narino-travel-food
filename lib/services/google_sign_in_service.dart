import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// Singleton GoogleSignIn instance configured with the Web OAuth Client ID
final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId: kIsWeb
      ? '860020371265-ir9kl5fb30fbbtfa23nmtri91og4crp3.apps.googleusercontent.com'
      : null,
  scopes: <String>['email', 'profile'],
);
