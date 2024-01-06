import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/cart_bottom_sheet/header_cart.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../slideble_done_product.dart';

class CartBottomSheet extends StatefulWidget {
  const CartBottomSheet({super.key});

  @override
  State<CartBottomSheet> createState() => _CartBottomSheetState();
}

class _CartBottomSheetState extends State<CartBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cartList = Provider.of<ProductInListProvider>(context).cart;

    return Column(
      children: [
        HeaderCart(
          productsCount: cartList.length.toString(),
          isOpened: true,
          onClick: () => Navigator.pop(context),
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          padding: EdgeInsets.symmetric(
              horizontal: AppPadding.bodyHorizontal, vertical: 16),
          color: MyColors.white,
          child: ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (_, idx) {
              final prod = cartList[idx];
              return SlidebleDoneProduct(
                prod: prod,
                idx: idx,
                onToggleDone: () {
                  Provider.of<ProductInListProvider>(context, listen: false)
                      .cancelProductAsDone(context, prod.id!);
                },
                onOpenDetails: (context) =>
                    Helper.openProductDetailsScreen(context, prod),
              );
            },
          ),
        )
      ],
    );
  }
}
