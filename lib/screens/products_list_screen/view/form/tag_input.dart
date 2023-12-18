import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/widgets/exports.dart';

class TagInput extends StatefulWidget {
  const TagInput({super.key});

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    tagsList = Provider.of<ProductProvider>(context).tags.map((e) {
      e.isSelected = false;
      return e;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
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
                icon: SvgPicture.asset('assets/icons/tagsList.svg', width: 24, colorFilter: const ColorFilter.mode( MyColors.primary, BlendMode.srcIn),),
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
              SectionTitle(title: 'Выбрать Тэг'),
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
                  ...tagsList
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
