import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';

class ProductsListScreen extends StatefulWidget {
  static String routeName = '/products';

  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  bool isInit = false;
  bool isLoaded = false;
  late ProductsScreenArguments _screenArguments;
  List<Product> _productsList = [];

  @override
  void didChangeDependencies() {
    if (!isInit) {
      _screenArguments =
          ModalRoute.of(context)?.settings.arguments as ProductsScreenArguments;
      Provider.of<ProductProvider>(context)
          .getProductsByCategory(context, _screenArguments.id)
          .then((value) {
        setState(() {
          _productsList = value ?? [];
        });
      });
      isInit = true;
      isLoaded = true;
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${_screenArguments.title}')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _productsList.length,
          itemBuilder: (_, idx) {
          final prod = _productsList[idx];
          return ListTile(
            title: Text(prod.title),
            subtitle: Text(prod.subtitle ?? ''),
          );
        }),
      ),
    );
  }
}
