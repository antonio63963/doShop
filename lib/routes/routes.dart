
import 'package:doshop_app/screens/home_screen/exports.dart';
import 'package:doshop_app/screens/product_screen.dart/view/product_screen.dart';
import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/subcategories_screen/exports.dart';


final routes = {
  '/': (context) => const HomeScreen(),
  SubcategoriesScreen.routeName: (context) => const SubcategoriesScreen(),
  ProductsListScreen.routeName: (context) => const ProductsListScreen(),
  ProductScreen.routeName: (context) => const ProductScreen(),
};
