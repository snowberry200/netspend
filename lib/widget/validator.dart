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
}
