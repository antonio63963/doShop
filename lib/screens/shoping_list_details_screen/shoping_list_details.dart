import 'package:doshop_app/db/localDB/local_db.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/product_in_list_item.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/widgets/exports.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(_screenArgs?.title ?? 'Не определен'),
        actions: [
          IconButton(
              onPressed: () {
                LocalDB.instance.getAllProdsInList();
              },
              icon: Icon(Icons.data_array_outlined))
        ],
      ),
      body: !isLoaded
          ? const Loading()
          : PageContentWrapper(
              onRefresh: () =>
                  Provider.of<ProductInListProvider>(context, listen: false)
                      .getProductsInList(context, _screenArgs!.id!),
              paddingHorizontal: AppPadding.bodyHorizontal,
              paddingVertical: 32,
              widgets: [
                ...productsList.entries
                    .map(
                      (entry) => Wrap(
                        spacing: 16,
                        children: [
                          SectionTitle(title: entry.key, paddingTop: 22, paddingBottom: 14,),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: entry.value.asMap().entries
                                .map(
                                  (prod) => ProductInListItem(
                                    prod: prod.value,
                                    borderRadius: Helper.getBorderRadius(prod.key, entry.value.length ),
                                    onIncrease: () {},
                                    onDecrease: () {},
                                    onClean: () {},
                                    onOpenDetails: (context) {},
                                    onFire: () {},
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ],
            ),
    );
  }
}
