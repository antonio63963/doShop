import 'package:doshop_app/db/localDB/local_db.dart';
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
    final _productsList = Provider.of<ProductInListProvider>(context).products;
    return Scaffold(
        appBar: AppBar(
          title: Text(_screenArgs?.title ?? 'Не определен'),
          actions: [
            IconButton(onPressed: () {LocalDB.instance.getAllProdsInList();}, icon: Icon(Icons.data_array_outlined))
          ],
        ),
        body: !isLoaded
            ? const Loading()
            : PageContentWrapper(
                onRefresh: () => Provider.of<ProductInListProvider>(context)
                    .getProductsInList(context, _screenArgs!.id!),
                widgets: [],
              ));
  }
}
