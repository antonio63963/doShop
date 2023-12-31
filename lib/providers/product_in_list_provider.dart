import 'package:doshop_app/db/exports.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProductInListProvider extends ErrorHandler {
  List<ProductInList> _products = [];

  List<ProductInList> get products => [..._products];

  Future<void> createProductInList(
      BuildContext context, ProductInList prod) async {
    GetIt.I<AbstractDB>().createProductInList(prod).then((response) {
      if (response == null) return;
      logger.i('Created ProdINList, ${response.toString()}');
      _products.add(response);
      notifyListeners();
    }).catchError((err) {
      logger.e('Create Product in List ERROR: $err');
      setErrorAlert(
          context: context, message: 'Не удалось добавить товар в список!');
    });
  }

  Future<void> insertMany(
      BuildContext context, List<ProductInList> prodList) async {
    GetIt.I<AbstractDB>().insertManyProductsInList(prodList).then((response) {
      if (response == null) return;
      logger.i('Created ProdINList, ${response.toString()}');
      _products = [..._products, ...response];
      notifyListeners();
    }).catchError((err) {
      logger.e('insert many Products in List ERROR: $err');
      setErrorAlert(
          context: context, message: 'Не удалось добавить товары в список!');
    });
  }

  Future<void> getProductsInList(BuildContext context, int listId) async {
    GetIt.I<AbstractDB>().getProductsInList(listId).then((response) {
      if (response == null) return;
      _products = response;
      notifyListeners();
    }).catchError((err) {
      logger.e('Get Products in List ERROR: $err');
      setErrorAlert(
          context: context, message: 'Не удалось получить товары списка!');
    });
  }

  Future<void> updateProductInList(
      BuildContext context, ProductInList list) async {
    GetIt.I<AbstractDB>().updateProductInList(list).then((response) {
      if (response == null) return;
      final idx = _products.indexWhere((p) => p.id == list.id);
      if (idx != -1) {
        _products[idx] = list;
        notifyListeners();
      }
    }).catchError((err) {
      logger.e('Update Product in List ERROR: $err');
      setErrorAlert(
          context: context,
          message: 'Не удалось редактировать товар в списке!');
    });
  }

  Future<void> deleteProductInList(BuildContext context, int id) async {
    GetIt.I<AbstractDB>().deleteProductInList(id).then((response) {
      if (response == 0) return;
      _products.removeWhere((p) => p.id == id);
      notifyListeners();
    }).catchError((err) {
      logger.e('Delete Product in List ERROR: $err');
      setErrorAlert(
          context: context, message: 'Не удалось удалить товар в списке!');
    });
  }

  Future<void> cleanShoppingList(
      BuildContext context, List<ProductInList> prodList) async {
    GetIt.I<AbstractDB>().deleteManyProductInList(prodList).then((response) {
      if (response == 0) return;
      for (var prod in prodList) {
        _products.removeWhere((p) => p.id == prod.id);
      }
      notifyListeners();
    }).catchError((err) {
      logger.e('Clean List ERROR: $err');
      setErrorAlert(context: context, message: 'Не удалось отчистить список!');
    });
  }
}
