import 'package:doshop_app/providers/product_provider.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

List<Widget> getActions(BuildContext context) {
  return [
    IconButton(
      onPressed: () => Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false),
      icon: const Icon(
        Icons.home,
        color: MyColors.primary,
      ),
    ),
    IconButton(
      onPressed: () => Provider.of<ProductProvider>(context, listen: false)
          .creanProductsListAmount(),
      icon: const Icon(
        Icons.cleaning_services_outlined,
        color: MyColors.primary,
      ),
    ),
  ];
}
