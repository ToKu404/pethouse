import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';

class FeatureUnavailable extends StatelessWidget {
  const FeatureUnavailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Color(0XFFFFFEFD), Color(0XFFFFE6CF)],
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
          Icon(
            Icons.warning_amber_rounded,
            color: Color(0XFFCF9D7A),
            size: 60,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Feature Not Yet Available',
            style: GoogleFonts.poppins(
              color: kDarkBrown,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
