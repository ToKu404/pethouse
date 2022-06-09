import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'gredient_button.dart';
import 'package:core/core.dart';

class AdoptionSuccess extends StatelessWidget {
  const AdoptionSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 309,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Color(0XFFFFE5CE), kWhite],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 14,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kWhite,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                'assets/vectors/success_cat.svg',
                height: 67,
                width: 56.83,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Thank You',
            style: GoogleFonts.poppins(
              color: Color(0XFFAE531E),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            'Adoption activities while being processed',
            style: GoogleFonts.poppins(
              color: kDarkBrown,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '23 Februari 2022 14:26',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          GradientButton(
            height: 39,
            width: 159,
            onTap: () {},
            text: 'View Order Status',
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 39,
            width: 159,
            decoration: BoxDecoration(
              color: kWhite,
              borderRadius: kBorderRadius,
              border: Border.all(
                color: kDarkBrown,
                width: 1.0,
              ),
            ),
            child: MaterialButton(
              onPressed: () {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              shape: RoundedRectangleBorder(
                borderRadius: kBorderRadius,
              ),
              child: Text(
                'Back to Home',
                style: const TextStyle(color: kDarkBrown),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
