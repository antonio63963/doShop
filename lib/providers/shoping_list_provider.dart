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
      logger.i('Created ShoppingList, ${response.toString()}');
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

  Future<void> updateList(BuildContext context, ShopingList list) async {
    if (list.id == null) {
      logger.e('Error update List No ID');
      setErrorAlert(
          context: context, message: 'Не возможно редактировать список!');
      return;
    }
    await GetIt.I<AbstractDB>().updateShoppingList(list).then((id) {
      if (id is int) {
        final idx = _lists.indexWhere((l) => l.id == list.id);
        if (idx != -1) {
          _lists[idx] = list;
          notifyListeners();
        } else {
          throw Error();
        }
      }
    }).catchError((err) {
      logger.e("Update Shopping lists Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось обновить список!');
    });
  }

  Future<void> deleteList(BuildContext context, int? listId) async {
    if (listId == null) {
      logger.e('Error delete List No ID');
      setErrorAlert(context: context, message: 'Не возможно удалить список!');
      return;
    }
    await GetIt.I<AbstractDB>().deleteShoppingList(listId).then((id) {
      logger.i('DELLLL: $id');
      if (id == 1) {
        _lists.removeWhere((l) => l.id == listId);
        notifyListeners();
      } else {
        throw Error();
      }
    }).catchError((err) {
      logger.e("Get Shopping lists Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось получить списки!');
    });
  }
}
