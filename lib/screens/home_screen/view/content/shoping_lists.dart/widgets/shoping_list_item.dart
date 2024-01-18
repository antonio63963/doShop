import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

import 'menu_list_item.dart';

class ShoppingListItem extends StatelessWidget {
  final ShoppingList list;
  final Function() onTap;
  const ShoppingListItem({
    required this.list,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BigListItem(
      onTap: onTap,
      colorBg: Color(list.colorBg ?? MyColors.defaultBG),
      title: list.title,
      subtitle: list.subtitle ?? '',
      img: list.img ?? DefaultValues.img,
      menu: MenuListItem(
        context: context,
        list: list,
      ),
    );
  }
}
