import 'dart:io';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';

import '../models/exports.dart';

class ErrorHandler with ChangeNotifier {
  ErrorAlert? errorProvider;

  void setErrorAlert({required BuildContext context, required String message}) {
    errorProvider = ErrorAlert(
      title: 'Что-то пошло не так...',
      message: message,
      onClose: clearErrorAlert,
    );
    Helper.showErrorAlert(context, errorProvider!);
  }

  void clearErrorAlert() {
    errorProvider = null;
    notifyListeners();
  }

  void sendReport(String message) {
       Map<String, String> log = {
      'date': DateTime.now().toString(),
      'errorMessage': message,
      'directory': Directory.current.path,
    };
  }
}
