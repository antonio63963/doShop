import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class SearchProductItem extends StatelessWidget {
  final Function()? onClick;
  final Product prod;
  final double? paddingVertical;
  final bool isOptions;
  final Function()? onTrailing;

  const SearchProductItem({
    super.key,
    this.onClick,
    required this.prod,
    this.paddingVertical = 4,
    this.isOptions = false,
    this.onTrailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical!),
      child: Container(
        decoration: BoxDecoration(
          color: Color(prod.colorBg ?? MyColors.defaultBG),
          borderRadius: !isOptions
              ? const BorderRadius.all(Radius.circular(5))
              : const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
        ),
        child: ListTile(
          tileColor: Color(prod.colorBg ?? MyColors.defaultBG),
          shape: RoundedRectangleBorder(
            borderRadius: !isOptions
                ? const BorderRadius.all(Radius.circular(5))
                : const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
          ),
          leading: SizedBox(
            width: 56,
            height: 56,
            child: Image.asset(
              prod.icon != null ? prod.icon! : DefaultValues.icon,
              fit: BoxFit.contain,
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  prod.title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              IconFire(isFire: prod.isFire, paddingHorizontal: 4),
            ],
          ),
          subtitle: Text(
            '${prod.subtitle ?? ''} (${prod.units})',
            style: const TextStyle(
              color: Color.fromARGB(255, 236, 236, 236),
              fontSize: 14,
            ),
          ),
          trailing: Wrap(
            spacing: 24,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  prod.amount.toString(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: onTrailing,
                icon: const Icon(
                  Icons.close_rounded,
                  size: 24,
                  color: MyColors.white,
                ),
              )
            ],
          ),
          onTap: onClick,
          contentPadding: const EdgeInsets.only(
            left: 16,
            top: 8,
            bottom: 8,
            right: 8,
          ),
        ),
      ),
    );
  }
}
