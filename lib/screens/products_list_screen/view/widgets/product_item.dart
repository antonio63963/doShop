import 'package:doshop_app/models/exports.dart';
import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final Product prod;

  const ProductItem({required this.prod, super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Material(
        borderRadius: BorderRadius.circular(5),
        elevation: 3,
        child: ListTile(
          // contentPadding: EdgeInsets.symmetric(
          //   vertical: 16, horizontal: 16,
          // ),
          tileColor: Color(prod.colorBg ?? MyColors.defaultBG),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          leading: SizedBox(
            width: 56,
            height: 56,
            child: Image.asset(prod.icon ?? prod.catImg ?? DefaultValues.img,
                fit: BoxFit.contain),
          ),
          title: Text(
            prod.title,
            style: const TextStyle(
                color:  MyColors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          subtitle: prod.subtitle != null
              ? Text(prod.subtitle!,
                  style: TextStyle(color: Color.fromARGB(255, 236, 236, 236), fontSize: 14))
              : null,
          onTap: () => print('Id: ${prod.id}'),
        ),
      ),
    );
  }
}
