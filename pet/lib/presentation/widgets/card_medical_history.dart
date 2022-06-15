import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/presentation/widgets/card_content_medical_history.dart';
import 'package:schedule/presentation/blocs/get_pet_medical_bloc/get_pet_medical_bloc.dart';

class CardMedicalHistory extends StatefulWidget {
  final String petId;
  const CardMedicalHistory({Key? key, required this.petId}) : super(key: key);

  @override
  State<CardMedicalHistory> createState() => _CardMedicalHistoryState();
}

class _CardMedicalHistoryState extends State<CardMedicalHistory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<GetPetMedicalBloc>(context)
        .add(FetchListPetMedical(petId: widget.petId));
  }

  @override
  Widget build(BuildContext context) {
    void _showModalSheet() {
      showModalBottomSheet(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10))),
          context: context,
          builder: (builder) {
            return Container(
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  color: Color(0xFFFDF7F9),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 40,
                    width: double.infinity,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 80 - 20,
                          child: Center(
                            child: Text(
                              'Medical Activity',
                              style: kTextTheme.subtitle1,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: const SizedBox(
                            width: 40,
                            height: 40,
                            child: Icon(Icons.close),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: SingleChildScrollView(child:
                        BlocBuilder<GetPetMedicalBloc, GetPetMedicalState>(
                            builder: ((context, state) {
                      if (state is GetPetMedicalLoading) {
                        return const CircularProgressIndicator();
                      } else if (state is GetPetMedicalSucces) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: state.listPetMedical
                                .map(
                                    (e) => CardContentMedical(medicalEntity: e))
                                .toList(),
                          ),
                        );
                      } else {
                        return const Text('Error');
                      }
                    }))),
                  ),
                ],
              ),
            );
          });
    }

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kWhite,
        boxShadow: [
          BoxShadow(
              blurRadius: 13, color: const Color(0xFF000000).withOpacity(.07)),
          BoxShadow(
              blurRadius: 5, color: const Color(0xFF000000).withOpacity(.05))
        ],
      ),
      height: 52,
      child: ListTile(
        leading: const Icon(
          Icons.history,
          color: kDarkBrown,
        ),
        title: Text(
          'Medical History',
          style: kTextTheme.subtitle1?.copyWith(color: kDarkBrown),
        ),
        trailing: const Icon(
          Icons.navigate_next,
          color: kDarkBrown,
        ),
        onTap: _showModalSheet,
      ),
    );
  }
}
