import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? label;
  final TextEditingController inputController;
  final Function(String)? onChange;
  const Input({
    this.label,
    required this.inputController,
    this.onChange,
    super.key,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool _isInputFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputController,
      onChanged: widget.onChange,
      textAlignVertical: TextAlignVertical.center,
      style: const TextStyle(color: MyColors.primary, fontSize: 16),
      decoration: InputDecoration(
        labelStyle: TextStyle(fontSize: 16),
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        suffix: IconButton(
          icon: const Icon(
            Icons.close,
            color: MyColors.primary,
          ),
          iconSize: 24,
          onPressed: () {
            widget.inputController.text = '';
            widget.onChange != null ? widget.onChange!('') : null;
            FocusManager.instance.primaryFocus?.unfocus();
          },
        ),
        labelText: widget.label ?? 'Продукт',
      ),
    );
  }
}
