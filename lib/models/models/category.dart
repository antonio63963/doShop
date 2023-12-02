import 'dart:ffi';

const String tableCategories = 'categories';

class CategoriesFields {
  static const String id = 'id';
  static const String title = 'title';
  static const String isShown = '1';
  static const String img = 'img';
}

class Category {
  int? id;
  String title;
  String img;
  Bool isShown = true as Bool;
  Category(this.id, this.title, this.img, this.isShown);


  
}