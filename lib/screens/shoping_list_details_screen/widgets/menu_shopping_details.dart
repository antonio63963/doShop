import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/widgets/ui/menu_item.dart';

enum MenuListDetails {
  cleanCart, cleanList, deleteList
}

class MenuShoppingDetails extends StatefulWidget {

  final BuildContext context;
  final String listTitle;

  const MenuShoppingDetails({
    required this.listTitle,
    required this.context,
    super.key,
  });

  @override
  State<MenuShoppingDetails> createState() => _MenuShoppingDetailsState();
}

class _MenuShoppingDetailsState extends State<MenuShoppingDetails> {
  MenuListDetails? selectedMenu;

  @override
  Widget build(BuildContext context) {
    void onCloseScreen(Product? prod) {
      Navigator.of(context).pop();
      Helper.showSnack(
          context: widget.context,
          text: '${prod?.title} удален из категории ${prod?.categoryTitle}');
    }

    void onSelectOption(MenuListDetails item) {
      switch (item) {
        case MenuListDetails.cleanCart:
          {
            () {};
            break;
          }
        case MenuListDetails.cleanList:
        ;

        case MenuListDetails.deleteList:
          Helper.showInfoAlert(
            widget.context,
            InfoAlert(
              title: 'Вы собираетесь удалить список!',
              message: 'Удалить ${widget.listTitle}',
              onSubmit: () {},
            ),
          );
      }
    }

    return PopupMenuButton<MenuListDetails>(
      initialValue: selectedMenu,
      onSelected: onSelectOption,
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<MenuListDetails>>[
        const PopupMenuItem<MenuListDetails>(
          value: MenuListDetails.cleanCart,
          child: MenuItem(
            title: 'Отчистить корзину',
            icon: Icons.remove_shopping_cart_outlined,
          ),
        ),
        const PopupMenuItem<MenuListDetails>(
          value: MenuListDetails.cleanList,
          child: MenuItem(
            title: 'Отчистить весь список',
            icon: Icons.playlist_remove_rounded,
          ),
        ),
        const PopupMenuItem<MenuListDetails>(
          value: MenuListDetails.deleteList,
          child: MenuItem(
            title: 'Удалить',
            icon: Icons.delete_forever_rounded,
          ),
        ),
      ],
    );
  }
}
