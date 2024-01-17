const String tableShoppingLists = 'shoppingLists';

class ShoppingListFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String img = 'img';
  static const String colorBg = 'colorBg';
}

class ShoppingList {
  final int? id;
  final String title;
  final String? subtitle;
  final String? img;
  final int? colorBg;

  ShoppingList({
    this.id,
    required this.title,
    this.subtitle,
    this.img,
    this.colorBg,
  });

  static ShoppingList fromJSON(Map<String, Object?> json) {
    return ShoppingList(
      id: json[ShoppingListFields.id] as int,
      title: json[ShoppingListFields.title] as String,
      subtitle: json[ShoppingListFields.subtitle] != null
          ? json[ShoppingListFields.subtitle] as String
          : null,
      img: json[ShoppingListFields.img] as String,
      colorBg: json[ShoppingListFields.colorBg] as int,
    );
  }

  Map<String, Object?> toJSON() => {
        ShoppingListFields.title: title,
        ShoppingListFields.subtitle: subtitle,
        ShoppingListFields.img: img,
        ShoppingListFields.colorBg: colorBg,
      };

  ShoppingList copy({
    int? id,
    String? title,
    int? productId,
    String? img,
    int? colorBg,
  }) =>
      ShoppingList(
        id: id ?? this.id,
        title: title ?? this.title,
        subtitle: subtitle,
        img: img ?? this.img,
        colorBg: colorBg ?? this.colorBg,
      );

  bool isChanged(ShoppingList list) =>
      title != list.title || img != list.img || colorBg != list.colorBg;

  @override
  String toString() {
    super.toString();
    return ''' 
      id: $id,
      title: $title,
      subtitle: $subtitle,
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
