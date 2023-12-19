import 'package:flutter/material.dart';

class SingleProductIcon extends StatelessWidget {
  final Color colorBg;
  final String img;

  const SingleProductIcon({
    required this.colorBg,
    required this.img,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorBg,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: SizedBox(
        width: 76,
        height: 76,
        child: Image.asset(
          img,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
