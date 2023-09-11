import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../components/custom_snack_bar.dart';
import '../../../model/user.dart';
import '../../local/auth_shared_prefs.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
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
            signInType: SignInType.google,
          );

          // Save user data in shared preferences
          await AuthSharedPreferences.saveUserDataInPrefs(userModel);

          return userModel;
        }
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
      await _googleSignIn.signOut();
      showCustomSnackBar(context, 'Signed out successfully');
    } catch (error) {
      showCustomSnackBar(
          context, 'Error occurred during sign-out. Try again later.');
    }
  }
}
