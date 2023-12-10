import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/fast_enter_form.dart';
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
        child: ListView(
          children: [
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
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(5),
                      elevation: 3,
                      child: ListTile(
                        // contentPadding: EdgeInsets.symmetric(
                        //   vertical: 16, horizontal: 16,
                        // ),
                        tileColor: Color(prod.colorBg ?? MyColors.defaultBG),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        leading: SizedBox(
                          width: 56,
                          height: 56,
                          child: Image.asset(prod.icon ?? prod.catImg ?? DefaultValues.img,
                              fit: BoxFit.contain),
                        ),
                        title: Text(
                          prod.title,
                          style: TextStyle(
                              color: MyColors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        subtitle: prod.subtitle != null
                            ? Text(prod.subtitle!,
                                style: TextStyle(
                                    color: MyColors.white, fontSize: 14))
                            : null,
                      ),
                    ),
                  );
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
