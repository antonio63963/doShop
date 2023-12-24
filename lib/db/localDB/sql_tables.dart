import '../../models/exports.dart';

const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
const intType = 'INTEGER NOT NULL';
const textType = 'TEXT NOT NULL';

class SqlTables {
  static String createCategories = '''
    CREATE TABLE IF NOT EXISTS $tableCategories(
      ${CategoryProdFields.id} $idType,
      ${CategoryProdFields.parentId} INTEGER,
      ${CategoryProdFields.title} $textType,
      ${CategoryProdFields.subtitle} $textType,
      ${CategoryProdFields.img} TEXT,
      ${CategoryProdFields.isShown} INTEGER DEFAULT 1 NOT NULL,
      ${CategoryProdFields.hasSubcategories} INTEGER DEFAULT 0 NOT NULL,
      ${CategoryProdFields.colorBg} INTEGER,
      ${CategoryProdFields.isSubcat} INTEGER
    );
  ''';
  // static String createCategories = '''
  //   CREATE TABLE IF NOT EXISTS $tableCategories(
  //     ${CategoryProdFields.id} $idType,
  //     ${CategoryProdFields.title} $textType,
  //     ${CategoryProdFields.img} TEXT,
  //     ${CategoryProdFields.isShown} INTEGER DEFAULT 1 NOT NULL,
  //     ${CategoryProdFields.subcategories} INTEGER DEFAULT 0 NOT NULL,
  //     ${CategoryProdFields.colorBg} INTEGER
  //   );
  // ''';

  // static String createSubcategories = '''
  //   CREATE TABLE IF NOT EXISTS $tableSubcategories(
  //     ${SubcategoryFields.id} $idType,
  //     ${SubcategoryFields.title} $textType,
  //     ${SubcategoryFields.subtitle} TEXT,
  //     ${SubcategoryFields.img} TEXT,
  //     ${SubcategoryFields.isShown} INTEGER DEFAULT 1 NOT NULL,
  //     ${SubcategoryFields.parentId} INTEGER
  //   );
  // ''';

  static String createProducts = '''
    CREATE TABLE IF NOT EXISTS $tableProducts(
      ${ProductFields.id} $idType,
      ${ProductFields.catId} INTEGER NOT NULL,
      ${ProductFields.title} $textType,
      ${ProductFields.subtitle} TEXT,
      ${ProductFields.icon} TEXT,
      ${ProductFields.units} TEXT,
      ${ProductFields.tag} TEXT,
      ${ProductFields.info} TEXT,
      ${ProductFields.isShown} INTEGER DEFAULT 1 NOT NULL
    );
  ''';

  static String createPhotos = '''
    CREATE TABLE IF NOT EXISTS $tablePhotos(
      ${PhotoFields.id} $idType,
      ${PhotoFields.photo} TEXT,
      ${PhotoFields.productId} INT,
      ${PhotoFields.categoryId} INT
    );
  ''';
}
