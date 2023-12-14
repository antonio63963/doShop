import 'package:logger/logger.dart';

var logger = Logger();

const String tableCategories = 'categories';

class CategoryProdFields {
  static String values = '''
    id, parentId, title, subtitle, img, isShown, colorBg, isSubcat, hasSubcategories
  ''';
  static const String id = 'id';
  static const String parentId = 'parentId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isShown = 'isShown';
  static const String img = 'img';
  static const String colorBg = 'colorBg';
  static const String isSubcat = 'isSubcat';
  static const String hasSubcategories = 'hasSubcategories';
}

class CategoryProd {
  int? id;
  int? parentId;
  String title;
  String? subtitle;
  String? img;
  bool isShown = true;
  int? colorBg;
  bool isSubcat = false;
  bool hasSubcategories = false;

  CategoryProd({
    this.id,
    this.parentId,
    required this.title,
    this.subtitle,
    this.img,
    this.isShown = true,
    this.colorBg,
    this.isSubcat = false,
    this.hasSubcategories = false,
  });

  CategoryProd copy({
    int? id,
    int? parentId,
    String? title,
    String? subtitle,
    String? img,
    bool? isShown,
    int? colorBg,
    bool? isSubcat,
    bool? hasSubcategories,
  }) =>
      CategoryProd(
        id: id ?? this.id,
        parentId: parentId ?? this.parentId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        img: img ?? this.img,
        isShown: isShown ?? this.isShown,
        colorBg: colorBg ?? this.colorBg,
        hasSubcategories: hasSubcategories ?? this.hasSubcategories,
        isSubcat: isSubcat ?? this.isSubcat,
      );

  static CategoryProd fromJSON(Map<String, Object?> json) {
    return CategoryProd(
      id: json[CategoryProdFields.id] as int,
      parentId: json[CategoryProdFields.parentId] != null
          ? json[CategoryProdFields.parentId] as int
          : null,
      title: json[CategoryProdFields.title] as String,
      subtitle: json[CategoryProdFields.subtitle] != null ? json[CategoryProdFields.subtitle] as String : null,
      img: json[CategoryProdFields.img] as String,
      isShown: intToBool(json[CategoryProdFields.isShown] as int),
      hasSubcategories:
          intToBool(json[CategoryProdFields.hasSubcategories] as int),
      colorBg: json[CategoryProdFields.colorBg] as int,
      isSubcat: intToBool(json[CategoryProdFields.isSubcat] as int),
    );
  }

  Map<String, Object?> toJSON() => {
        CategoryProdFields.parentId: parentId,
        CategoryProdFields.title: title,
        CategoryProdFields.subtitle: subtitle,
        CategoryProdFields.isShown: isShown ? 1 : 0,
        CategoryProdFields.img: img,
        CategoryProdFields.hasSubcategories: hasSubcategories ? 1 : 0,
        CategoryProdFields.colorBg: colorBg,
        CategoryProdFields.isSubcat: isSubcat,
      };

  static bool intToBool(int value) => value == 1;

  @override
  String toString() {
    logger.d('''
      id: $id,
      parentId: $parentId,
      title: $title,
      subtitle: $subtitle,
      img: $img,
      isShown: $isShown,
      colorBg: $colorBg,
      hasSubcategories: $hasSubcategories,
      isSubcat: $isSubcat,
    ''');
    return super.toString();
  }
}
