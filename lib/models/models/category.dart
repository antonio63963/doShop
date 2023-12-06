import 'package:logger/logger.dart';

var logger = Logger();

const String tableCategories = 'categories';

class CategoryProdFields {
  static String values = '''
    id, title, img, isShown, subcategories, colorBg
  ''';
  static const String id = 'id';
  static const String title = 'title';
  static const String isShown = 'isShown';
  static const String img = 'img';
  static const String subcategories = 'subcategories';
  static const String colorBg = 'colorBg';
}

class CategoryProd {
  int? id;
  String title;

  String? img;
  bool? isShown;

  bool? subcategories;
  int? colorBg;

  CategoryProd({
    this.id,
    required this.title,

    this.img,
    this.isShown = true,

    this.subcategories,
    this.colorBg,
  });

  CategoryProd copy({
    int? id,
    String? title,
    String? img,
    bool? isShown,
    bool? subcategories,
    int? colorBg,
  }) =>
      CategoryProd(
        id: id ?? this.id,
        title: title ?? this.title,
        img: img ?? this.img,
        isShown: isShown ?? this.isShown,
        subcategories: subcategories ?? this.subcategories,
        colorBg: colorBg ?? this.colorBg,
      );

  static CategoryProd fromJSON(Map<String, Object?> json) {
    return CategoryProd(
      id: json[CategoryProdFields.id] as int,
      title: json[CategoryProdFields.title] as String,
      img: json[CategoryProdFields.img] as String,
      isShown: intToBool(json[CategoryProdFields.isShown] as int),
      subcategories: intToBool(json[CategoryProdFields.subcategories] as int),
      colorBg: json[CategoryProdFields.colorBg] as int,
    );
  }

  Map<String, Object?> toJSON() => {
        CategoryProdFields.title: title,
        CategoryProdFields.isShown: isShown != null && isShown! ? 1 : 0,
        CategoryProdFields.img: img,
        CategoryProdFields.subcategories:
            subcategories != null && subcategories! ? 1 : 0,
        CategoryProdFields.colorBg: colorBg
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
