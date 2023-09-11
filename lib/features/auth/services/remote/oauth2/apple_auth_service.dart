import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../model/user.dart';
import '../../local/auth_shared_prefs.dart';

class AppleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithApple(BuildContext context) async {
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName
        ],
      );

      final AuthCredential credential = OAuthProvider("apple.com").credential(
        accessToken: result.authorizationCode,
        idToken: result.identityToken,
      );

      final UserCredential authResult =
          await _auth.signInWithCredential(credential);
      final User? user = authResult.user;

      if (user != null) {
        final userModel = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            photoURL: user.photoURL ?? '',
            signInType: SignInType.apple);

        // Save user data in shared preferences
        await AuthSharedPreferences.saveUserDataInPrefs(userModel);

        return userModel;
      }
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(context, getErrorMessage(e.code));
    } catch (error) {
      print(error);
      showCustomSnackBar(context, 'An error occurred. Try again later.');
    }

    return null;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      showCustomSnackBar(context, 'Signed out successfully');
    } catch (error) {
      print(error);
      showCustomSnackBar(
          context, 'Error occurred during sign-out. Try again later.');
    }
  }
}
