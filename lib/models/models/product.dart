const String tableProducts = 'products';

class ProductFields {
  static String values =
      'id, catId, title, subtitle, photos, units, description, isShown';
  static const String id = 'id';
  static const String catId = 'catId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String icon = 'icon';
  static const String photos = 'photos';
  static const String units = 'units';
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
  String? description;
  bool isShown;

  Product({
    this.id,
    required this.catId,
    required this.title,
    this.subtitle,
    this.icon,
    this.catImg,
    this.photos,
    required this.units,
    this.description,
    this.isShown = true,
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
    String? description,
    bool? isShown,
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
        description: description ?? this.description,
        isShown: isShown ?? this.isShown,
      );

  static Product fromJSON(Map<String, Object?> json) {
    return Product(
      id: json[ProductFields.id] as int,
      catId: json[ProductFields.catId] as int,
      title: json[ProductFields.title] as String,
      units: json[ProductFields.units] as String,
      catImg: json['catImg'] != null ? json['catImg'] as String : null,
    );
  }
}
