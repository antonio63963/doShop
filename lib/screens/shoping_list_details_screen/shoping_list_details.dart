import 'package:doshop_app/screens/shoping_list_details_screen/widgets/menu_shopping_details.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:flutter/material.dart';
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

class ShopingListDetails extends StatefulWidget {
  static const String routeName = 'listDetails';
  const ShopingListDetails({super.key});

  @override
  State<ShopingListDetails> createState() => _ShopingListDetailsState();
}

class _ShopingListDetailsState extends State<ShopingListDetails> {
  int? id;
  bool isInit = false;
  bool isLoaded = false;
  ProductInListDetailsScreenArguments? _screenArgs;

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
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                position: badges.BadgePosition.topEnd(end: -10),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
            MenuShoppingDetails(
              context: context,
              listTitle: _screenArgs?.title ?? '',
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
                  ...productsList.entries
                      .map(
                        (entry) => Wrap(
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
                                        Provider.of<ProductInListProvider>(
                                                context,
                                                listen: false)
                                            .markProductAsDone(prod.value.id!);
                                      },
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      )
                      .toList(),
                  const SizedBox(height: 50),
                ],
              ),
        bottomSheet: HeaderCart(
          productsCount: cartList.length.toString(),
          isOpened: false,
          onClick: () {
            showModal(context, const CartBottomSheet());
          },
        )
        //  CartBottomSheet()
        );
  }
}
