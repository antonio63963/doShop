import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final String? info;
  const AdditionalInfo({this.info, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(
          title: 'Дополнительное инфо:',
          paddingHorizontal: 0,
          paddingBottom: 12,
          paddingTop: 30,
        ),
        info != null
            ? Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 226, 219, 233),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Text(info!),
              )
            : Text(
                'Нет Информации',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: MyColors.primary,
                ),
              ),
      ],
    );
  }
}
