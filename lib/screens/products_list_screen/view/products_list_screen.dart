import 'package:doshop_app/providers/user_template_provider.dart';
import 'package:doshop_app/widgets/ui/screen_with_search.dart';
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
import 'widgets/products_list_for_template.dart';

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
  UserTemplate? _addToTemplate;

  TextEditingController _searchController = TextEditingController();

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
          .getProductsByCategory(context, _screenArguments.id)
          .then((value) {
        isInit = true;
        isLoaded = true;
        _addToList =
            Provider.of<ShoppingListProvider>(context, listen: false).addToList;
        if (_addToList == null) {
          _addToTemplate =
              Provider.of<UserTemplateProvider>(context, listen: false)
                  .addToTempate;
        }
      });
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

    return Scaffold(
      appBar: _addToList != null || _addToTemplate != null
          ? AppBarAddToList(
              listId:
                  _addToList != null ? _addToList!.id! : _addToTemplate!.id!,
              listTitle: _addToList != null
                  ? _addToList!.title
                  : _addToTemplate!.title,
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
      body:
          // !isLoaded
          //     ? const Loading()
          //     :
          // PageContentWrapper(
          //     onRefresh: () => productProvider.getProductsByCategory(
          //         context, _screenArguments.id),
          //     widgets: [
          //       Input(
          //         inputController: _searchController,
          //       ),
          //       const TagsSection(),
          //       _productsList.isNotEmpty
          //           ? _addToTemplate != null
          //               ? const ProductsListForTemplate()
          //               : const ProductList()
          //           : const EmptyScreen(
          //               message: 'Пока что нет товаров',
          //             ),
          //       const SizedBox(
          //         height: 32,
          //       )
          //     ],
          //   ),
          RefreshIndicator(
        onRefresh: () =>
            productProvider.getProductsByCategory(context, _screenArguments.id),
        child: PageWithSearch(
            content: Column(children: [
              const TagsSection(),
              _productsList.isNotEmpty
                  ? _addToTemplate != null
                      ? const ProductsListForTemplate()
                      : const ProductList()
                  : const EmptyScreen(
                      message: 'Пока что нет товаров',
                    ),
            ]),
            isLoaded: isLoaded),
      ),
      floatingActionButton: !productProvider.isAnySelected
          ? _addToList == null || _addToTemplate != null
              ? FAB(
                  onClick: openModal,
                  icon: Icons.add,
                )
              : null
          : FAB(
              onClick: _addToList != null || _addToTemplate != null
                  ? _addToList != null
                      ? () => onAddToList(context, _addToList!)
                      : () => onAddToTemplate(context, _addToTemplate!)
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

void onAddToList(BuildContext context, ShoppingList addToList) {
  final productsWithAmount =
      Provider.of<ProductProvider>(context, listen: false)
          .getSelectedProducts();
  final selectedProducts = ProductInList.convertProductsToSelected(
      productsWithAmount, addToList.id!);
  Provider.of<ProductInListProvider>(context, listen: false)
      .insertMany(context, selectedProducts)
      .then((isStatusOk) {
    Navigator.pop(context);
    Helper.showSnack(
        context: context,
        text:
            'Добавлено ${productsWithAmount.length} товаров в "${addToList.title}');
  });
}

void onAddToTemplate(BuildContext context, UserTemplate addToTemplate) {
  final selectedProducts = Provider.of<ProductProvider>(context, listen: false)
      .products
      .where((p) => p.amount > 0)
      .toList();
  final idsList =
      selectedProducts.fold([], (value, element) => [...value, element.id]);
  String uniqueIdsString = '';
  if (addToTemplate.productsIds.isNotEmpty) {
    uniqueIdsString = {...addToTemplate.productsIds.split(','), ...idsList}
        .toList()
        .join(',');
  } else {
    uniqueIdsString = idsList.join(',');
  }

  Provider.of<UserTemplateProvider>(context, listen: false)
      .updateTemplate(context, addToTemplate.copy(productsIds: uniqueIdsString))
      .then((value) {
    Navigator.pop(context);
    Helper.showSnack(
        context: context,
        text: 'Добавлено ${idsList.length} товаров в "${addToTemplate.title}');
  });
}
