import 'package:flutter/material.dart';

import 'package:doshop_app/exports.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class CategoriesProvider with ChangeNotifier {
  List<Category> _categories = [];

  List<Category> get categories {
    return  _categories;
  }

  Future<void> getCategoriesList() async {
    try {
      final categoriesList = await GetIt.I<AbstractDB>().getCategories();
      if (categoriesList == null) {
        _categories = [];
      }
    } catch (err) {}
  }
}
