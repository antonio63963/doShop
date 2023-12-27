import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:doshop_app/utils/constants.dart';

class IconFire extends StatelessWidget {
  final bool isFire;
  final double paddingHorizontal;

  const IconFire({required this.isFire, this.paddingHorizontal = 0, super.key});

  @override
  Widget build(BuildContext context) {
    return isFire
        ? Padding(
            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
            child: SvgPicture.asset(
              'assets/icons/fire_fill.svg',
              width: 24,
              colorFilter:
                  const ColorFilter.mode(MyColors.accent, BlendMode.srcIn),
            ),
          )
        : const SizedBox();
  }
}
