import 'package:doshop_app/models/models/product.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
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
            right: AppPadding.bodyHorizontal,
          ),
          child: const Text('Единицы*',
              style: TextStyle(
                  color: MyColors.primary, fontWeight: FontWeight.w600)),
        ),
        ScrollableRow(
          paddingLeft: AppPadding.bodyHorizontal,
          widthRow: 650,
          widgets: unitsList
              .asMap()
              .entries
              .map((unit) => ElevatedButton(
                    onPressed: () =>
                        markUnitAsSelected(unit.key),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: unit.value.isSelected
                          ? MyColors.primary
                          : MyColors.lightPurple,
                    ),
                    child: Text(
                      unit.value.tag,
                      style: TextStyle(
                        color: unit.value.isSelected
                            ? MyColors.white
                            : MyColors.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}
