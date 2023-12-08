import 'package:doshop_app/widgets/ui/input.dart';
import 'package:flutter/material.dart';

class FastEnterForm extends StatefulWidget {
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddinRight;
  final double? paddingLeft;

  const FastEnterForm({
    this.paddingTop,
    this.paddingBottom,
    this.paddinRight,
    this.paddingLeft,
    super.key,
  });

  @override
  State<FastEnterForm> createState() => _FastEnterFormState();
}

class _FastEnterFormState extends State<FastEnterForm> {
  final TextEditingController enterProductController = TextEditingController();

  void onChange(String str) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: widget.paddingTop ?? 0,
        bottom: widget.paddingBottom ?? 0,
        right: widget.paddinRight ?? 0,
        left: widget.paddingLeft ?? 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            inputController: enterProductController,
            onChange: onChange,
          ),
          if (enterProductController.text.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Подтвердить'),
                  ),
                  const SizedBox(width: 24),
                  ElevatedButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      enterProductController.text = '';
                      onChange('_');
                    },
                    child: const Text('Отменить'),
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
