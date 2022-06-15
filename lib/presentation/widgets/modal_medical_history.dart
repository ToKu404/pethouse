import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:core/core.dart';

class BottomNavMedicalHistory extends StatefulWidget {
  final String? petName;
  const BottomNavMedicalHistory({Key? key, required this.petName}) : super(key: key);

  @override
  State<BottomNavMedicalHistory> createState() => _BottomNavMedicalHistoryState();
}

class _BottomNavMedicalHistoryState extends State<BottomNavMedicalHistory> {
  @override
  Widget build(BuildContext context) {
   return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: 90,
                ),
                Text(
                  widget.petName!,
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFAE531E),
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
                IconButton(
                  icon: CircleAvatar(
                      backgroundColor: kGreyTransparant.withOpacity(0.1),
                      child: const Icon(Icons.close,color: Color(0xFFAE531E),)),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
  
}


