import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:provider/provider.dart';

import 'product_in_list_item.dart';

class SlidebleProductInListItem extends StatelessWidget {
  final ProductInList prod;
  final int idx;
  final Function() onToggleDone;

  final BorderRadius borderRadius;
  final void Function(BuildContext) onOpenDetails;

  const SlidebleProductInListItem({
    required this.prod,
    required this.idx,
    required this.onToggleDone,
    required this.onOpenDetails,
    required this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    void onDelete() {
      Provider.of<ProductInListProvider>(context, listen: false)
          .deleteProductInList(context, prod.id!);
    }
    logger.f('SLIDEBLE++++: ${prod.toString()}');
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
              onPressed: (context) => onDelete(),
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
          prod: prod,
          onDelete: onDelete,
          onOpenDetails: onOpenDetails,
          borderRadius: borderRadius,
          onToggleDone: onToggleDone,
        ),
      ),
    );
  }
}
