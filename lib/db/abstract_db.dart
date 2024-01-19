import 'package:doshop_app/models/exports.dart';

abstract class AbstractDB {
  Future<List<CategoryProd>?> getCategories();

  Future<List<CategoryProd>?> getSubcategories(int catId);

  Future<List<Product>?> getProuductsByCategory(int catId);
  Future<Product?> createProduct(Product product);
  Future<List<Product>> searchInAllProducts(String searchData);
  Future<Product?> getProductById(int id);
  Future<int?> updateProduct(Product prod);
  Future<int?> deleteProduct(int eventId);
  Future<Photo?> savePhoto(Photo newImg);

 Future<ProductInList?> createCustomProductInList(ProductInList prod);
  Future<List<ProductInList>?> insertManyProductsInList(
      List<ProductInList> prodList);
  Future<List<ProductInList>?> getProductsInList(int listId);
  Future<int?> updateProductInList(ProductInList prodInList);
  Future<int?> markProductAsDone(int id);
  Future<int?> cancelProductAsDone(int id);
  Future<int?> cleanShoppingList(int listId);
  Future<int?> deleteProductInList(int prodId);
  Future<int?> deleteManyProductInList(List<ProductInList> prodList);
  Future<int?> deleteProductsFromCart();

  Future<ShoppingList?> createList(ShoppingList product);
  Future<List<ShoppingList>?> getShoppingLists();
  Future<int?> updateShoppingList(ShoppingList list);
  Future<int?> deleteShoppingList(int listId);

  Future<UserTemplate?> createTempate(UserTemplate uTemp);
  Future<List<UserTemplate>?> getAllTemplates();
  Future<int?> updateTemplate(UserTemplate uTemp);
  Future<int?> deleteTemplate(int tempId);
  Future<List<Product>?> getTemplateProducts(String prodsIds);
}
