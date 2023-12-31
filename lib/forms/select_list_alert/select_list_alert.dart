import 'package:doshop_app/forms/widgets/buttons_form_row.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/providers/shoping_list_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/select_list_section.dart';

class SelectListAlert extends StatefulWidget {
  const SelectListAlert({super.key});

  @override
  State<SelectListAlert> createState() => _SelectListAlertState();
}

class _SelectListAlertState extends State<SelectListAlert> {
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      final shopingListProvider = Provider.of<ShopingListProvider>(context);
      if (shopingListProvider.lists.isEmpty) {
        shopingListProvider.getLists(context).then((value) {
          _selectedProducts =
              Provider.of<ProductProvider>(context, listen: false)
                  .products
                  .where((p) => p.amount > 0)
                  .toList();
          _isLoaded = true;
        });
      }
      _isInit = true;
    }
  }

  void onSubmit(BuildContext context) {
    if (radioListOption == null) return;
    final List<ProductInList> productsToInsert = _selectedProducts
        .map((p) => ProductInList(
              amount: p.amount,
              prodId: p.id,
              isFire: p.isFire,
              listId: radioListOption!,
              dateCreated: DateTime.now(),
            ))
        .toList();
    Provider.of<ProductInListProvider>(context)
        .insertMany(context, productsToInsert)
        .then((value) {
          Navigator.pop(context);
          Helper.showSnack(context: context,text: 'Добавлено ${_selectedProducts.length} товаров в "${selectedListTitle}');
        });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lists = Provider.of<ShopingListProvider>(context).lists;
    return Dialog(
      backgroundColor: MyColors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            ButtonsFormRow(
                onClose: () => Navigator.pop(context),
                onSubmit: () => onSubmit(context))
          ],
        ),
      ),
    );
  }
}
