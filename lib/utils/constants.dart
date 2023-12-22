import 'package:flutter/material.dart';

const String defaultFont = 'Montserrat';

class MyColors {
  static const Color primary = Color.fromRGBO(65, 44, 85, 1);
  static const Color secondary = Color.fromRGBO(99, 52, 143, 1);
  static const Color lightPurple = Color.fromRGBO(210, 192, 228, 1);
  static const Color accent = Color(0xFFFC8832);
  // static const Color accent = Color(0xFFEF8630);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);
  static const Color label = Color.fromARGB(160, 44, 48, 85);

  static const int defaultBG = 0xFF80CBC4;

  // static const Color purple1 = Color.fromRGBO(127, 131, 183, 1);
  // static const Color purple2 = Color.fromRGBO(109, 91, 180, 1);
  // static const Color red1 = Color.fromRGBO(176, 101, 101, 1);
  // static const Color red2 = Color.fromRGBO(183, 127, 161, 1);
  // static const Color red3 = Color.fromRGBO(183, 127, 127, 1);
  // static const Color teal = Color.fromRGBO(91, 137, 180, 1);
  // static const Color green1 = Color.fromRGBO(127, 183, 173, 1);
  // static const Color green2 = Color.fromRGBO(128, 183, 127, 1);

  // Categories
  static const List<Color> listColors = [
    Color(0xFF7F83B7),
    Color(0xFFB06565),
    Color(0xFF5B89B4),
    Color(0xFF6D5BB4),
    Color(0xFF7FB7AD),
    Color(0xFFB7977F),
    Color(0xFF80B77F),
    Color(0xFF7F95B7),
    Color(0xFFB77F7F),
    Color(0xFFB77FA1),
    Color(0xFFA57FB7),
    Color(0xFF7FA3B7),
  ];

  static const Color danger = Color.fromRGBO(252, 43, 43, 1);
}

enum MenuOptionsValues { photo, edit, hide, delete }

class AppPadding {
  static double bodyHorizontal = 16;
}

class Units {
  static String thing = "шт.";
  static String kg = "кг";
  static String pack = "уп.";
  static String block = "блок";
  static String lt = "л.";
  static String couple = 'пара';
}

class DefaultValues {
  static String img = 'assets/img/categories/hobby.png';
  static String icon = 'assets/icons/label.png';
}

class IconsAssets {
  static List<String> bakaleya = [
    'boxes.png', 'corn.png', 'eggs.png', 'oil.png', 'pasta.png'
  ];
  static List<String> fish = [
    'fish_band.png', 'fish_box.png', 'octopus.png', 'red_fish.png'
  ];
  static List<String> meat = [
    'big_leg.png', 'chicken.png', 'hen_repair.png', 'kolbasa.png', 'steak.png'
  ];
  static List<String> milk = [
    'cheese.png', 'milk.png', 'yogurt.png'
  ];
}
