import 'package:doshop_app/db/localDB/sql_queries.dart';
import 'package:doshop_app/exports.dart';
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

logger.d('CatPage: ${categoriesProvider.categories}');
    return RefreshIndicator(
        onRefresh: () => categoriesProvider.getCategoriesList(context),
        child: ElevatedButton(child: Text('test'), onPressed: () => SqlQueries.initCategories(),)
        // child: GridView.count(
        //     padding: const EdgeInsets.all(16),
        //     crossAxisCount: 2,
        //     mainAxisSpacing: 8,
        //     crossAxisSpacing: 8,
        //     children: categoriesProvider.categories
        //         .map(
        //           (cast) => Container(
        //             padding: const EdgeInsets.all(8),
        //             color: Colors.teal[200],
        //             child: const Text('Heed not the rabble'),
        //           ),
        //         )
        //         .toList()),

        // child: Padding(
        //   padding: const EdgeInsets.all(16.0),
        //   child: GridView.builder(
        //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        //       maxCrossAxisExtent: 200,
        //       crossAxisSpacing: 8,
        //       mainAxisSpacing: 8,
        //     ),
        //     itemCount: categoriesProvider.categories.length,
        //     itemBuilder: (ctx, index) => Container(
        //       padding: const EdgeInsets.all(8),
        //       color: Colors.teal[200],
        //       child: const Text('Heed not the rabble'),
        //     ),
        //   ),
        // ),
      );
  }
}
