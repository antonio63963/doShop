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

  static String initProducts() {
    final values = products.map((prod) => '''
    (
      ${prod.id}, ${prod.catId}, "${prod.title}", "${prod.subtitle}",
      "${prod.icon}", "${prod.units}", "${prod.tag}", 
      "${prod.info}", ${prod.isShown ? 1 : 0}
    )
  ''');

    final valuesString = values.join(',');
    return '''
        INSERT INTO $tableProducts (${ProductFields.values})
        VALUES $valuesString
      ''';
  }
}