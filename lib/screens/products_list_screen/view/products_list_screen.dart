import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';

import 'package:doshop_app/screens/products_list_screen/view/form/product_form.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/products_list_appbar.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/tags_section.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'widgets/products_list.dart';
import 'widgets/search_input.dart';

class ProductsListScreen extends StatefulWidget {
  static String routeName = '/products';

  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  bool isInit = false;
  bool isLoaded = false;
  late ProductsScreenArguments _screenArguments;

  late ProductProvider productProvider;
  List<Product> _productsList = [];

  void openModal() {
    Helper.showModal(
      context,
      ProductForm(
        catImg: _screenArguments.catImg,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      _screenArguments =
          ModalRoute.of(context)?.settings.arguments as ProductsScreenArguments;
      productProvider = Provider.of<ProductProvider>(context);
      Provider.of<ProductProvider>(context)
          .getProductsByCategory(context, _screenArguments.id);
      isInit = true;
      isLoaded = true;
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    productProvider.creanProductsList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _productsList = productProvider.products;

    return Scaffold(
      appBar: ProductsListAppBar(
        appBar: AppBar(),
        title: _screenArguments.title,
        subtitle: _screenArguments.subtitle ?? '',
      ),
      body: PageContentWrapper(
        onRefresh: () =>
            productProvider.getProductsByCategory(context, _screenArguments.id),
        widgets: [
          SearchInput(
            onInput: (String value) => productProvider.setSearchData(value),
          ),
          const TagsSection(),
          _productsList.isNotEmpty
              ? const ProductList()
              : const EmptyScreen(
                  message: 'Пока что нет товаров',
                ),
        ],
      ),
      floatingActionButton: !productProvider.isAnySelected
          ? FAB(
              onClick: openModal,
              icon: Icons.add,
            )
          : FAB(
              onClick: () {},
              svgPath: 'assets/icons/addToList.svg',
            ),
    );
  }
}
