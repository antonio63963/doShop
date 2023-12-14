import 'package:doshop_app/models/exports.dart';

import '../initial_data.dart';

class SqlInitialData {
  static String initCategories() {
    final values = categories.map((cat) => '''
    (
      ${cat.id}, ${cat.parentId}, "${cat.title}", "${cat.subtitle}", 
      "${cat.img}",
      ${cat.isShown ? 1 : 0},
      ${cat.colorBg},
      ${cat.isSubcat ? 1 : 0},
      ${cat.hasSubcategories ? 1 : 0}
    )
  ''');
    final valuesString = values.join(',');
    return '''
        INSERT INTO $tableCategories (${CategoryProdFields.values})
        VALUES $valuesString
      ''';
  }

  // static String initSubcategories() {
  //   final values = subcategories.map((sub) => '''
  //   (
  //     ${sub.id}, "${sub.title}", "${sub.subtitle}",
  //     "${sub.img}",
  //     ${sub.isShown != null && sub.isShown! ? 1 : 0}, 
  //     ${sub.parentId}
  //   )
  // ''');

  //   final valuesString = values.join(',');
  //   return '''
  //       INSERT INTO $tableSubcategories (${SubcategoryFields.values})
  //       VALUES $valuesString
  //     ''';
  // }

  static String initProducts() {
    final values = products.map((prod) => '''
    (
      ${prod.id}, ${prod.catId}, "${prod.title}", "${prod.subtitle}",
      "${prod.icon}", ${prod.photos}, "${prod.units}", "${prod.tag}", 
      "${prod.description}", ${prod.isShown ? 1 : 0}
    )
  ''');

    final valuesString = values.join(',');
    return '''
        INSERT INTO $tableProducts (${ProductFields.values})
        VALUES $valuesString
      ''';
  }
}