import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class SelectListSection extends StatelessWidget {
  final int? radioListOption;
  final Function(int?) onChangeOption;
  final List<ShopingList> lists;

  const SelectListSection({
    super.key,
    required this.radioListOption,
    required this.onChangeOption,
    required this.lists,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.bodyHorizontal,
        vertical: 24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(
            title: 'Выбрать список',
            paddingHorizontal: 0,
            paddingBottom: 0,
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView(
              shrinkWrap: true,
              children: lists.map((l) {
                return RadioListTile(
                  value: l.id,
                  title: Text(l.title,
                      style: const TextStyle(
                          color: MyColors.primary, fontSize: 18)),
                  groupValue: radioListOption,
                  onChanged: (value) {
                   onChangeOption(value);
                  },
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
