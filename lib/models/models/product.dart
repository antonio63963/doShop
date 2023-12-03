import 'package:logger/logger.dart';

var logger = Logger();

const String tableProducts = 'products';

class ProductFields {
  static const String id = 'id';
  static const String catId = 'catId';
  static const String title = 'title';
  static const String subtitle = 'subtitle';
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
  List<int>? photos;
  String units;
  String? description;
  bool isShown;

  Product({
    this.id,
    required this.catId,
    required this.title,
    this.subtitle,
    this.photos,
    required this.units,
    this.description,
    this.isShown = true,
  });
}
