import 'package:core/core.dart';
import 'package:core/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemovePetConfirmation extends StatelessWidget {
  const RemovePetConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 275,
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: const LinearGradient(
          colors: [Color(0XFFFFE6CF), Color(0XFFFFFEFD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 14,
            offset: const Offset(2, 4),
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
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.warning_amber_rounded,
              color: Color(0XFFCF9D7A),
              size: 60,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Are You Sure?',
            style: GoogleFonts.poppins(
              color: const Color(0XFFAE531E),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Delete Pet From Database',
            style: GoogleFonts.poppins(
              color: kDarkBrown,
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 29,
                width: 65,
                decoration: BoxDecoration(
                  color: const Color(0XFFFED0AC),
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
                  child: const Text(
                    'No',
                    style: TextStyle(color: kDarkBrown),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GradientButton(
                height: 29,
                width: 65,
                onTap: () {},
                text: 'Yes', isClicked: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
