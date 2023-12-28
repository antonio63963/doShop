import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/widgets/exports.dart';

class SelectColorRow extends StatelessWidget {
  final List<ColorTile> colorsList;
  final Function(int) markColorAsSelected;
  final Color colorBg;

  const SelectColorRow({
    required this.colorsList,
    required this.markColorAsSelected,
    required this.colorBg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const SectionTitle(
          title: 'Выбрать цвет',
          paddingBottom: 12,
          paddingTop: 32,
        ),
        ScrollableRow(
          widthRow: 1500,
          widgets: colorsList.asMap().entries.map((color) {
            return GestureDetector(
              onTap: () => markColorAsSelected(color.key),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(color.value.color),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: color.value.isSelected
                      ? const Icon(
                          Icons.check_circle_sharp,
                          color: MyColors.white,
                          size: 24,
                        )
                      : null,
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
