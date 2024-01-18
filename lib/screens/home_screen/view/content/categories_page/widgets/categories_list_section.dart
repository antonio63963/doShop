import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';

import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/subcategories_screen/view/subcategories_screen.dart';

import 'category_item.dart';

class CategoriesListSection extends StatelessWidget {
  final List<CategoryProd> catList;

  const CategoriesListSection({required this.catList, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: catList.length,
        itemBuilder: (ctx, index) {
          final cat = catList[index];
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
                            backToList: () => Navigator.pop(context),
                          ))
                  : Navigator.of(context).pushNamed(
                      ProductsListScreen.routeName,
                      arguments: ProductsListScreenArguments(
                        id: cat.id!,
                        title: cat.title,
                        colorBg: cat.colorBg ?? MyColors.defaultBG,
                        catImg: cat.img ?? DefaultValues.img,
                        isSubcats: cat.isSubcat,
                        backToList: () => Navigator.pop(context),
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}
