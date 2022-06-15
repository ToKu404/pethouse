import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardMedicalHistory extends StatelessWidget {
  final String? petName;
  const CardMedicalHistory({Key? key, required this.petName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kPrimaryColor,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 52,
        child: ListTile(
          leading: const Icon(
            Icons.history,
            color: kWhite,
          ),
          title: Text(
            'Medical History',
            style: kTextTheme.headline6,
          ),
          trailing: const Icon(
            Icons.navigate_next,
            color: kWhite,
          ),
          onTap: () => {
            showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return const Text('Tst');
                })
          },
        ),
      ),
    );
  }
}
