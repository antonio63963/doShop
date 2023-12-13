import 'package:flutter/material.dart';

import '../../models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

import 'secondary_button.dart';

class ShowError extends StatelessWidget {
  final ErrorAlert error;
  final BuildContext ctx;
  final Function()? onRepeat;
  const ShowError({
    required this.error,
    required this.ctx,
    this.onRepeat,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: MyColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      title: Row(
        children: [
          const Icon(
            Icons.warning,
            color: MyColors.danger,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: FittedBox(
              child: Text(
                error.title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: MyColors.danger,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Text(
        error.message,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: MyColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        if (onRepeat is Function)
          OutlinedButton(
            onPressed: onRepeat,
            child: const Text('Обновить'),
          ),
        SecondaryButton(
          text: 'Ok',
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    );
  }
}
