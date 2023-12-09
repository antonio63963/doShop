import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class SubcategoryItem extends StatelessWidget {
  final Subcategory sub;
  final Function onTap;
  const SubcategoryItem({
    required this.sub,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Color(sub.colorBg!),
          ),
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
        ),
      ),
    );
  }
}
