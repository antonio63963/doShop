import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';
import '../utils/constants.dart';

class ProductProvider extends ErrorHandler {
  List<Product> _products = [];
  List<String> tags = [];
  bool isAnySelected = false;
  String? _selectedTag;
  String searchData = '';

  void setTag(String? tag) {
    if (tag == null || tags.contains(tag)) {
      return;
    } else {
      tags.add(tag);
    }
  }

  void setSelectedTag(String? tag) {
    logger.f('set Selected $tag');
    _selectedTag = tag;
    notifyListeners();
  }

  void setSearchData(String data) {
    searchData = data;
    notifyListeners();
  }

  List<Product> get products {
    final filterResult = filterByTag(_selectedTag, [..._products]);
    return filterByInput(searchData, filterResult);
  }

  List<Product> filterByTag(String? tag, List<Product> productsList) {
    if (tag != null) {
      return productsList
          .where((prod) => prod.tag!.toLowerCase().contains(tag.toLowerCase()))
          .toList();
    }
    return productsList;
  }

  void creanProductsList() {
    _products = [];
    isAnySelected = false;
    tags = [];
    notifyListeners();
  }

  Future<void> getProductsByCategory(BuildContext context, int catId) async {
    GetIt.I<AbstractDB>().getProuductsByCategory(catId).then((prods) {
      _products = prods != null ? sortAZ(prods) : [];
      for (var prod in _products) {
        setTag(prod.tag);
      }
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
      isAnySelected = true;
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
          if(_products[existProdIndex].amount == 0) {
            _products[existProdIndex].isFire = false;
          }
      _checkIfExistsSelected(); // to set Icon on FAB
      logger.i('EEEEEE(()()()) $isAnySelected');
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

  void _checkIfExistsSelected() {
    isAnySelected = false;
    for (var i = 0; i < _products.length; i++) {
      if (_products[i].amount > 0) {
        isAnySelected = true;
        break;
      }
    }
    notifyListeners();
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

  List<Product> filterByInput(String searchData, List<Product> productsList) {
    if (productsList.isEmpty) return [];
    if (searchData == '') return productsList;
    return productsList
        .where((prod) =>
            prod.title.toLowerCase().contains(searchData.toLowerCase()))
        .toList();
  }
}
