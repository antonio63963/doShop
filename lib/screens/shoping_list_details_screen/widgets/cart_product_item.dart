import 'package:doshop_app/models/models/product_in_list.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'product_in_list_tile.dart';

class CartProductItem extends StatelessWidget {
  final ProductInList prod;
  final bool isOptions;
  final Function()? toggleIsOptions;
  final Function()? onToggleIsDone;
  final Function()? onClick;
  final BorderRadius? borderRadius;

  const CartProductItem({
    super.key,
    required this.prod,
    required this.isOptions,
    this.toggleIsOptions,
    this.onToggleIsDone,
    required this.borderRadius,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(prod.colorBg ?? MyColors.defaultBG),
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      borderRadius: !isOptions
          ? borderRadius ?? const BorderRadius.all(Radius.circular(5))
          : const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
      child: ProductInListTile(
        prod: prod,
        borderRadius: null,
        isOptions: isOptions,
        key: key,
        toggleIsOptions: toggleIsOptions,
      ),
    );
  }
}
