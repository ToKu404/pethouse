// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class BorderIconButton extends StatelessWidget {
//   final double height;
//   final double width;
//   final VoidCallback onTap;
//   final String text;
//   final String iconPath;

//   const BorderIconButton(
//       {super.key,
//       required this.height,
//       required this.width,
//       required this.onTap,
//       required this.text,
//       required this.iconPath});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//             side: const BorderSide(width: 1, color: Colors.grey)),
//         primary: Colors.white,
//         elevation: 0,
//       ),
//       child: Container(
//           height: height,
//           width: width,
//           alignment: Alignment.center,
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SvgPicture.asset(iconPath),
//               const SizedBox(
//                 width: 8,
//               ),
//               Text(
//                 text,
//                 style: const TextStyle(color: Color(0xFF4B2710)),
//               ),
//             ],
//           )),
//     );
//   }
// }
