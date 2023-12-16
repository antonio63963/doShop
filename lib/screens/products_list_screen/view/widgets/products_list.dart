import 'package:doshop_app/models/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'slidable_product_item.dart';

class ProductList extends StatelessWidget {

  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final productsList = productProvider.products;
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productsList.length,
        itemBuilder: (_, idx) {
          final prod = productsList[idx];
          return SlidableProductItem(
            onClick: productProvider.increaseAmount,
            onClickTrailing: productProvider.decreaseAmount,
            onToggleFire: productProvider.toggleFire,
            prod: prod,
            idx: idx,
          );
        },
      ),
    );
  }
}
