
import 'package:doshop_app/db/initial_data.dart';
import 'package:doshop_app/exports.dart';
import 'package:get_it/get_it.dart';

import '../db/exports.dart';

class CategoriesProvider {
  List<Category> _categories = [];
  
  Future<void> getCategoriesList() async {
    try {
      final categoriesList = await GetIt.I<AbstractDB>().getCategories();
      if(categoriesList == null) {
        _categories = [];

      }
    } catch(err) {

    }
  }
}