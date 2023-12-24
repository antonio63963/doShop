import 'package:doshop_app/models/exports.dart';

abstract class AbstractDB {
  Future<List<CategoryProd>?> getCategories();
  Future<List<CategoryProd>?> getSubcategories(int catId);
  Future<List<Product>?> getProuductsByCategory(int catId);
  Future<Product?> createProduct(Product product);
  Future<Product?> getProductById(int id);
  Future<int?> updateProduct(Product prod);
  Future<int?> deleteProduct(int eventId);
  Future<Photo?> savePhoto(Photo newImg);
}
