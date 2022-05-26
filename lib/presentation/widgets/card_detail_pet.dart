import 'package:flutter/material.dart';
import 'package:pethouse/utils/styles.dart';

class CardDetailPet extends StatelessWidget {
  final String type;

  CardDetailPet({required this.type, required this.content});

  final String content;


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
        color: kOrange,
        child: Container(
          padding: EdgeInsets.all(kPadding),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: [kSecondaryColor, kPrimaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            borderRadius: kBorderRadius,
          ),
          width: 120,
          height: 68,
          child: Column(
            children: [
              Text(
                type,
                style: kTextTheme.bodyText2,
              ),
              Text(content, style: kTextTheme.headline6)
            ],
          ),
        ),
      ),
    );
  }
}
