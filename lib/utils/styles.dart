import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFFFF8500);
const Color kSecondaryColor = Color(0xFFECA540);
const Color kDarkBrown = Color(0xFF4B2710);
const Color kWhite = Colors.white;
const Color kGrey = Color(0xFFD4D4D4);

BorderRadius kBorderRadius = BorderRadius.circular(10);

const double kMargin = 20.0;
const double kPadding = 10.0;

final TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(fontSize: 41, fontWeight: FontWeight.w700),
  headline2: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
  headline3: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
  headline4: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline5: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline6: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
  subtitle1: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),
  subtitle2: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w500, color: kDarkBrown),
  bodyText1: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400),
  bodyText2: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w300),
  button: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
  caption: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400),
  overline: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w400),
);

const kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryContainer: kPrimaryColor,
  secondary: kSecondaryColor,
  secondaryContainer: kSecondaryColor,
  surface: kDarkBrown,
  background: kWhite,
  error: Colors.red,
  onPrimary: kPrimaryColor,
  onSecondary: kDarkBrown,
  onSurface: kDarkBrown,
  onBackground: kWhite,
  onError: kWhite,
  brightness: Brightness.light,
);
