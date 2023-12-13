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
    final tags = productProvider
        .tags
        .map((tag) => ElevatedButton(onPressed: () => productProvider.setSelectedTag(tag), child: Text(tag)), )
        .toList();
    return ScrollableRow(
      widgets: tags,
      paddingLeft: AppPadding.bodyHorizontal,
      paddingBottom: 20,
    );
  }
}
