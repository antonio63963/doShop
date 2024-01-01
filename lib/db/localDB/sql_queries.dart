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

  static String searchInAllPorducts(String searchData) => '''
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
    WHERE $tableProducts.${ProductFields.title} LIKE '%$searchData%';
  ''';

  static String productById(int id) => '''
    SELECT $tableProducts.*,
    $tableCategories.${CategoryProdFields.img} as catImg,
    $tableCategories.${CategoryProdFields.colorBg},
    $tableCategories.${CategoryProdFields.title} as categoryTitle,
    $tableCategories.${CategoryProdFields.subtitle} as categorySubtitle,
    $tablePhotos.${PhotoFields.id} as photoId,
    $tablePhotos.${PhotoFields.photo}
    FROM $tableProducts
    JOIN $tableCategories ON $tableCategories.${CategoryProdFields.id} = $tableProducts.${ProductFields.catId}
    LEFT JOIN $tablePhotos ON $tablePhotos.${PhotoFields.productId} = $id
    WHERE $tableProducts.${ProductFields.id} = $id;
  ''';

  static String allLists = '''
    SELECT *
    FROM $tableShopingLists;
  ''';

  static String getProductsInList(int listId) => '''
    SELECT $tableProductInList.*,
    $tableCategories.${CategoryProdFields.img} as catImg,
    $tableCategories.${CategoryProdFields.colorBg},
    $tableCategories.${CategoryProdFields.title},
    $tableCategories.${CategoryProdFields.subtitle}
    FROM $tableProductInList
    JOIN $tableProducts ON $tableProducts.${ProductFields.id} = $tableProductInList.${ProductInListFields.prodId}
    LEFT JOIN $tableCategories ON $tableProducts.${ProductFields.catId} IS NOT NULL AND $tableCategories.${CategoryProdFields.id} = $tableProducts.${ProductFields.catId}
    WHERE $tableProductInList.${ProductInListFields.listId} = $listId;
  ''';

  static String insertProductInList(ProductInList product) => '''
    INSERT OR REPLACE INTO $tableProductInList (${ProductInListFields.values})
    VALUES (${product.toJSON()})
    RETURNING id;
  ''';
  // static String insertOrUpdateProductInList(ProductInList product) => '''
  //   INSERT INTO $tableProductInList (${ProductInListFields.values})
  //   VALUES (${product.toJSON()}) ON DUPLICATE KEY UPDATE prodId = VALUES(prodId);
  // ''';

static String insertOrUpdateProductsInList(List<ProductInList> products) {
    final values = products.map((prod) => '''
    (
      (SELECT id FROM $tableProductInList WHERE prodId = ${prod.prodId}),
      ${prod.prodId}, ${prod.listId}, "${prod.amount}", "${prod.isFire ? 1 : 0}",
      "${prod.isDone ? 1 : 0}", "${prod.dateCreated}"
    )
  ''');

    final valuesString = values.join(',');
    return '''
        INSERT OR REPLACE INTO $tableProductInList (${ProductInListFields.values})
        VALUES $valuesString
        RETURNING id;
      ''';
  }

  static String getAllProductsInList() => '''
    SELECT *
    FROM $tableProductInList;
  ''';


}
