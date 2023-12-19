import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/utils/constants.dart';
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

      child: ListView(children: [
        FastEnterForm(
          paddingBottom: 16,
          paddingTop: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
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
                  cat.hasSubcategories
                      ? Navigator.of(context)
                          .pushNamed(SubcategoriesScreen.routeName,
                              arguments: SubcategoriesScreenArguments(
                                id: cat.id!,
                                title: cat.title,
                                colorBg: cat.colorBg ?? MyColors.defaultBG,
                                catImg: cat.img ?? DefaultValues.img,
                              ))
                      : Navigator.of(context).pushNamed(
                          ProductsListScreen.routeName,
                          arguments: ProductsListScreenArguments(
                            id: cat.id!,
                            title: cat.title,
                            colorBg: cat.colorBg ?? MyColors.defaultBG,
                            catImg: cat.img ?? DefaultValues.img,
                            isSubcats: cat.isSubcat,
                          ),
                        );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
