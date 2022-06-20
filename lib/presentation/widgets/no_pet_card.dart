import 'package:core/core.dart';
import 'package:core/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPetCard extends StatelessWidget {
  const NoPetCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text("You haven't added a pet yet",
            style: kTextTheme.bodyText2?.copyWith(fontSize: 14)),
        const SizedBox(
          height: 19,
        ),
        GradientButton(
          height: 52,
          width: 200,
          onTap: () {
            Navigator.pushNamed(context, ADD_PET_ROUTE_NAME);
          },
          text: 'Add Pet',
          isClicked: false,
        ),
      ],
    );
  }
}
