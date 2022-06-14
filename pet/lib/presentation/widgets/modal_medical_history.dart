import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';
import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:pet/presentation/bloc/get_pet_medical/get_pet_medical_bloc.dart';
import 'package:pet/presentation/widgets/card_content_medical_history.dart';

class BottomNavMedicalHistory extends StatefulWidget {
  final String? petName;
  const BottomNavMedicalHistory({Key? key,required this.petName}) : super(key: key);

  @override
  State<BottomNavMedicalHistory> createState() =>
      _BottomNavMedicalHistoryState();
}

class _BottomNavMedicalHistoryState extends State<BottomNavMedicalHistory> {
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<GetPetMedicalBloc>(context).add(GetListPetMedical(listPetMedical: listPetMedical));
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<GetPetMedicalBloc, GetPetMedicalState>(
    //   builder: (context, state) {
    //     if (state is GetPetMedicalLoading) {
    //       return const Center(
    //         child: CircularProgressIndicator(),
    //       );
    //     } else if (state is GetPetMedicalError) {
    //       return Center(
    //         child: Text(state.message),
    //       );
    //     } else if (state is GetPetMedicalSucces) {
    //       return _buildMedicalData(
    //         state.listPetMedical,
    //       );
    //     } else {
    //       return const Center();
    //     }
    //   },
    // );
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: 90,
                ),
                Text(
                  widget.petName!,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFAE531E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  icon: CircleAvatar(
                      backgroundColor: kGreyTransparant.withOpacity(0.1),
                      child: const Icon(Icons.close,color: const Color(0xFFAE531E),)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            // listMedical.isEmpty
            //     ? Center(
            //   child: Text('Empty Data'),
            // )
            //     : Expanded(
            //   child: ListView.builder(
            //       itemCount: listMedical.length,
            //       itemBuilder: (context, index) {
            //         return CardContentMedical(
            //           medicalEntity: listMedical[index],
            //         );
            //       }),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalData(List<GetPetMedicalEntity> listMedical) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: 90,
                ),
                Text(
                  'Ikhsan’s Medical History',
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFAE531E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  icon: CircleAvatar(
                    backgroundColor: kGreyTransparant.withOpacity(0.1),
                      child: const Icon(Icons.close,color: const Color(0xFFAE531E),)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            listMedical.isEmpty
                ? Center(
                    child: Text('Empty Data'),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: listMedical.length,
                        itemBuilder: (context, index) {
                          return CardContentMedical(
                            medicalEntity: listMedical[index],
                          );
                        }),
                  )
          ],
        ),
      ),
    );
  }
}
