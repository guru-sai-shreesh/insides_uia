import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../model/user.dart';
import '../../local/auth_shared_prefs.dart';

class FacebookAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance
          .login(permissions: const ['email', 'public_profile']);
      if (loginResult.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        final UserCredential authResult =
            await _auth.signInWithCredential(credential);
        final User? user = authResult.user;
        if (user != null) {
          final userModel = UserModel(
            uid: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? '',
            photoURL: user.photoURL ?? '',
            signInType: SignInType.facebook,
          );

          // Save user data in shared preferences
          await AuthSharedPreferences.saveUserDataInPrefs(userModel);

          return userModel;
        }
      }
    } on FirebaseAuthException catch (e) {
      showCustomSnackBar(context, getErrorMessage(e.code));
    } catch (error) {
      showCustomSnackBar(context, 'An error occurred. Try again later.');
    }

    return null;
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      await FacebookAuth.instance.logOut();
      showCustomSnackBar(context, 'Signed out successfully');
    } catch (error) {
      print(error);
      showCustomSnackBar(
          context, 'Error occurred during sign-out. Try again later.');
    }
  }
}
