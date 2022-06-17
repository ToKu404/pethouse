import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

const Color kPrimaryColor = Color(0xFFEE4E64);
const Color kSecondaryColor = Color(0xFFEE4E64);
const Color kDarkBrown = Color(0xFF300303);
const Color kWhite = Colors.white;
const Color kGrey = Color(0xFFEFE6E7);
const Color kGreyTransparant = Color(0xFFBEC2C5);
const Color kOrange = Color(0xFFEF9F21);

BorderRadius kBorderRadius = BorderRadius.circular(10);

const double kMargin = 20.0;
const double kPadding = 10.0;

final TextTheme kTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(fontSize: 42, fontWeight: FontWeight.w800),
  headline2: GoogleFonts.poppins(fontSize: 26, fontWeight: FontWeight.w600),
  headline3: GoogleFonts.poppins(
      fontSize: 21, fontWeight: FontWeight.w600, color: kMainOrangeColor),
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
  overline: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, color: kDarkBrown),
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
  primary: kMainOrangeColor,
  primaryContainer: kMainOrangeColor,
  secondary: kMainPinkColor,
  secondaryContainer: kMainPinkColor,
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

const kTitleColor = Color(0xFF300303);
const kMainOrangeColor = Color(0xFFEE4E64);
const kMainBlueColor = Color(0xFF000072);
const kMainPinkColor = Color(0xFFEE4E64);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

const String mapStyle = '''
[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]
''';
