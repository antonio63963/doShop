import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_product_item.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';

class SearchDataList extends StatelessWidget {
  final Function(Product) onItemClick;
  final List<Product> productsList;
  const SearchDataList({
    super.key,
    required this.onItemClick,
    required this.productsList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.bodyHorizontal),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productsList.length,
        itemBuilder: (_, idx) {
          final prod = productsList[idx];
          return
          //  MyListTile(
          //   paddingVertical: 4,
          //   colorBg: Color(prod.colorBg ?? MyColors.defaultBG),
          //   shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5))),
          //   title: prod.title,
          //   subtitle: prod.subtitle,
          //   isFire: prod.isFire,
          //   onTap: () => onItemClick(prod),
          // );
          SearchProductItem(
            isShownAmount: false,
              onClick: () => onItemClick(prod), prod: prod);
        },
      ),
    );
  }
}
