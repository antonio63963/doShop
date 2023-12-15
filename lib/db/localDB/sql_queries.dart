import '../../models/exports.dart';

class SqlQueries {
  static String allCategories = '''
    SELECT
     ${CategoryProdFields.id}, ${CategoryProdFields.title}, ${CategoryProdFields.isShown}, ${CategoryProdFields.img}, ${CategoryProdFields.hasSubcategories},
    ${CategoryProdFields.isSubcat},
    ${CategoryProdFields.colorBg}
    FROM $tableCategories
    WHERE $tableCategories.${CategoryProdFields.isSubcat} = 0
  ''';

  static String subcategoriesByCatId(int catId) {
    return '''
      SELECT $tableCategories.*
      FROM $tableCategories
      WHERE $tableCategories.${CategoryProdFields.parentId} = $catId
    ''';
  }

  static String productsByCategoryId(int catId) => '''
    SELECT $tableProducts.${ProductFields.id},
    $tableProducts.${ProductFields.catId},
    $tableProducts.${ProductFields.title},
    $tableProducts.${ProductFields.isShown},
    $tableProducts.${ProductFields.subtitle}, 
    $tableProducts.${ProductFields.units},
    $tableProducts.${ProductFields.tag},
    $tableProducts.${ProductFields.icon},
    $tableCategories.${CategoryProdFields.img},
    $tableCategories.${CategoryProdFields.colorBg}
    FROM $tableProducts
    JOIN $tableCategories ON $tableCategories.${CategoryProdFields.id} = $catId
    WHERE $tableProducts.${ProductFields.catId} = $catId
  ''';

  static String allProductsBySearch(String searchData) => '''
    SELECT $tableProducts.${ProductFields.id},
    $tableProducts.${ProductFields.catId},
    $tableProducts.${ProductFields.title},
    $tableProducts.${ProductFields.isShown},
    $tableProducts.${ProductFields.subtitle}, 
    $tableProducts.${ProductFields.units},
    $tableProducts.${ProductFields.tag},
    $tableProducts.${ProductFields.icon},
    $tableCategories.${CategoryProdFields.img},
    $tableCategories.${CategoryProdFields.colorBg}
    FROM $tableProducts
    JOIN $tableCategories ON $tableCategories.${CategoryProdFields.id} = $tableProducts.${ProductFields.catId}
    WHERE $tableProducts.${ProductFields.title} LIKE %$searchData%;
  ''';
}
