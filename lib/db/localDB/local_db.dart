import 'package:doshop_app/db/abstractDB.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/db/localDB/sql_tables.dart';

import 'sql_queries.dart';

class LocalDB implements AbstractDB{
  static final LocalDB instance = LocalDB._init();

  static Database? _database;
  static String? _dbPath;

  LocalDB._init();

  Future<Database?> get database async {
    logger.w('DB: $_database');
    if (_database != null) return _database;
    _database = await _initDB('doshop.db');
    logger.d('DB has been inited $_database');
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    _dbPath = path;
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
      onOpen: (db) => logger.d('OPENED: $db'),
      onConfigure: (db) async {
        logger.d('CONF: $db');
      },
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('PRAGMA foreign_keys=on;');
    await db.execute(SqlTables.createCategories);
    await db.execute(SqlTables.createSubcategories);
    await db.execute(SqlTables.createProducts);

    final response = await db.rawQuery(SqlQueries.initCategories());
    logger.d('Added Categ: $response');
    final subs = await db.rawQuery(SqlQueries.initSubcategories());
    logger.d('Added SUB: $subs');


    // await db.execute(SqlTables.createCars);
    // await db.execute(SqlTables.createCalendarEvents);
    // await db.execute(SqlTables.createClientsCars);
    // await db.execute(SqlTables.createDebetEvents);
    // await db.execute(SqlTables.createIndexVin);
    // await db.execute(SqlTables.createIndexBrand);
    // await db.execute(SqlTables.createIndexEventId);
  }

  //Categories
  @override
  Future<List<Category>?> getCategories() async{
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.allCategories);
    logger.i('Categories: $response');
    final a = response?.map((res) => Category.fromJSON(res)).toList();
    logger.w('AAAAAA: $a');
    return a;
  }

  savePhoto() {}

  //utils functions
  Future<void> deleteDB() async {
    logger.i('WOW $_database');
    final db = await instance.database;
    logger.i('DB DELETED: $db');
    return deleteDatabase(_dbPath!);
  }

  Future getAllTablesNames() async {
    final db = await instance.database;
    logger.d('Tables!!! ${await db?.query("sqlite_master") ?? "NOOOO"}');
  }
  
}
