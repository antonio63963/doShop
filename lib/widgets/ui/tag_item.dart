import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TagItem extends StatelessWidget {
  final ProductTag tag;
  final Function() onClick;

  const TagItem({
    required this.tag,
    required this.onClick,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        GestureDetector(
          onTap: onClick,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: tag.isSelected ? MyColors.primary : MyColors.lightPurple,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                tag.isSelected
                    ? const Padding(
                        padding: EdgeInsets.only(right: 4),
                        child:
                            Icon(Icons.done, size: 14, color: MyColors.white),
                      )
                    : const SizedBox(),
                Text(
                  tag.tag,
                  style: TextStyle(
                    color: tag.isSelected ? MyColors.white : MyColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
