import 'package:doshop_app/models/models/product.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class SelectIconRow extends StatelessWidget {
  final List<ProductTag> iconsList;
  final Function(int) markIconAsSelected;
  final Color colorBg;

  const SelectIconRow({
    required this.iconsList,
    required this.markIconAsSelected,
    required this.colorBg,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        const SectionTitle(
          title: 'Выбрать иконку',
          paddingBottom: 12,
          paddingTop: 32,
        ),
        ScrollableRow(
          paddingLeft: AppPadding.bodyHorizontal,
          widthRow: 800,
          widgets: iconsList.asMap().entries.map((icon) {
            return GestureDetector(
              onTap: () => markIconAsSelected(icon.key),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: icon.value.isSelected ? MyColors.primary : colorBg,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                ),
                child: SizedBox(
                  width: 76,
                  height: 76,
                  child: Image.asset(
                    icon.value.tag,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }
}
