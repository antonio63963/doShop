import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class DontShowButton extends StatelessWidget {
  final Function() setNotShown;
  
  const DontShowButton({super.key, required this.setNotShown});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32),
        child: OutlinedButton(
          onPressed: setNotShown,
          style: OutlinedButton.styleFrom(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            side: const BorderSide(
              color: MyColors.white,
            ),
          ),
          child: const Text(
            'Не показывать больше',
            style: TextStyle(
              color: MyColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
