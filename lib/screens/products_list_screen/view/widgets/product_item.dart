import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductItem extends StatefulWidget {
  final Product prod;

  const ProductItem({
    required this.prod,
    super.key,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int amount = 0;

  void increaseAmount() {
    setState(() {
      amount++;
    });
  }

  void decreaseAmount() {
    setState(() {
      amount--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 3,
        child: ListTile(
          // contentPadding: EdgeInsets.symmetric(
          //   vertical: 16, horizontal: 16,
          // ),
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
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/fire_fill.svg',
                width: 24,
                colorFilter: ColorFilter.mode(MyColors.accent, BlendMode.srcIn),
              ),
            ],
          ),
          subtitle: Text(
            '${widget.prod.subtitle ?? ''} (${widget.prod.units})',
            style: const TextStyle(
              color: Color.fromARGB(255, 236, 236, 236),
              fontSize: 14,
            ),
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // SvgPicture.asset(
              //   'assets/icons/fire_fill.svg',
              //   width: 24,
              //   colorFilter: ColorFilter.mode(MyColors.accent, BlendMode.srcIn),
              // ),
              // const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(10),
                child: Text(
                  amount.toString(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: MyColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 40,
                  width: 40,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: const BoxDecoration(
                    color: MyColors.label,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      '-',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: MyColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          onTap: () => print('Id: ${widget.prod.id}'),
          contentPadding: EdgeInsets.only(
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
