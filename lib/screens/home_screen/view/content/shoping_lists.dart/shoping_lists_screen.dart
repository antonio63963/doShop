import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/shoping_list_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/shoping_lists.dart/widgets/shoping_lists_section.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/widgets/ui/page_content_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListsPage extends StatefulWidget {
  const ListsPage({super.key});

  @override
  State<ListsPage> createState() => _ListsPageState();
}

class _ListsPageState extends State<ListsPage> {
  bool isInit = false;
  bool isLoaded = false;
  List<ShopingList> _shopingLists = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      Provider.of<ShopingListProvider>(context).getLists(context).then((value) {
        isLoaded = true;
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    _shopingLists = Provider.of<ShopingListProvider>(context).lists;

    return PageContentWrapper(
      paddingHorizontal: AppPadding.bodyHorizontal,
      paddingVertical: 32,
      onRefresh: () async {},
      widgets: [
        ShopingListsSection(lists: _shopingLists),
      ],
    );
  }
}
