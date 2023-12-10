import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/fast_enter_form.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';

import 'widgets/product_item.dart';

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
        child: ListView(
          children: [
            Card(
              clipBehavior: Clip.hardEdge,
              child: Container(
                  color: Color(
                    _productsList[0].colorBg ?? MyColors.defaultBG,
                  ),
                  child: Image.asset(
                      _productsList[0].catImg ?? DefaultValues.img)),
            ),
            FastEnterForm(
              paddingBottom: 30,
              paddingTop: 30,
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _productsList.length,
                itemBuilder: (_, idx) {
                  final prod = _productsList[idx];
                  return ProductItem(prod: prod);
                }),
          ],
        ),
      ),
    );
  }
}

ShapeBorder getBorderRadius(int idx, List<Object> list) {
  if (idx == 0) {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(5),
            bottomLeft: Radius.circular(5)));
  } else if (idx == list.length - 1) {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(5),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(18)));
  } else {
    return const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)));
  }
}
