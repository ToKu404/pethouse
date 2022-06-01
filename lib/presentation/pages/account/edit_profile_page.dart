// import 'package:flutter/material.dart';
// import 'package:pethouse/presentation/widgets/btnback_decoration.dart';
// import 'package:pethouse/presentation/widgets/gredient_button.dart';
// import 'package:core/core.dart';

// class EditProfilePage extends StatelessWidget {
//   static const ROUTE_NAME = 'edit_profile';

//   const EditProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//       appBar: AppBar(
//         title: Text('Edit Profile',style: TextStyle(color: Colors.black)),
//         leading: btnBack_decoration(),
//         centerTitle: true,
//         elevation: 5,
//         backgroundColor: kWhite,

//       ),
//       body: SafeArea(
//         child: Container(
//           margin: const EdgeInsets.all(kMargin),
//           child: Center(
//             child: Column(
//               children: [
//                 //USERNAME
//                 TextFormField(
//                   decoration: InputDecoration(
//                       fillColor: const Color(0xFF929292),
//                       labelText: 'Username',
//                       border: OutlineInputBorder(borderRadius: kBorderRadius)),
//                 ),
//                 const SizedBox(
//                   height: 19,
//                 ),
//                 //  EMAIL ADDRESS
//                 TextFormField(
//                   decoration: InputDecoration(
//                       fillColor: const Color(0xFF929292),
//                       labelText: 'Email Address',
//                       border: OutlineInputBorder(borderRadius: kBorderRadius)),
//                 ),
//                 SizedBox(
//                   height: 19,
//                 ),
//                 GradientButton(
//                     height: 60, width: 360,
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     text: 'Confirm'),
//               ],
//             ),
//           ),
//         ),
//       ),

//     );
//   }
// }
