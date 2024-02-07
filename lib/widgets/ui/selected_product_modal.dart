import 'package:doshop_app/forms/widgets/select_list_section.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/product.service.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_product_item.dart';
import 'package:doshop_app/screens/product_details_screen.dart/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forms/widgets/buttons_form_row.dart';

class SelectedProductModal extends StatefulWidget {
  final Product prod;
  const SelectedProductModal({super.key, required this.prod});

  @override
  State<SelectedProductModal> createState() => _SelectedProductModalState();
}

class _SelectedProductModalState extends State<SelectedProductModal> {
  bool _isInit = false;
  bool _isLoaded = false;

  Product? _selectedProduct;

  int? radioListOption;
  String? selectedListTitle;

  void onChangeOption(int? value, String? title) {
    setState(() {
      radioListOption = value;
      selectedListTitle = title;
    });
  }

  void onOpen(BuildContext context, prod) => Navigator.of(context).pushNamed(
        ProductDetailsScreen.routeName,
        arguments: ProductDetailsScreenArguments(
          id: prod.id!,
          title: prod.title,
          subtitle: prod.subtitle,
          colorBg: prod.colorBg!,
        ),
      );
  void onClean() {
    if (_selectedProduct != null) {
      setState(() {
        _selectedProduct!.amount = 0;
        _selectedProduct!.isFire = false;
      });
    }
  }

  void onIncreaseAmount() {
    if (_selectedProduct != null) {
      setState(() {
        _selectedProduct!.amount +=
            ProductService.unitDelta(_selectedProduct!.units);
      });
    }
  }

  void onDecreaseAmount() {
    if (_selectedProduct != null) {
      if (_selectedProduct!.amount == 0) return;
      setState(() {
        _selectedProduct!.amount -=
            ProductService.unitDelta(_selectedProduct!.units);
        if (_selectedProduct!.amount == 0 && _selectedProduct!.isFire) {
          _selectedProduct!.isFire = false;
        }
      });
    }
  }

  void onFire() {
    if (_selectedProduct == null) return;
    setState(() {
      _selectedProduct!.isFire = !_selectedProduct!.isFire;
    });
  }

  void onClose() {
    Navigator.pop(context);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  @override
  void initState() {
    super.initState();
    _selectedProduct = widget.prod.copy();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final shoppingListProvider = Provider.of<ShoppingListProvider>(context);
      if (shoppingListProvider.lists.isEmpty) {
        shoppingListProvider.getLists(context);
      }
      _isInit = true;
      _isLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final lists = Provider.of<ShoppingListProvider>(context).lists;
    return _selectedProduct == null
        ? const Text('Что-то пошло не так продукт не найден!')
        : Container(
            decoration: const BoxDecoration(
              color: MyColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SearchProductItem(
                  prod: _selectedProduct!,
                  paddingVertical: 0,
                  onTrailing: onClose,
                ),
                if (!_isLoaded)
                  const LinearProgressIndicator(
                    color: MyColors.primary,
                  ),
                OptionProductRow(
                  onOpen: () => onOpen(context, _selectedProduct),
                  onClean: onClean,
                  onIncreaseAmount: onIncreaseAmount,
                  onDecreaseAmount: onDecreaseAmount,
                  onFire: onFire,
                  isFire: _selectedProduct!.isFire,
                ),
                SelectListSection(
                  radioListOption: radioListOption,
                  onChangeOption: onChangeOption,
                  lists: lists,
                ),
                ButtonsFormRow(
                  isSaveActive: lists.isNotEmpty,
                  onClose: onClose,
                  onSubmit: () {},
                ),
                SizedBox(height: 32),
              ],
            ),
          );
  }
}
