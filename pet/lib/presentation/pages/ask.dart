
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:core/core.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Pethouse',
//       theme: ThemeData(colorScheme: kColorScheme),
//       home: const AskPet(),
//     );
//   }
// }

// class AskPet extends StatefulWidget {
//   const AskPet({Key? key}) : super(key: key);

//   @override
//   State<AskPet> createState() => _AskPetState();
// }

// class _AskPetState extends State<AskPet> {
//   int _selectedPet = 0;

//   @override
//   Widget CustomPet(int Index, String name, String icon_selected,
//       String icon_reg, bool isSelected) {
//     return InkWell(
//       child: Container(
//         height: 90,
//         width: 75,
//         decoration: BoxDecoration(
//           color: (_selectedPet == Index) ? kPrimaryColor : const Color(0XFFF6F6F6),
//           borderRadius: kBorderRadius,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: SvgPicture.asset(
//                 (_selectedPet == Index) ? icon_selected : icon_reg,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Text(
//                 name,
//                 style: TextStyle(
//                   color:
//                       (_selectedPet == Index) ? kDarkBrown : const Color(0xFF969696),
//                   fontWeight: (_selectedPet == Index)
//                       ? FontWeight.bold
//                       : FontWeight.normal,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           _selectedPet = Index;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: double.infinity,
//         width: double.infinity,
//         child: Column(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 240),
//                     child: Text(
//                       'What pet do you have?',
//                       style: GoogleFonts.poppins(
//                         color: kDarkBrown,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomPet(
//                             1,
//                             'Cat',
//                             'assets/icons/selected_cat_icon_outline.svg',
//                             'assets/icons/cat_icon_outline.svg',
//                             false),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         CustomPet(
//                             2,
//                             'Dog',
//                             'assets/icons/selected_dog_icon_outline.svg',
//                             'assets/icons/dog_icon_outline.svg',
//                             false),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         CustomPet(
//                             3,
//                             'Bird',
//                             'assets/icons/selected_bird_icon_outline.svg',
//                             'assets/icons/bird_icon_outline.svg',
//                             false),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 10),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         CustomPet(
//                             4,
//                             'Hamster',
//                             'assets/icons/selected_hamster_icon_outline.svg',
//                             'assets/icons/hamster_icon_outline.svg',
//                             false),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         CustomPet(
//                             5,
//                             'Fish',
//                             'assets/icons/selected_fish_icon_outline.svg',
//                             'assets/icons/fish_icon_outline.svg',
//                             false),
//                       ],
//                     ),
//                   ),
//                   // SizedBox(
//                   //   height: 150,
//                   // ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 46,
//                     width: 46,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                           colors: [kSecondaryColor, kPrimaryColor],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter),
//                       borderRadius: BorderRadius.circular(500),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AskGender()),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 InkWell(
//                   child: Text(
//                     'Skip for Now',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: const Color(0XFF969696),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const AskGender()),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class AskGender extends StatefulWidget {
//   const AskGender({Key? key}) : super(key: key);

//   @override
//   State<AskGender> createState() => _AskGenderState();
// }

// class _AskGenderState extends State<AskGender> {
//   int _selectedPetGender = 0;

//   @override
//   Widget CustomPetGender(
//       int Index, String name, IconData icon, Color color, bool isSelected) {
//     return InkWell(
//       child: Container(
//         height: 50,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: (_selectedPetGender == Index) ? kPrimaryColor : Colors.grey,
//             width: 1.0,
//           ),
//           borderRadius: kBorderRadius,
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(
//               width: 20,
//             ),
//             Icon(
//               icon,
//               color: (_selectedPetGender == Index) ? color : Colors.grey,
//             ),
//             const SizedBox(
//               width: 20,
//             ),
//             Text(
//               name,
//               style: TextStyle(
//                 color: (_selectedPetGender == Index) ? color : Colors.grey,
//                 fontWeight: (_selectedPetGender == Index)
//                     ? FontWeight.bold
//                     : FontWeight.normal,
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           _selectedPetGender = Index;
//         });
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 32,
//                     width: 32,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(500),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 240),
//                     child: Text(
//                       'What pet do you have?',
//                       style: GoogleFonts.poppins(
//                         color: kDarkBrown,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 30,
//                   ),
//                   CustomPetGender(
//                     1,
//                     'Female',
//                     Icons.female,
//                     Colors.red,
//                     false,
//                   ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   CustomPetGender(
//                     2,
//                     'Male',
//                     Icons.male,
//                     Colors.blue,
//                     false,
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 46,
//                     width: 46,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                           colors: [kSecondaryColor, kPrimaryColor],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter),
//                       borderRadius: BorderRadius.circular(500),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const PetName(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 InkWell(
//                   child: Text(
//                     'Skip for Now',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: const Color(0XFF969696),
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const PetName(),
//                       ),
//                     );
//                   },
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PetName extends StatelessWidget {
//   const PetName({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         width: double.infinity,
//         height: double.infinity,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(
//               height: 50,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 32,
//                     width: 32,
//                     decoration: BoxDecoration(
//                       color: Colors.grey,
//                       borderRadius: BorderRadius.circular(500),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                     ),
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Your pet\'s name?',
//                     style: GoogleFonts.poppins(
//                       color: kDarkBrown,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(30),
//                     child: TextFormField(
//                       autofocus: true,
//                       decoration: InputDecoration(
//                         fillColor: const Color(0xFF929292),
//                         hintText: 'Pet Name',
//                         border: OutlineInputBorder(borderRadius: kBorderRadius),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Column(
//               children: [
//                 InkWell(
//                   child: Container(
//                     height: 46,
//                     width: 46,
//                     decoration: BoxDecoration(
//                       gradient: const LinearGradient(
//                           colors: [kSecondaryColor, kPrimaryColor],
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter),
//                       borderRadius: BorderRadius.circular(500),
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward_ios_rounded,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 40,
//                 ),
//                 InkWell(
//                   child: Text(
//                     'Skip for Now',
//                     style: GoogleFonts.poppins(
//                       fontSize: 12,
//                       color: const Color(0XFF969696),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 50,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
