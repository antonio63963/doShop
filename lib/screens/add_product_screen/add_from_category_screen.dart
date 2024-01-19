import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/providers/user_template_provider.dart';

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
  UserTemplate? _addToTemplate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      _addToList =
          Provider.of<ShoppingListProvider>(context, listen: false).addToList;

      _addToTemplate = Provider.of<UserTemplateProvider>(context, listen: false)
          .addToTempate;

      if (_addToList == null && _addToTemplate == null ||
          _addToList != null && _addToTemplate != null) {
        Navigator.pop(context);
      }
    }
    isInit = true;
  }

  @override
  void dispose() {
    super.dispose();
    if (_addToList != null) {
      Provider.of<ShoppingListProvider>(context, listen: false)
          .setAddToList(null);
    }
    if (_addToTemplate != null) {
      Provider.of<UserTemplateProvider>(context, listen: false)
          .setAddToTemplate(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _addToList != null ? AppBarAddToList(
        listId: _addToList!.id!,
        listTitle: _addToList!.title,
        backToList: () => Navigator.pop(context),
      ): AppBarAddToList(
        listId: _addToTemplate!.id!,
        listTitle: _addToTemplate!.title,
        backToList: () => Navigator.pop(context),
      ),
      body: const CategoriesPage(),
      // body: Text('wwwww')
    );
  }
}
