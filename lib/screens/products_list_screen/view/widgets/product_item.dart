import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/screens/product_details_screen.dart/exports.dart';
import 'package:doshop_app/widgets/ui/icon_fire.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    final theme = Theme.of(context);
    print('ICON: ${widget.prod.icon}');
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
                          onTap: () {
                            widget.onDecrease();
                            if (isOptions) {
                              closeOptions();
                            }
                          },
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
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
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
                ? Wrap(
                    direction: Axis.vertical,
                    children: [
                      const SizedBox(height: 8),
                      Wrap(
                        direction: Axis.horizontal,
                        spacing: 16,
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.onOpenDetails(context);
                              closeOptions();
                            },
                            icon: Icon(Icons.open_in_new),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.onClean();
                              if (widget.prod.isFire) {
                                widget.onFire();
                              }
                              closeOptions();
                            },
                            icon: Icon(Icons.cleaning_services_outlined),
                          ),
                          IconButton(
                            onPressed: widget.onIncrease,
                            icon: const Icon(
                              Icons.plus_one_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: widget.onDecrease,
                            icon: const Icon(
                              Icons.exposure_neg_1,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              widget.onFire();
                              closeOptions();
                            },
                            icon: SvgPicture.asset(
                              !widget.prod.isFire
                                  ? 'assets/icons/fire_fill.svg'
                                  : 'assets/icons/fire.svg',
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                !widget.prod.isFire
                                    ? MyColors.accent
                                    : MyColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
