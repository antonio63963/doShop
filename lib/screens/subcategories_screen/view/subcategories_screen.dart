import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/providers/exports.dart';

import 'package:doshop_app/screens/products_list_screen/export.dart';
import 'package:doshop_app/screens/subcategories_screen/view/subcategory_item.dart';
import 'package:doshop_app/widgets/appbar_add_to_list.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/widgets/ui/screen_with_search.dart';


class SubcategoriesScreen extends StatefulWidget {
  static String routeName = '/subcategories';

  const SubcategoriesScreen({super.key});

  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  final TextEditingController searchController = TextEditingController();
  List<CategoryProd> _subcategories = [];
  bool isInit = false;
  bool isLoaded = false;
  late SubcategoriesScreenArguments _screenArguments;

  ShoppingList? _addToList;
  UserTemplate? _addToTemplate;

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
        _addToList =
            Provider.of<ShoppingListProvider>(context, listen: false).addToList;
        if (_addToList == null) {
          _addToTemplate =
              Provider.of<UserTemplateProvider>(context, listen: false)
                  .addToTempate;
        }
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    void backToList() {
      Navigator.pop(context);
      if (_screenArguments.backToList != null) {
        _screenArguments.backToList!();
      }
    }

    return Scaffold(
        appBar: _addToList != null || _addToTemplate != null
            ? AppBarAddToList(
                listId:
                    _addToList != null ? _addToList!.id! : _addToTemplate!.id!,
                listTitle: _addToList != null
                    ? _addToList!.title
                    : _addToTemplate!.title,
                backToList: backToList,
              )
            : AppBar(
                backgroundColor: MyColors.white,
                title: Text(
                  _screenArguments.title,
                  style:
                      const TextStyle(fontSize: 20.0, color: MyColors.primary),
                  textAlign: TextAlign.center,
                ),
              ),
        body: PageWithSearch(
          beforeInput: _addToList != null
            ? SectionTitle(
                title: _screenArguments.title,
                paddingBottom: 0,
                fontSize: 20,
              )
            : const SizedBox(),
          isLoaded: isLoaded,
          content: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
            child: ListView.builder(
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
                      arguments: ProductsListScreenArguments(
                        id: sub.id!,
                        title: sub.title,
                        catImg: sub.img ?? DefaultValues.img,
                        subtitle: sub.subtitle ?? '',
                        colorBg: sub.colorBg ?? MyColors.defaultBG,
                        isSubcats: sub.isSubcat,
                        backToList: backToList,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        )
        // !isLoaded
        //     ? const Loading()
        //     : ListView(
        //         children: [
        //           _addToList != null || _addToTemplate != null
        //               ? SectionTitle(
        //                   title: _screenArguments.title,
        //                   paddingBottom: 0,
        //                   fontSize: 20,
        //                 )
        //               : const SizedBox(),
        //           Input(inputController: searchController),
        //           Padding(
        //             padding: EdgeInsets.symmetric(
        //                 horizontal: AppPadding.bodyHorizontal),
        //             child: ListView.builder(
        //               shrinkWrap: true,
        //               physics: const NeverScrollableScrollPhysics(),
        //               itemCount: _subcategories.length,
        //               itemBuilder: (_, idx) {
        //                 final sub = _subcategories[idx];
        //                 return SubcategoryItem(
        //                   sub: sub,
        //                   onTap: () {
        //                     Navigator.of(context).pushNamed(
        //                       ProductsListScreen.routeName,
        //                       arguments: ProductsListScreenArguments(
        //                         id: sub.id!,
        //                         title: sub.title,
        //                         catImg: sub.img ?? DefaultValues.img,
        //                         subtitle: sub.subtitle ?? '',
        //                         colorBg: sub.colorBg ?? MyColors.defaultBG,
        //                         isSubcats: sub.isSubcat,
        //                         backToList: backToList,
        //                       ),
        //                     );
        //                   },
        //                 );
        //               },
        //             ),
        //           ),
        //           const SizedBox(height: 30),
        //         ],
        //       ),
        );
  }
}
