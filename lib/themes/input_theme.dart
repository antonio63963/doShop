import 'package:flutter/material.dart';
import 'package:doshop_app/utils/constants.dart';

final inputTheme = InputDecorationTheme(
  hintStyle: const TextStyle(color: MyColors.primary),
  // focusedBorder: const UnderlineInputBorder(
  //   borderSide: BorderSide(color: MyColors.accent, width: 1.0),
  // ),
  enabledBorder: OutlineInputBorder(
    borderSide: const BorderSide(color: MyColors.primary, width: 1.0),
    borderRadius: BorderRadius.circular(5),
  ),
  border: const UnderlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
);
