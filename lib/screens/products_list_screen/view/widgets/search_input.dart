import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:doshop_app/widgets/exports.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onInput;

  SearchInput({required this.onInput, super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Input(
        inputController: _searchController,
        onChange: widget.onInput,
        paddingVertical: 20,
      ),
    );
  }
}
