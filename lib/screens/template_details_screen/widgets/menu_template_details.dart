import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/providers/user_tempate_provider.dart';
import 'package:doshop_app/screens/add_product_screen/add_from_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/shopping_list_provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/widgets/ui/menu_item.dart';

enum MenuTdetails { add, cleanAmount, cleanTemplate, deleteTemplate }

class MenuTemplateDetails extends StatefulWidget {
  final BuildContext context;
  final String templateTitle;
  final int templateId;

  const MenuTemplateDetails({
    required this.templateTitle,
    required this.templateId,
    required this.context,
    super.key,
  });

  @override
  State<MenuTemplateDetails> createState() => _MenuShoppingDetailsState();
}

class _MenuShoppingDetailsState extends State<MenuTemplateDetails> {
  MenuTdetails? selectedMenu;

  @override
  Widget build(BuildContext context) {
    void onSelectOption(MenuTdetails item) {
      switch (item) {
        case MenuTdetails.add:
          () {
            Provider.of<UserTemplateProvider>(context, listen: false)
                .setAddToTemplate(widget.templateId);
            //to avoid 2 params at the same time:
            Provider.of<ShoppingListProvider>(context, listen: false)
                .setAddToList(null);
            Navigator.of(context).pushNamed(AddFromCategoryScreen.routeName);
          };
          break;
        case MenuTdetails.cleanTemplate:
          Provider.of<UserTemplateProvider>(context).cleanTemplate(
            context,
            UserTemplate(
                id: widget.templateId,
                title: widget.templateTitle,
                productsIds: ''),
          );
          break;

        case MenuTdetails.cleanAmount:
          Provider.of<ProductProvider>(context, listen: false)
              .cleanSelectedProducts();
          break;

        case MenuTdetails.deleteTemplate:
          Helper.showInfoAlert(
            widget.context,
            InfoAlert(
              title: 'Вы собираетесь удалить шаблон!',
              message: 'Удалить ${widget.templateTitle}',
              onSubmit: () =>
                  Provider.of<UserTemplateProvider>(context, listen: false)
                      .deleteTemplate(context, widget.templateId)
                      .then(
                        (value) => Helper.showSnack(
                          context: widget.context,
                          text: 'Список ${widget.templateTitle} удален',
                        ),
                      ),
            ),
          );
      }
    }

    return PopupMenuButton<MenuTdetails>(
      initialValue: selectedMenu,
      onSelected: onSelectOption,
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuTdetails>>[
        const PopupMenuItem<MenuTdetails>(
          value: MenuTdetails.add,
          child: MenuItem(
            title: 'Добавить товар',
            icon: Icons.format_list_bulleted_add,
          ),
        ),
        const PopupMenuItem<MenuTdetails>(
          value: MenuTdetails.cleanAmount,
          child: MenuItem(
            title: 'Обнулить выбранные',
            icon: Icons.remove_done_rounded,
          ),
        ),
        const PopupMenuDivider(),
        const PopupMenuItem<MenuTdetails>(
          value: MenuTdetails.cleanTemplate,
          child: MenuItem(
            title: 'Отчистить шаблон',
            icon: Icons.playlist_remove_rounded,
          ),
        ),
        const PopupMenuItem<MenuTdetails>(
          value: MenuTdetails.deleteTemplate,
          child: MenuItem(
            title: 'Удалить шаблон',
            icon: Icons.delete_forever_rounded,
          ),
        ),
      ],
    );
  }
}
