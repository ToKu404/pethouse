import 'package:flutter/material.dart';
import 'package:pethouse/utils/styles.dart';

class CardPeriodicSummary extends StatelessWidget {
  const CardPeriodicSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhite,
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 52,
        child: ListTile(
          leading: Icon(Icons.shower,color: kOrange,),
          title: Text('Shower',style: TextStyle(color: kOrange)),
          subtitle: Text('Last Activity : 20 Agustus 2022',style: TextStyle(color: kDarkBrown),),

        ),
      ),
    );
  }
}
