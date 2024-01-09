class SubcategoriesScreenArguments {
  final int id;
  final String title;
  final int colorBg;
  final String catImg;
  final Function()? backToList;

  SubcategoriesScreenArguments({
    required this.id,
    required this.title,
    required this.colorBg,
    required this.catImg,
    this.backToList,
  });
}

class ProductsListScreenArguments {
  final int id;
  final String title;
  final String? subtitle;
  final int colorBg;
  final String catImg;
  final bool isSubcats;
  final Function()? backToList;

  ProductsListScreenArguments({
    required this.id,
    required this.title,
    this.subtitle,
    required this.colorBg,
    required this.catImg,
    required this.isSubcats,
    this.backToList,
  });
}

class ProductDetailsScreenArguments {
  final int id;
  final String title;
  final String? subtitle;
  final int colorBg;
  ProductDetailsScreenArguments({
    required this.id,
    required this.title,
    this.subtitle,
    required this.colorBg,
  });
}

class ProductInListDetailsScreenArguments {
  final int? id;
  final String title;
  final String? subtitle;
  final int? colorBg;
  ProductInListDetailsScreenArguments({
    this.id,
    required this.title,
    this.subtitle,
    this.colorBg,
  });
}
// class AddFromCategoriesScreenArguments {
//   final int listId;
//   final String listTitle;

//   AddFromCategoriesScreenArguments({
//     required this.listId,
//     required this.listTitle,
//   });
// }
