import 'package:doshop_app/screens/home_screen/view/content/shoping_lists.dart/widgets/shoping_list_item.dart';
import 'package:doshop_app/screens/shoping_list_details/shoping_list_details.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/models/exports.dart';

class ShopingListsSection extends StatelessWidget {
  final List<ShopingList> lists;

  const ShopingListsSection({super.key, required this.lists});

  @override
  Widget build(BuildContext context) {
    return lists.isEmpty
        ? const EmptyScreen(message: 'Пока что нет списков')
        : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: lists.length,
            itemBuilder: (_, idx) {
              final l = lists[idx];
              return ShopingListItem(
                list: l,
                onTap: () => Navigator.of(context).pushNamed(
                  ShopingListDetails.routeName,
                  arguments: {"id": l.id},
                ),
              );
            });
  }
}
