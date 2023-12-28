import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  final String message;
  const EmptyScreen({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: MyColors.primary);
        
    return Center(
      child: Text(
        message,
        style: style,
      ),
    );
  }
}
