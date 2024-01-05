import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OptionProductRow extends StatelessWidget {
  final Function() onOpen;
  final Function()? onClean;
  final Function()? onDelete;
  final Function() onIncreaseAmount;
  final Function() onDecreaseAmount;
  final Function() onFire;
  final Function()? onToggleDone;
  final bool isFire;

  const OptionProductRow({
    super.key,
    required this.onOpen,
    this.onClean,
    this.onDelete,
    required this.onIncreaseAmount,
    required this.onDecreaseAmount,
    required this.onFire,
    this.onToggleDone,
    required this.isFire,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8),
      color: MyColors.white,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 16,
        children: [
          // open
          IconButton(
            onPressed: onOpen,
            icon: const Icon(Icons.open_in_new),
          ),
          //clean
          if(onClean != null)
          IconButton(
            onPressed: onClean,
            icon: const Icon(Icons.cleaning_services_outlined),
          ),
          //delete
          if(onDelete != null)
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete_forever),
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
          //done
          if (onToggleDone != null)
            IconButton(
              onPressed: onToggleDone,
              icon: const Icon(
                Icons.done_all_rounded,
              ),
            ),
        ],
      ),
    );
  }
}
