import 'package:doshop_app/screens/shoping_list_details_screen/widgets/product_in_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/models/exports.dart';

class SlidebleDoneProduct extends StatelessWidget {
  final ProductInList prod;
  final int idx;
  final Function() onToggleDone;
  final BorderRadius? borderRadius;
  final void Function(BuildContext) onOpenDetails;

  const SlidebleDoneProduct({
    required this.prod,
    required this.idx,
    required this.onToggleDone,
    required this.onOpenDetails,
    this.borderRadius,
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
          ],
        ),
        endActionPane: ActionPane(motion: const ScrollMotion(), children: [
          SlidableAction(
            onPressed: (context) => onToggleDone(),
            icon: Icons.done_all_rounded,
          ),
        ]),
        child: ProductInListTile(
          isOptions: false,
          prod: prod,
          borderRadius: borderRadius,
          onToggleIsDone: onToggleDone,
        ),
      ),
    );
  }
}
