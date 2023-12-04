import 'package:doshop_app/providers/error_handler.dart';

import 'package:doshop_app/exports.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class CategoriesProvider extends ErrorHandler {
  List<Category> _categories = [];

  List<Category> get categories {
    return _categories;
  }

  void getCategoriesList(
    BuildContext context,
  ) {
    GetIt.I<AbstractDB>()
        .getCategories()
        .then((categoriesList) => _categories = categoriesList ?? [])
        .catchError((err) {
      logger.e("GetCategoriesError: $err");
      setErrorAlert(
          context: context,
          message:
              'Что-то пошло не так. Не удалось получить Список Категорий!');
    });
  }
}
