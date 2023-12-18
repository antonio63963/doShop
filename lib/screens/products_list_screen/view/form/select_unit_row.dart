import 'package:doshop_app/models/models/product.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/widgets/ui/tag_item.dart';
import 'package:flutter/material.dart';

class SelectUnitRow extends StatelessWidget {
  final List<ProductTag> unitsList;
  final Function(int) markUnitAsSelected;

  const SelectUnitRow({
    required this.unitsList,
    required this.markUnitAsSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 16.0,
            bottom: 12,
            left: AppPadding.bodyHorizontal,
          ),
          child: const Text('Единицы*',
              style: TextStyle(
                  color: MyColors.primary, fontWeight: FontWeight.w600)),
        ),
        ScrollableRow(
          widthRow: 650,
          widgets: unitsList
              .asMap()
              .entries
              .map((unit) =>
               TagItem(tag: unit.value, onClick: () => markUnitAsSelected(unit.key),)          
                  )
              .toList(),
        ),
      ],
    );
  }
}
