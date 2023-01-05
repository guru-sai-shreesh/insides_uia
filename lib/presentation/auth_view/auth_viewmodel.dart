import 'package:flutter/material.dart';

import 'package:insides/presentation/base/base_view_model.dart';
import 'package:insides/presentation/auth_view/auth_functions.dart';

class AuthViewModel extends BaseViewModel with AuthViewModelInput, AuthViewModelOutput {
  //text controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AuthFunctions _authFunctions = AuthFunctions();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  void start() {
    // TODO: implement start
  }

  @override
  void signInEmailPassword(String email, String password) {
    _authFunctions.sign_up(
      _emailController.text,
      _passwordController.text,
    );

    _emailController.clear();
    _passwordController.clear();
  }

  //getter
  TextEditingController get getPasswordController => _passwordController;
  TextEditingController get getEmailController => _emailController;

  String get getTextPasswordController => _passwordController.text;
  String get getTextEmailController => _emailController.text;

  //setter
  setEmailController(TextEditingController value) {
    _emailController = value;
  }

  setPasswordController(TextEditingController value) {
    _passwordController = value;
  }
}

abstract class AuthViewModelInput {
  void signInEmailPassword(String email, String password);
}

abstract class AuthViewModelOutput {}