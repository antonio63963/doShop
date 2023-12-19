import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/widgets/exports.dart';

class TagInput extends StatefulWidget {
  final List<ProductTag> tagsList;
  final TextEditingController tagController;

  const TagInput({
    required this.tagsList,
    required this.tagController,
    super.key,
  });

  @override
  State<TagInput> createState() => _TagInputState();
}

class _TagInputState extends State<TagInput> {
  final TextEditingController tagController = TextEditingController();
  List<ProductTag> tagsList = [];
  bool isInput = false;
  bool isAutofocus = false;

  void onTagSelect(String tagValue) {
    setState(() {
      tagController.text = tagValue;
      isInput = true;
    });
  }

  @override
  Widget build(BuildContext context) {
logger.i('TagInput: ${widget.tagsList}');
    return isInput
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Input(
                  inputController: tagController,
                  label: 'Тэг',
                  autofocus: isAutofocus,
                ),
              ),
              IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/tagsList.svg',
                  width: 24,
                  colorFilter:
                      const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
                ),
                onPressed: () => setState(() {
                  isInput = false;
                  isAutofocus = false;
                }),
              ),
              SizedBox(width: AppPadding.bodyHorizontal),
            ],
          )
        : Wrap(
            children: [
             const SectionTitle(title: 'Выбрать Тэг'),
              ScrollableRow(
                widthRow: 1000,
                widgets: [
                  TagItem(
                    onClick: () {
                      setState(() {
                        isInput = true;
                        isAutofocus = true;
                      });
                    },
                    tag: ProductTag(tag: 'Новый тэг', isSelected: false),
                  ),
                  ...widget.tagsList
                      .asMap()
                      .entries
                      .map(
                        (tag) => TagItem(
                          tag: tag.value,
                          onClick: () => onTagSelect(tag.value.tag),
                        ),
                      )
                      .toList()
                ],
              ),
            ],
          );
  }
}
