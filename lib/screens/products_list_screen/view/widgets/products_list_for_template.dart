import 'package:doshop_app/screens/template_details_screen/widgets/slideble_template_product_item.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';

class ProductsListForTemplate extends StatelessWidget {
  const ProductsListForTemplate({super.key});

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
          return SlidableTemplateProductItem(
              prod: prod,
              idx: idx,
              onClick: () =>
                  Provider.of<ProductProvider>(context, listen: false).setIsChecked(prod.id!),
              onOpenDetails: (context) =>
                  Helper.openProductDetailsScreen(context, prod),
              borderRadius: const BorderRadius.all(Radius.circular(5)),
              isChecked: prod.amount > 0);
          // SlidableProductItem(
          //   onClick: () => productProvider.increaseAmount(prod.id),
          //   onClickTrailing: () => productProvider.decreaseAmount(prod.id),
          //   onToggleFire: () => productProvider.toggleFire(prod.id),
          //   onClean: () => productProvider.cleanAmount(prod.id),
          //   onOpenDetails: (BuildContext context) => Navigator.of(context).pushNamed(
          //     ProductDetailsScreen.routeName,
          //     arguments: ProductDetailsScreenArguments(
          //       id: prod.id!,
          //       title: prod.title,
          //       subtitle: prod.subtitle,
          //       colorBg: prod.colorBg!,
          //     ),
          //   ),
          //   prod: prod,
          //   idx: idx,
          // );
        },
      ),
    );
  }
}
