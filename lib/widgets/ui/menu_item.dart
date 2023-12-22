import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final String? svgPath;

  const MenuItem({
    super.key,
    required this.title,
    this.icon,
    this.svgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        svgPath != null
            ? SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  svgPath!,
                  fit: BoxFit.contain,
                ))
            : Icon(icon),
        const SizedBox(width: 8),
        Text(title),
      ],
    );
  }
}
