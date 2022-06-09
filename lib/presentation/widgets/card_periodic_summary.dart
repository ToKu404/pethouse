import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';

class CardPeriodicSummary extends StatelessWidget {
  final Iconify iconfy;
  final String titlePeriodic;
  final String typePeriodic;
  final String datePeriodic;

  CardPeriodicSummary(
      {required this.iconfy,
      required this.titlePeriodic,
      required this.typePeriodic,
      required this.datePeriodic});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhite,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 62,
        child: ListTile(
          leading: iconfy,
          title: Text(titlePeriodic, style: TextStyle(color: kOrange)),
          subtitle: Text(
            'Last ' + typePeriodic + ' : ' + datePeriodic,
            style: TextStyle(color: kDarkBrown),
          ),
        ),
      ),
    );
  }
}

class CardPeriodicWeight extends StatelessWidget {
  final Iconify iconfy;
  final String titlePeriodic;
  final String typePeriodic;
  final String datePeriodic;
  final double? weightValue;
  CardPeriodicWeight(
      {required this.iconfy,
      required this.titlePeriodic,
      required this.typePeriodic,
      required this.datePeriodic,
      this.weightValue});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhite,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 62,
        child: ListTile(
          leading: iconfy,
          title: Text(titlePeriodic, style: TextStyle(color: kOrange)),
          subtitle: Row(
            children: [
              Expanded(
                child: Text(
                  'Last ' +
                      typePeriodic +
                      ' : ' +
                      weightValue.toString() +
                      '\t' +
                      'Kg On '+
                      
                      datePeriodic,
                  style: TextStyle(color: kDarkBrown),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
