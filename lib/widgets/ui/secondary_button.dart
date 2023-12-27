import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const SecondaryButton({
    required this.text,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return OutlinedButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: theme.textTheme.bodySmall?.copyWith(
          color: MyColors.primary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
