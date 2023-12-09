
import 'package:doshop_app/screens/home_screen/exports.dart';
import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/subcategories_screen/exports.dart';


final routes = {
  '/': (context) => const HomeScreen(),
  SubcategoriesScreen.routeName: (context) => SubcategoriesScreen(),
  ProductsListScreen.routeName: (context) => ProductsListScreen(),
};
