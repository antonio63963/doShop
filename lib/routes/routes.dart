import 'package:doshop_app/screens/add_product_screen/add_from_category_screen.dart';
import 'package:doshop_app/screens/home_screen/exports.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/product_details_screen.dart';
import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/shoping_list_details.dart';
import 'package:doshop_app/screens/subcategories_screen/exports.dart';
import 'package:doshop_app/screens/template_details_screen/template_details_screen.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  SubcategoriesScreen.routeName: (context) => const SubcategoriesScreen(),
  ProductsListScreen.routeName: (context) => const ProductsListScreen(),
  ProductDetailsScreen.routeName: (context) => const ProductDetailsScreen(),
  ShoppingListDetails.routeName: (context) => const ShoppingListDetails(),
  AddFromCategoryScreen.routeName: (context) => const AddFromCategoryScreen(),
  TemplateDetailsScreen.routeName: (context) => const TemplateDetailsScreen(),
};
