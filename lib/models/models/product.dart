import 'package:doshop_app/models/exports.dart';

const String tableProducts = 'products';

enum MenuOptionsValues { photo, edit, delete }

class ProductFields {
  static String values =
      'id, catId, title, subtitle, icon, units, tag, info, isShown';
  static const String id = 'id';
  static const String catId = 'catId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String icon = 'icon';
  static const String photos = 'photos';
  static const String units = 'units';
  static const String tag = 'tag';
  static const String info = 'info';
  static const String isShown = 'isShown';
}

class Product {
  int? id;
  int catId;
  String title;
  String? subtitle;
  String? icon;
  String? catImg;
  List<Photo>? photos;
  String units;
  String? tag;
  String? info;
  bool isShown;
  int? colorBg;
  // for select
  double amount = 0;
  bool isFire = false;
  // for full data
  String? categoryTitle;
  String? categorySubtitle;

  Product({
    this.id,
    required this.catId,
    required this.title,
    this.subtitle,
    this.icon,
    this.catImg,
    this.photos,
    required this.units,
    this.tag,
    this.info,
    this.isShown = true,
    this.colorBg,
    //for select
    this.amount = 0,
    this.isFire = false,
    this.categoryTitle,
    this.categorySubtitle,
  }) {
    photos = photos ?? [];
  }

  Product copy({
    int? id,
    int? catId,
    String? title,
    String? subtitle,
    String? icon,
    String? catImg,
    List<Photo>? photos,
    String? units,
    String? tag,
    String? info,
    bool? isShown,
    int? colorBg,
    String? categoryTitle,
    String? categorySubtitle,
  }) =>
      Product(
        id: id ?? this.id,
        catId: catId ?? this.catId,
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        icon: icon ?? this.icon,
        catImg: catImg ?? this.catImg,
        photos: photos ?? this.photos,
        units: units ?? this.units,
        tag: tag ?? this.tag,
        info: info ?? this.info,
        isShown: isShown ?? this.isShown,
        colorBg: colorBg ?? this.colorBg,
        categoryTitle: categoryTitle ?? this.categoryTitle,
        categorySubtitle: categorySubtitle ?? this.categorySubtitle,
      );

  Map<String, Object?> toJSON() => {
        ProductFields.title: title,
        ProductFields.catId: catId,
        ProductFields.icon: icon,
        ProductFields.subtitle: subtitle,
        ProductFields.tag: tag,
        ProductFields.units: units,
      };

  static Product fromJSON(Map<String, Object?> json) {
    return Product(
      id: json[ProductFields.id] as int,
      catId: json[ProductFields.catId] as int,
      title: json[ProductFields.title] as String,
      subtitle: json[ProductFields.subtitle] != null &&
              json[ProductFields.subtitle] != "null"
          ? json[ProductFields.subtitle] as String
          : null,
      units: json[ProductFields.units] as String,
      tag: json[ProductFields.tag] as String,
      icon:
          json[ProductFields.icon] != null && json[ProductFields.icon] != "null"
              ? json[ProductFields.icon] as String
              : null,
      catImg: json['catImg'] != null ? json['catImg'] as String : null,
      colorBg: json['colorBg'] != null ? json['colorBg'] as int : null,
      categorySubtitle: json['categorySubtitle'] != null
          ? json['categorySubtitle'] as String
          : null,
      categoryTitle: json['categoryTitle'] != null
          ? json['categoryTitle'] as String
          : null,
      photos: json[ProductFields.photos] == null
          ? []
          : json[ProductFields.photos] as List<Photo>,
    );
  }

  bool isEqual(Product prod2) {
    print(''' 
        $title == ${prod2.title} && $info == ${prod2.info} && $tag == ${prod2.tag} && $units == ${prod2.units} && $icon == ${prod2.icon}
      ''');
    if (title == prod2.title &&
        subtitle == prod2.subtitle &&
        info == prod2.info &&
        tag == prod2.tag &&
        units == prod2.units &&
        icon == prod2.icon) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String toString() {
    super.toString();
    return ''' 
      id: $id,
      title: $title,
      subtitle: $subtitle,
      units: $units,
      tag: $tag,
      icon: $icon,
      catId: $catId,
      info: $info,
      colorBg: $colorBg,
      categoryTitle: $categoryTitle,
      categorySubtitle: $categorySubtitle,
      catImg: $catImg,
      photos: $photos,
    ''';
  }
}

class ProductTag {
  final String tag;
  bool isSelected = false;
  ProductTag({required this.tag, this.isSelected = false});

  @override
  String toString() {
    super.toString();
    return '''
     { tag: $tag,
      isSelected: $isSelected
      }
    ''';
  }
}
