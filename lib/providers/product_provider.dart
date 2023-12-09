import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class ProductProvider extends ErrorHandler {
  List<Product> _products = [];

  List<Product> get categories {
    return [..._products];
  }

  Future<List<Product>?> getProductsByCategory(
      BuildContext context, int catId) async {
    try {
      return await GetIt.I<AbstractDB>().getProuductsByCategory(catId);
    } catch (err) {
      logger.e('Products by Category: $err');
      setErrorAlert(
          context: context,
          message: 'Не удалось получить Список продуктов!');
    }
    return null;
  }

  
}
