import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OutlinedIconButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? svg;
  final Function() onClick;
  final double paddingTop;
  final double paddingRight;
  final double paddingBottom;
  final double paddingLeft;

  const OutlinedIconButton({
    super.key,
    required this.title,
    this.icon,
    this.svg,
    required this.onClick,
    this.paddingTop = 0,
    this.paddingRight = 0,
    this.paddingBottom = 0,
    this.paddingLeft = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop,
        right: paddingRight,
        bottom: paddingBottom,
        left: paddingLeft,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          side: const BorderSide(
            color: MyColors.primary,
          ),
        ),
        onPressed: onClick,
        child: Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            if (icon != null) Icon(icon),
            if (svg != null)
              SvgPicture.asset(
                svg!,
                colorFilter: const ColorFilter.mode(
                  MyColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            Text(
              title,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: MyColors.primary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
