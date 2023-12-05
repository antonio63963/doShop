import 'package:doshop_app/db/initial_data.dart';

import '../../models/exports.dart';

class SqlQueries {
  static String initCategories() {
    final values = categories.map((cat) => '''
    (${cat.id}, "${cat.title}","${cat.img}",
    ${cat.isShown != null && cat.isShown! ? 1 : 0},
    ${cat.subcategories != null && cat.subcategories! ? 1 : 0},
  ''');
    final valuesString = values.join(',');
    return '''
        INSERT INTO $tableCategories (${CategoryFields.values})
        VALUES $valuesString
      ''';
  }
  static String initSubcategories() {
    final values = subcategories.map((sub) => '''
    (${sub.id}, "${sub.title}", "${sub.subtitle}",
    ${sub.isShown != null && sub.isShown! ? 1 : 0}, "${sub.img}",
    ${sub.parentId}
  ''');
    final valuesString = values.join(',');
    return '''
        INSERT INTO $tableSubcategories (${CategoryFields.values})
        VALUES $valuesString
      ''';
  }

  static String allCategories = '''
    SELECT ${CategoryFields.id}, ${CategoryFields.title}, ${CategoryFields.isShown}, ${CategoryFields.img}, ${CategoryFields.subcategories}
    FROM $tableCategories
  ''';
}
