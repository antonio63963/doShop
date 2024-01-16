import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

const String tableProductInList = 'productInLists';

class ProductInListFields {
  static String values = '''
  id, prodId, listId, amount, isFire, isDone, dateCreated
 ''';

  static const String id = 'id';
  static const String prodId = 'prodId';
  static const String listId = 'listId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
  static const String info = 'info';
  static const String units = 'units';
  static const String amount = 'amount';
  static const String isFire = 'isFire';
  static const String isDone = 'isDone';
  static const String dateCreated = 'dateCreated';
}

class ProductInList {
  final int? id;
  final int? prodId;
  final int listId;
  double amount;
  bool isFire = false;
  bool isDone = false;
  final DateTime dateCreated;
  //for ui
  final String? title;
  final String? subtitle;
  final String? info;
  final int? colorBg;
  final String? icon;
  final String? units;
  final String? catTitle;

  ProductInList({
    this.id,
    this.prodId,
    required this.amount,
    required this.listId,
    this.isFire = false,
    this.isDone = false,
    required this.dateCreated,
    this.title,
    this.subtitle,
    this.info,
    this.colorBg,
    this.icon,
    this.units,
    this.catTitle,
  });

  ProductInList copy({
    int? id,
    int? prodId,
    int? listId,
    double? amount,
    bool? isFire,
    DateTime? dateCreated,
    bool? isDone,
    String? icon,
    int? colorBg,
    String? title,
    String? subtitle,
    String? info,
    String? units,
    String? catTitle,
  }) {
    return ProductInList(
      id: id ?? this.id,
      prodId: prodId ?? this.prodId,
      listId: listId ?? this.listId,
      amount: amount ?? this.amount,
      isFire: isFire ?? this.isFire,
      dateCreated: dateCreated ?? this.dateCreated,
      isDone: isDone ?? this.isDone,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      info: info ?? this.info,
      colorBg: colorBg ?? this.colorBg,
      units: units ?? this.units,
      catTitle: catTitle ?? this.catTitle,
    );
  }

  Map<String, Object?> toJSON() => {
        ProductInListFields.prodId: prodId,
        ProductInListFields.listId: listId,
        ProductInListFields.title: title,
        ProductInListFields.subtitle: subtitle,
        ProductInListFields.info: info,
        ProductInListFields.units: units,
        ProductInListFields.amount: amount,
        ProductInListFields.isFire: isFire ? 1 : 0,
        ProductInListFields.isDone: isDone ? 1 : 0,
        ProductInListFields.dateCreated: dateCreated.toIso8601String(),
      };

  static ProductInList fromJSON(Map<String, Object?> json) {
    return ProductInList(
      id: json[ProductInListFields.id] as int,
      prodId: json[ProductInListFields.prodId] != null &&
              json[ProductInListFields.prodId] != 'null'
          ? json[ProductInListFields.prodId] as int
          : null,
      amount: json[ProductInListFields.amount] as double,
      listId: json[ProductInListFields.listId] as int,
      isFire: intToBool(json[ProductInListFields.isFire] as int),
      title: json['title'] as String,
      subtitle: json['subtitle'] != null && json['subtitle'] != 'null'
          ? json['subtitle'] as String
          : null,
      info: json['info'] != null && json['info'] != 'null'
          ? json['info'] as String
          : null,
      icon: json['icon'] != null && json['icon'] != 'null'
          ? json['icon'] as String
          : null,
      colorBg:
          json['colorBg'] is int ? json['colorBg'] as int : MyColors.defaultBG,
      isDone: intToBool(json[ProductInListFields.isDone] as int),
      units: json['units'] != null ? json['units'] as String : null,
      catTitle: json['catTitle'] != null ? json['catTitle'] as String : null,
      dateCreated:
          DateTime.parse(json[ProductInListFields.dateCreated] as String),
    );
  }

  bool isChanged(ProductInList prod2) =>
      amount != prod2.amount || isFire != prod2.isFire ? true : false;

  static bool intToBool(int value) => value == 0 ? false : true;

  static List<ProductInList> convertProductsToSelected(
      List<Product> products, int listId) {
    return products
        .map((p) => ProductInList(
              amount: p.amount,
              prodId: p.id,
              isFire: p.isFire,
              listId: listId,
              dateCreated: DateTime.now(),
            ))
        .toList();
  }

  static List<ProductInList> twoMapsConcatToList(
    List<Map<String, Object?>> map1,
    List<Map<String, Object?>> map2,
  ) {
    final prodsResult1 = map1.map((p) => ProductInList.fromJSON(p)).toList();
    final prodsResult2 = map2.map((p) => ProductInList.fromJSON(p)).toList();
    return [...prodsResult1, ...prodsResult2];
  }

  @override
  String toString() {
    super.toString();
    return '''
      id: $id,
      prodId: $prodId,
      amount: $amount,
      listId: $listId,
      isFire: $isFire,
      title: $title,
      subtitle: $subtitle,
      icon: $icon,
      colorBg: $colorBg,
      isDone: $isDone,
      catTitle: $catTitle,
      dateCreated: $dateCreated,
     ''';
  }
}
