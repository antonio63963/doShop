import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';
import '../utils/constants.dart';

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

  void creanProductsList() {
    _products = [];
    notifyListeners();
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

  //select
  void increaseAmount(int? prodId) {
    if (prodId == null) return;
    final existProdIndex =
        _products.indexWhere((existProd) => prodId == existProd.id);
    if (existProdIndex != -1) {
      _products[existProdIndex].units == Units.kg
          ? _products[existProdIndex].amount += 0.5
          : _products[existProdIndex].amount++;
      notifyListeners();
    } else {
      return;
    }
  }

  void decreaseAmount(int? prodId) {
    if (prodId == null) return;
    final existProdIndex =
        _products.indexWhere((existProd) => prodId == existProd.id);
    if (existProdIndex != -1) {
      _products[existProdIndex].units == Units.kg
          ? _products[existProdIndex].amount -= 0.5
          : _products[existProdIndex].amount--;
      notifyListeners();
    } else {
      return;
    }
  }

  void _markAsSelected(int idx) {
    final prod = _products[idx];
    if (prod.amount == 0) {
      prod.units == Units.kg ? prod.amount += 0.5 : prod.amount++;
    }
  }

  void toggleFire(int? prodId) {
    if (prodId == null) return;
    final existProdIndex =
        _products.indexWhere((existProd) => prodId == existProd.id);
    if (existProdIndex != -1) {
      _markAsSelected(existProdIndex);
      _products[existProdIndex].isFire
          ? _products[existProdIndex].isFire = false
          : _products[existProdIndex].isFire = true;

      notifyListeners();
    } else {
      return;
    }
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
