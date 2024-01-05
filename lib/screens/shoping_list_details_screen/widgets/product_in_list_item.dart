import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/options_product_tile.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/product_in_list_tile.dart';
import 'package:doshop_app/widgets/ui/outlined_icon_button.dart';
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
      ),
      child: Material(
        borderRadius: widget.borderRadius,
        color: Color(widget.prod.colorBg ?? MyColors.defaultBG),
        clipBehavior: Clip.hardEdge,
        elevation: 3,
        child: Column(
          children: [
            ProductInListTile(
              prod: widget.prod,
              isOptions: isOptions,
              borderRadius: widget.borderRadius,
              onClick: widget.onIncrease,
              toggleIsOptions: () => setState(() => isOptions = !isOptions),
            ),
            isOptions
                ? OptionsProductTile(
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
                    onIncrease: widget.onIncrease,
                    onDecrease: widget.onDecrease,
                    onFire: () {
                      widget.onFire();
                      closeOptions();
                    },
                    isFire: widget.prod.isFire,
                    onToggleDone: () {
                      widget.onToggleDone();
                      closeOptions();
                    },
                    onSubmit: () {},
                    onClose: closeOptions)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
