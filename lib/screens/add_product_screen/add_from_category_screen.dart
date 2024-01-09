import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';

import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/categories_page.dart';
import 'package:doshop_app/widgets/appbar_add_to_list.dart';

class AddFromCategoryScreen extends StatefulWidget {
  static const String routeName = '/add_from_category';

  const AddFromCategoryScreen({super.key});

  @override
  State<AddFromCategoryScreen> createState() => _AddFromCategoryScreenState();
}

class _AddFromCategoryScreenState extends State<AddFromCategoryScreen> {
  bool isInit = false;
  ShoppingList? _addToList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      _addToList = Provider.of<ShoppingListProvider>(context).addToList;
      if (_addToList == null) {
        Navigator.pop(context);
      }
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarAddToList(
        listId: _addToList!.id!,
        listTitle: _addToList!.title,
        backToList: () => Navigator.pop(context),
      ),
      body: const CategoriesPage(),
      // body: Text('wwwww')
    );
  }
}
