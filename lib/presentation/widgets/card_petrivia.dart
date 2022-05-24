import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pethouse/utils/styles.dart';

class CardPetrivia extends StatelessWidget {
  const CardPetrivia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          left: kPadding, right: kPadding, bottom: kPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: kWhite,
        border: Border.all(
          color: kDarkBrown,
          width: 1.0,
        ),
      ),
      height: 84.0,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: const Radius.circular(10),
            ),
            child: Image.network(
              'https://asset.kompas.com/crops/19eDcoHMwAlkdNYIS0XG77gRP3Q=/0x36:666x480/750x500/data/photo/2021/05/09/60980b3de5305.jpg',
              width: 94,
              fit: BoxFit.cover,
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
                          left: 10,
                          top: 10,
                          right: 10,
                        ),
                        child: Text(
                          "Kucing Tawuran Rebutan Whiskas",
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            color: kDarkBrown,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
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
                        "Tue, 17 May 2022",
                        style: GoogleFonts.poppins(
                          color: kPrimaryColor,
                          fontSize: 9,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 2,
                    ),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Justo, tristique turpis mauris.",
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 9,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
