import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ButtonsRow extends StatelessWidget {
  final Function() onSubmit;
  final Function() onClose;

  const ButtonsRow({
    super.key,
    required this.onSubmit,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: onSubmit,
            style: TextButton.styleFrom(
              foregroundColor: MyColors.primary,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.save_rounded),
                SizedBox(width: 12),
                Text('Сохранить')
              ],
            ),
          ),
          const SizedBox(width: 16),
          TextButton(
            onPressed: onClose,
            style: TextButton.styleFrom(
              foregroundColor: MyColors.danger,
              textStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            child: const Row(
              children: [
                Icon(Icons.close_rounded),
                SizedBox(width: 10),
                FittedBox(child: Text('Отмена'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
