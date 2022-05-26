import 'package:flutter/material.dart';
import 'package:pethouse/utils/styles.dart';

class CardMedicalHistory extends StatelessWidget {
  const CardMedicalHistory({Key? key}) : super(key: key);

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
          onTap: () => {},
        ),
      ),
    );
  }
}
