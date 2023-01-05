import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFunctions {
  final _auth = FirebaseAuth.instance;

  //sign in
  void sign_in (String email, String password){
    //todo: exception
    _auth.signInWithEmailAndPassword(
      email: email,
      password: password
    );
  }

  //sign up
  void sign_up (String email, String password){
    //todo: exception
    _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //logout
  void logout (){
    _auth.signOut();
  }
}