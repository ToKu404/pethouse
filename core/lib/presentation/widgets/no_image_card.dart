import 'package:core/core.dart';
import 'package:flutter/material.dart';

class NoImageCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;
  const NoImageCard({Key? key, this.width, this.height, this.borderRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 0), color: kGrey),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image,
              color: kGreyTransparant,
            ),
            Text(
              'No Image',
              style: kTextTheme.caption?.copyWith(color: kGreyTransparant),
            )
          ],
        ),
      ),
    );
  }
}
