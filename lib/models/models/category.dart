import 'package:logger/logger.dart';

var logger = Logger();

const String tableCategories = 'categories';

class CategoryFields {
  static String values = '''
    id, title, subtitle, img, isShown, subcategories, parentId
  ''';
  static const String id = 'id';
  static const String title = 'title';
  static const String isShown = 'isShown';
  static const String img = 'img';
  static const String subcategories = 'subcategories';
  static const String colorBg = 'colorBg';
}

class Category {
  int? id;
  String title;

  String? img;
  bool? isShown;

  bool? subcategories;
  String? colorBg;

  Category({
    this.id,
    required this.title,

    this.img,
    this.isShown = true,

    this.subcategories,
    this.colorBg,
  });

  Category copy({
    int? id,
    String? title,
    String? img,
    bool? isShown,
    bool? subcategories,
    String? colorBg,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        img: img ?? this.img,
        isShown: isShown ?? this.isShown,
        subcategories: subcategories ?? this.subcategories,
        colorBg: colorBg ?? this.colorBg,
      );

  static Category fromJSONtoCategory(Map<String, Object?> json) {
    return Category(
      id: json[CategoryFields.id] as int,
      title: json[CategoryFields.title] as String,
      img: json[CategoryFields.img] as String,
      isShown: intToBool(json[CategoryFields.isShown] as int),
      subcategories: intToBool(json[CategoryFields.subcategories] as int),
      // colorBg: json[CategoryFields.colorBg] as String,
    );
  }

  Map<String, Object?> toJSON() => {
        CategoryFields.title: title,
        CategoryFields.isShown: isShown != null && isShown! ? 1 : 0,
        CategoryFields.img: img,
        CategoryFields.subcategories:
            subcategories != null && subcategories! ? 1 : 0,
        CategoryFields.colorBg: colorBg
      };

  static bool intToBool(int value) => value == 1;

  @override
  String toString() {
    logger.d('''
      id: $id,
      title: $title,
      img: $img,
      isShown: $isShown,
      colorBg: $colorBg,
    ''');
    return super.toString();
  }
}
