import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';
import 'modal_header.dart';

// ignore: must_be_immutable
class ModalBottomFormLayout extends StatelessWidget {
  final String catImg;
  final String title;
  final List<Widget> widgets;
  final Function() onSubmit;
  final void Function()? onClose;
  final double? horizontalPadding;
  final double? verticalPadding;
  String submitTitle;
  IconData submitIcon;

  ModalBottomFormLayout({
    super.key,
    required this.catImg,
    required this.title,
    required this.widgets,
    required this.onSubmit,
    this.onClose,
    this.submitTitle = 'Сохранить',
    this.submitIcon = Icons.save,
    this.horizontalPadding,
    this.verticalPadding,
  });

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Wrap(
      children: [
        GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.opaque,
          child: Container(
            padding: mediaQueryData.viewInsets,
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0))),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModalHeader(
                    title: title,
                    onClose: () {
                      Navigator.pop(context);
                    },
                  ),
                  ...widgets,
                  Padding(
                    padding: EdgeInsets.only(
                      left: AppPadding.bodyHorizontal,
                      right: AppPadding.bodyHorizontal,
                      bottom: 32,
                      top: 32,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SecondaryButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              onSubmit();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Processing Data')),
                              );
                            }
                          },
                          text: submitTitle,
                        ),
                        const SizedBox(width: 12),
                        SecondaryButton(
                          onPressed: () {
                            if (onClose is Function) onClose!();
                            Navigator.pop(context);
                          },
                          text: 'Отменить',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
