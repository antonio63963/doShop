import 'package:doshop_app/forms/product_form/widgets/info_input.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/utils/validators.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/services/product.service.dart';

import 'package:doshop_app/widgets/exports.dart';

import '../product_form/widgets/select_unit_row.dart';

class AddToListForm extends StatefulWidget {
  final int listId;

  const AddToListForm({
    required this.listId,
    super.key,
  });

  @override
  State<AddToListForm> createState() => _AddToListFormState();
}

class _AddToListFormState extends State<AddToListForm> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  String selectedUnit = Units.kg;

  bool isLoading = false;

  List<ProductTag> unitsList = [];

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

  void onAddNewProduct(BuildContext context, ProductInList prod) {
    Provider.of<ProductInListProvider>(context, listen: false)
        .createCustomProductInList(context, prod)
        .then((value) {
      Navigator.pop(context);
      Helper.showSnack(context: context, text: 'Товар добавлен в список');
    });
  }

  dynamic submitForm(BuildContext context) {
    setState(() {
      isLoading = true;
    });
    final prod = ProductInList(
      listId: widget.listId,
      title: titleController.text,
      subtitle:
          subtitleController.text.isNotEmpty ? subtitleController.text : null,
      units: selectedUnit,
      info: infoController.text.isEmpty ? null : infoController.text,
      amount: double.parse(amountController.text),
      dateCreated: DateTime.now(),
    );
    onAddNewProduct(context, prod);
  }

  @override
  void initState() {
    super.initState();

    unitsList = ProductService.unitsList.map((e) {
      e.isSelected = false;
      return e;
    }).toList();
    markUnitAsSelected(0);
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
        SelectUnitRow(
          unitsList: unitsList,
          markUnitAsSelected: markUnitAsSelected,
        ),
        Input(
          label: 'Количество',
          inputController: amountController,
          inputType: TextInputType.number,
          validator: Validator.amount,
        )
      ],
      onSubmit: () => submitForm(context),
    );
  }
}
