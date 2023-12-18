import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class ModalHeader extends StatelessWidget {
  final String title;
  final Function() onClose;

  const ModalHeader({
    required this.title,
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.bodyHorizontal),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Wrap(
          //   spacing: 8,
          //   children: [
          //     Image.asset(catImg, width: 48),
          //   ],
          // ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(color: MyColors.primary, fontSize: 20, fontWeight: FontWeight.w600),
          ),
          IconButton(
            onPressed: onClose,
            icon: const Icon(
              Icons.close,
              color: MyColors.primary,
            ),
            color: Colors.red,
            highlightColor: MyColors.lightPurple,
          ),
        ],
      ),
    );
  }
}
