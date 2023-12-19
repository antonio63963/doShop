import 'package:flutter/material.dart';

class PageContentWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final List<Widget> widgets;
  final double paddingHorizontal;
  final double paddingVertical;

  const PageContentWrapper({
    required this.onRefresh,
    required this.widgets,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      child: RefreshIndicator(
        onRefresh: onRefresh,
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: ListView(
            children: widgets,
          ),
        ),
      ),
    );
  }
}
