import 'dart:async';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';
import '../utils/constants.dart';

class ProductProvider extends ErrorHandler {
  List<Product> _products = [];
  Product? productDetails;
  List<ProductTag> tags = [];
  bool isAnySelected = false;
  int? _selectedTagIdx;
  String searchData = '';

  void setTagToArray(String? tag) {
    if (tag == null) return;
    final idx = tags.indexWhere((el) => el.tag == tag);
    if (idx == -1) {
      tags.add(ProductTag(tag: tag));
    }
  }

  void setSelectedTag(int? idx) {
    if (_selectedTagIdx is int) {
      tags[_selectedTagIdx!].isSelected = false;
    }

    if (idx != null && _selectedTagIdx != idx) {
      _selectedTagIdx = idx;
      tags[idx].isSelected = true;
    } else {
      _selectedTagIdx = null;
    }
    notifyListeners();
  }

  List<ProductTag> copyTagsList() {
    return tags.map((t) {
      t.isSelected = false;
      return t;
    }).toList();
  }

  void setSearchData(String data) {
    searchData = data;
    notifyListeners();
  }

  // List<Product> allProductsBySearch(String searchData) {
  //   Timer? checkTypingTimer;

  //   startTimer() {
  //     checkTypingTimer = Timer(const Duration(microseconds:600), () {

  //     });
  //   }

  //   resetTimer() {
  //     checkTypingTimer?.cancel();
  //     startTimer();
  //   }
  // }

  List<Product> get products {
    final filterResult = filterByTag(_selectedTagIdx, [..._products]);
    return filterByInput(searchData, filterResult);
  }

  List<Product> filterByTag(int? tagIdx, List<Product> productsList) {
    if (tagIdx != null) {
      return productsList
          .where((prod) =>
              prod.tag!.toLowerCase().contains(tags[tagIdx].tag.toLowerCase()))
          .toList();
    }
    return productsList;
  }

  void creanProductsList() {
    _products = [];
    isAnySelected = false;
    tags = [];
    _selectedTagIdx = null;
    // notifyListeners();
  }

  Future<Product?> createProduct(BuildContext context, Product product) async {
    GetIt.I<AbstractDB>().createProduct(product).then((response) {
      if (response != null) {
        logger.d('CreatedProduct: ${response.toString()}');
        _products.add(response);
        if (response.tag != null) {
          setTagToArray(response.tag);
        }
        notifyListeners();
        return response;
      }
    }).catchError((err) {
      logger.e('Create product, $err');
      setErrorAlert(context: context, message: 'Не удалось создать продукт!');
      return null;
    });
    return null;
  }

  Future<void> getProductsByCategory(BuildContext context, int catId) async {
    GetIt.I<AbstractDB>().getProuductsByCategory(catId).then((prods) {
      _products = prods != null ? sortAZ(prods) : [];
      for (var prod in _products) {
        setTagToArray(prod.tag);
      }
      notifyListeners();
    }).catchError((err) {
      logger.e('Products by Category: $err');
      setErrorAlert(
          context: context, message: 'Не удалось получить Список продуктов!');
    });
  }

  Future<bool> getProductById(BuildContext context, int id) async {
    try {
      final product = await GetIt.I<AbstractDB>().getProductById(id);
      if (product != null) {
        productDetails = product;
        notifyListeners();
        return true;
      }
    } catch (err) {
      logger.e('Product by id: $err');
      setErrorAlert(context: context, message: 'Не удалось получить продукт!');
    }
    return false;
  }

  Future<Product?> updateProduct(BuildContext context, Product prod) async {
    try {
      final updatedResponse = await GetIt.I<AbstractDB>().updateProduct(prod);
      logger.i('UPDATED: $updatedResponse');
      if (updatedResponse != 0) {
        final updatedIdx =
            _products.indexWhere((element) => element.id == prod.id);
        if (updatedIdx != -1) {
          _products[updatedIdx] = prod;
          productDetails = prod;
          notifyListeners();
          return prod;
        }
      }
    } catch (err) {
      logger.e('Update Product: $err');
      setErrorAlert(context: context, message: 'Не удалось обновить продукт!');
      return null;
    }
    return null;
  }

  Future<int?> deleteProduct(BuildContext context, int prodId) async {
    if (productDetails?.id == null) {
      throw UnsupportedError('There is no id');
    }
    try {
      final deleted = await GetIt.I<AbstractDB>().deleteProduct(prodId);
      if (deleted != null) {
        _products = _products.where((p) => p.id != prodId).toList();
        notifyListeners();
        return deleted;
      }
    } catch (err) {
      logger.e('Delete Product: $err');
      setErrorAlert(context: context, message: 'Не удалось удалить продукт!');
      return 0;
    }
    return 0;
  }

  Future<void> savePhoto(BuildContext context, Photo photoData) async {
    logger.d('Save Photo provider: $photoData');
    await GetIt.I<AbstractDB>().savePhoto(photoData).then((ph) {
      if (ph != null && productDetails != null) {
        productDetails!.photos?.add(ph);
        notifyListeners();
      }
    }).catchError((err) {
      logger.e('Photo Save: $err');
      setErrorAlert(context: context, message: 'Не удалось сохранить фото!');
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

  void cleanAmount(int? prodId) {
    if (prodId == null) return;
    final existProdIndex =
        _products.indexWhere((existProd) => prodId == existProd.id);
    if (existProdIndex != -1) {
      _products[existProdIndex].amount = 0;
      _checkIfExistsSelected();
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
      if (_products[existProdIndex].amount == 0) {
        _products[existProdIndex].isFire = false;
      }
      _checkIfExistsSelected(); // to set Icon on FAB
      logger.i('EEEEEE(()()()) $isAnySelected');
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
