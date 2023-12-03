

import '../../exports.dart';

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
      ${CategoryFields.parentId} INTEGER,
    );
  ''';
    static String createProducts = '''
    CREATE TABLE IF NOT EXISTS $tableCategories(
      ${CategoryFields.id} $idType,
      ${CategoryFields.title} $textType,
      ${CategoryFields.subtitle} TEXT,
      ${CategoryFields.img} TEXT,
      ${CategoryFields.isShown} INTEGER DEFAULT 1 NOT NULL,
      ${CategoryFields.subcategories} INTEGER DEFAULT 0 NOT NULL,
      ${CategoryFields.parentId} INTEGER,
      ${CategoryFields.parentId} TEXT,
    );
  ''';
}