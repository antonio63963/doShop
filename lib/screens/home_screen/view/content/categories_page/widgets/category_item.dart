import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final CategoryProd category;
  const CategoryItem({required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 5,
      shadowColor: MyColors.primary,
      type: MaterialType.transparency,
      child: Ink(
        decoration: BoxDecoration(
          color: Color(category.colorBg ?? MyColors.defaultBG),
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    fit: BoxFit.contain,
                    category.img ?? 'assets/img/categories/hobby.png',
                    height: 132,
                    width: 180,
                  ),
                  Text(category.title, style: theme.textTheme.headlineMedium)
                ],
              ),
            )),
      ),
    );
  }
}
