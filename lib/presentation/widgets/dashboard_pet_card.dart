import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/utils/styles.dart';

class DashboardPetCard extends StatelessWidget {
  const DashboardPetCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10, right: 10),
          width: 100,
          height: 85,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: kDarkBrown, width: 1),
              color: Colors.white),
        ),
        SizedBox(
          height: 90,
          width: 105,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.only(top: 4, left: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.female,
                            color: kPrimaryColor,
                            size: 20,
                          ),
                          Text(
                            "Adi",
                            style: GoogleFonts.poppins(
                                color: kDarkBrown,
                                fontSize: 12,
                                height: 1.2,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/vectors/dog.svg',
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Text(
                  "2 years 1 month",
                  style: GoogleFonts.poppins(
                      color: kPrimaryColor, fontSize: 8, height: 1),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
