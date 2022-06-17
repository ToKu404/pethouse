import 'package:core/core.dart';
import 'package:flutter/material.dart';

class CardAboutContent extends StatelessWidget {
  final String subjek;
  final String contentSubjek;
  CardAboutContent({required this.subjek, required this.contentSubjek});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
      ),
      height: 60,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(subjek,
                style: kTextTheme.bodyText1
                    ?.copyWith(fontWeight: FontWeight.bold, color: kDarkBrown)),
          ),
          SizedBox(
            height: 5,
          ),
          Expanded(child: Text(contentSubjek, style: kTextTheme.bodyText2?.copyWith(color: kWhite,fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }
}
