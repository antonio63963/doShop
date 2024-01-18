
import 'package:doshop_app/screens/shoping_list_details_screen/shoping_list_details.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/models/exports.dart';

import 'menu_template.dart';

class TemplatesListSection extends StatelessWidget {
  final List<UserTemplate> templates;

  const TemplatesListSection({super.key, required this.templates});

  @override
  Widget build(BuildContext context) {
    return templates.isEmpty
        ? const EmptyScreen(message: 'Пока что нет списков')
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: templates.length,
            itemBuilder: (_, idx) {
              final t = templates[idx];
              return BigListItem(
                menu: MenuTemplate(context: context, template: t,),
                title: t.title,
                subtitle: t.subtitle ?? '',
                img: t.img ?? DefaultValues.img,
                colorBg: MyColors.primary,
                onTap: () => Navigator.of(context).pushNamed(
                  ShoppingListDetails.routeName,
                  arguments: ProductInListDetailsScreenArguments(
                    id: t.id!,
                    title: t.title,
                    subtitle: t.subtitle,
                  ),
                ),
              );
            });
  }
}
