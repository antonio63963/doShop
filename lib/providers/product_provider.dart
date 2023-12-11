import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class ProductProvider extends ErrorHandler {
  List<Product> _products = [];

  String searchData = '';

  void setSearchData(String data) {
    searchData = data;
    notifyListeners();
  }

  List<Product> get products {
    return [..._products];
  }

  Future<void> getProductsByCategory(BuildContext context, int catId) async {
    GetIt.I<AbstractDB>().getProuductsByCategory(catId).then((prods) {
      _products = prods != null ? sortAZ(prods) : [];
      notifyListeners();
    }).catchError((err) {
      logger.e('Products by Category: $err');
      setErrorAlert(
          context: context, message: 'Не удалось получить Список продуктов!');
    });
  }

  //UTILS
  List<Product> sortAZ(List<Product> products) {
    products.sort((a, b) => a.title.compareTo(b.title));
    return products;
  }

  List<Product> sortByInput(String searchData) {
    final res = searchData == ''
        ? sortAZ(products)
        : products.where((prod) =>
            prod.title.toLowerCase().contains(searchData.toLowerCase()));
    return res.toList();
  }

  List<Product> search(String searchData) {
    logger.i('Serch data client input on Event create: $searchData $products');
    if (searchData == '') return [..._products];
    final res = [...products]
        .where((prod) =>
            prod.title.toLowerCase().contains(searchData.toLowerCase()))
        .toList();
    return res;
  }
}
