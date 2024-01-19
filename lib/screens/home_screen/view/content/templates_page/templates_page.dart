import 'package:doshop_app/utils/constants.dart';
import 'package:doshop_app/widgets/exports.dart';
import 'package:doshop_app/widgets/ui/page_content_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:doshop_app/providers/user_template_provider.dart';

import 'widgets/templates_list_section.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({super.key});

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  bool isInit = false;
  bool isLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInit) {
      Provider.of<UserTemplateProvider>(context, listen: false)
          .getTemplates(context)
          .then((value) {
        isLoaded = true;
      });
    }
    isInit = true;
  }

  @override
  Widget build(BuildContext context) {
    final templatesList = Provider.of<UserTemplateProvider>(context).templates;
    return isLoaded
        ? PageContentWrapper(
            emptyScreenText: 'Пока что нет Шаблонов',
            isScreenEmpty: templatesList.isEmpty,
            paddingHorizontal: AppPadding.bodyHorizontal,
            paddingVertical: 32,
            onRefresh: () async {
              Provider.of<UserTemplateProvider>(context, listen: false)
                  .getTemplates(context);
            },
            widgets: [
              TemplatesListSection(templates: templatesList),
            ],
          )
        : const Loading();
  }
}
