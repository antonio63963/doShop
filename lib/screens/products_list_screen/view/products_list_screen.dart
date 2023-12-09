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
        _productsList = value ?? [];
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
    );
  }
}
