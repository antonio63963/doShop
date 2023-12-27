import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'amount_with_decrease_button.dart';

class ProductItem extends StatefulWidget {
  final Product prod;
  final Function() onIncrease;
  final Function() onDecrease;
  final Function() onClean;
  final Function(BuildContext) onOpenDetails;
  final Function() onFire;

  const ProductItem({
    required this.prod,
    required this.onIncrease,
    required this.onDecrease,
    required this.onClean,
    required this.onOpenDetails,
    required this.onFire,
    super.key,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool isOptions = false;

  void closeOptions() {
    setState(() {
      isOptions = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 3,
        child: Column(
          children: [
            ListTile(
              tileColor: Color(widget.prod.colorBg ?? MyColors.defaultBG),
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
                    widget.prod.icon != null
                        ? widget.prod.icon!
                        : DefaultValues.icon,
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
                  ? AmountWithDecreaseButton(
                      amount: widget.prod.amount.toString(),
                      onDecrease: () {
                        widget.onDecrease();
                        if (isOptions) {
                          closeOptions();
                        }
                      },
                    )
                  : null,
              onTap: isOptions ? closeOptions : widget.onIncrease,
              onLongPress: () => setState(() {
                isOptions = true;
              }),
              contentPadding: const EdgeInsets.only(
                left: 16,
                top: 8,
                bottom: 8,
                right: 8,
              ),
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
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
