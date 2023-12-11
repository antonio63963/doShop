import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/exports.dart';
import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/subcategories_screen/view/subcategory_item.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/fast_enter_form.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:provider/provider.dart';

class SubcategoriesScreen extends StatefulWidget {
  static String routeName = '/subcategories';

  const SubcategoriesScreen({super.key});

  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  List<Subcategory> _subcategories = [];
  bool isInit = false;
  bool isLoaded = false;
  late SubcategoriesScreenArguments _screenArguments;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      _screenArguments = ModalRoute.of(context)?.settings.arguments
          as SubcategoriesScreenArguments;
      Provider.of<CategoriesProvider>(context)
          .getSubcategoriesList(context, _screenArguments.id)
          .then((value) {
        logger.d('CatScreen: $value');
        setState(() {
          _subcategories = value ?? [];
          isLoaded = true;
        });
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Подкатегории'), actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.more_vert),
      //   ),
      // ]),
      appBar: AppBar(
        backgroundColor: MyColors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 128,
        title: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: MyColors.primary),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert,
                        color: MyColors.primary,
                      ))
                ],
              ),
              Row(
                children: [
                  Image.asset(
                    _screenArguments.catImg,
                    height: 55.0,
                    width: 55.0,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    _screenArguments.title.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20.0, color: MyColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      body: !isLoaded
          ? const Loading()
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
              child: ListView(
                children: [
                  FastEnterForm(
                    paddingBottom: 30,
                    paddingTop: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _subcategories.length,
                    itemBuilder: (_, idx) {
                      final sub = _subcategories[idx];
                      return SubcategoryItem(
                        sub: sub,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ProductsListScreen.routeName,
                            arguments: ProductsScreenArguments(
                              id: sub.id!,
                              title: sub.title,
                              catImg: sub.img ?? DefaultValues.img,
                              subtitle: sub.subtitle ?? '',
                              colorBg: sub.colorBg ?? MyColors.defaultBG,
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}
