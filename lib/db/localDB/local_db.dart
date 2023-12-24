import 'dart:convert';
import 'dart:typed_data';

import 'package:doshop_app/db/abstractDB.dart';
import 'package:doshop_app/db/localDB/sql_initial_data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/db/localDB/sql_tables.dart';

import 'sql_queries.dart';

class LocalDB implements AbstractDB {
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
    // await db.execute(SqlTables.createSubcategories);
    await db.execute(SqlTables.createProducts);
    await db.execute(SqlTables.createPhotos);

    final response = await db.rawQuery(SqlInitialData.initCategories());
    logger.d('Added Categ: $response');
    // final subs = await db.rawQuery(SqlInitialData.initSubcategories());
    // logger.d('Added SUB: $subs');
    try {
      final prods = await db.rawQuery(SqlInitialData.initProducts());
    logger.i('Products: $prods');
      
    } catch (err) {
      logger.e('ON ADD PRODS: $err');
    }

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
  Future<List<CategoryProd>?> getCategories() async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.allCategories);
    logger.i('Categories: $response');
    return response?.map((res) => CategoryProd.fromJSON(res)).toList();
  }

  @override
  Future<List<CategoryProd>?> getSubcategories(int catId) async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.subcategoriesByCatId(catId));
    logger.i('SUbCatEGORIES: $response');

    final a = response?.map((sub) => CategoryProd.fromJSON(sub)).toList();
    logger.d('WOW: $a');
    return a;
  }

  //Products
  @override
  Future<List<Product>?> getProuductsByCategory(int catId) async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.productsByCategoryId(catId));
    // final response = await db?.rawQuery('SELECT * FROM products WHERE products.catId = 11');
    logger.i('Products by Category: $response');

    final a = response?.map((sub) => Product.fromJSON(sub)).toList();
    logger.i('$a');
    return a;
  }

  @override
  Future<Product?> createProduct(Product product) async {
    final db = await instance.database;
    final productId = await db?.insert(tableProducts, product.toJSON());
    logger.i('Created Product ID: $productId, ${product.toJSON()}');
    return product.copy(id: productId);
  }

  @override
  Future<Product?> getProductById(int id) async {
    final db = await instance.database;
    final map = await db?.rawQuery(
      SqlQueries.productById(id),
    );
    logger.d(' input ID: $id, getProuduct map: $map');
    if (map != null) {
      return Product.fromJSON(map[0]);
    }
    return null;
  }

  @override
  Future<int?> updateProduct(Product prod) async {
    if (prod.id == null) throw UnimplementedError('No id to update product!!!');
    logger.i("Product for update: ${prod.toString()}");
    final db = await instance.database;
    return await db?.update(
      tableProducts,
      prod.toJSON(),
      where: '${ProductFields.id} = ?',
      whereArgs: [prod.id],
    );
  }

  @override
  Future<int?> deleteProduct(int prodId) async {
    final db = await instance.database;
    final resp = await db?.delete(
      tableProducts,
      where: '${ProductFields.id} = ?',
      whereArgs: [prodId],
    );
    logger.i('Delete event response: $resp');
    return resp;
  }

  @override
  Future<Photo?> savePhoto(Photo newImg) async {
    final db = await instance.database;
    final photoId = await db?.insert(tablePhotos, newImg.toJSON());
    if (photoId != null) {
      return newImg.copy(id: photoId);
    }
    return null;
  }

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
