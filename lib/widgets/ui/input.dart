import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class Input extends StatefulWidget {
  final String? Function(String?)? validator;
  final String? label;
  final TextEditingController inputController;
  final Function(String)? onChange;
  final bool autofocus;
  final double paddingVertical;
  final double paddingHorizontal;
  final int maxLines;
  final TextInputType? inputType;

  const Input({
    this.validator,
    this.label,
    required this.inputController,
    this.onChange,
    this.autofocus = false,
    this.paddingHorizontal = 16,
    this.paddingVertical = 16,
    this.maxLines = 1,
    this.inputType = TextInputType.text,

    super.key,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: widget.paddingHorizontal,
        vertical: widget.paddingVertical,
      ),
      child: TextFormField(
        keyboardType: widget.inputType,
        textCapitalization: TextCapitalization.sentences,
        validator: widget.validator,
        maxLines: widget.maxLines,
        autofocus: widget.autofocus,
        controller: widget.inputController,
        onChanged: widget.onChange,
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(color: MyColors.primary, fontSize: 16),
        decoration: InputDecoration(
          labelStyle: theme.textTheme.labelMedium,
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
              widget.onChange != null ? widget.onChange!('') : null;
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          labelText: widget.label ?? 'Продукт',
        ),
      ),
    );
  }
}
