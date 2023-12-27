import 'package:flutter/material.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

showModal(BuildContext context, Widget content) {
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        topRight: Radius.circular(5),
      ),
    ),
    backgroundColor: Colors.transparent,
    context: context,
    useRootNavigator: false,
    isScrollControlled: true,
    isDismissible: true,
    builder: (context) {
      // return
      // SingleChildScrollView(
      //     controller: ModalScrollController.of(context), child: content);
      return SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: content,
          ),
        ),
      );
    },
  );
}
