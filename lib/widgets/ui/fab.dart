import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:doshop_app/utils/constants.dart';

class FAB extends StatelessWidget {
  final String? svgPath;
  final IconData? icon;
  final Function() onClick;

  const FAB({
    this.svgPath,
    this.icon,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onClick,
      shape: const CircleBorder(),
      backgroundColor: MyColors.primary,
      child: svgPath == null
          ? Icon(
              icon!,
              size: 24,
              color: MyColors.white,
            )
          : SvgPicture.asset(
              svgPath!,
              width: 24,
              colorFilter: const ColorFilter.mode(
                MyColors.white,
                BlendMode.srcIn,
              ),
            ),
    );
  }
}
