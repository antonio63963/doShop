import 'dart:ui';

const String tableShopingLists = 'shopingLists';

class ShopingListFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String isTemplate = 'isTemplate';
  static const String img = 'img';
  static const String colorBg = 'colorBg';
}

class ShopingList {
  final int? id;
  final String title;
  final String? subtitle;
  final bool isTemplate;
  final String? img;
  final int? colorBg;

  ShopingList({
    this.id,
    required this.title,
    this.subtitle,
    this.isTemplate = false,
    this.img,
    this.colorBg,
  });

  static ShopingList fromJSON(Map<String, Object?> json) {
    return ShopingList(
      id: json[ShopingListFields.id] as int,
      title: json[ShopingListFields.title] as String,
      subtitle: json[ShopingListFields.subtitle] != null
          ? json[ShopingListFields.subtitle] as String
          : null,
      isTemplate: intToBool(json[ShopingListFields.isTemplate] as int),
      img: json[ShopingListFields.img] as String,
      colorBg: json[ShopingListFields.colorBg] as int,
    );
  }

  Map<String, Object?> toJSON() => {
        ShopingListFields.title: title,
        ShopingListFields.subtitle: subtitle,
        ShopingListFields.isTemplate: isTemplate,
        ShopingListFields.img: img,
        ShopingListFields.colorBg: colorBg,
      };

  ShopingList copy({
    int? id,
    String? title,
    String? photo,
    int? productId,
    String? img,
    int? colorBg,
  }) =>
      ShopingList(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle,
        isTemplate: isTemplate,
        img: img,
        colorBg: colorBg,
      );

  @override
  String toString() {
    super.toString();
    return ''' 
      id: $id,
      title: $title,
      subtitle: $subtitle,
      isTemplate: $isTemplate,
      img: $img,
      colorBg: $colorBg,
    ''';
  }

  static bool intToBool(int value) => value == 0 ? false : true;
}

class ColorTile {
  final int color;
  bool isSelected;
  ColorTile({required this.color, this.isSelected = false});
}
