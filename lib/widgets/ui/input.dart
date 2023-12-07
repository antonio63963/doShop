import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final TextEditingController inputController;
  final Function(String)? onChange;
  const Input({
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
    return Row(
      children: [
        Flexible(
          child: FocusScope(
            child: Focus(
              onFocusChange: (bool focuse) {
                setState(() {
                  _isInputFocused = focuse;
                });
              },
              child: TextField(
                onChanged: widget.onChange,
                controller: widget.inputController,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: MyColors.primary),
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  suffix: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: MyColors.primary,
                    ),
                    iconSize: 24,
                    onPressed: () {
                      widget.inputController.text = '';
                    },
                  ),
                  labelText: 'Продукт',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        !_isInputFocused
            ? IconButton(
                onPressed: () {},
                icon: const Icon(Icons.mic),
                color: MyColors.primary,
              )
            : const SizedBox(),
      ],
    );
  }
}
