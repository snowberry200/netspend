import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StatementValidator {
  StatementValidator._();

  static dynamic showLoggedInnStatement(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static dynamic showSignUpMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.lightBlue,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static dynamic authValidateMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: CupertinoColors.activeBlue,
        duration: const Duration(seconds: 4),
      ),
    );
  }

  static String? validateName({required String? name}) {
    if (name == null || name.isEmpty) {
      return 'Name field cannot be empty';
    } else if (name.length < 4) {
      return 'Please enter a correct name (min 4 characters)';
    }
    return null;
  }

  static String? validateUsername({required String? username}) {
    if (username == null || username.isEmpty) {
      return 'Username field cannot be empty';
    } else if (username.length < 4) {
      return 'Please enter a correct username (min 4 characters)';
    }
    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null || password.isEmpty) {
      return 'Password field cannot be empty';
    } else if (password.length < 5) {
      return 'Password cannot be less than 5 characters';
    }
    return null;
  }
}
