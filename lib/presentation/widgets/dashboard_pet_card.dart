import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/presentation/pages/mypet/pet_description_page.dart';
import 'package:core/core.dart';

class DashboardPetCard extends StatelessWidget {
  final String name;
  final String type;
  final String age;

  const DashboardPetCard(
      {super.key, required this.name, required this.type, required this.age});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, PetDescriptionPage.ROUTE_NAME),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5, right: 10),
            width: 120,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: kDarkBrown, width: 1),
                color: Colors.white),
          ),
          SizedBox(
            height: 105,
            width: 125,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.only(
                          top: 8,
                          left: 6,
                        ),
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
                              name,
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
                        type,
                        width: 65,
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    age,
                    style: GoogleFonts.poppins(color: kGrey, fontSize: 9),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
