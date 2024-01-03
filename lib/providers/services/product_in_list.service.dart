import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';

class ProductInListService {
  static void addOrUpdateOne(ProductInList prod, List<ProductInList> srcList) {
    final idx = srcList.indexWhere((p) => p.prodId == prod.prodId);
    if (idx != -1) {
      srcList[idx] = prod.copy(id: srcList[idx].id);
    } else {
      srcList.add(prod);
    }
  }

  static void addOrUpdateMany(
      List<ProductInList> newProds, List<ProductInList> srcList) {
    for (var p in srcList) {
      addOrUpdateOne(p, srcList);
    }
  }

  static Map<String, List<ProductInList>> sorByCategories(
      List<ProductInList> productsList) {
    final Map<String, List<ProductInList>> sortedProductsMap = {};
    for (var p in productsList) {
      if (!p.isDone) {
        if (p.catTitle != null) {
          if (sortedProductsMap[p.catTitle] != null) {
            sortedProductsMap[p.catTitle]!.add(p);
          } else {
            sortedProductsMap[p.catTitle!] = [p];
          }
        } else {
          if (sortedProductsMap[DefaultValues.catTitle] != null) {
            sortedProductsMap[DefaultValues.catTitle]!.add(p);
          } else {
            sortedProductsMap[DefaultValues.catTitle] = [p];
          }
        }
      }
    }
    return sortedProductsMap;
  }
}
