import 'package:doshop_app/forms/shoping_list_form/widgets/select_color_row.dart';
import 'package:doshop_app/forms/widgets/select_icon_row.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/shoping_list.service.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class ShopingListForm extends StatefulWidget {
  const ShopingListForm({super.key});

  @override
  State<ShopingListForm> createState() => _ShopingListFormState();
}

class _ShopingListFormState extends State<ShopingListForm> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController subtitleController = TextEditingController();
  int _selectedColor = MyColors.defaultBG;
  String _selectedIcon = DefaultValues.img;

  List<ProductTag> _iconsList = [];
  List<ColorTile> _colorsList = [];

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

  void markColorAsSelected(int idx) {
    setState(() {
      for (var e in _colorsList) {
        e.isSelected = false;
      }
      _colorsList[idx].isSelected = true;
      _selectedColor = _colorsList[idx].color;
      _colorsList = [
        _colorsList[idx],
        ..._colorsList.where((e) => e.color != _colorsList[idx].color)
      ];
    });
  }

  @override
  void initState() {
    super.initState();
    _iconsList = ShopingListService.getIcons();
    _colorsList = ShopingListService.getColors();
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomFormLayout(
        title: 'Создать Список',
        widgets: [
          Input(
            label: 'Заголовок',
            inputController: titleController,
          ),
          Input(
            label: 'Подзаголовок',
            inputController: subtitleController,
          ),
          SelectColorRow(
            colorsList: _colorsList,
            markColorAsSelected: markColorAsSelected,
            colorBg: Color(_selectedColor),
          ),
          SelectIconRow(
            iconsList: _iconsList,
            markIconAsSelected: markIconAsSelected,
            colorBg: Color(_selectedColor),
          ),
        ],
        onSubmit: () {});
  }
}
