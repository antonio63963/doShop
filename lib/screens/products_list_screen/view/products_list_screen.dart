import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/show_modal.dart';

import 'package:doshop_app/forms/product_form/product_form.dart';
import 'package:doshop_app/forms/select_list_alert/select_list_modal.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/actions.dart';
import 'package:doshop_app/widgets/appbar_add_to_list.dart';

import 'package:doshop_app/screens/products_list_screen/view/widgets/tags_section.dart';
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
  late ProductsListScreenArguments _screenArguments;
  ShoppingList? _addToList;

  late ProductProvider productProvider;
  List<Product> _productsList = [];

  void openModal() {
    showModal(
      context,
      ProductForm(
        catId: _screenArguments.id,
        colorBg: _screenArguments.colorBg,
        tagsList: productProvider.copyTagsList(),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    if (!isInit) {
      _screenArguments = ModalRoute.of(context)?.settings.arguments
          as ProductsListScreenArguments;
      productProvider = Provider.of<ProductProvider>(context);
      Provider.of<ProductProvider>(context, listen: false)
          .getProductsByCategory(context, _screenArguments.id);
      isInit = true;
      isLoaded = true;
      _addToList =
          Provider.of<ShoppingListProvider>(context, listen: false).addToList;
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    productProvider.onLeave();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _productsList = productProvider.products;
    final addToList =
        Provider.of<ShoppingListProvider>(context, listen: false).addToList;

    return Scaffold(
      appBar: addToList != null
          ? AppBarAddToList(
              listId: addToList.id!,
              listTitle: addToList.title,
              backToList: () {
                Navigator.pop(context);
                if (_screenArguments.backToList != null) {
                  _screenArguments.backToList!();
                }
              },
            )
          : AppBar(
              title: Text(
                  '${_screenArguments.title} ${_screenArguments.subtitle ?? ''}'),
              actions: getActions(context),
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
          const SizedBox(
            height: 32,
          )
        ],
      ),
      floatingActionButton: !productProvider.isAnySelected
          ? addToList == null
              ? FAB(
                  onClick: openModal,
                  icon: Icons.add,
                )
              : null
          : FAB(
              onClick: _addToList != null
                  ? () {
                      final productsWithAmount =
                          Provider.of<ProductProvider>(context, listen: false)
                              .getSelectedProducts();
                      final selectedProducts =
                          ProductInList.convertProductsToSelected(
                              productsWithAmount, addToList!.id!);
                      Provider.of<ProductInListProvider>(context, listen: false)
                          .insertMany(context, selectedProducts)
                          .then((isStatusOk) async {
                        logger.i('ADDED ASYNC');
                        Navigator.pop(context);
                        Helper.showSnack(
                            context: context,
                            text:
                                'Добавлено ${productsWithAmount.length} товаров в "${addToList.title}');
                      });
                    }
                  : () {
                      showDialog(
                          context: context,
                          builder: (_) => const SelectListModal());
                    },
              svgPath: 'assets/icons/addToList.svg',
            ),
    );
  }
}
