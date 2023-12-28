import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';

class ShopingListService {
  static const String grocery = 'assets/img/lists';

  static List<ProductTag> getIcons() {
    return [
      ProductTag(tag: DefaultValues.icon, isSelected: true),
      ...IconsAssets.shopingLists
          .map((i) => ProductTag(tag: 'assets/img/lists/$i'))
          .toList()
    ];
  }

  static List<ColorTile> getColors() {
    return [
       ColorTile(color: MyColors.defaultBG, isSelected: true),
      ...MyColors.listColors.map((i) => ColorTile(color: i)).toList()
    ];
  }
}
