import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/validators.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/shoping_list.service.dart';
import 'package:doshop_app/providers/user_tempate_provider.dart';

import 'package:doshop_app/forms/widgets/select_icon_row.dart';
import 'package:doshop_app/widgets/exports.dart';

class UserTemplateForm extends StatefulWidget {
  final UserTemplate? uTemp;
  const UserTemplateForm({this.uTemp, super.key});

  @override
  State<UserTemplateForm> createState() => _UserTemplateFormState();
}

class _UserTemplateFormState extends State<UserTemplateForm> {
  bool isInit = false;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();

  String _selectedIcon = DefaultValues.img;

  List<ProductTag> _iconsList = [];

  void markIconAsSelected(int idx) {
    setState(() {
      for (var e in _iconsList) {
        e.isSelected = false;
      }
      _iconsList[idx].isSelected = true;
      _selectedIcon = _iconsList[idx].tag;
      _iconsList = [
        _iconsList[idx],
        ..._iconsList.where((e) => e.tag != _iconsList[idx].tag)
      ];
    });
  }

  void onCreate(UserTemplate newTemp) {
    Provider.of<UserTemplateProvider>(context, listen: false)
        .createTemplate(context, newTemp)
        .then((value) {
      Navigator.pop(context);
      Helper.showSnack(
          context: context, text: 'Список ${newTemp.title} добавлен');
    });
  }

  void onUpdate(UserTemplate updatedTemp) {
    if (widget.uTemp == null) return;
    final isChanged = widget.uTemp!.isChanged(updatedTemp);
    logger.i('IS CHANGED: $isChanged');
    if (!isChanged) {
      Helper.showSnack(
          context: context, text: 'Список ${widget.uTemp?.title} не изменен');
    } else {
      Provider.of<UserTemplateProvider>(context, listen: false)
          .updateTemplate(context, updatedTemp.copy(id: widget.uTemp?.id))
          .then((value) {
        Navigator.pop(context);
        Helper.showSnack(
            context: context, text: 'Список ${widget.uTemp?.title} изменен');
      });
    }
  }

  void onSubmit() {
    final userTemplate = UserTemplate(
      title: titleController.text,
      subtitle:
          subtitleController.text.isEmpty ? null : subtitleController.text,
      img: _selectedIcon,
      productsIds: '',
    );
    widget.uTemp != null ? onUpdate(userTemplate) : onCreate(userTemplate);
  }

  @override
  void initState() {
    super.initState();
    if (!isInit) {
      _iconsList = ShopingListService.getIcons();
      if (widget.uTemp != null) {
        titleController.text = widget.uTemp!.title;
        subtitleController.text = widget.uTemp!.subtitle ?? '';
        final iconIdx =
            _iconsList.indexWhere((i) => i.tag == widget.uTemp?.img);
        markIconAsSelected(iconIdx);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomFormLayout(
      title: 'Создать Список',
      widgets: [
        Input(
          label: 'Заголовок',
          inputController: titleController,
          validator: Validator.title,
        ),
        Input(
          label: 'Подзаголовок',
          inputController: subtitleController,
        ),
        SelectIconRow(
          iconsList: _iconsList,
          markIconAsSelected: markIconAsSelected,
          colorBg: MyColors.primary,
        ),
      ],
      onSubmit: onSubmit,
    );
  }
}
