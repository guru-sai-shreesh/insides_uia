import 'package:flutter/material.dart';

class CustomSnackBar extends StatelessWidget {
  final String content;

  CustomSnackBar({required this.content});

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(content),
      duration: Duration(seconds: 3),
    );
  }
}

void showCustomSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3),
    ),
  );
}

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'account-exists-with-different-credential':
      return 'The account already exists with a different credential';
    case 'invalid-credential':
      return 'Error occurred while accessing credentials. Try again.';
    default:
      return 'An error occurred. Try again later.';
  }
}
