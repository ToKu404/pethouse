import 'package:flutter/material.dart';

import '../../core.dart';

class AppBarBackButton extends StatelessWidget {
  const AppBarBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: Container(
          decoration: const BoxDecoration(shape: BoxShape.circle, color: kGrey),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            size: 18,
            color: kWhite,
          ),
        ),
      ),
    );
  }
}
