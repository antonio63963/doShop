import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SubcategoryItem extends StatelessWidget {
  final Subcategory sub;
  const SubcategoryItem({required this.sub, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(sub.colorBg!),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        SizedBox(
          width: 134,
          height: 90,
          child: Image.asset(
            sub.img ?? 'assets/img/categories/hobby.png',
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sub.title,
                style: const TextStyle(
                    color: MyColors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800),
              ),
              Text(
                sub.subtitle ?? '',
                style: const TextStyle(color: MyColors.white, fontSize: 16),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
