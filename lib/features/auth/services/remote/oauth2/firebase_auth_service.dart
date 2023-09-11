import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseAuthService {
  static Future<void> initialize() async {
    await Firebase.initializeApp();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  // Sign out the user and revoke OAuth tokens
  Future<void> signOutUser() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();

      // Sign out from Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }

      // Sign out from Facebook
      await FacebookAuth.instance.logOut();

      // Sign out from Apple
      // await SignInWithApple.revokeAccessAndRemoveUser();

      // You can also clear any additional data stored in shared preferences or elsewhere here
    } catch (error) {
      // Handle any errors that occur during sign-out
      print('Error during sign-out: $error');
    }
  }
}
