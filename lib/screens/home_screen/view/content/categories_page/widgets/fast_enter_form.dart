import 'package:doshop_app/widgets/ui/input.dart';
import 'package:flutter/material.dart';

class FastEnterForm extends StatelessWidget {
  final TextEditingController searchController;
  final double? paddingTop;
  final double? paddingBottom;
  final Function(String)? onChange;

  const FastEnterForm({
    required this.searchController,
    this.paddingBottom = 16,
    this.paddingTop = 16,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop ?? 0,
        bottom: paddingBottom ?? 0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            inputController: searchController,
            onChange: onChange,
          ),
          if (searchController.text.isNotEmpty)
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
                      searchController.text = '';
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
