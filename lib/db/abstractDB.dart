import 'package:doshop_app/exports.dart';

abstract class AbstractDB {
  Future<List<Category>?> getCategories();
}