import 'package:google_sign_in/google_sign_in.dart';

// Singleton GoogleSignIn instance configured with the Web OAuth Client ID
final GoogleSignIn googleSignIn = GoogleSignIn(
  clientId:
      '187733989912-4tl32be27591kovqe935jir5kpmrduiv.apps.googleusercontent.com',
  scopes: <String>['email', 'profile'],
);
