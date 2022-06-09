import 'package:core/core.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  final double height;
  final double width;
  final VoidCallback onTap;
  final String text;

  const GradientButton(
      {super.key,
      required this.height,
      required this.width,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [kSecondaryColor, kPrimaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        borderRadius: kBorderRadius,
      ),
      child: MaterialButton(
        onPressed: onTap,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
        child: Text('${text}',
            style: kTextTheme.subtitle1?.copyWith(color: kWhite)),
      ),
    );
  }
}
