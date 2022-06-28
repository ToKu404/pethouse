import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerLoadingView extends StatelessWidget {
  final double borderRadius;
  const ShimmerLoadingView({Key? key, this.borderRadius = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: Colors.black12,
        highlightColor: Colors.white10,
        child: Container(
            decoration: const BoxDecoration(color: Colors.amberAccent)),
      ),
    );
  }
}
