import 'package:doshop_app/forms/add_to_list_form/add_to_list_form.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/screens/add_product_screen/add_from_category_screen.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/menu_shopping_details.dart';
import 'package:doshop_app/utils/show_modal.dart';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

import 'package:doshop_app/db/localDB/local_db.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/widgets/exports.dart';

import 'widgets/cart_bottom_sheet/cart_bottom_sheet.dart';
import 'widgets/cart_bottom_sheet/header_cart.dart';
import 'widgets/slidable_product_in_list_item.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

class ShoppingListDetails extends StatefulWidget {
  static const String routeName = 'listDetails';
  const ShoppingListDetails({super.key});

  @override
  State<ShoppingListDetails> createState() => _ShoppingListDetailsState();
}

class _ShoppingListDetailsState extends State<ShoppingListDetails> {
  int? id;
  bool isInit = false;
  bool isLoaded = false;
  ProductInListDetailsScreenArguments? _screenArgs;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      _screenArgs = ModalRoute.of(context)!.settings.arguments
          as ProductInListDetailsScreenArguments;
      if (_screenArgs?.id == null) {
        Navigator.pop(context);
      }
      Provider.of<ProductInListProvider>(context, listen: false)
          .getProductsInList(context, _screenArgs!.id!)
          .then((value) {
        isLoaded = true;
        isInit = true;
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    final productsList = Provider.of<ProductInListProvider>(context).products;
    final cartList = Provider.of<ProductInListProvider>(context).cart;
    logger.i('LIST DETAILS: ${productsList.toString()}');
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenArgs?.title ?? 'Не определен'),
        actions: [
          IconButton(
            onPressed: () {
              LocalDB.instance.getAllProdsInList();
            },
            icon: badges.Badge(
              badgeContent: Text(
                cartList.length.toString(),
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
              position: badges.BadgePosition.topEnd(end: -10),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          MenuShoppingDetails(
            context: context,
            listTitle: _screenArgs?.title ?? '',
            listId: _screenArgs!.id!,
          )
        ],
      ),
      body: !isLoaded
          ? const Loading()
          : PageContentWrapper(
              onRefresh: () =>
                  Provider.of<ProductInListProvider>(context, listen: false)
                      .getProductsInList(context, _screenArgs!.id!),
              paddingHorizontal: AppPadding.bodyHorizontal,
              widgets: [
                ...productsList.entries.map((entry) {
                  logger.i('ENTRY: $entry');
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
                              (prod) => SlidebleProductInListItem(
                                idx: prod.key,
                                prod: prod.value,
                                borderRadius: Helper.getBorderRadius(
                                    prod.key, entry.value.length),
                                onOpenDetails: (context) =>
                                    Helper.openProductDetailsScreen(
                                        context, prod.value),
                                onToggleDone: () {
                                  Provider.of<ProductInListProvider>(context,
                                          listen: false)
                                      .markProductAsDone(
                                          context, prod.value.id!);
                                },
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  );
                }).toList(),
                const SizedBox(height: 50),
              ],
            ),
      bottomSheet: HeaderCart(
        productsCount: cartList.length.toString(),
        isOpened: false,
        onClick: () {
          showModal(context, const CartBottomSheet());
        },
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: _screenArgs != null
          ? ExpandableFab(
              key: _key,
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(Icons.format_list_bulleted_add),
                fabSize: ExpandableFabSize.regular,
                foregroundColor: MyColors.white,
                backgroundColor: MyColors.primary,
                shape: const CircleBorder(),
              ),
              closeButtonBuilder: DefaultFloatingActionButtonBuilder(
                child: const Icon(Icons.close),
                fabSize: ExpandableFabSize.small,
                foregroundColor: MyColors.white,
                backgroundColor: MyColors.accent,
                shape: const CircleBorder(),
              ),
              children: [
                FloatingActionButton.small(
                  // shape: const CircleBorder(),
                  heroTag: null,
                  child: SvgPicture.asset(
                    'assets/icons/newNotice.svg',
                    colorFilter: const ColorFilter.mode(
                        MyColors.primary, BlendMode.srcIn),
                  ),
                  onPressed: () {

                    if (_screenArgs?.id != null) {
                      showModal(
                        context,
                        AddToListForm(
                          listId: _screenArgs!.id!,
                        ),
                      );
                    }
                    final state = _key.currentState;
                    if (state != null) {
                      state.toggle();
                    }
                  },
                ),
                FloatingActionButton.small(
                  // shape: const CircleBorder(),
                  heroTag: null,
                  child: SvgPicture.asset(
                    'assets/icons/templates.svg',
                    colorFilter: const ColorFilter.mode(
                        MyColors.primary, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    final state = _key.currentState;
                    if (state != null) {
                      state.toggle();
                    }
                  },
                ),
                FloatingActionButton.small(
                  // shape: const CircleBorder(),
                  heroTag: null,
                  child: SvgPicture.asset(
                    'assets/icons/categories.svg',
                    colorFilter: const ColorFilter.mode(
                        MyColors.primary, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    final state = _key.currentState;
                    if (_screenArgs == null) return;
                    Provider.of<ShoppingListProvider>(context, listen: false)
                        .setAddToList(ShoppingList(
                            title: _screenArgs!.title, id: _screenArgs!.id));
                    Navigator.of(context).pushNamed(
                      AddFromCategoryScreen.routeName,
                    );
                    if (state != null) {
                      state.toggle();
                    }
                  },
                ),
              ],
            )
          : null,
      //  CartBottomSheet()
    );
  }
}
