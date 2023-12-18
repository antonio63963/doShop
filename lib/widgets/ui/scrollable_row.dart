import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ScrollableRow extends StatelessWidget {
  final List<Widget> widgets;
  final double? paddingBottom;
  final double? paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? widthRow;
  final ScrollController? scrollController;
  const ScrollableRow(
      {required this.widgets,
      this.paddingBottom,
      this.paddingTop,
      this.paddingRight,
      this.paddingLeft,
      this.widthRow = 1000,
      this.scrollController,
      super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: paddingBottom ?? 0,
        top: paddingTop ?? 0,
        left: paddingLeft ?? 0,
        right: paddingRight ?? 0,
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: widthRow != null && widthRow! < mediaQueryData.size.width
              ? mediaQueryData.size.width
              : widthRow,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [SizedBox(width: AppPadding.bodyHorizontal / 2), ...widgets],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Icon(Icons.arrow_back_ios),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
