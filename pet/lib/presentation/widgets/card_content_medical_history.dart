
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pet/domain/entities/medical_entity.dart';

class CardContentMedical extends StatelessWidget {
  final MedicalEntity medicalEntity;
  CardContentMedical({Key? key, required this.medicalEntity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTimeNow = medicalEntity.timeNow.toDate();
    DateTime dateTimeExpired = medicalEntity.expiredDate.toDate();

    return Container(
      margin: const EdgeInsets.only(
          left: kPadding, right: kPadding, bottom: kPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Color(0xFFFFF6E9),
        border: Border.all(
          color: Color(0xFF784E2F),
          width: 1.0,
        ),
      ),
      height: 80.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only( left: 10,
                        top: 12,
                      ),
                      child: Icon(Icons.location_on, size: 7,),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                        ),
                        child: Text(
                          medicalEntity.location,
                          style: GoogleFonts.poppins(
                            color: kDarkBrown,
                            fontSize: 7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 10,
                        top: 10,
                      ),
                      child: Text(
                          'Posted On '
                              + DateFormat.yMMMMEEEEd().add_jm().format(dateTimeNow),
                        style: GoogleFonts.poppins(
                          color: Color(0xFFA59387),
                          fontSize: 5,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Text(
                    medicalEntity.activity,
                    style: GoogleFonts.poppins(
                      color: kDarkBrown,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(
                    medicalEntity.description,
                    style: GoogleFonts.poppins(
                      color: kPrimaryColor,
                      fontSize: 6,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      'Expired on '
                      +DateFormat.yMMMMEEEEd().add_jm().format(dateTimeExpired),
                      style: GoogleFonts.poppins(
                        color: Color(0xFFA59387),
                        fontSize: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
