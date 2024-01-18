import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class BigListItem extends StatelessWidget {
  final Function() onTap;
  final Color colorBg;
  final String title;
  final String subtitle;
  final String img;
  final Widget menu;

  const BigListItem({
    super.key,
    required this.onTap,
    required this.colorBg,
    required this.title,
    required this.subtitle,
    required this.img,
    required this.menu,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => onTap(),
        child: Ink(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: colorBg,
          ),
          padding: const EdgeInsets.only(top: 8, right: 4, bottom: 8, left: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 134,
                height: 90,
                child: Image.asset(
                  img,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 60),
                      child: Text(
                        title,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            height: 1.2,
                            color: MyColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              menu
            ],
          ),
        ),
      ),
    );
  }
}
