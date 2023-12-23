import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final Color colorBg;
  final String imgAsset;
  final String labelText;
  final String text;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;

  const InfoRow(
      {super.key,
      required this.colorBg,
      required this.imgAsset,
      required this.labelText,
      required this.text,
      this.paddingLeft = 0,
      this.paddingRight = 0,
      this.paddingTop = 0,
      this.paddingBottom = 0});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        bottom: paddingBottom,
        left: paddingLeft,
        right: paddingRight,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleProductIcon(
            colorBg: colorBg,
            img: imgAsset,
          ),
          SizedBox(width: AppPadding.bodyHorizontal),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: labelText,
                paddingHorizontal: 0,
                paddingBottom: 0,
              ),
              Text(
                text,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: MyColors.primary),
              ),
            ],
          )
        ],
      ),
    );
  }
}
