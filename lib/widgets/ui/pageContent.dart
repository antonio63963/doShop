import 'package:flutter/material.dart';

import '../../screens/products_list_screen/view/widgets/search_input.dart';

class PageContent extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> widgets;

  const PageContent({
    required this.onRefresh,
    required this.widgets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: widgets,
        ),
      ),
    );
  }
}
