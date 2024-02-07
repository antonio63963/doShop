import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/validators.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/product.service.dart';

import 'package:doshop_app/widgets/exports.dart';

import 'widgets/info_input.dart';
import '../widgets/select_icon_row.dart';
import 'widgets/select_unit_row.dart';
import 'widgets/tag_input.dart';

class ProductForm extends StatefulWidget {
  final Product? product;
  final int catId;
  final int colorBg;
  final List<ProductTag> tagsList;

  const ProductForm({
    this.product,
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

  TextEditingController getInitControllerValue(String field) {
    if (widget.product != null) {
      if (widget.product?.toJSON()[field] != null) {
        return TextEditingController(
            text: widget.product?.toJSON()[field] as String);
      }
      return TextEditingController();
    } else {
      return TextEditingController();
    }
  }

  void markIconAsSelected(int idx) {
    setState(() {
      for (var e in iconsList) {
        e.isSelected = false;
      }
      iconsList[idx].isSelected = true;
      selectedIcon = iconsList[idx].tag;
      iconsList = [
        iconsList[idx],
        ...iconsList.where((e) => e.tag != iconsList[idx].tag)
      ];
    });
  }

  void markUnitAsSelected(int idx) {
    setState(() {
      for (var e in unitsList) {
        e.isSelected = false;
      }
      unitsList[idx].isSelected = true;
      selectedUnit = unitsList[idx].tag;
      unitsList = [
        unitsList[idx],
        ...unitsList.where((e) => e.tag != unitsList[idx].tag)
      ];
    });
  }

  void onAddNewProduct(Product prod) {
    productProvider?.createProduct(context, prod).then((value) {
      Navigator.pop(context);
    });
  }

  void onUpdateProduct(Product prod) {
    if (widget.product!.isEqual(prod)) {
      Helper.showSnack(context: context, text: 'Не получены новые данные.');
      return;
    } else {
      Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(context, prod)
          .then((value) {
        Navigator.pop(context);
      });
    }
  }

  dynamic submitForm(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    final prod = Product(
      id: widget.product?.id,
      catId: widget.catId,
      title: titleController.text,
      subtitle:
          subtitleController.text.isNotEmpty ? subtitleController.text : null,
      units: selectedUnit,
      icon: selectedIcon,
      tag: tagController.text,
      colorBg: widget.colorBg,
      info: infoController.text.isEmpty ? null : infoController.text,
      categoryTitle: widget.product?.categoryTitle,
      categorySubtitle: widget.product?.categorySubtitle,
    );
    widget.product != null ? onUpdateProduct(prod) : onAddNewProduct(prod);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    iconsList = ProductService.getIconsByCat(widget.catId);
    unitsList = ProductService.unitsList.map((e) {
      e.isSelected = false;
      return e;
    }).toList();
    productProvider = Provider.of<ProductProvider>(context);

    titleController = getInitControllerValue('title');
    subtitleController = getInitControllerValue('subtitle');
    tagController = getInitControllerValue('tag');
    infoController = getInitControllerValue('info');
    if (widget.product != null) {
      selectedUnit =
          widget.product?.units != null ? widget.product!.units : Units.kg;

      final unitIndex =
          unitsList.indexWhere((u) => u.tag == widget.product?.units);
      if (unitIndex != -1) {
        markUnitAsSelected(unitIndex);
      } else {
        markUnitAsSelected(0);
      }

      final iconIndex =
          iconsList.indexWhere((i) => i.tag == widget.product?.icon);
      if (iconIndex != -1) {
        markIconAsSelected(iconIndex);
      }
    } else {
      markUnitAsSelected(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalBottomFormLayout(
      isLoading: isLoading,
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
