import 'package:flutter/material.dart';

import '../../models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

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
      // backgroundColor: MyColors.backgroundLight,
      title: Text(
        error.title,
        style: theme.textTheme.bodyLarge?.copyWith(color: MyColors.danger),
      ),
      content: Text(
        error.message,
        style: theme.textTheme.bodyMedium,
      ),
      actions: <Widget>[
        if (onRepeat is Function)
          OutlinedButton(
            onPressed: onRepeat,
            child: const Text('Обновить'),
          ),
        // SecondaryButton(
        //   text: 'Ok',
        //   onPressed: () {
        //     Navigator.of(ctx).pop();
        //   },
        // )
      ],
    );
  }
}
