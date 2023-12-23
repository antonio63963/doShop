import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final Color? bgColor;
  final Color? textColor;
  final String text;

  const PrimaryButton({
    required this.onPressed,
    this.bgColor,
    this.textColor,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(backgroundColor: bgColor ?? MyColors.accent),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? MyColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
