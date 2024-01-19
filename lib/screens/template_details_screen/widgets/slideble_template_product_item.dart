import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';


class SlidableTemplateProductItem extends StatelessWidget {
  final Product prod;
  final int idx;
  final Function() onClick;
  final BorderRadius borderRadius;
  final void Function(BuildContext) onOpenDetails;
  final bool isChecked;

  const SlidableTemplateProductItem({
    required this.prod,
    required this.idx,
    required this.onClick,
    required this.onOpenDetails,
    required this.borderRadius,
    required this.isChecked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
        child: MyListTile(
          colorBg: Color(prod.colorBg ?? MyColors.defaultBG),
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          title: prod.title,
          subtitle: prod.subtitle,
          isFire: false,
          onTap: onClick,
          trailing: Checkbox(
            onChanged: (value) => onClick(),
            value: isChecked,
            checkColor: MyColors.primary,
            activeColor: MyColors.white,
     
          ),
        ),
      ),
    );
  }
}
