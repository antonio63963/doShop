import 'package:flutter/material.dart';

import '../../../utils/constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 22,
        direction: Axis.vertical,
        children: [
          CircularProgressIndicator(),
          Text(
            'Загрузка...',
            style: TextStyle(
              color: MyColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }
}
