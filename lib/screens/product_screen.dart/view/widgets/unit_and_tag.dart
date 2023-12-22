import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class UnitAndTag extends StatelessWidget {
  final Product? product;
  const UnitAndTag({this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        if (product != null && product!.tag != null)
          TagItem(
            tag: ProductTag(
              tag: product!.tag!,
              isSelected: true,
            ),
            onClick: () {},
          ),
        if (product != null)
          TagItem(
            tag: ProductTag(
              tag: product!.units,
              isSelected: true,
            ),
            onClick: () {},
          ),
      ],
    );
  }
}
