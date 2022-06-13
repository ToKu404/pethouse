
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/constants.dart';

class LoadingScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SpinKitCircle(
      size: 120,
      duration: Duration(seconds: 1),
      itemBuilder: (context, index){
        final colors = [kPrimaryColor,kSecondaryColor,kWhite];
        final color = colors[index%colors.length];
        return DecoratedBox(
            decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle
            )
        );
      },
    );
  }
}
