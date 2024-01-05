import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class PageContentWrapper extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final bool isScreenEmpty;
  final List<Widget> widgets;
  final double paddingHorizontal;
  final double paddingVertical;

  const PageContentWrapper({
    this.isScreenEmpty = false,
    required this.onRefresh,
    required this.widgets,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return isScreenEmpty
        ? const EmptyScreen(message: 'Пока что нет списков')
        : Padding(
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
