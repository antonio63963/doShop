import 'dart:async';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/categories_list_section.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_data_list.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/categories_provider.dart';

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

  void onSearchItem(Product prod) {
    showModal(
      context,
      SelectedProductModal(
        prod: prod,
      ),
    );
    setState(() {
      _productsBySearch = [];
      searchController.text = '';
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
    final addToList = Provider.of<ShoppingListProvider>(context, listen: false).addToList;

    return RefreshIndicator(
      onRefresh: () => categoriesProvider.getCategoriesList(context),
      child: ListView(children: [
        addToList != null
            ? const SectionTitle(
                title: 'Категории',
                paddingBottom: 0,
                fontSize: 20,
              )
            : const SizedBox(),
        Input(
          inputController: searchController,
          onChange: getProductsBySearch,
          paddingVertical: 32,
        ),
        _productsBySearch.isEmpty
            ? CategoriesListSection(catList: categoriesProvider.categories)
            : SearchDataList(
                onItemClick: onSearchItem, productsList: _productsBySearch),
      ]),
    );
  }
}
