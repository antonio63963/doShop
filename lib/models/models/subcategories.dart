import 'dart:convert';

import 'package:doshop_app/models/models/category.dart';
import 'package:doshop_app/utils/constants.dart';

const String tableSubcategories = 'subcategories';

class SubcategoryFields {
  static String values = '''
    id, title, subtitle, img, isShown, parentId
  ''';
  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String img = 'img';
  static const String isShown = 'isShown';
  static const String parentId = 'parentId';
}

class Subcategory {
  int? id;
  String title;
  String? subtitle;
  String? img;
  bool? isShown;
  int parentId;
  int? colorBg = MyColors.defaultBG;

  Subcategory({
    this.id,
    required this.title,
    this.subtitle,
    this.img,
    this.isShown = true,
    required this.parentId,
    this.colorBg = MyColors.defaultBG,
  });

  Subcategory copy({
    int? id,
    String? title,
    String? subtitle,
    String? img,
    bool? isShown,
    int? parentId,
    int? colorBg,
  }) =>
      Subcategory(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        img: img ?? this.img,
        isShown: isShown ?? this.isShown,
        parentId: parentId ?? this.parentId,
        colorBg: colorBg ?? this.colorBg,
      );

  static Subcategory fromJSON(Map<String, Object?> json) {
    return Subcategory(
      id: json[SubcategoryFields.id] as int,
      title: json[SubcategoryFields.title] as String,
      subtitle: json[SubcategoryFields.subtitle] == null
          ? null
          : json[SubcategoryFields.subtitle] as String,
      img: json[SubcategoryFields.img] as String,
      isShown: intToBool(json[SubcategoryFields.isShown] as int),
      parentId: json[SubcategoryFields.parentId] as int,
      colorBg: json[CategoryProdFields.colorBg] as int,
    );
  }

  Map<String, Object?> toJSON() => {
        SubcategoryFields.title: title,
        SubcategoryFields.subtitle: subtitle,
        SubcategoryFields.isShown: isShown != null && isShown! ? 1 : 0,
        SubcategoryFields.img: img,
        SubcategoryFields.parentId: parentId,
      };

  static bool intToBool(int value) => value == 1;

  @override
  String toString() {
    print('''
      id: $id,
      title: $title,
      subtitle: $subtitle,
      img: $img,
      isShown: $isShown,
      parentId: $parentId,
      colorBg: $colorBg,
    ''');
    return super.toString();
  }
}
