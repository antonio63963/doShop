import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class HeaderCart extends StatelessWidget {
  final bool isOpened;
  final Function() onClick;
  final String productsCount;

  const HeaderCart({
    super.key,
    required this.productsCount,
    required this.isOpened,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onClick,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 14.0, horizontal: AppPadding.bodyHorizontal),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Wrap(
                children: [
                  const Text(
                    'Корзина',
                    style: TextStyle(
                      color: MyColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  badges.Badge(
                    badgeContent: Text(
                      productsCount,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    position: badges.BadgePosition.topEnd(end: -10),
                    child: const Icon(Icons.shopping_cart_outlined),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Icon(!isOpened ? Icons.arrow_drop_up : Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
