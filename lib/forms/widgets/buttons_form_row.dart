import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class ButtonsFormRow extends StatelessWidget {
  final Function() onClose;
  final Function() onSubmit;
  
  const ButtonsFormRow({super.key, required this.onClose, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(),
      child: Wrap(
        spacing: 16,
        children: [
          SecondaryButton(
            text: 'Подтвердить',
            onPressed: onSubmit,
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
