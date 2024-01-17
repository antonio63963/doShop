import 'package:doshop_app/forms/add_to_list_form/add_to_list_form.dart';
import 'package:doshop_app/utils/show_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/providers/shopping_list_provider.dart';
import 'package:doshop_app/utils/constants.dart';

import 'package:doshop_app/screens/add_product_screen/add_from_category_screen.dart';
import 'package:provider/provider.dart';

class FabExpandable extends StatelessWidget {
  final GlobalKey<ExpandableFabState> globalKey;
  final ProductInListDetailsScreenArguments screenArgs;

  const FabExpandable(
      {super.key, required this.globalKey, required this.screenArgs});

  @override
  Widget build(BuildContext context) {
    return ExpandableFab(
      key: globalKey,
      openButtonBuilder: RotateFloatingActionButtonBuilder(
        child: const Icon(Icons.format_list_bulleted_add),
        fabSize: ExpandableFabSize.regular,
        foregroundColor: MyColors.white,
        backgroundColor: MyColors.primary,
        shape: const CircleBorder(),
      ),
      closeButtonBuilder: DefaultFloatingActionButtonBuilder(
        child: const Icon(Icons.close),
        fabSize: ExpandableFabSize.small,
        foregroundColor: MyColors.white,
        backgroundColor: MyColors.accent,
        shape: const CircleBorder(),
      ),
      children: [
        FloatingActionButton.small(
          // shape: const CircleBorder(),
          heroTag: null,
          child: SvgPicture.asset(
            'assets/icons/newNotice.svg',
            colorFilter:
                const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
          ),
          onPressed: () {
            if (screenArgs.id != null) {
              showModal(
                context,
                AddToListForm(
                  listId: screenArgs.id!,
                ),
              );
            }
            final state = globalKey.currentState;
            if (state != null) {
              state.toggle();
            }
          },
        ),
        FloatingActionButton.small(
          // shape: const CircleBorder(),
          heroTag: null,
          child: SvgPicture.asset(
            'assets/icons/templates.svg',
            colorFilter:
                const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
          ),
          onPressed: () {
            final state = globalKey.currentState;
            if (state != null) {
              state.toggle();
            }
          },
        ),
        FloatingActionButton.small(
          // shape: const CircleBorder(),
          heroTag: null,
          child: SvgPicture.asset(
            'assets/icons/categories.svg',
            colorFilter:
                const ColorFilter.mode(MyColors.primary, BlendMode.srcIn),
          ),
          onPressed: () {
            final state = globalKey.currentState;

            Provider.of<ShoppingListProvider>(context, listen: false)
                .setAddToList(
                    ShoppingList(title: screenArgs.title, id: screenArgs.id));
            Navigator.of(context).pushNamed(
              AddFromCategoryScreen.routeName,
            );
            if (state != null) {
              state.toggle();
            }
          },
        ),
      ],
    );
  }
}
