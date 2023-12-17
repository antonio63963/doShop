import 'package:doshop_app/utils/constants.dart';

import '../models/models/product.dart';

class ProductService {
  static final List<ProductTag> _unitsList = [
    ProductTag(tag: Units.kg, isSelected: true),
    ProductTag(tag: Units.thing),
    ProductTag(tag: Units.lt),
    ProductTag(tag: Units.pack),
    ProductTag(tag: Units.block),
    ProductTag(tag: Units.couple),
  ];

 static List<ProductTag> get unitsList {
    return [..._unitsList];
  }

  static const String grocery = 'assets/icons/grocery';

  static List<ProductTag> getIconsByCat(int cat) {
    if (cat == 11) {
      return [
        ProductTag(tag: 'assets/icons/label.png', isSelected: true),
        ...IconsAssets.meat
            .map((i) => ProductTag(tag: '$grocery/meat/$i'))
            .toList()
      ];
    } else {
      return [ProductTag(tag: 'assets/icons/label.png', isSelected: true)];
    }
  }
}
