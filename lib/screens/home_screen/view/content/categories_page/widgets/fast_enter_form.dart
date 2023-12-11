import 'package:doshop_app/widgets/ui/input.dart';
import 'package:flutter/material.dart';

class FastEnterForm extends StatelessWidget {
  final double? paddingTop;
  final double? paddingBottom;
  final double? paddinRight;
  final double? paddingLeft;

   FastEnterForm({
    this.paddingTop,
    this.paddingBottom,
    this.paddinRight,
    this.paddingLeft,
    super.key,
  });

  final TextEditingController enterProductController = TextEditingController();
  void onChange(String str) {}

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0,
        bottom: paddingBottom ?? 0,
        right: paddinRight ?? 0,
        left: paddingLeft ?? 0,
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
