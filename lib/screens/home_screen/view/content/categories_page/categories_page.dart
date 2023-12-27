import 'dart:async';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/categories_list_section.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_data_list.dart';
import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/categories_provider.dart';

import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/category_item.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/fast_enter_form.dart';

import 'package:doshop_app/screens/subcategories_screen/exports.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final TextEditingController searchController = TextEditingController();

  bool isInit = false;
  bool isLoaded = false;
  late ProductProvider _productProvider;

  Timer? checkTypingTimer;
  List<Product> _productsBySearch = [];

  void getProductsBySearch(String searchStr) {
    checkTypingTimer?.cancel();

    checkTypingTimer = Timer(const Duration(microseconds: 1000), () async {
      final searchData =
          await _productProvider.searchInAllProducts(context, searchStr);
      setState(() {
        _productsBySearch = searchData;
      });
    });
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      _productProvider = Provider.of<ProductProvider>(context);
      Provider.of<CategoriesProvider>(context).getCategoriesList(context);
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    return RefreshIndicator(
      onRefresh: () => categoriesProvider.getCategoriesList(context),
      // child: ElevatedButton(child: Text('test'), onPressed: () => SqlQueries.initCategories(),)

      child: ListView(children: [
        FastEnterForm(
          searchController: searchController,
          paddingBottom: 16,
          paddingTop: 16,
          onChange: getProductsBySearch,
        ),
        _productsBySearch.isEmpty
            ? CategoriesListSection(catList: categoriesProvider.categories)
            : SearchDataList(
                onItemClick: (int) {}, productsList: _productsBySearch),
      ]),
    );
  }
}
