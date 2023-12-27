import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class AmountWithDecreaseButton extends StatelessWidget {
  final String amount;
  final Function() onDecrease;

  const AmountWithDecreaseButton({
    super.key,
    required this.amount,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            amount,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: MyColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: onDecrease,
          child: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
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
    );
  }
}
