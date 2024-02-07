import 'package:doshop_app/forms/shoping_list_form/widgets/select_color_row.dart';
import 'package:doshop_app/forms/widgets/select_icon_row.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/shoping_list.service.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:doshop_app/utils/validators.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListForm extends StatefulWidget {
  final ShoppingList? list;
  const ShoppingListForm({this.list, super.key});

  @override
  State<ShoppingListForm> createState() => _ShoppingListFormState();
}

class _ShoppingListFormState extends State<ShoppingListForm> {
  bool isInit = false;
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

  void onCreate(ShoppingList newList) {
    Provider.of<ShoppingListProvider>(context, listen: false)
        .createList(context, newList)
        .then((value) {
      Navigator.pop(context);
      Helper.showSnack(
          context: context, text: 'Список ${newList.title} добавлен');
    });
  }

  void onUpdate(ShoppingList newList) {
    if (widget.list == null) return;
    final isChanged = widget.list!.isChanged(newList);
    if (!isChanged) {
      Helper.showSnack(
          context: context, text: 'Список ${widget.list?.title} не изменен');
    } else {
      Provider.of<ShoppingListProvider>(context, listen: false)
          .updateList(context, newList.copy(id: widget.list?.id))
          .then((value) {
        Navigator.pop(context);
        Helper.showSnack(
            context: context, text: 'Список ${widget.list?.title} изменен');
      });
    }
  }

  void onSubmit() {
    final newList = ShoppingList(
      title: titleController.text,
      subtitle:
          subtitleController.text.isEmpty ? null : subtitleController.text,
      colorBg: _selectedColor,
      img: _selectedIcon,
    );
    widget.list != null ? onUpdate(newList) : onCreate(newList);
  }

  @override
  void initState() {
    super.initState();
    if (!isInit) {
      _iconsList = ShopingListService.getIcons();
      _colorsList = ShopingListService.getColors();
      if (widget.list != null) {
        titleController.text = widget.list!.title;
        subtitleController.text = widget.list!.subtitle ?? '';
        _selectedColor = widget.list!.colorBg ?? MyColors.defaultBG;
        final iconIdx = _iconsList.indexWhere((i) => i.tag == widget.list?.img);
        markIconAsSelected(iconIdx);
        final colorIdx =
            _colorsList.indexWhere((c) => c.color == widget.list?.colorBg);
        markColorAsSelected(colorIdx);
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
      onSubmit: onSubmit,
    );
  }
}
