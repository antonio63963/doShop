import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class InfoInput extends StatefulWidget {
  final TextEditingController infoController;
  const InfoInput({required this.infoController, super.key});

  @override
  State<InfoInput> createState() => _InfoInputState();
}

class _InfoInputState extends State<InfoInput> {
  bool isShowInput = false;
  @override
  Widget build(BuildContext context) {
    return !isShowInput
        ? Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => setState(() {
                  isShowInput = true;
                }),
                child: const Text('Дополнительно'),
              ),
              SizedBox(width: AppPadding.bodyHorizontal),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Input(
                  inputController: widget.infoController,
                  maxLines: 3,
                  label: 'Дополнительная информация',
                ),
              ),
              IconButton(
                onPressed: () => setState(() {
                  isShowInput = false;
                }),
                icon: const Icon(
                  Icons.close_fullscreen_outlined,
                  size: 24,
                  color: MyColors.primary,
                ),
              ),
              SizedBox(width: AppPadding.bodyHorizontal),
            ],
          );
  }
}
