// import 'package:core/core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class ServicePage extends StatefulWidget {
//   const ServicePage({Key? key}) : super(key: key);

//   @override
//   State<ServicePage> createState() => _ServicePageState();
// }

// class _ServicePageState extends State<ServicePage> {
//   final List<String> _tabTitle = ['Adopt', 'Market'];
//   final List<Widget> _bodyPage = [
//     const AdoptSection(),
//     const MarketSection(),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: _bodyPage.length,
//         child: SafeArea(
//             child: Column(
//           children: [
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: kPadding),
//               width: double.infinity,
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide: BorderSide.none),
//                     filled: true,
//                     prefixIcon: Icon(
//                       Icons.search_sharp,
//                       color: Colors.grey[400],
//                     ),
//                     hintStyle: TextStyle(
//                       color: Colors.grey[400],
//                     ),
//                     hintText: "Search for breed, race, or gender",
//                     fillColor: const Color(0xFFF6F6F6)),
//               ),
//             ),
//             TabBar(
//               indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8), // Creates border
//                   color: kOrange),
//               tabs: [
//                 Tab(
//                   child: Text(_tabTitle[0]),
//                 ),
//                 Tab(
//                   child: Text(_tabTitle[1]),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 8,
//             ),
//             Expanded(child: TabBarView(children: _bodyPage))
//           ],
//         )));
//   }
// }
