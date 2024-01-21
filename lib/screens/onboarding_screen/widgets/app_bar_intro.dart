import 'package:flutter/material.dart';

import 'package:doshop_app/utils/constants.dart';

class AppBarIntro extends StatelessWidget implements PreferredSizeWidget {
  final Function() onClose;

  const AppBarIntro({
    super.key,
    required this.onClose,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF7A72C3),
      actions: [
        IconButton(
          onPressed: onClose,
          icon: const Icon(
            Icons.close_rounded,
            color: MyColors.white,
          ),
        ),
      ],
    );
  }
}
