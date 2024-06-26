import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../models/exports.dart';
import '../widgets/exports.dart';
import 'constants.dart';

class Helper {
  static void showErrorAlert(BuildContext context, ErrorAlert err) {
    showDialog(
      context: context,
      builder: (_) => ShowError(
        ctx: _,
        error: err,
      ),
    );
  }

  static void showInfoAlert(BuildContext context, InfoAlert alert) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        // backgroundColor: MyColors.backgroundLight,
        title: Text(alert.title, style: theme.textTheme.bodyLarge),
        content: Text(
          alert.message,
          style: theme.textTheme.bodyMedium,
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () {
              if (alert.onClose != null) alert.onClose!();
              Navigator.of(context).pop();
            },
            child: const Text('Отменить'),
          ),
          // SecondaryButton(
          //   text: 'Ok',
          //   onPressed: () {
          //     if (alert.onSubmit != null) alert.onSubmit!();
          //     Navigator.of(context).pop();
          //   },
          // )
        ],
      ),
    );
  }

  static showSnack({required BuildContext context, String text = 'Изменено'}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
