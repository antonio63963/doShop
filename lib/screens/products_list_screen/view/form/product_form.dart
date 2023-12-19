import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/validators.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product.service.dart';

import 'package:doshop_app/screens/products_list_screen/view/form/tag_input.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/select_icon_row.dart';
import 'package:doshop_app/screens/products_list_screen/view/form/select_unit_row.dart';

import 'package:doshop_app/widgets/exports.dart';

import 'info_input.dart';

class ProductForm extends StatefulWidget {
  final String? catImg;
  final int catId;
  final int colorBg;
  final List<ProductTag> tagsList;

  const ProductForm({
    this.catImg,
    required this.catId,
    required this.colorBg,
    required this.tagsList,
    super.key,
  });

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  ProductProvider? productProvider;
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  String selectedUnit = Units.kg;
  String selectedIcon = DefaultValues.icon;

  bool isLoading = false;

  List<ProductTag> iconsList = [];
  List<ProductTag> unitsList = [];
  // List<ProductTag> tagsList = [];

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
      unitsList = [
        unitsList[idx],
        ...unitsList.where((e) => e.tag != unitsList[idx].tag)
      ];
      selectedUnit = unitsList[idx].tag;
    });
  }

  dynamic submitForm(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    final prod = Product(
      catId: widget.catId,
      title: titleController.text,
      subtitle: subtitleController.text,
      units: selectedUnit,
      icon: selectedIcon,
      tag: tagController.text,
      colorBg: widget.colorBg,
      info: infoController.text,
    );
    productProvider?.createProduct(context, prod).then((value) {
      Navigator.pop(context);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iconsList = ProductService.getIconsByCat(widget.catId);
    unitsList = ProductService.unitsList;
    productProvider = Provider.of<ProductProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Tags:::: ${widget.tagsList}');
    return ModalBottomFormLayout(
      isLoading: isLoading,
      catImg: widget.catImg ?? DefaultValues.img,
      title: 'Добавить продукт',
      widgets: [
        Input(
          label: 'Название товара*',
          inputController: titleController,
          paddingVertical: 10,
          validator: Validator.title,
        ),
        Input(
          label: 'Краткое описание',
          inputController: subtitleController,
          paddingVertical: 10,
        ),
        InfoInput(infoController: infoController),
        TagInput(
          tagsList: widget.tagsList,
          tagController: tagController,
        ),
        SelectUnitRow(
          unitsList: unitsList,
          markUnitAsSelected: markUnitAsSelected,
        ),
        SelectIconRow(
          iconsList: iconsList,
          markIconAsSelected: markIconAsSelected,
          colorBg: Color(widget.colorBg),
        ),
      ],
      onSubmit: () => submitForm(context),
    );
  }
}
