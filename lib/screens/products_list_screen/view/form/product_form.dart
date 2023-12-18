import 'package:doshop_app/screens/products_list_screen/view/form/info_input.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/tag_input.dart';
import 'package:doshop_app/widgets/ui/tag_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product.service.dart';

import 'package:doshop_app/screens/products_list_screen/view/form/select_icon_row.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/select_unit_row.dart';

import 'package:doshop_app/widgets/exports.dart';

class ProductForm extends StatefulWidget {
  final String? catImg;
  final int catId;
  final Color colorBg;

  const ProductForm({
    this.catImg,
    required this.catId,
    required this.colorBg,
    super.key,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  String selectedUnit = Units.kg;
  String selectedIcon = DefaultValues.icon;

  List<ProductTag> iconsList = [];
  List<ProductTag> unitsList = [];
  List<ProductTag> tagsList = [];

  void markIconAsSelected(int idx) {
    setState(() {
      for (var e in iconsList) {
        e.isSelected = false;
      }
      iconsList[idx].isSelected = true;
      selectedIcon = iconsList[idx].tag;
    });
  }

  void markUnitAsSelected(int idx) {
    setState(() {
      for (var e in unitsList) {
        e.isSelected = false;
      }
      unitsList[idx].isSelected = true;
      selectedUnit = unitsList[idx].tag;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iconsList = ProductService.getIconsByCat(widget.catId);
    unitsList = ProductService.unitsList;
    tagsList = Provider.of<ProductProvider>(context).tags;
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomFormLayout(
      catImg: widget.catImg ?? DefaultValues.img,
      title: 'Добавить продукт',
      widgets: [
        Input(
          label: 'Название товара*',
          inputController: titleController,
          paddingVertical: 10,
        ),
        Input(
          label: 'Краткое описание',
          inputController: subtitleController,
          paddingVertical: 10,
        ),
        // InfoInput(infoController: infoController),
        const TagInput(),
        SelectUnitRow(
          unitsList: unitsList,
          markUnitAsSelected: markUnitAsSelected,
        ),
        SelectIconRow(
          iconsList: iconsList,
          markIconAsSelected: markIconAsSelected,
          colorBg: widget.colorBg,
        ),
      ],
      onSubmit: () {},
    );
  }
}
