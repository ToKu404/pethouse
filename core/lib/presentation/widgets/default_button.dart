import 'package:flutter/material.dart';

import '../../utils/constants.dart';

class GradientButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback? onTap;
  final String text;
  final bool isClicked;

  const GradientButton(
      {super.key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.isClicked,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: isClicked ? Colors.blueGrey : kPrimaryColor,
        borderRadius: kBorderRadius,
      ),
      child: MaterialButton(
        onPressed: onTap,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
        child: Text(text,
            style: kTextTheme.subtitle1?.copyWith(color: kWhite)),
      ),
    );
  }
}
