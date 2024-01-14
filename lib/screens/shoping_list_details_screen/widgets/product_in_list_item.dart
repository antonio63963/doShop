import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_in_list_provider.dart';
import 'package:doshop_app/providers/services/product.service.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/options_product_tile.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/screens/shoping_list_details_screen/widgets/product_in_list_tile.dart';
import 'package:doshop_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInListItem extends StatefulWidget {
  final ProductInList prod;
  final BorderRadius borderRadius;
  final Function()? onClean;
  final Function()? onDelete;
  final Function(BuildContext) onOpenDetails;
  final Function() onToggleDone;

  const ProductInListItem({
    required this.prod,
    required this.borderRadius,
    this.onClean,
    this.onDelete,
    required this.onOpenDetails,
    required this.onToggleDone,
    super.key,
  });

  @override
  State<ProductInListItem> createState() => _ProductInListItemState();
}

class _ProductInListItemState extends State<ProductInListItem> {
  bool isLoading = false;
  late ProductInList product;
  bool isOptions = false;

  void closeOptions() {
    setState(() {
      isOptions = false;
    });
  }

  void onIncreaseAmount() {
    logger.i('OnIncrease Amount: ${widget.prod.toString()}');
    if(widget.prod.unit == null) return;
    setState(() {
      widget.prod.amount += ProductService.unitDelta(widget.prod.unit!);
    });
  }

  void onDecreaseAmount() {
    if (widget.prod.amount == 0 || widget.prod.unit == null) return;
    setState(() {
     widget.prod.amount -= ProductService.unitDelta(widget.prod.unit!);
    });
  }

  void onToggleFire() {
    setState(() {
      widget.prod.isFire = !widget.prod.isFire;
    });
  }

  void onUpdateProduct(BuildContext context) {
    logger.i('CHANGEA::: ${!widget.prod.isChanged(product)}');
    if (!widget.prod.isChanged(product)) {
      Helper.showSnack(context: context, text: 'Нет изменений');
      return;
    }
    setState(() {
      isLoading = true;
    });
    Provider.of<ProductInListProvider>(context, listen: false)
        .updateProductInList(context, widget.prod)
        .then((value) {
      isLoading = false;
      Helper.showSnack(
          context: context, text: '${widget.prod.title} был обновлен.');
      closeOptions();
    });
  }

  @override
  void initState() {
    super.initState();
    //for compare changed item to update
    product = widget.prod.copy();
  }

  @override
  Widget build(BuildContext context) {
        logger.f('PRODUCT IN LIST TILE: ${widget.prod.toString()}');
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
              toggleIsOptions: () => setState(() => isOptions = !isOptions),
            ),
            if (isLoading)
              const LinearProgressIndicator(color: MyColors.accent),
            isOptions
                ? OptionsProductTile(
                    onOpen: () {
                      widget.onOpenDetails(context);
                      closeOptions();
                    },
                    onClean: widget.onClean != null
                        ? () {
                            widget.onClean!();
                            if (widget.prod.isFire) {
                              onToggleFire();
                            }
                          }
                        : null,
                    onDelete: widget.onDelete,
                    onIncrease: onIncreaseAmount,
                    onDecrease: onDecreaseAmount,
                    onFire: () {
                      onToggleFire();
                    },
                    isFire: !widget.prod.isFire,
                    onToggleDone: () {
                      widget.onToggleDone();
                      closeOptions();
                      onUpdateProduct(context);
                    },
                    onSubmit: () => onUpdateProduct(context),
                    onClose: closeOptions,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
