import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';

import 'package:doshop_app/screens/products_list_screen/view/widgets/product_item.dart';

class SlidableProductItem extends StatelessWidget {
  final Product prod;
  final int idx;
  final Function() onClick;
  final Function() onClickTrailing;
  final Function() onToggleFire;
  final Function() onClean;
  final void Function(BuildContext) onOpenDetails;

  const SlidableProductItem({
    required this.prod,
    required this.idx,
    required this.onClick,
    required this.onClickTrailing,
    required this.onToggleFire,
    required this.onClean,
    required this.onOpenDetails,
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
            onPressed: onOpenDetails,
            icon: Icons.open_in_new,
          ),
          SlidableAction(
            onPressed: (context) => onClean(),
            icon: Icons.cleaning_services_outlined,
          ),
        ],
      ),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        CustomSlidableAction(
          onPressed: (context) => onToggleFire(),
          child: SvgPicture.asset(
            !prod.isFire
                ? 'assets/icons/fire_fill.svg'
                : 'assets/icons/fire.svg',
            width: 24,
            colorFilter: ColorFilter.mode(
              !prod.isFire ? MyColors.accent : MyColors.primary,
              BlendMode.srcIn,
            ),
          ),
        ),
      ]),
      child: ProductItem(
        onIncrease: onClick,
        onDecrease: onClickTrailing,
        onClean: onClean,
        prod: prod,
        onOpenDetails: onOpenDetails,
        onFire: onToggleFire,
      ),
    );
  }
}
