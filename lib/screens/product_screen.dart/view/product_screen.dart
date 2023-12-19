import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/widgets/exports.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(_screenArguments?.title ?? 'Название не найдено'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert,
              size: 24,
              color: MyColors.primary,
            ),
          ),
        ],
      ),
      body: !_isLoaded
          ? const Loading()
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
              child: PageContentWrapper(
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
                  SizedBox(height: 32),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SingleProductIcon(
                        colorBg: Color(
                            _screenArguments?.colorBg ?? MyColors.defaultBG),
                        img: _product?.icon ?? DefaultValues.icon,
                      ),
                      SizedBox(width: AppPadding.bodyHorizontal),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionTitle(
                            title: 'Короткое описание:',
                            paddingHorizontal: 0,
                            paddingBottom: 12,
                          ),
                          Text(
                            _screenArguments?.subtitle ?? 'Нет',
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: MyColors.primary),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  Wrap(
                    spacing: 12,
                    children: [
                      if (_product != null && _product!.tag != null)
                        TagItem(
                          tag: ProductTag(
                            tag: _product!.tag!,
                            isSelected: true,
                          ),
                          onClick: () {},
                        ),
                      TagItem(
                        tag: ProductTag(
                          tag: _product!.units,
                          isSelected: true,
                        ),
                        onClick: () {},
                      ),
                    ],
                  ),
                  const SectionTitle(
                    title: 'Дополнитеоьное инфо:',
                    paddingHorizontal: 0,
                    paddingBottom: 12,
                    paddingTop: 30,
                  ),
                  _product?.info != null
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 226, 219, 233),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          child: Text(_product!.info!),
                        )
                      : Text(
                          'Нет Информации',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: MyColors.primary,
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
