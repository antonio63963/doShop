
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/exports.dart';

class DoshopApp extends StatelessWidget {
  const DoshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CategoriesProvider()),
    ]);
  }
}