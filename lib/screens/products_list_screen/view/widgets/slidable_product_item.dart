import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/product_item.dart';
import 'package:flutter_svg/svg.dart';

class SlidableProductItem extends StatelessWidget {
  final Product prod;
  final int idx;
  final Function? onClick;
  const SlidableProductItem({
    required this.prod,
    required this.idx,
    this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
        key: ValueKey(idx),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.open_in_new,
            )
          ],
        ),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          CustomSlidableAction(
            onPressed: (context) {},
            child: SvgPicture.asset(
              'assets/icons/fire.svg',
              colorFilter:
                  const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
            ),
          ),
        ]),
        child: ProductItem(
          prod: prod,
        ));
  }
}
