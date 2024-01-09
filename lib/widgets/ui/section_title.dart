import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final double? fontSize;
  final double paddingHorizontal;
  final double paddingTop;
  final double paddingBottom;

  const SectionTitle({
    required this.title,
    this.fontSize = 16,
    this.paddingBottom = 16,
    this.paddingHorizontal = 16,
    this.paddingTop = 16,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: paddingHorizontal,
        right: paddingHorizontal,
        top: paddingTop,
        bottom: paddingBottom,
      ),
      child: Text(
        title,
        style: TextStyle(
          color: MyColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
