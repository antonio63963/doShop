
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/shopping_list_provider.dart';

import 'package:doshop_app/widgets/ui/screen_with_search.dart';
import 'package:doshop_app/providers/categories_provider.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/categories_list_section.dart';
import 'package:doshop_app/widgets/exports.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  bool isInit = false;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    if (!isInit) {
      Provider.of<CategoriesProvider>(context)
          .getCategoriesList(context)
          .then((value) => isLoaded = true);
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);
    final addToList =
        Provider.of<ShoppingListProvider>(context, listen: false).addToList;

    return RefreshIndicator(
      onRefresh: () => categoriesProvider.getCategoriesList(context),
      child: PageWithSearch(
        beforeInput: addToList != null
            ? const SectionTitle(
                title: 'Категории',
                paddingBottom: 0,
                fontSize: 20,
              )
            : const SizedBox(),
        isLoaded: isLoaded,
        content: CategoriesListSection(catList: categoriesProvider.categories),
      ),
    );
  }
}
