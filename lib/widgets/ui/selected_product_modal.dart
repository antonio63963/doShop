import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_product_item.dart';
import 'package:doshop_app/screens/product_details_screen.dart/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/widgets/ui/primary_button.dart';
import 'package:flutter/material.dart';

class SelectedProductModal extends StatefulWidget {
  final Product prod;
  const SelectedProductModal({super.key, required this.prod});

  @override
  State<SelectedProductModal> createState() => _SelectedProductModalState();
}

class _SelectedProductModalState extends State<SelectedProductModal> {
  Product? _selectedProduct;

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
        _selectedProduct!.units == Units.kg
            ? _selectedProduct!.amount += DefaultValues.plusAmount
            : _selectedProduct!.amount += 1;
      });
    }
  }

  void onDecreaseAmount() {
    if (_selectedProduct != null) {
      if (_selectedProduct!.amount == 0) return;
      setState(() {
        _selectedProduct!.units == Units.kg
            ? _selectedProduct!.amount -= DefaultValues.plusAmount
            : _selectedProduct!.amount -= 1;
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
  Widget build(BuildContext context) {
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
                OptionProductRow(
                  onOpen: () => onOpen(context, _selectedProduct),
                  onClean: onClean,
                  onIncreaseAmount: onIncreaseAmount,
                  onDecreaseAmount: onDecreaseAmount,
                  onFire: onFire,
                  isFire: _selectedProduct!.isFire,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppPadding.bodyHorizontal,
                    vertical: 24,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionTitle(
                        title: 'Выбрать список',
                        paddingHorizontal: 0,
                      ),
                      ListView(
                        shrinkWrap: true,
                        children: [],
                      ),
                      Wrap(
                        spacing: 16,
                        children: [
                          SecondaryButton(
                            text: 'Подтвердить',
                            onPressed: onClose,
                          ),
                          PrimaryButton(
                            text: 'Отменить',
                            iconData: Icons.close_outlined,
                            elevation: 0,
                            textColor: MyColors.danger,
                            bgColor: MyColors.white,
                            onPressed: onClose,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
