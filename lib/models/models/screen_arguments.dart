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
class ProductsListScreenArguments {
  final int id;
  final String title;
  final String? subtitle;
  final int colorBg;
  final String catImg;
  final bool isSubcats;

  ProductsListScreenArguments({
    required this.id,
    required this.title,
    this.subtitle,
    required this.colorBg,
    required this.catImg,
    required this.isSubcats,
  });
}
class ProductScreenArguments {
  final int id;
  final String title;
  final String? subtitle;
  final int colorBg;
  final String catImg;

  ProductScreenArguments({
    required this.id,
    required this.title,
    this.subtitle,
    required this.colorBg,
    required this.catImg,
  });
}