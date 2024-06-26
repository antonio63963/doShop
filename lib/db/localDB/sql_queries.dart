import 'package:doshop_app/db/initial_data.dart';

import '../../models/exports.dart';

class SqlQueries {
  static String allCategories = '''
    SELECT ${CategoryProdFields.id}, ${CategoryProdFields.title}, ${CategoryProdFields.isShown}, ${CategoryProdFields.img}, ${CategoryProdFields.subcategories}, 
    ${CategoryProdFields.colorBg}
    FROM $tableCategories
  ''';

  static String subcategoriesByCatId(int catId) {
    return '''
      SELECT $tableSubcategories.*, $tableCategories.${CategoryProdFields.colorBg}
      FROM $tableSubcategories
      JOIN $tableCategories ON $tableCategories.${CategoryProdFields.id} = $catId
      WHERE $tableSubcategories.${SubcategoryFields.parentId} = $catId
    ''';
  }

  static String productsByCategoryId(int catId) => '''
    SELECT $tableProducts.${ProductFields.id},
    $tableProducts.${ProductFields.catId},
    $tableProducts.${ProductFields.title},
    $tableProducts.${ProductFields.isShown},
    $tableProducts.${ProductFields.subtitle}, 
    $tableProducts.${ProductFields.units},
    $tableSubcategories.${SubcategoryFields.img}
    FROM $tableProducts
    JOIN $tableSubcategories ON $tableSubcategories.${SubcategoryFields.id} = $catId
    WHERE $tableProducts.${ProductFields.catId} = $catId
  ''';
}
