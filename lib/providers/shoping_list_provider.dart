import 'package:doshop_app/db/exports.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ShopingListProvider extends ErrorHandler {
  List<ShopingList> _lists = [];

  List<ShopingList> get lists => [..._lists];

  Future<void> createList(BuildContext context, ShopingList list) async {
    await GetIt.I<AbstractDB>().createList(list).then((response) {
      if (response == null) return;
      _lists.add(response);
      notifyListeners();
      
    }).catchError((err) {
      logger.e("Create list Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось создать Список!');
    });
  }
  Future<void> getLists(BuildContext context) async {
    await GetIt.I<AbstractDB>().getShopingLists().then((response) {
      _lists = response ?? [];
      notifyListeners();
    }).catchError((err) {
      logger.e("Get Shopping lists Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось получить списки!');
    });
  }
}
