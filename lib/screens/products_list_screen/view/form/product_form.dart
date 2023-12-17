import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/models/models/category.dart';
import 'package:doshop_app/providers/product.service.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/select_icon_row.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/select_unit_row.dart';
import 'package:doshop_app/widgets/ui/scrollable_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';

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
  List<ProductTag> iconsList = [];
  List<ProductTag> unitsList = [];

  void markIconAsSelected(int idx) {
    setState(() {
      for (var e in iconsList) {
        e.isSelected = false;
      }
      iconsList[idx].isSelected = true;
    });
  }

  void markUnitAsSelected(int idx) {
    setState(() {
      for (var e in unitsList) {
        e.isSelected = false;
      }
      unitsList[idx].isSelected = true;
    });
  }

  @override
  void initState() {
    super.initState();
    iconsList = ProductService.getIconsByCat(widget.catId);
    unitsList = ProductService.unitsList;
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomFormLayout(
      catImg: widget.catImg ?? DefaultValues.img,
      title: 'Добавить продукт',
      widgets: [
        Input(
          label: 'Название товара',
          inputController: titleController,
        ),
        Input(
          label: 'Краткое описание',
          inputController: subtitleController,
        ),
        SelectUnitRow(
          unitsList: unitsList,
          markUnitAsSelected: markUnitAsSelected,
        ),
        SelectIconRow(
          iconsList: iconsList,
          markIconAsSelected: markIconAsSelected,
          colorBg: widget.colorBg,
        )
      ],
      onSubmit: () {},
    );
  }
}
