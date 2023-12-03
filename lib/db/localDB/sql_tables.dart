import '../../models/exports.dart';

const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const intType = 'INTEGER NOT NULL';
const textType = 'TEXT NOT NULL';

class SqlTables {
  static String createCategories = '''
    CREATE TABLE IF NOT EXISTS $tableCategories(
      ${CategoryFields.id} $idType,
      ${CategoryFields.title} $textType,
      ${CategoryFields.subtitle} TEXT,
      ${CategoryFields.img} TEXT,
      ${CategoryFields.isShown} INTEGER DEFAULT 1 NOT NULL,
      ${CategoryFields.subcategories} INTEGER DEFAULT 0 NOT NULL,
      ${CategoryFields.parentId} INTEGER
    );
  ''';
  static String createProducts = '''
    CREATE TABLE IF NOT EXISTS $tableProducts(
      ${ProductFields.id} $idType,
      ${ProductFields.title} $textType,
      ${ProductFields.subtitle} TEXT,
      ${ProductFields.icon} TEXT,
      ${ProductFields.photos} TEXT,
      ${ProductFields.units} TEXT,
      ${ProductFields.description} TEXT,
      ${ProductFields.isShown} INTEGER DEFAULT 1 NOT NULL
    );
  ''';
  static String createPhotos = '''
    CREATE TABLE IF NOT EXISTS $tablePhotos(
      ${PhotoFields.id} $idType,
      ${PhotoFields.title} $textType,
      ${PhotoFields.photo} BLOB,
      ${PhotoFields.productId} INT,
      ${PhotoFields.categoryId} INT
    );
  ''';
}
