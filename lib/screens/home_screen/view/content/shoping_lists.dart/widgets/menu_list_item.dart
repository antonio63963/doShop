import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/forms/shoping_list_form/shoping_list_form.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/shoping_list_provider.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:doshop_app/widgets/ui/menu_item.dart';

enum MenuOptionsValues {clean, edit, delete}

class MenuListItem extends StatefulWidget {
  final ShopingList list;
  final BuildContext context;

  const MenuListItem({
    required this.list,
    required this.context,
    super.key,
  });

  @override
  State<MenuListItem> createState() => _MenuListItemState();
}

class _MenuListItemState extends State<MenuListItem> {
  MenuOptionsValues? selectedMenu;

  @override
  Widget build(BuildContext context) {
    void onCloseScreen(ShopingList? list) {
      Navigator.of(context).pop();
      Helper.showSnack(
          context: widget.context,
          text: 'Список ${list?.title} удален');
    }

    void onSelectOption(MenuOptionsValues item) {
      switch (item) {
        case MenuOptionsValues.clean:
          {
            () {};
            break;
          }
        case MenuOptionsValues.edit:
          showModal(
              widget.context,
              ShopingListForm(
                list: widget.list,
              ));

        case MenuOptionsValues.delete:
          Helper.showInfoAlert(
            widget.context,
            InfoAlert(
              title: 'Вы собираетесь удалить список!',
              message: 'Удалить список?',
              onSubmit: () =>
                  Provider.of<ShopingListProvider>(context, listen: false)
                      .deleteList(context, widget.list.id!)
                      .then(
                        (value) => onCloseScreen(widget.list),
                      ),
            ),
          );
      }
    }

    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<MenuOptionsValues>(
        iconColor: MyColors.white,
        initialValue: selectedMenu,
        onSelected: onSelectOption,
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<MenuOptionsValues>>[
          const PopupMenuItem<MenuOptionsValues>(
            value: MenuOptionsValues.clean,
            child: MenuItem(
              title: 'Отчистить',
              icon: Icons.cleaning_services_outlined,
            ),
          ),
          const PopupMenuItem<MenuOptionsValues>(
            value: MenuOptionsValues.edit,
            child: MenuItem(
              title: 'Редактировать',
              icon: Icons.edit_outlined,
            ),
          ),
          const PopupMenuItem<MenuOptionsValues>(
            value: MenuOptionsValues.delete,
            child: MenuItem(
              title: 'Удалить',
              icon: Icons.delete_forever_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
