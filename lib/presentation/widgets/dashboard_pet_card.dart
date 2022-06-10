import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/pages/pet_description_page.dart';

class DashboardPetCard extends StatelessWidget {
  final PetEntity pet;

  const DashboardPetCard({super.key, required this.pet});

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
                            pet.gender != null && pet.gender != ''
                                ? Icon(
                                    pet.gender == 'Male'
                                        ? Icons.male
                                        : Icons.female,
                                    color: kPrimaryColor,
                                    size: 20,
                                  )
                                : Container(
                                    width: 20,
                                    height: 20,
                                  ),
                          ],
                        ),
                      ),
                      kPetTypeVector.containsKey(pet.petType!.toLowerCase())
                          ? SvgPicture.asset(
                              kPetTypeVector[pet.petType!.toLowerCase()] ?? '',
                              width: 65,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 20,
                            ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  height: 25,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      pet.petName ?? '',
                      style: GoogleFonts.poppins(
                          color: kDarkBrown,
                          fontSize: 12,
                          height: 1.2,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    getAge(),
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

  String getAge() {
    DateTime? born = pet.dateOfBirth?.toDate();
    DateTime today = DateTime.now();
    int yearDiff = today.year - (born?.year ?? 0);
    int monthDiff = today.month - (born?.month ?? 0);
    int dayDiff = today.day - (born?.day ?? 0);

    String age = '';
    if (yearDiff > 0) {
      age += yearDiff.toString();
      int percentMonth = (monthDiff / 12).round();
      age += percentMonth > 0 ? '.$percentMonth' : '';
      age += ' Year';
    } else if (monthDiff > 0) {
      age += '$monthDiff Month';
    } else {
      age += '$dayDiff Day';
    }
    return age;
  }
}
