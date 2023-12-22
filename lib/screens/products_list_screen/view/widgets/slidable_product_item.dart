import 'package:doshop_app/screens/product_screen.dart/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/product_item.dart';
import 'package:flutter_svg/svg.dart';

class SlidableProductItem extends StatelessWidget {
  final Product prod;
  final int idx;
  final Function(int?) onClick;
  final Function(int?) onClickTrailing;
  final Function(int?) onToggleFire;

  const SlidableProductItem({
    required this.prod,
    required this.idx,
    required this.onClick,
    required this.onClickTrailing,
    required this.onToggleFire,
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
            onPressed: (context) {
              logger.i('Prod Arguments: ${prod.toString()}');
              Navigator.of(context).pushNamed(ProductScreen.routeName,
                  arguments: ProductScreenArguments(
                    id: prod.id!,
                    title: prod.title,
                    subtitle: prod.subtitle,
                    colorBg: prod.colorBg!,
                  ));
            },
            icon: Icons.open_in_new,
          )
        ],
      ),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        CustomSlidableAction(
          onPressed: (context) => onToggleFire(prod.id),
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
        onTap: onClick,
        onTrailing: onClickTrailing,
        prod: prod,
      ),
    );
  }
}
