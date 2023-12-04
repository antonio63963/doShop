
import '../../exports.dart';

class SqlQueries {
   static String allCategories = '''
    SELECT ${CategoryFields.id}, ${CategoryFields.title}, ${CategoryFields.isShown}, ${CategoryFields.img}, ${CategoryFields.subcategories}, ${CategoryFields.colorBg}
    FROM $tableCategories
  ''';
}