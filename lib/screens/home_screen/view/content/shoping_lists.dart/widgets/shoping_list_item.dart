import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'menu_list_item.dart';

class ShopingListItem extends StatelessWidget {
  final ShopingList list;
  final Function onTap;
  const ShopingListItem({
    required this.list,
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
          height: 120,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            color: Color(list.colorBg ?? MyColors.defaultBG),
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
                  list.img ?? DefaultValues.img,
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
                      constraints: BoxConstraints(maxHeight: 60),
                      child: Text(
                        list.title,
                        style: const TextStyle(
                            overflow: TextOverflow.fade,
                            height: 1.2,
                            color: MyColors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      list.subtitle ?? '',
                      style: const TextStyle(
                          color: MyColors.white,
                          fontSize: 16,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ),
              MenuListItem(
                context: context,
                list: list,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
