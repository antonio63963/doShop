import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';

class AppBarMain extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final String subtitle;
  final AppBar appBar;
  final Function() onMenu;

  const AppBarMain({
    required this.title,
    required this.subtitle,
    required this.appBar,
    required this.onMenu,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title  $subtitle'),
      actions: [
        IconButton(
          onPressed: () => Navigator.of(context)
              .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
          icon: const Icon(
            Icons.home,
            color: MyColors.primary,
          ),
        ),
        IconButton(
          onPressed: onMenu,
          icon: const Icon(
            Icons.more_vert,
            color: MyColors.primary,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}
