import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class SearchProductItem extends StatefulWidget {
  final Function() onClick;
  final Product prod;
  final bool isOptions;

  const SearchProductItem({
    super.key,
    required this.onClick,
    required this.prod,
    this.isOptions = false,
  });

  @override
  State<SearchProductItem> createState() => _SearchProductItemState();
}

class _SearchProductItemState extends State<SearchProductItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      tileColor: Color(widget.prod.colorBg ?? MyColors.defaultBG),
      shape: RoundedRectangleBorder(
        borderRadius: !widget.isOptions
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
            widget.prod.icon != null ? widget.prod.icon! : DefaultValues.icon,
            fit: BoxFit.contain),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              widget.prod.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  color: MyColors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          IconFire(isFire: widget.prod.isFire, paddingHorizontal: 4),
        ],
      ),
      subtitle: Text(
        '${widget.prod.subtitle ?? ''} (${widget.prod.units})',
        style: const TextStyle(
          color: Color.fromARGB(255, 236, 236, 236),
          fontSize: 14,
        ),
      ),
      trailing: widget.prod.amount > 0
          ? Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.prod.amount.toString(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: MyColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
      onTap: widget.onClick,
      contentPadding: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
    );
  }
}
