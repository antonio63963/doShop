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
    await db.execute(SqlTables.createProducts);
    await db.execute(SqlTables.createPhotos);
    await db.execute(SqlTables.createShopingLists);
    await db.execute(SqlTables.createProductInList);
    await db.rawQuery(SqlInitialData.initCategories());
    await db.rawQuery(SqlInitialData.initProducts());
  }

  //Categories
  @override
  Future<List<CategoryProd>?> getCategories() async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.allCategories);
    return response?.map((res) => CategoryProd.fromJSON(res)).toList();
  }

  @override
  Future<List<CategoryProd>?> getSubcategories(int catId) async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.subcategoriesByCatId(catId));
    final a = response?.map((sub) => CategoryProd.fromJSON(sub)).toList();
    logger.d('WOW: $a');
    return a;
  }

  //Products
  @override
  Future<List<Product>?> getProuductsByCategory(int catId) async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.productsByCategoryId(catId));
    logger.i('Products by Category: $response');
    return response?.map((sub) => Product.fromJSON(sub)).toList();
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
  Future<List<Product>> searchInAllProducts(String searchData) async {
    if (searchData == '') return [];
    final db = await instance.database;
    final response =
        await db?.rawQuery(SqlQueries.searchInAllPorducts(searchData));
    logger.i('SearchInAllProducts: $response');
    final res = response?.map((sub) => Product.fromJSON(sub)).toList();

    return res ?? [];
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

//SHOPING LISTS
  @override
  Future<ShoppingList?> createList(ShoppingList list) async {
    final db = await instance.database;
    final listId = await db?.insert(tableShoppingLists, list.toJSON());
    logger.i('Created ShoppingList ID: $listId, ${list.toJSON()}');
    return listId != null ? list.copy(id: listId) : null;
  }

  @override
  Future<List<ShoppingList>?> getShoppingLists() async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.allLists);
    logger.i('Get ShoppingLists: $response');
    if (response != null) {
      return response.map((list) => ShoppingList.fromJSON(list)).toList();
    }
    return null;
  }

  @override
  Future<int?> updateShoppingList(ShoppingList list) async {
    logger.i("Product for update: ${list.toString()}");
    final db = await instance.database;
    return await db?.update(
      tableShoppingLists,
      list.toJSON(),
      where: '${ShoppingListFields.id} = ?',
      whereArgs: [list.id],
    );
  }

  @override
  Future<int?> deleteShoppingList(int listId) async {
    final db = await instance.database;
    final resp = await db?.delete(
      tableShoppingLists,
      where: '${ShoppingListFields.id} = ?',
      whereArgs: [listId],
    );
    logger.i('Delete list response: $resp');
    return resp;
  }

  //PRODUCTS IN LIST
  @override
  Future<ProductInList?> createCustomProductInList(ProductInList prod) async {
    final db = await instance.database;
    final productInListId = await db?.insert(tableProductInList, prod.toJSON());
    logger.i(
        'Created CUSTOM ProductInList ID: $productInListId, ${prod.toJSON()}');
    return productInListId != null ? prod.copy(id: productInListId) : null;
  }

  @override
  Future<List<ProductInList>?> insertManyProductsInList(
      List<ProductInList> prodList) async {
    final db = await instance.database;
    if (db == null) throw UnimplementedError('Db not opened!');

    return db.transaction((txn) async {
      final listIdsMap =
          await txn.rawQuery(SqlQueries.insertOrUpdateProductsInList(prodList));
      final ids = listIdsMap.map((e) => e["id"] as int).toList().join(',');
      logger.i('INSERT MANY PROD IN LIST: $ids, ${prodList.toString()}');
      final addedProds =
          await txn.rawQuery(SqlQueries.getProductsInListByIds(ids));
      return addedProds.map((p) => ProductInList.fromJSON(p)).toList();
    });

    // return listIds.length == prodList.length
    //     ? prodList
    //         .asMap()
    //         .entries
    //         .map((p) => p.value.copy(id: listIds[p.key]["id"] as int))
    //         .toList()
    //     : null;
  }

  @override
  Future<List<ProductInList>?> getProductsInList(int listId) async {
    final db = await instance.database;
    return db?.transaction((txn) async {
      final prods = await txn.rawQuery(SqlQueries.getProductsInList(listId));
      final customProds =
          await txn.rawQuery(SqlQueries.customProductsInList(listId));
      return ProductInList.twoMapsConcatToList(prods, customProds);
    });
  }

  @override
  Future<int?> updateProductInList(ProductInList prodInList) async {
    logger.i("Product in list amount for update: ${prodInList.toString()}");
    final db = await instance.database;
    return await db?.update(
      tableProductInList,
      prodInList.toJSON(),
      where: '${ProductInListFields.id} = ?',
      whereArgs: [prodInList.id],
    );
  }

  @override
  Future<int?> markProductAsDone(int id) async {
    final db = await instance.database;
    return await db?.update(
      tableProductInList,
      {ProductInListFields.isDone: true},
      where: '${ProductInListFields.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int?> cancelProductAsDone(int id) async {
    final db = await instance.database;
    return await db?.update(
      tableProductInList,
      {ProductInListFields.isDone: false},
      where: '${ProductInListFields.id} = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<int?> deleteProductInList(int prodId) async {
    final db = await instance.database;
    return await db?.delete(
      tableProductInList,
      where: '${ProductInListFields.id} = ?',
      whereArgs: [prodId],
    );
  }

  @override
  Future<int?> deleteProductsFromCart() async {
    final db = await instance.database;
    final resp = await db?.delete(
      tableProductInList,
      where: '${ProductInListFields.isDone} = ?',
      whereArgs: [1],
    );
    logger.i('Delete Cart response: $resp');
    return resp;
  }

  @override
  Future<int?> deleteManyProductInList(List<ProductInList> prodList) async {
    final List<String> prodIdsList =
        prodList.fold([], (value, element) => [...value, '${element.id}']);
    final db = await instance.database;
    final resp = await db?.delete(
      tableProductInList,
      where:
          '${ProductInListFields.id} IN (${List.filled(prodList.length, '?').join(',')})',
      whereArgs: prodIdsList,
    );
    logger.i('Delete Many products in list. response: $resp');
    return resp;
  }

  @override
  Future<int?> cleanShoppingList(int listId) async {
    final db = await instance.database;
    final resp = await db?.delete(
      tableProductInList,
      where: '${ProductInListFields.listId} = ?',
      whereArgs: [listId],
    );
    logger.i('Delete Many products in list. response: $resp');
    return resp;
  }

  Future<List<ProductInList>?> getAllProdsInList() async {
    final db = await instance.database;
    final response = await db?.rawQuery(SqlQueries.getAllProductsInList());
    logger.i('All PRODUCTS in list. response: $response');
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
