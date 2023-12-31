import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/widgets/ui/scrollable_row.dart';

class TagsSection extends StatelessWidget {
  const TagsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final tags = productProvider.tags.asMap().entries.map((entry) {
      int idx = entry.key;
      ProductTag tag = entry.value;
      return ElevatedButton(
        onPressed: () => productProvider.setSelectedTag(idx),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          backgroundColor:
              tag.isSelected ? MyColors.primary : MyColors.lightPurple,
        ),
        child: Text(
          tag.tag,
          style: TextStyle(
            color: tag.isSelected ? MyColors.white : MyColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }).toList();
    return ScrollableRow(
      widgets: tags,
      paddingBottom: 20,
    );
  }
}
