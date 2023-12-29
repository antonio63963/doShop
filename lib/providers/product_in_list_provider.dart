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
      _products.add(response);
      notifyListeners();
    }).catchError((err) {
      logger.e('Create Product in List ERROR: $err');
      setErrorAlert(
          context: context, message: 'Не удалось добавить товар в список!');
    });
  }
  Future<void> getProductsInList(
      BuildContext context, int listId) async {
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
}
