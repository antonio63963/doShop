import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionProductRow extends StatelessWidget {
  final Function() onOpen;
  final Function() onClean;
  final Function() onIncreaseAmount;
  final Function() onDecreaseAmount;
  final Function() onFire;
  final bool isFire;

  const OptionProductRow({
    super.key,
    required this.onOpen,
    required this.onClean,
    required this.onIncreaseAmount,
    required this.onDecreaseAmount,
    required this.onFire,
    required this.isFire,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      children: [
        const SizedBox(height: 8),
        Wrap(
          direction: Axis.horizontal,
          spacing: 16,
          children: [
            // open
            IconButton(
              onPressed: onOpen,
              icon: const Icon(Icons.open_in_new),
            ),
            //clean
            IconButton(
              onPressed: onClean,
              icon: const Icon(Icons.cleaning_services_outlined),
            ),
            //increase
            IconButton(
              onPressed: onIncreaseAmount,
              icon: const Icon(
                Icons.plus_one_outlined,
              ),
            ),
            //decrease
            IconButton(
              onPressed: onDecreaseAmount,
              icon: const Icon(
                Icons.exposure_neg_1,
              ),
            ),
            //fire
            IconButton(
              onPressed: onFire,
              icon: SvgPicture.asset(
                isFire ? 'assets/icons/fire_fill.svg' : 'assets/icons/fire.svg',
                width: 24,
                colorFilter: ColorFilter.mode(
                  isFire ? MyColors.accent : MyColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
