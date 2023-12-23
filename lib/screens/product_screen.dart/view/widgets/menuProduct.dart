import 'package:doshop_app/forms/product_form/product_form.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/models/models/alerts.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:doshop_app/widgets/ui/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuProduct extends StatefulWidget {
  final int colorBg;
  final Product product;
  final BuildContext context;

  const MenuProduct({
    required this.colorBg,
    required this.product,
    required this.context,
    super.key,
  });

  @override
  State<MenuProduct> createState() => _MenuProductState();
}

class _MenuProductState extends State<MenuProduct> {
  MenuOptionsValues? selectedMenu;

  @override
  Widget build(BuildContext context) {
    void onCloseScreen(Product? prod) {
      Navigator.of(context).pop();
      Helper.showSnack(
          context: widget.context,
          text: '${prod?.title} удален из категории ${prod?.categoryTitle}');
    }

    void onSelectOption(MenuOptionsValues item) {
      switch (item) {
        case MenuOptionsValues.photo:
          {
            () {};
            break;
          }
        case MenuOptionsValues.edit:
          showModal(
              widget.context,
              ProductForm(
                catId: Provider.of<ProductProvider>(context, listen: false)
                    .productDetails!
                    .catId,
                colorBg: widget.colorBg,
                tagsList: Provider.of<ProductProvider>(context, listen: false)
                    .copyTagsList(),
                product: Provider.of<ProductProvider>(context, listen: false)
                    .productDetails,
              ));

        case MenuOptionsValues.hide:
        // TODO: Handle this case.
        case MenuOptionsValues.delete:
          Helper.showInfoAlert(
            widget.context,
            InfoAlert(
              title: 'Вы собираетесь удалить товар!',
              message: 'Удалить товар?',
              onSubmit: () =>
                  Provider.of<ProductProvider>(context, listen: false)
                      .deleteProduct(context, widget.product.id!)
                      .then(
                        (value) => onCloseScreen(widget.product),
                      ),
            ),
          );
      }
    }

    return PopupMenuButton<MenuOptionsValues>(
      initialValue: selectedMenu,
      onSelected: onSelectOption,
      itemBuilder: (BuildContext context) =>
          <PopupMenuEntry<MenuOptionsValues>>[
        const PopupMenuItem<MenuOptionsValues>(
          value: MenuOptionsValues.photo,
          child: MenuItem(
            title: 'Сделать фото',
            icon: Icons.photo_camera,
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
          value: MenuOptionsValues.hide,
          child: MenuItem(
            title: 'Скрыть товар',
            svgPath: 'assets/icons/hide.svg',
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
    );
  }
}
