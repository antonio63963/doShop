
import 'package:flutter/material.dart';

import 'package:doshop_app/themes/input_theme.dart';
import 'package:doshop_app/utils/constants.dart';

final appTheme = ThemeData(
  secondaryHeaderColor: MyColors.accent,
  scaffoldBackgroundColor: MyColors.white,
  fontFamily: defaultFont,
  inputDecorationTheme: inputTheme,
  dividerColor: MyColors.primary,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: MyColors.accent,
    iconSize: 24,
  ),
  textTheme: TextTheme(
      headlineMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: MyColors.white,
      ),
      labelMedium: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: MyColors.primary,
      ),
      bodyLarge: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      bodyMedium: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodySmall: TextStyle(
        color: Colors.white.withOpacity(0.6),
        fontSize: 12,
      )),
  appBarTheme: const AppBarTheme(
    backgroundColor: MyColors.white,
    titleTextStyle: TextStyle(
      fontFamily: 'Montserrat',
      color: MyColors.primary,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
  ),
  listTileTheme: ListTileThemeData(iconColor: Colors.yellow.shade800, subtitleTextStyle: TextStyle(fontSize: 12)),
);