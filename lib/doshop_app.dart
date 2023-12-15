
import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/screens/home_screen/exports.dart';
import 'package:doshop_app/themes/appTheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/exports.dart';
import 'package:doshop_app/routes/routes.dart';

class DoshopApp extends StatelessWidget {
  const DoshopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CategoriesProvider()),
      ChangeNotifierProvider(create: (context) => ProductProvider()),
    ], 
    child: MaterialApp(
      title: 'DoShop',
      routes: routes,
      theme: appTheme,
    ),
    );
  }
}