import 'package:doshop_app/screens/products_list_screen/view/widgets/tags_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

import 'widgets/search_input.dart';
import 'widgets/slidable_product_item.dart';

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

  late ProductProvider productProvider;
  List<Product> _productsList = [];


  @override
  void didChangeDependencies() {
    if (!isInit) {
      _screenArguments =
          ModalRoute.of(context)?.settings.arguments as ProductsScreenArguments;
      productProvider = Provider.of<ProductProvider>(context);
      logger.d('++++++ProdScreen+++++ : $_screenArguments');
      Provider.of<ProductProvider>(context)
          .getProductsByCategory(context, _screenArguments.id);
      isInit = true;
      isLoaded = true;
    }
    isInit = true;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    productProvider.creanProductsList();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _productsList = productProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: Text('${_screenArguments.title}  ${_screenArguments.subtitle}'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
            icon: const Icon(
              Icons.home,
              color: MyColors.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: MyColors.primary,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            productProvider.getProductsByCategory(context, _screenArguments.id),
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: [
              SearchInput(onInput: (String value) => productProvider.setSearchData(value)),
             const TagsSection(),
              _productsList.isNotEmpty
                  ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _productsList.length,
                        itemBuilder: (_, idx) {
                          final prod = _productsList[idx];
                          return SlidableProductItem(
                            onClick: productProvider.increaseAmount,
                            onClickTrailing: productProvider.decreaseAmount,
                            onToggleFire: productProvider.toggleFire,
                            prod: prod,
                            idx: idx,
                          );
                        }),
                  )
                  : const Center(
                      child: Text('Пока что нет товаров'),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: MyColors.primary,
        child: !productProvider.isAnySelected
            ? const Icon(
                Icons.add,
                size: 24,
                color: MyColors.white,
              )
            : SvgPicture.asset(
                'assets/icons/addToList.svg',
                width: 24,
                colorFilter: const ColorFilter.mode(
                  MyColors.white,
                  BlendMode.srcIn,
                ),
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
