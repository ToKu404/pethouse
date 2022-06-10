import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widgets/gredient_button.dart';

class HomeScheduleNoPetPage extends StatelessWidget {
  const HomeScheduleNoPetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/vectors/add_pet.svg',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 19,
          ),
          Text(
            "You haven't added a pet yet",
            style: GoogleFonts.poppins(
              color: kDarkBrown,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: 19,
          ),
          GradientButton(
              height: 52,
              width: 200,
              onTap: () {
                Navigator.pop(context);
              },
              text: 'Add Pet'),
        ],
      )),
    );
  }
}
