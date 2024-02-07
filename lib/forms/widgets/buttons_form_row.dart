import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class ButtonsFormRow extends StatelessWidget {
  final Function() onClose;
  final Function() onSubmit;
  final bool isSaveActive;

  const ButtonsFormRow({
    super.key,
    required this.onClose,
    required this.onSubmit,
    this.isSaveActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(),
      child: Wrap(
        spacing: 16,
        children: [
          isSaveActive
              ? PrimaryButton(
                  elevation: 0,
                  bgColor: MyColors.white,
                  iconData: Icons.save,
                  text: 'Сохранить',
                  onPressed: onSubmit,
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 204, 204, 204)),
                  onPressed: null,
                  child: const Text(
                    'СОХРАНИТЬ',
                    style: TextStyle(
                        color: MyColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
          PrimaryButton(
            text: 'Отменить',
            iconData: Icons.close_outlined,
            elevation: 0,
            textColor: MyColors.danger,
            bgColor: MyColors.white,
            onPressed: onClose,
          )
        ],
      ),
    );
  }
}
