import 'package:doshop_app/screens/product_screen.dart/view/widgets/info_row.dart';
import 'package:doshop_app/screens/product_screen.dart/view/widgets/unit_and_tag.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/widgets/exports.dart';

import 'widgets/additional_info.dart';

class ProductScreen extends StatefulWidget {
  static String routeName = '/productScreen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isLoaded = false;
  bool _isInit = false;

  ProductScreenArguments? _screenArguments;
  ProductProvider? _productProvider;
  Product? _product;

  Future<void> refresh() async {
    final response = await Provider.of<ProductProvider>(context, listen: false)
        .getProductById(context, _screenArguments!.id);
    setState(() {
      _product = response;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _screenArguments =
          ModalRoute.of(context)?.settings.arguments as ProductScreenArguments;
      _productProvider = Provider.of<ProductProvider>(context);
      _productProvider?.getProductById(context, _screenArguments!.id).then(
            (value) => setState(
              () {
                _product = value;
                _isInit = true;
              },
            ),
          );
    }
    _isLoaded = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(
        appBar: AppBar(),
        title: _screenArguments?.title ?? 'Не определен',
        subtitle: _screenArguments?.subtitle ?? '',
        onMenu: () {},
      ),
      body: !_isLoaded
          ? const Loading()
          : PageContentWrapper(
              paddingHorizontal: AppPadding.bodyHorizontal,
              onRefresh: refresh,
              widgets: [
                const Card(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: Icon(
                      Icons.photo,
                      size: 100,
                      color: MyColors.primary,
                    ),
                  ),
                ),
                InfoRow(
                  labelText: 'Категория:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: _product?.catImg ?? DefaultValues.icon,
                  text:
                      '${_product?.categoryTitle} ${_product?.categorySubtitle}',
                  paddingBottom: 32,
                  paddingTop: 32,
                ),
                InfoRow(
                  labelText: 'Короткое описание:',
                  colorBg:
                      Color(_screenArguments?.colorBg ?? MyColors.defaultBG),
                  imgAsset: _product?.icon ?? DefaultValues.icon,
                  text: _screenArguments?.subtitle ?? 'Нет',
                  paddingBottom: 32,
                ),
                UnitAndTag(
                  product: _product,
                ),
                AdditionalInfo(info: _product?.info),
              ],
            ),
    );
  }
}
