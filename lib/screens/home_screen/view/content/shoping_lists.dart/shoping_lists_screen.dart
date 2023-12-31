import 'package:doshop_app/models/models/category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/shoping_list_provider.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/screens/home_screen/view/content/shoping_lists.dart/widgets/shoping_lists_section.dart';
import 'package:doshop_app/widgets/exports.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  bool isInit = false;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      Provider.of<ShopingListProvider>(context, listen: false)
          .getLists(context)
          .then((value) {
        isLoaded = true;
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    final shopingLists = Provider.of<ShopingListProvider>(context).lists;
logger.i('WOWOWOWOW: {$shopingLists.toString()}');
    return isLoaded
        ? PageContentWrapper(
            isScreenEmpty: shopingLists.isEmpty,
            paddingHorizontal: AppPadding.bodyHorizontal,
            paddingVertical: 32,
            onRefresh: () async {
              Provider.of<ShopingListProvider>(context, listen: false)
                  .getLists(context);
            },
            widgets: [
              ShopingListsSection(lists: shopingLists),
            ],
          )
        : const Loading();
  }
}
