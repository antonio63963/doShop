import 'package:doshop_app/models/models/product_in_list.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class ProductInListTile extends StatelessWidget {
  final ProductInList prod;
  final bool isOptions;
  final Function()? toggleIsOptions;
  final Function()? onToggleIsDone;
  final Function()? onClick;
  final BorderRadius? borderRadius;

  const ProductInListTile({
    super.key,
    required this.prod,
    required this.isOptions,
    this.toggleIsOptions,
    this.onToggleIsDone,
    required this.borderRadius,
    this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 16,
      ),
      leading: SizedBox(
        width: 56,
        height: 56,
        child: Image.asset(prod.icon != null ? prod.icon! : DefaultValues.icon,
            fit: BoxFit.contain),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              prod.title ?? '',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          IconFire(isFire: prod.isFire, paddingHorizontal: 4),
        ],
      ),
      subtitle: Text(
        '${prod.subtitle ?? ''} (${prod.unit})',
        style: const TextStyle(
          color: Color.fromARGB(255, 236, 236, 236),
          fontSize: 14,
        ),
      ),
      trailing: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('${prod.amount}',
              style: theme.textTheme.bodyLarge?.copyWith(height: 1.1)),
          const SizedBox(width: 8),
          Text(
            prod.unit ?? '',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      onTap: isOptions ? toggleIsOptions : onClick,
      onLongPress: toggleIsOptions,
    );
  }
}
