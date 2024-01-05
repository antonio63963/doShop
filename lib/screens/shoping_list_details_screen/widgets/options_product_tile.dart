import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class OptionsProductTile extends StatelessWidget {
  final Function() onOpen;
  final Function() onClean;
  final Function() onIncrease;
  final Function() onDecrease;
  final Function() onFire;
  final bool isFire;
  final Function() onToggleDone;
  final Function() onSubmit;
  final Function() onClose;

  const OptionsProductTile({
    super.key,
    required this.onOpen,
    required this.onClean,
    required this.onIncrease,
    required this.onDecrease,
    required this.onFire,
    required this.isFire,
    required this.onToggleDone,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      color: MyColors.white,
      child: Column(
        children: [
          OptionProductRow(
            onOpen: onOpen,
            onClean: onClean,
            onIncreaseAmount: onIncrease,
            onDecreaseAmount: onDecrease,
            onFire: onFire,
            isFire: isFire,
            onToggleDone: onToggleDone,
          ),
          SizedBox(height: 22),
          ButtonBar(
            children: [
              OutlinedIconButton(
                title: 'ПОДТВЕРДИТЬ',
                svg: 'assets/icons/confirm_update.svg',
                onClick: onSubmit,
              ),
              OutlinedIconButton(
                paddingLeft: 16,
                title: 'ОТМЕНИТЬ',
                icon: Icons.close_rounded,
                onClick: onClose,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
