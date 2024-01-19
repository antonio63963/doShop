import 'package:doshop_app/db/exports.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class UserTemplateProvider extends ErrorHandler {
  List<UserTemplate> _uTemps = [];
  // for add products by form with categories
  UserTemplate? _addToTemplate;

  List<UserTemplate> get templates => [..._uTemps];

  UserTemplate? get addToTempate => _addToTemplate?.copy();

  void setAddToTemplate(int? tempId) {
    if (tempId != null) {
      _addToTemplate = _uTemps.firstWhere((p) => p.id == tempId);
    } else {
      _addToTemplate = null;
    }
  }

  Future<void> createTemplate(BuildContext context, UserTemplate uTemp) async {
    await GetIt.I<AbstractDB>().createTempate(uTemp).then((response) {
      if (response == null) return;
      logger.i('Created template, ${response.toString()}');
      _uTemps.add(response);
      notifyListeners();
    }).catchError((err) {
      logger.e("Create Template Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось создать Шаблон!');
    });
  }

  Future<void> getTemplates(BuildContext context) async {
    await GetIt.I<AbstractDB>().getAllTemplates().then((response) {
      _uTemps = response ?? [];
      notifyListeners();
    }).catchError((err) {
      logger.e("Get Templates Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось получить Шаблоны!');
    });
  }

  Future<void> updateTemplate(BuildContext context, UserTemplate uTemp) async {
    if (uTemp.id == null) {
      logger.e('Error update Template No ID');
      setErrorAlert(
          context: context, message: 'Не возможно редактировать Шаблон!');
      return;
    }
    await GetIt.I<AbstractDB>().updateTemplate(uTemp).then((id) {
      if (id is int) {
        final idx = _uTemps.indexWhere((l) => l.id == uTemp.id);
        if (idx != -1) {
          _uTemps[idx] = uTemp;
          notifyListeners();
        } else {
          throw Error();
        }
      }
    }).catchError((err) {
      logger.e("Update Template Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось обновить Шаблон!');
    });
  }

  Future<void> cleanTemplate(BuildContext context, UserTemplate uTemp) async {
    if (uTemp.id == null) {
      logger.e('Error update Template No ID');
      setErrorAlert(
          context: context, message: 'Не возможно редактировать Шаблон!');
      return;
    }
    await GetIt.I<AbstractDB>()
        .updateTemplate(uTemp.copy(productsIds: ''))
        .then((id) {
      if (id is int) {
        final idx = _uTemps.indexWhere((l) => l.id == uTemp.id);
        if (idx != -1) {
          _uTemps[idx] = uTemp;
          notifyListeners();
        } else {
          throw Error();
        }
      }
    }).catchError((err) {
      logger.e("Update Template Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось обновить Шаблон!');
    });
  }

  Future<void> deleteTemplate(BuildContext context, int? tempId) async {
    if (tempId == null) {
      logger.e('Error delete List No ID');
      setErrorAlert(context: context, message: 'Не возможно удалить Шаблон!');
      return;
    }
    await GetIt.I<AbstractDB>().deleteShoppingList(tempId).then((id) {
      logger.i('DELLLL: $id');
      if (id == 1) {
        _uTemps.removeWhere((l) => l.id == tempId);
        notifyListeners();
      } else {
        throw Error();
      }
    }).catchError((err) {
      logger.e("Delete temlate id: $tempId Error!!! $err");
      setErrorAlert(context: context, message: 'Не удалось удалить Шаблон!');
    });
  }
}
