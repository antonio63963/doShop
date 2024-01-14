import 'package:doshop_app/utils/constants.dart';

import '../../models/models/product.dart';

class ProductService {
  static final List<ProductTag> _unitsList = [
    ProductTag(tag: Units.kg, isSelected: true),
    ProductTag(tag: Units.thing),
    ProductTag(tag: Units.lt),
    ProductTag(tag: Units.pack),
    ProductTag(tag: Units.block),
    ProductTag(tag: Units.couple),
    ProductTag(tag: Units.meter),
    ProductTag(tag: Units.square),
  ];

  static List<ProductTag> get unitsList {
    return [..._unitsList];
  }

  static const String grocery = 'assets/icons/grocery';

  static List<ProductTag> getIconsByCat(int cat) {
    if (cat == 11) {
      return [
        ProductTag(tag: DefaultValues.icon, isSelected: true),
        ...IconsAssets.meat
            .map((i) => ProductTag(tag: '$grocery/meat/$i'))
            .toList()
      ];
    } else {
      return [ProductTag(tag: DefaultValues.icon, isSelected: true)];
    }
  }

  static double unitDelta(String unit) => unit == Units.kg ||
          unit == Units.lt ||
          unit == Units.meter ||
          unit == Units.square
      ? 0.5
      : 1;
}
