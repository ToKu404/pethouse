import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFFFF8500);
const Color kSecondaryColor = Color(0xFFECA540);
const Color kDarkBrown = Color(0xFF4B2710);
const Color kWhite = Colors.white;
const Color kGrey = Color(0xFFD4D4D4);
const Color kGreyTransparant = Color(0xFF878787);
const Color kOrange = Color(0xFFEF9F21);

BorderRadius kBorderRadius = BorderRadius.circular(10);

const double kMargin = 20.0;
const double kPadding = 10.0;

final TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(fontSize: 41, fontWeight: FontWeight.w700),
  headline2: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
  headline3: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w600, color: kSecondaryColor),
  headline4: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline5: GoogleFonts.poppins(
      fontSize: 18, fontWeight: FontWeight.w700, color: kDarkBrown),
  headline6: GoogleFonts.poppins(
      fontSize: 16, fontWeight: FontWeight.w700, color: kWhite),
  subtitle1: GoogleFonts.poppins(
      fontSize: 14, fontWeight: FontWeight.w600, color: kDarkBrown),
  subtitle2: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w500, color: kDarkBrown),
  bodyText1: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: kGreyTransparant),
  bodyText2: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w300, color: kDarkBrown),
  button: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w700),
  caption: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, color: kDarkBrown),
  overline: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, color: kOrange),
);

final kTimePickerTheme = TimePickerThemeData(
  backgroundColor: kWhite,
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  dayPeriodColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kSecondaryColor : kWhite),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  dayPeriodTextColor: kDarkBrown,
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: kPrimaryColor, width: 1),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kSecondaryColor : kWhite),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kWhite : kSecondaryColor),
  dialHandColor: kDarkBrown,
  dialBackgroundColor: kSecondaryColor,
  hourMinuteTextStyle:
      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
  helpTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: kDarkBrown),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? kWhite : kDarkBrown),
  entryModeIconColor: kPrimaryColor,
);

const kColorScheme = ColorScheme(
  primary: kPrimaryColor,
  primaryContainer: kPrimaryColor,
  secondary: kSecondaryColor,
  secondaryContainer: kSecondaryColor,
  surface: kDarkBrown,
  background: kWhite,
  error: Colors.red,
  onPrimary: kWhite,
  onSecondary: kDarkBrown,
  onSurface: kDarkBrown,
  onBackground: kWhite,
  onError: kWhite,
  brightness: Brightness.light,
);

// TEXT CONSTANTS
// Adopt
const String kOpenAdoptTitle = 'Open Adopt';
const String kEditAdoptTitle = 'Edit Open Adopt';

const String kOpenAdoptAddPicture = 'Add Picture';

const Map<String, String> kPetTypeIcon = {
  'fish': 'assets/icons/fish_icon_outline.svg',
  'cat': 'assets/icons/cat_icon_outline.svg',
  'bird': 'assets/icons/bird_icon_outline.svg',
  'dog': 'assets/icons/dog_icon_outline.svg',
  'rabbit': 'assets/icons/rabbit_icon_outline.svg',
  'hamster': 'assets/icons/hamster_icon_outline.svg',
  'other': 'assets/icons/other_icon_outline.svg',
};

const Map<String, String> kPetTypeVector = {
  'fish': 'assets/vectors/fish_vector.svg',
  'cat': 'assets/vectors/cat_vector.svg',
  'dog': 'assets/vectors/dog_vector.svg',
};

const Map<String, IconData> kTaskType = {
  'Feed': FontAwesomeIcons.utensils,
  'Walk': FontAwesomeIcons.personWalking,
  'Pee': FontAwesomeIcons.toilet,
  'Vitamin': FontAwesomeIcons.pills,
  'Shower': FontAwesomeIcons.shower,
  'Grooming': FontAwesomeIcons.faceSmile,
  'Weight Scale': FontAwesomeIcons.weightScale,
  'Period': FontAwesomeIcons.timeline,
};
