import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/products_list_screen/view/widgets/icon_fire.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductItem extends StatefulWidget {
  final Product prod;
  final Function(int?) onTap;
  final Function(int?) onTrailing;

  const ProductItem({
    required this.prod,
    required this.onTap,
    required this.onTrailing,
    super.key,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 3,
        child: ListTile(
          tileColor: Color(widget.prod.colorBg ?? MyColors.defaultBG),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          leading: SizedBox(
            width: 56,
            height: 56,
            child: Image.asset(
                widget.prod.icon ?? widget.prod.catImg ?? DefaultValues.img,
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
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        widget.prod.amount.toString(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: MyColors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => widget.onTrailing(widget.prod.id),
                      child: Container(
                        height: 40,
                        width: 40,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 5),
                        decoration: const BoxDecoration(
                          color: MyColors.label,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        alignment: Alignment.center,
                        child: const FittedBox(
                          child: Text(
                            '-',
                            style: TextStyle(
                              color: MyColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          // child: SvgPicture.asset(
                          //   'assets/icons/basket_minus.svg',
                          //   width: 24,
                          //   colorFilter: const ColorFilter.mode(
                          //       MyColors.white, BlendMode.srcIn),
                          // ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                )
              : null,
          onTap: () => widget.onTap(widget.prod.id),
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
