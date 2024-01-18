import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/forms/user_template_form/user_temlate_form.dart';
import 'package:doshop_app/providers/user_tempate_provider.dart';

import 'package:doshop_app/utils/show_modal.dart';
import 'package:doshop_app/widgets/ui/menu_item.dart';

enum MenuOptionsValues { clean, edit, delete }

class MenuTemplate extends StatefulWidget {
  final UserTemplate template;
  final BuildContext context;

  const MenuTemplate({
    required this.template,
    required this.context,
    super.key,
  });

  @override
  State<MenuTemplate> createState() => _MenuTemplateState();
}

class _MenuTemplateState extends State<MenuTemplate> {
  MenuOptionsValues? selectedMenu;

  @override
  Widget build(BuildContext context) {
    void onSelectOption(MenuOptionsValues item) {
      switch (item) {
        case MenuOptionsValues.clean:
          if (widget.template.id == null) return;
          Provider.of<UserTemplateProvider>(context, listen: false)
              .cleanTemplate(context, widget.template);
          break;

        case MenuOptionsValues.edit:
          showModal(
            widget.context,
            UserTemplateForm(
              uTemp: widget.template,
            ),
          );

        case MenuOptionsValues.delete:
          Helper.showInfoAlert(
            widget.context,
            InfoAlert(
              title: 'Вы собираетесь удалить шаблон!',
              message: 'Удалить шаблон?',
              onSubmit: () =>
                  Provider.of<UserTemplateProvider>(context, listen: false)
                      .deleteTemplate(context, widget.template.id!)
                      .then(
                        (value) => Helper.showSnack(
                          context: widget.context,
                          text: 'Список ${widget.template.title} удален',
                        ),
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
