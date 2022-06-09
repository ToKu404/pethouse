import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CardAdopt extends StatelessWidget {
  const CardAdopt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 135,
        margin: const EdgeInsets.symmetric(
          vertical: 40,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [kSecondaryColor, kPrimaryColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: kBorderRadius,
          border: Border.all(
            color: kDarkBrown,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
             Padding(
               padding: const EdgeInsets.only(
                 left: 10, top: 10, right: 10, bottom: 10,
               ),
               child: SvgPicture.asset(
                  'assets/vectors/card_adopt.svg',
                  width: 90,
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10, top: 25, right: 10,
                          ),
                          child: Text(
                            "Lets Make",
                            style: GoogleFonts.poppins(
                              color: kWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "New Friend!",
                        style: GoogleFonts.poppins(
                          color: kDarkBrown,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: SizedBox(
                       width: 100,
                       height: 30,
                       child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30),
                            ),
                            primary: Colors.white,
                            onPrimary: Colors.grey,
                          ),
                          onPressed: () {},
                          child: Text('Adopt Now',
                            style: GoogleFonts.poppins(
                              color: kDarkBrown,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
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
    );
  }
}
