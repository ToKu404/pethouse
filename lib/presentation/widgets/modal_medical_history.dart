import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/utils/styles.dart';

class BottomNavMedicalHistory extends StatelessWidget {
  const BottomNavMedicalHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
           height: 500,
            color: kWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                        ),
                        Text('Ikhsan’s Medical History',
                          style: GoogleFonts.poppins(
                            color: Color(0xFFAE531E),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          icon: SvgPicture.asset('assets/close.svg'),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                    Divider(color: Colors.grey,),
                    Container(
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
                                          "Park East Animal Hospital",
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
                                        "Posted on 17 May 2022 at 09.28",
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
                                    "Vaccinated",
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
                                    " For Bordatella ",
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
                                      "Expires on 17 May 2023",
                                      style: GoogleFonts.poppins(
                                        color: Color(0xFF982E20),
                                        fontSize: 5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
  }
}
