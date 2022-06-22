import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        size: 120,
        duration: const Duration(seconds: 1),
        itemBuilder: (context, index) {
          final colors = [kPrimaryColor, kSecondaryColor, kWhite];
          final color = colors[index % colors.length];
          return DecoratedBox(
              decoration: BoxDecoration(color: color, shape: BoxShape.circle));
        },
      ),
    );
  }
}
