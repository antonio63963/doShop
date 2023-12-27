import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/home_screen/view/content/categories_page/widgets/search_product_item.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';

class SearchDataList extends StatelessWidget {
  final Function(int) onItemClick;
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
          return SearchProductItem(
              onClick: () => onItemClick(prod.id!), prod: prod);
        },
      ),
    );
  }
}
