import 'package:doshop_app/utils/constants.dart';
import 'package:flutter/material.dart';

class TakePhoto extends StatelessWidget {
  final Function() onClick;
  const TakePhoto({super.key, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
color: const Color.fromARGB(255, 244, 233, 255),
      shadowColor: MyColors.primary,
      type: MaterialType.card,
       borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: InkWell(
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          onTap: onClick,
          child: SizedBox(
            width: 200,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.photo,
                  size: 100,
                  color: MyColors.primary,
                ),
                Text(
                  'Сделать фото',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: MyColors.primary,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // GestureDetector(
    //   onTap: onClick,
    //   child: Card(
    //     child: SizedBox(
    //         width: 200,
    //         height: 200,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             const Icon(
    //               Icons.photo,
    //               size: 100,
    //               color: MyColors.primary,
    //             ),
    //             Text(
    //               'Сделать фото',
    //               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
    //                     color: MyColors.primary,
    //                   ),
    //             ),
    //           ],
    //         )),
    //   ),
    // );
  }
}
