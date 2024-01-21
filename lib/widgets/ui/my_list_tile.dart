import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/ui/icon_fire.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final Color colorBg;
  final ShapeBorder? shape;
  final String? img;
  final String title;
  final bool isFire;
  final String? subtitle;
  final Widget? trailing;
  final Function()? onTap;
  final Function()? onLongPress;
  final double paddingHorizontal;
  final double paddingVertical;

  const MyListTile({
    super.key,
    required this.colorBg,
    required this.shape,
    this.img,
    required this.title,
    required this.isFire,
    this.subtitle,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.paddingHorizontal = 0,
    this.paddingVertical = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: paddingHorizontal, vertical: paddingVertical),
      child: ListTile(
        contentPadding: const EdgeInsets.only(
          left: 16,
          top: 8,
          bottom: 8,
          right: 8,
        ),
        tileColor: colorBg,
        shape: shape,
        leading: SizedBox(
          width: 56,
          height: 56,
          child: Image.asset(img != null ? img! : DefaultValues.icon,
              fit: BoxFit.contain),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
            ),
            IconFire(isFire: isFire, paddingHorizontal: 4),
          ],
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: const TextStyle(
                  color: Color.fromARGB(255, 236, 236, 236),
                  fontSize: 14,
                ),
              )
            : null,
        trailing: trailing,
        onTap: onTap,
        onLongPress: onLongPress,
      ),
    );
  }
}
