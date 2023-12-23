import 'dart:async';
import 'dart:math';

import 'package:doshop_app/widgets/ui/primary_button.dart';
import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
        backgroundColor: MyColors.white,
        shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
        title: Text(
          alert.title,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: MyColors.primary,
            fontSize: 20,
          ),
        ),
        content: Text(
          alert.message,
          style: theme.textTheme.bodyMedium?.copyWith(color: MyColors.primary),
        ),
        actions: <Widget>[
          PrimaryButton(
            text: 'Отменить',
            onPressed: () {
              if (alert.onClose != null) alert.onClose!();
              Navigator.of(context).pop();
            },
            bgColor: MyColors.danger,
            textColor: MyColors.white,
          ),
          SecondaryButton(
            text: 'Ok',
            onPressed: () {
              if (alert.onSubmit != null) alert.onSubmit!();
              Navigator.of(context).pop();
            },
          )
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

  // for more radius first(top) and last(bottom) items
  ShapeBorder getBorderRadius(int idx, List<Object> list) {
    if (idx == 0) {
      return const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomRight: Radius.circular(5),
              bottomLeft: Radius.circular(5)));
    } else if (idx == list.length - 1) {
      return const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(18),
              bottomLeft: Radius.circular(18)));
    } else {
      return const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)));
    }
  }
}
