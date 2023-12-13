const String tableProducts = 'products';

class ProductFields {
  static String values =
      'id, catId, title, subtitle, icon, photos, units, tag, description, isShown';
  static const String id = 'id';
  static const String catId = 'catId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String icon = 'icon';
  static const String photos = 'photos';
  static const String units = 'units';
  static const String tag = 'tag';
  static const String description = 'description';
  static const String isShown = 'isShown';
}

class Product {
  int? id;
  int catId;
  String title;
  String? subtitle;
  String? icon;
  String? catImg;
  List<int>? photos;
  String units;
  String? tag;
  String? description;
  bool isShown;
  int? colorBg;
  // for select
  double amount = 0;
  bool isFire = false;

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
    this.description,
    this.isShown = true,
    this.colorBg,
    //for select
    this.amount = 0,
    this.isFire = false,
  });

  Product copy({
    int? id,
    int? catId,
    String? title,
    String? subtitle,
    String? icon,
    String? catImg,
    List<int>? photos,
    String? units,
    String? tag,
    String? description,
    bool? isShown,
    int? colorBg,
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
        description: description ?? this.description,
        isShown: isShown ?? this.isShown,
        colorBg: colorBg ?? this.colorBg,
      );

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
      icon: json[ProductFields.icon] != null
          ? json[ProductFields.icon] as String
          : null,
      catImg: json['img'] != null ? json['img'] as String : null,
      colorBg: json['colorBg'] != null ? json['colorBg'] as int : null,
    );
  }
}
