import 'package:doshop_app/models/exports.dart';

abstract class AbstractDB {
  Future<List<CategoryProd>?> getCategories();
  Future<List<Subcategory>?> getSubcategories(int catId);
  Future<List<Product>?> getProuductsByCategory(int catId);
}
