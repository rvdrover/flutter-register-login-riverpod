import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'alert_dialogs.dart';


Future<void> showExceptionAlertDialog({
  required BuildContext context,
  required String title,
  required dynamic exception,
}) =>
    showAlertDialog(
      context: context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

String _message(dynamic exception) {
  if (exception is FirebaseException) {
    return exception.message ?? exception.toString();
  }
  if (exception is PlatformException) {
    return exception.message ?? exception.toString();
  }
  
  return exception.toString();
}

// TODO: Revisit this
// NOTE: The full list of FirebaseAuth errors is stored here:
// These are just the most relevant for email & password sign in:
// Map<String, String> _errors = {
//   'ERROR_WEAK_PASSWORD': 'The password must be 8 characters long or more.',
//   'ERROR_INVALID_CREDENTIAL': 'The email address is badly formatted.',
//   'ERROR_EMAIL_ALREADY_IN_USE':
//       'The email address is already registered. Sign in instead?',
//   'ERROR_INVALID_EMAIL': 'The email address is badly formatted.',
//   'ERROR_WRONG_PASSWORD': 'The password is incorrect. Please try again.',
//   'ERROR_USER_NOT_FOUND':
//       'The email address is not registered. Need an account?',
//   'ERROR_TOO_MANY_REQUESTS':
//       'We have blocked all requests from this device due to unusual activity. Try again later.',
//   'ERROR_OPERATION_NOT_ALLOWED':
//       'This sign in method is not allowed. Please contact support.',
// };
