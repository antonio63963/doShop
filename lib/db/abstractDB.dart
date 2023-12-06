import 'package:doshop_app/models/exports.dart';

abstract class AbstractDB {
  Future<List<CategoryProd>?> getCategories();
}