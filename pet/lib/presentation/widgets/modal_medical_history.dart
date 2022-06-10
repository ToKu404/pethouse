// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:core/core.dart';
// import 'package:pet/domain/entities/medical_entity.dart';
// import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
// import 'package:pet/presentation/bloc/get_medical/get_medical_bloc.dart';
// import 'package:pet/presentation/widgets/card_content_medical_history.dart';

// class BottomNavMedicalHistory extends StatefulWidget {
//   const BottomNavMedicalHistory({Key? key}) : super(key: key);

//   @override
//   State<BottomNavMedicalHistory> createState() =>
//       _BottomNavMedicalHistoryState();
// }

// class _BottomNavMedicalHistoryState extends State<BottomNavMedicalHistory> {
//   @override
//   void initState() {
//     super.initState();
//     BlocProvider.of<GetMedicalBloc>(context).add(GetListMedical());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetMedicalBloc, GetMedicalState>(
//       builder: (context, state) {
//         if (state is GetMedicalLoading) {
//           return const Center(
//             child: CircularProgressIndicator(),
//           );
//         } else if (state is GetMedicalError) {
//           return Center(
//             child: Text(state.message),
//           );
//         } else if (state is ListMedicalLoaded) {
//           return _buildMedicalData(
//             state.listmedicalEntity,
//           );
//         } else {
//           return const Center();
//         }
//       },
//     );
//   }

//   Widget _buildMedicalData(List<MedicalEntity> listMedical) {
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//             color: kWhite,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(10), topRight: Radius.circular(10))),
//         height: 500,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Row(
//               children: [
//                 const SizedBox(
//                   width: 90,
//                 ),
//                 Text(
//                   'Ikhsan’s Medical History',
//                   style: GoogleFonts.poppins(
//                     color: const Color(0xFFAE531E),
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 50,
//                 ),
//                 IconButton(
//                   icon: CircleAvatar(
//                     backgroundColor: kGreyTransparant.withOpacity(0.1),
//                       child: const Icon(Icons.close,color: const Color(0xFFAE531E),)),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//             const Divider(
//               color: Colors.grey,
//             ),
//             listMedical.isEmpty
//                 ? Center(
//                     child: Text('Empty Data'),
//                   )
//                 : Expanded(
//                     child: ListView.builder(
//                         itemCount: listMedical.length,
//                         itemBuilder: (context, index) {
//                           return CardContentMedical(
//                             medicalEntity: listMedical[index],
//                           );
//                         }),
//                   )
//           ],
//         ),
//       ),
//     );
//   }
// }
