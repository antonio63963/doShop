import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/widgets/exports.dart';

class ProductForm extends StatelessWidget {
  final String? catImg;
  const ProductForm({this.catImg, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController subtitleController = TextEditingController();

    return ModalBottomFormLayout(
        catImg: catImg ?? DefaultValues.img,
        title: 'Добавить продукт',
        widgets: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Input(
                label: 'Название товара', inputController: titleController),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Input(
                label: 'Краткое описание', inputController: subtitleController),
          ),
          Text('Единицы*'),
          Wrap(spacing: 10, children: [])
        ],
        onSubmit: () {});
  }
}
