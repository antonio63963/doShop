import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onPressed;
  final Color? bgColor;
  final Color? textColor;
  final String text;
  final IconData? iconData;
  final double? elevation;

  const PrimaryButton({
    required this.onPressed,
    this.bgColor,
    this.textColor,
    required this.text,
    this.iconData,
    this.elevation = 5,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: bgColor ?? MyColors.accent, elevation: elevation),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (iconData != null)
            Icon(
              iconData,
              color: textColor ?? MyColors.primary,
            ),
          const SizedBox(width: 8),
          Text(
            text.toUpperCase(),
            style: TextStyle(
              color: textColor ?? MyColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
