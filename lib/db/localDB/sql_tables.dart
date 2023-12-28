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
      ${PhotoFields.productId} INTEGER NOT NULL,
      ${PhotoFields.categoryId} INTEGER NOT NULL
    );
  ''';
  static String createShopingLists = '''
    CREATE TABLE IF NOT EXISTS $tableShopingLists(
      ${ShopingListFields.id} $idType,
      ${ShopingListFields.title} $textType,
      ${ShopingListFields.subtitle} TEXT,
      ${ShopingListFields.isTemplate} INTEGER NOT NULL,
      ${ShopingListFields.colorBg} INTEGER
    );
  ''';
}
