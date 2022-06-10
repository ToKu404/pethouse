import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:core/core.dart';

class btnBack_decoration extends StatelessWidget {
  const btnBack_decoration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: kGrey),
          child: Icon(
            FontAwesomeIcons.arrowLeft,
            size: 18,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
