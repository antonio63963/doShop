// import 'package:doshop_app/utils/constants.dart';
// import 'package:flutter/material.dart';

// class PrimaryButton extends StatelessWidget {
//   final Function() onClick;
//   final Color? bgColor;
//   final Color? textColor;

//   const PrimaryButton({
//     required this.onClick,
//     this.bgColor,
//     this.textColor,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => productProvider.setSelectedTag(idx),
//       style: ElevatedButton.styleFrom(
//         backgroundColor:
//             tag.isSelected ? MyColors.primary : MyColors.lightPurple,
//       ),
//       child: Text(
//         tag.tag,
//         style: TextStyle(
//           color: tag.isSelected ? MyColors.white : MyColors.secondary,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }
// }
