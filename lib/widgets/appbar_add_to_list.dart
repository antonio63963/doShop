import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/shopping_list_provider.dart';

class AppBarAddToList extends StatelessWidget implements PreferredSizeWidget {
  final int listId;
  final String listTitle;
  final Function() backToList;

  const AppBarAddToList({
    super.key,
    required this.listId,
    required this.listTitle,
    required this.backToList,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(Icons.format_list_bulleted_add),
        onPressed: () {
          backToList();
          Provider.of<ShoppingListProvider>(context).setAddToList(null);
        },
      ),
      title: Text(listTitle),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close_rounded),
        ),
      ],
    );
  }
}
