import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/domain/entities/medical_entity.dart';
// import 'package:pet/domain/entities/medical_entity.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:pet/presentation/widgets/modal_medical_history.dart';
class CardMedicalHistory extends StatelessWidget {
  final String? petName;
  const CardMedicalHistory({Key? key,required this.petName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kOrange,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 52,
        child: ListTile(
          leading: Icon(Icons.history,color: kWhite,),
          title: Text('Medical History',style: kTextTheme.headline6,),
          trailing: Icon(Icons.navigate_next,color: kWhite,),
          onTap: () => {showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return BottomNavMedicalHistory(petName: petName,);
              }
          )
          },
        ),
      ),
    );
  }
}