import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class CategoriesProvider extends ErrorHandler {
  List<Category> _categories = [];

  List<Category> get categories {
    return _categories;
  }

  Future<void> getCategoriesList(
    BuildContext context,
  ) async {
    try {
      final categoriesList = await GetIt.I<AbstractDB>().getCategories();
      logger.w('wow it comes: $categoriesList');
      if (categoriesList == null) {
        _categories = [];
      } else {
        _categories = categoriesList;
      }
      notifyListeners();
    } catch (err) {
      logger.e("GetCategoriesError: $err");
      // ignore: use_build_context_synchronously
      setErrorAlert(
          context: context,
          message:
              'Что-то пошло не так. Не удалось получить Список Категорий!');
    }
  }
  // GetIt.I<AbstractDB>().getCategories().then((categoriesList) => _categories = categoriesList ?? [] ).catchError((err) {
  //       logger.e("GetCategoriesError: $err");
  //     setErrorAlert(context: context, message: 'Что-то пошло не так. Не удалось получить Список Категорий!');

  // });
}
