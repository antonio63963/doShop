import 'package:doshop_app/db/localDB/sql_queries.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/categories_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final theme = Theme.of(context);

    logger.d('CatPage: ${categoriesProvider.categories}');
    return RefreshIndicator(
      onRefresh: () => categoriesProvider.getCategoriesList(context),
      // child: ElevatedButton(child: Text('test'), onPressed: () => SqlQueries.initCategories(),)

      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: categoriesProvider.categories.length,
            itemBuilder: (ctx, index) {
              final cat = categoriesProvider.categories[index];
              return Material(
                elevation: 5,
                shadowColor: MyColors.primary,
                type: MaterialType.transparency,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Color(cat.colorBg ?? MyColors.defaultBG),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Image.asset(
                              fit: BoxFit.contain,
                              cat.img ?? 'assets/img/categories/hobby.png',
                              height: 132,
                              width: 180,
                            ),
                            Text(cat.title, style: theme.textTheme.headlineMedium)
                          ],
                        ),
                      )),
                ),
              );
            }),
      ),
    );
  }
}
