import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarTitleHome extends StatelessWidget {
  final String title;
  final int currentTab;
  const AppBarTitleHome(
      {super.key, required this.title, required this.currentTab});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: SvgPicture.asset(
            getIconByTab(currentTab),
            fit: BoxFit.contain,
            colorFilter:
                const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
          ),
        ),
        Text(title),
      ],
    );
  }
}

String getIconByTab(int currentTab) {
  switch (currentTab) {
    case 0:
      return 'assets/icons/categories.svg';
    case 1:
      return 'assets/icons/templates.svg';
    case 2:
      return 'assets/icons/lists.svg';
    default:
      return 'assets/icons/categories.svg';
  }
}
