import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/categories_provider.dart';

import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/category_item.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/fast_enter_form.dart';

import 'package:doshop_app/screens/subcategories_screen/exports.dart';

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
      Provider.of<CategoriesProvider>(context).getCategoriesList(context);
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider = Provider.of<CategoriesProvider>(context);

    logger.d('CatPage: ${categoriesProvider.categories}');
    return RefreshIndicator(
      onRefresh: () => categoriesProvider.getCategoriesList(context),
      // child: ElevatedButton(child: Text('test'), onPressed: () => SqlQueries.initCategories(),)

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(children: [
          const SizedBox(height: 32),
          const FastEnterForm(),
          const SizedBox(height: 32),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: categoriesProvider.categories.length,
            itemBuilder: (ctx, index) {
              final cat = categoriesProvider.categories[index];
              return CategoryItem(
                category: cat,
                onTap: () {
                  Navigator.of(context).pushNamed(
                    cat.subcategories!
                        ? SubcategoriesScreen.routeName
                        : ProductsListScreen.routeName,
                    arguments: cat.id,
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}
