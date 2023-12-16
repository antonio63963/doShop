import 'package:flutter/material.dart';

class PageContentWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> widgets;

  const PageContentWrapper({
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
