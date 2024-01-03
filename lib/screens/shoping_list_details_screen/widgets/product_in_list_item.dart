import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/product_in_list_tile.dart';
import 'package:flutter/material.dart';

class ProductInListItem extends StatefulWidget {
  final ProductInList prod;
  final BorderRadius borderRadius;
  final Function() onIncrease;
  final Function() onDecrease;
  final Function() onClean;
  final Function(BuildContext) onOpenDetails;
  final Function() onFire;
  final Function() onToggleDone;

  const ProductInListItem({
    required this.prod,
    required this.borderRadius,
    required this.onIncrease,
    required this.onDecrease,
    required this.onClean,
    required this.onOpenDetails,
    required this.onFire,
    required this.onToggleDone,
    super.key,
  });

  @override
  State<ProductInListItem> createState() => _ProductInListItemState();
}

class _ProductInListItemState extends State<ProductInListItem> {
  bool isOptions = false;

  void closeOptions() {
    setState(() {
      isOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
      ),
      child: Material(
        borderRadius: widget.borderRadius,
        elevation: 3,
        child: Column(
          children: [
            // ListTile(
            //   contentPadding: const EdgeInsets.only(
            //     left: 16,
            //     top: 8,
            //     bottom: 8,
            //     right: 16,
            //   ),
            //   tileColor: Color(widget.prod.colorBg ?? MyColors.defaultBG),
            //   shape: RoundedRectangleBorder(
            //     borderRadius: !isOptions
            //         ? widget.borderRadius
            //         : const BorderRadius.only(
            //             topLeft: Radius.circular(5),
            //             topRight: Radius.circular(5),
            //           ),
            //   ),
            //   leading: SizedBox(
            //     width: 56,
            //     height: 56,
            //     child: Image.asset(
            //         widget.prod.icon != null
            //             ? widget.prod.icon!
            //             : DefaultValues.icon,
            //         fit: BoxFit.contain),
            //   ),
            //   title: Row(
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Expanded(
            //         child: Text(
            //           widget.prod.title ?? '',
            //           overflow: TextOverflow.ellipsis,
            //           style: const TextStyle(
            //               color: MyColors.white,
            //               fontWeight: FontWeight.w600,
            //               fontSize: 16),
            //         ),
            //       ),
            //       IconFire(isFire: widget.prod.isFire, paddingHorizontal: 4),
            //     ],
            //   ),
            //   subtitle: Text(
            //     '${widget.prod.subtitle ?? ''} (${widget.prod.unit})',
            //     style: const TextStyle(
            //       color: Color.fromARGB(255, 236, 236, 236),
            //       fontSize: 14,
            //     ),
            //   ),
            //   trailing: Row(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     mainAxisSize: MainAxisSize.min,
            //     children: [
            //       Text('${widget.prod.amount}',
            //           style: theme.textTheme.bodyLarge?.copyWith(height: 1.1)),
            //      const SizedBox(width: 8),
            //       Text(
            //         widget.prod.unit ?? '',
            //         style: theme.textTheme.bodyMedium?.copyWith(
            //           fontWeight: FontWeight.w600,
            //         ),
            //       )
            //     ],
            //   ),
            //   //  widget.prod.amount > 0
            //   //     ? AmountWithDecreaseButton(
            //   //         amount: widget.prod.amount.toString(),
            //   //         onDecrease: () {
            //   //           widget.onDecrease();
            //   //           if (isOptions) {
            //   //             closeOptions();
            //   //           }
            //   //         },
            //   //       )
            //   //     : null,
            //   onTap: isOptions ? closeOptions : widget.onIncrease,
            //   onLongPress: () => setState(() {
            //     isOptions = true;
            //   }),
            // ),
            ProductInListTile(
              prod: widget.prod,
              isOptions: isOptions,
              borderRadius: widget.borderRadius,
              onClick: widget.onIncrease,
              toggleIsOptions: () => setState(() => isOptions = !isOptions),
            ),
            isOptions
                ? OptionProductRow(
                    onOpen: () {
                      widget.onOpenDetails(context);
                      closeOptions();
                    },
                    onClean: () {
                      widget.onClean();
                      if (widget.prod.isFire) {
                        widget.onFire();
                      }
                      closeOptions();
                    },
                    onIncreaseAmount: widget.onIncrease,
                    onDecreaseAmount: widget.onDecrease,
                    onFire: () {
                      widget.onFire();
                      closeOptions();
                    },
                    isFire: widget.prod.isFire,
                    onToggleDone: () {
                      widget.onToggleDone();
                      closeOptions();
                    },
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
