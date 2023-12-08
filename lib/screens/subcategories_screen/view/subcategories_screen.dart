import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/exports.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      final catId = ModalRoute.of(context)?.settings.arguments as int;
      Provider.of<CategoriesProvider>(context)
          .getSubcategoriesList(context, catId)
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
      appBar: AppBar(title: const Text('Подкатегории'), actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert),
        ),
      ]),
      body: !isLoaded
          ? const Loading()
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
              child: ListView(
                children: [
                  const FastEnterForm(
                    paddingBottom: 30,
                    paddingTop: 30,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _subcategories.length,
                    itemBuilder: (_, idx) {
                      final sub = _subcategories[idx];
                      return SubcategoryItem(sub: sub);
                    },
                  )
                ],
              ),
            ),
    );
  }
}
