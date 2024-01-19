import 'package:doshop_app/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/show_modal.dart';

import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_data_list.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:provider/provider.dart';

class PageWithSearch extends StatefulWidget {
  final Widget? beforeInput;
  final Widget content;
  final bool isLoaded;

  const PageWithSearch({
    super.key,
    required this.content,
    required this.isLoaded,
    this.beforeInput,
  });

  @override
  State<PageWithSearch> createState() => _PageWithSearchState();
}

class _PageWithSearchState extends State<PageWithSearch> {
  final TextEditingController searchController = TextEditingController();
  bool isInit = false;

  Timer? checkTypingTimer;
  List<Product> _productsBySearch = [];

  void getProductsBySearch(String searchString) {
    if (searchController.text.trim().isEmpty) {
      setState(() {
        _productsBySearch = [];
      });
      return;
    }
    checkTypingTimer?.cancel();
    checkTypingTimer = Timer(const Duration(milliseconds: 500), () async {
      final searchData =
          await Provider.of<ProductProvider>(context, listen: false)
              .searchInAllProducts(context, searchController.text);
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
  Widget build(BuildContext context) {
    return !widget.isLoaded
        ? const Loading()
        : ListView(
            children: [
              widget.beforeInput ?? const SizedBox(),
              Input(
                inputController: searchController,
                onChange: getProductsBySearch,
                paddingVertical: 32,
              ),
              _productsBySearch.isEmpty
                  ? widget.content
                  : SearchDataList(
                      onItemClick: onSearchItem,
                      productsList: _productsBySearch),
              const SizedBox(height: 30),
            ],
          );
  }
}
