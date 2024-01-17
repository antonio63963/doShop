import 'package:doshop_app/models/models/user_template.dart';

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
    CREATE TABLE IF NOT EXISTS $tableShoppingLists(
      ${ShoppingListFields.id} $idType,
      ${ShoppingListFields.title} $textType,
      ${ShoppingListFields.subtitle} TEXT,
      ${ShoppingListFields.colorBg} INTEGER,
      ${ShoppingListFields.img} TEXT
    );
  ''';
  static String createProductInList = '''
    CREATE TABLE IF NOT EXISTS $tableProductInList(
      ${ProductInListFields.id} $idType,
      ${ProductInListFields.prodId} INTENGER,
      ${ProductInListFields.listId} INTENGER NOT NULL,
      ${ProductInListFields.amount} REAL,
      ${ProductInListFields.title} TEXT,
      ${ProductInListFields.subtitle} TEXT,
      ${ProductInListFields.info} TEXT,
      ${ProductInListFields.units} TEXT,
      ${ProductInListFields.isFire} INTEGER NOT NULL,
      ${ProductInListFields.isDone} INTEGER NOT NULL,
      ${ProductInListFields.dateCreated} TEXT
    );
  ''';
  static String createUserTemplate = '''
    CREATE TABLE IF NOT EXISTS $tableUserTemplates(
      ${UserTemplateFields.id} $idType,
      ${UserTemplateFields.title} TEXT,
      ${UserTemplateFields.subtitle} TEXT,
      ${UserTemplateFields.img} TEXT,
      ${UserTemplateFields.productsIds} TEXT    
    );
  ''';
}
