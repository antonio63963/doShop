import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/providers/user_tempate_provider.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';

import 'package:doshop_app/forms/select_list_alert/select_list_modal.dart';
import 'package:doshop_app/screens/add_product_screen/add_from_category_screen.dart';
import 'package:doshop_app/screens/product_details_screen.dart/view/product_details_screen.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/slideble_product_item.dart';
import 'package:doshop_app/widgets/exports.dart';

import 'widgets/menu_template_details.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class TemplateDetailsScreen extends StatefulWidget {
  static const String routeName = 'templateDetails';
  const TemplateDetailsScreen({super.key});

  @override
  State<TemplateDetailsScreen> createState() => _TemplateDetailsScreenState();
}

class _TemplateDetailsScreenState extends State<TemplateDetailsScreen> {
  int? id;
  bool isInit = false;
  bool isLoaded = false;
  TempateDetailsScreenArguments? _screenArgs;
  late ProductProvider _productProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      _screenArgs = ModalRoute.of(context)!.settings.arguments
          as TempateDetailsScreenArguments;
      if (_screenArgs?.id == null || _screenArgs?.prodsIds == null) {
        Navigator.pop(context);
      }
      _productProvider = Provider.of<ProductProvider>(context);
      _productProvider
          .getTemplateProducts(context, _screenArgs!.prodsIds)
          .then((value) {
        isLoaded = true;
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    final tProducts = _productProvider.templateProducts;
    logger.f('Details Temp: ${tProducts.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Шаблон ${_screenArgs?.title}'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
            icon: const Icon(
              Icons.home,
              color: MyColors.primary,
            ),
          ),
          MenuTemplateDetails(
            context: context,
            templateTitle: _screenArgs?.title ?? '',
            templateId: _screenArgs!.id!,
          )
        ],
      ),
      body: !isLoaded
          ? const Loading()
          : PageContentWrapper(
              onRefresh: () =>
                  Provider.of<ProductProvider>(context, listen: false)
                      .getTemplateProducts(context, _screenArgs!.prodsIds),
              paddingHorizontal: AppPadding.bodyHorizontal,
              widgets: [
                ...tProducts.entries.map((entry) {
                  return Wrap(
                    spacing: 16,
                    children: [
                      SectionTitle(
                        title: entry.key,
                        paddingTop: 22,
                        paddingBottom: 14,
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: entry.value
                            .asMap()
                            .entries
                            .map(
                              (prod) => SlidebleProductItem(
                                onClick: () => _productProvider
                                    .increaseAmount(prod.value.id),
                                onClickTrailing: () => _productProvider
                                    .decreaseAmount(prod.value.id),
                                onToggleFire: () =>
                                    _productProvider.toggleFire(prod.value.id),
                                onClean: () =>
                                    _productProvider.cleanAmount(prod.value.id),
                                onOpenDetails: (BuildContext context) =>
                                    Navigator.of(context).pushNamed(
                                  ProductDetailsScreen.routeName,
                                  arguments: ProductDetailsScreenArguments(
                                    id: prod.value.id!,
                                    title: prod.value.title,
                                    subtitle: prod.value.subtitle,
                                    colorBg: prod.value.colorBg!,
                                  ),
                                ),
                                prod: prod.value,
                                idx: prod.key,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 80),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: !_productProvider.isAnySelected
          ? FAB(
              // svgPath: 'assets/icons/addToList.svg',
              icon: Icons.format_list_bulleted_add,
              onClick: () {
                Provider.of<UserTemplateProvider>(context, listen: false)
                    .setAddToTemplate(_screenArgs!.id);
                //to avoid 2 params at the same time:
                Provider.of<ShoppingListProvider>(context, listen: false)
                    .setAddToList(null);
                Navigator.of(context)
                    .pushNamed(AddFromCategoryScreen.routeName);
              },
            )
          : FAB(
              onClick: () {
                showDialog(
                    context: context, builder: (_) => const SelectListModal());
              },
              svgPath: 'assets/icons/addToList.svg',
            ),
    );
  }
}
