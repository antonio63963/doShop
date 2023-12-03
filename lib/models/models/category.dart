import 'package:logger/logger.dart';

var logger = Logger();

const String tableCategories = 'categories';

class CategoryFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isShown = '1';
  static const String img = 'img';
  static const String parentId = 'parentId';
  static const String subcategories = 'subcategories';
  static const String colorBg = 'colorBg';
}

class Category {
  int? id;
  String title;
  String? subtitle;
  String? img;
  bool? isShown;
  int? parentId;
  bool? subcategories;
  String? colorBg;

  Category({
    this.id,
    required this.title,
    this.subtitle,
    this.img,
    this.isShown = true,
    this.parentId,
    this.subcategories,
     this.colorBg,
  });

  Category copy({
    int? id,
    String? title,
    String? subtitle,
    String? img,
    bool? isShown,
    bool? subcategories,
    int? parentId,
    String? colorBg,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        img: img ?? this.img,
        isShown: isShown ?? this.isShown,
        subcategories: subcategories ?? this.subcategories,
        parentId: parentId ?? this.parentId,
        colorBg: colorBg ?? this.colorBg,
      );

  static Category fromJSON(Map<String, Object?> json) {
    return Category(
      id: json[CategoryFields.id] as int,
      title: json[CategoryFields.title] as String,
      subtitle: json[CategoryFields.subtitle] as String,
      img: json[CategoryFields.img] as String,
      isShown: intToBool(json[CategoryFields.isShown] as int),
      subcategories: intToBool(json[CategoryFields.subcategories] as int),
      parentId: json[CategoryFields.parentId] as int,
      colorBg: json[CategoryFields.colorBg] as String,
    );
  }

  Map<String, Object?> toJSON() => {
        CategoryFields.title: title,
        CategoryFields.subtitle: subtitle,
        CategoryFields.isShown: isShown != null && isShown! ? 1 : 0,
        CategoryFields.img: img,
        CategoryFields.subcategories:
            subcategories != null && subcategories! ? 1 : 0,
        CategoryFields.parentId: parentId,
        CategoryFields.colorBg: colorBg
      };

  static bool intToBool(int value) => value == 1;

  @override
  String toString() {
    logger.d('''
      id: $id,
      title: $title,
      subtitle: $subtitle,
      img: $img,
      isShown: $isShown,
      colorBg: $colorBg,
    ''');
    return super.toString();
  }
}
