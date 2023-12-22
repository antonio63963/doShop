import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
  List<ProductTag> tagsList = [];
  bool isInput = false;
  bool isAutofocus = false;

  void onTagSelect(String tagValue) {
    widget.tagController.text = tagValue;
    isInput = true;
  }

  @override
  void initState() {
    super.initState();
    logger.i('INIT TAG: ${widget.tagController.text}');
    setState(() {
      isInput = widget.tagController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isInput
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Input(
                  inputController: widget.tagController,
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
