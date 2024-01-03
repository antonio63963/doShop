import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';

import 'product_in_list_item.dart';

class SlidebleProductInListItem extends StatelessWidget {
  final ProductInList prod;
  final int idx;
  final Function() onClick;
  final Function() onClickTrailing;
  final Function() onToggleFire;
  final Function() onToggleDone;
  final Function() onClean;
  final BorderRadius borderRadius;
  final void Function(BuildContext) onOpenDetails;

  const SlidebleProductInListItem({
    required this.prod,
    required this.idx,
    required this.onClick,
    required this.onClickTrailing,
    required this.onToggleFire,
    required this.onToggleDone,
    required this.onClean,
    required this.onOpenDetails,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Slidable(
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
              icon: Icons.delete_forever_outlined,
              foregroundColor: MyColors.danger,
              borderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          ],
        ),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) => onToggleDone(),
            icon: Icons.done_all_rounded,
          ),
        ]),
        child: ProductInListItem(
          onIncrease: onClick,
          onDecrease: onClickTrailing,
          onClean: onClean,
          prod: prod,
          onOpenDetails: onOpenDetails,
          onFire: onToggleFire,
          borderRadius: borderRadius,
          onToggleDone: onToggleDone,
        ),
      ),
    );
  }
}
