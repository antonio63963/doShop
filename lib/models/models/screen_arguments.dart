class SubcategoriesScreenArguments {
  final int id;
  final String title;
  final int colorBg;
  final String catImg;

  SubcategoriesScreenArguments({
    required this.id,
    required this.title,
    required this.colorBg,
    required this.catImg,
  });
}
class ProductsScreenArguments {
  final int id;
  final String title;
  final String? subtitle;
  final int colorBg;
  final String catImg;
  final bool isSubcats;

  ProductsScreenArguments({
    required this.id,
    required this.title,
    this.subtitle,
    required this.colorBg,
    required this.catImg,
    required this.isSubcats,
  });
}
