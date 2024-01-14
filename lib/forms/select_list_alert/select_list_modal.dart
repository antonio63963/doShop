import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';

import 'package:doshop_app/widgets/exports.dart';
import '../widgets/select_list_section.dart';
import 'widgets/buttons_row.dart';

class SelectListModal extends StatefulWidget {
  const SelectListModal({super.key});

  @override
  State<SelectListModal> createState() => _SelectListModalState();
}

class _SelectListModalState extends State<SelectListModal> {
  bool _isInit = false;
  bool _isLoaded = false;
  List<Product> _selectedProducts = [];

  int? radioListOption;
  String? selectedListTitle;

  void onChangeOption(int? value, String? title) {
    setState(() {
      radioListOption = value;
      selectedListTitle = title;
    });
  }

  void onSubmit(BuildContext context) {
    if (radioListOption == null) return;
    final List<ProductInList> productsToInsert =
        ProductInList.convertProductsToSelected(
            _selectedProducts, radioListOption!);
    Provider.of<ProductInListProvider>(context, listen: false)
        .insertMany(context, productsToInsert)
        .then((value) {
      Navigator.pop(context);
      Helper.showSnack(
          context: context,
          text:
              'Добавлено ${_selectedProducts.length} товаров в "$selectedListTitle"');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final shopingListProvider = Provider.of<ShoppingListProvider>(context);
      if (shopingListProvider.lists.isEmpty) {
        shopingListProvider.getLists(context).then((value) {
          _selectedProducts =
              Provider.of<ProductProvider>(context, listen: false)
                  .getSelectedProducts();
          _isLoaded = true;
        });
      } else {
        _selectedProducts = Provider.of<ProductProvider>(context, listen: false)
            .getSelectedProducts();
        _isLoaded = true;
      }
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lists = Provider.of<ShoppingListProvider>(context).lists;
    return Dialog(
      backgroundColor: MyColors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Добавить ${_selectedProducts.length} товаров',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: MyColors.primary,
                fontSize: 20,
              ),
            ),
            _isLoaded
                ? SelectListSection(
                    radioListOption: radioListOption,
                    onChangeOption: onChangeOption,
                    lists: lists,
                  )
                : const Loading(),
            ButtonsRow(
              onClose: () => Navigator.pop(context),
              onSubmit: () => onSubmit(context),
            ),
          ],
        ),
      ),
    );
  }
}
