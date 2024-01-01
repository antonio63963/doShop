const String tableProductInList = 'productInLists';

class ProductInListFields {
  static String values = '''
  id, prodId, listId, amount, isFire, isDone, dateCreated
 ''';
  static const String id = 'id';
  static const String prodId = 'prodId';
  static const String listId = 'listId';
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
  final int? colorBg;
  final String? icon;

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
    this.colorBg,
    this.icon,
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
      colorBg: colorBg ?? this.colorBg,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  Map<String, Object?> toJSON() => {
        ProductInListFields.prodId: prodId,
        ProductInListFields.listId: listId,
        ProductInListFields.amount: amount,
        ProductInListFields.isFire: isFire ? 1 : 0,
        ProductInListFields.isDone: isDone ? 1 : 0,
        ProductInListFields.dateCreated: dateCreated.toIso8601String(),
      };
  static ProductInList fromJSON(Map<String, Object?> json) {
    return ProductInList(
      id: json[ProductInListFields.id] as int,
      amount: json[ProductInListFields.amount] as double,
      listId: json[ProductInListFields.listId] as int,
      isFire: intToBool(json[ProductInListFields.isFire] as int),
      title: json['title'] as String,
      subtitle: json['subtitle'] != null ? json['subtitle'] as String : null,
      icon: json['icon'] as String,
      colorBg: json['colorBg'] as int,
      isDone: intToBool(json[ProductInListFields.isDone] as int),
      dateCreated:
          DateTime.parse(json[ProductInListFields.dateCreated] as String),
    );
  }

  static bool intToBool(int value) => value == 0 ? false : true;

  @override
  String toString() {
    super.toString();
    return '''
      id: $id,
      amount: $amount,
      listId: $listId,
      isFire: $isFire,
      title: $title,
      subtitle: $subtitle,
      icon: $icon,
      colorBg: $colorBg,
      isDone: $isDone,
      dateCreated: $dateCreated,
     ''';
  }
}
