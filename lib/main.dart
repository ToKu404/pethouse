import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/account/change_password_page.dart';
import 'package:pethouse/presentation/pages/account/edit_profile_page.dart';
import 'package:pethouse/presentation/pages/account/account_page.dart';
import 'package:pethouse/presentation/pages/activity/add_medical_activity.dart';
import 'package:pethouse/presentation/pages/activity/add_new_task.dart';
import 'package:pethouse/presentation/pages/adopt_page.dart';
import 'package:pethouse/presentation/pages/home_page.dart';
import 'package:pethouse/presentation/pages/mypet/pet_description_page.dart';
import 'package:pethouse/presentation/pages/other/check_internet_page.dart';
import 'package:pethouse/presentation/pages/auth/login_page.dart';
import 'package:pethouse/presentation/pages/auth/register_page.dart';
import 'package:pethouse/presentation/pages/other/splash_screen_page.dart';
import 'package:pethouse/presentation/pages/petrivia/detail_petrivia.dart';
import 'package:pethouse/presentation/pages/schedule/schedule_calendar_page.dart';
import 'package:pethouse/utils/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pethouse',
      theme: ThemeData(colorScheme: kColorScheme),
      initialRoute: SplashScreen.ROUTE_NAME,
      routes: {
        SplashScreen.ROUTE_NAME:(context) => SplashScreen(),
        RegisterPage.ROUTE_NAME: (context) => const RegisterPage(),
        LoginPage.ROUTE_NAME: (context) => const LoginPage(),
        HomePage.ROUTE_NAME: (context) => const HomePage(),
        AccountPage.ROUTE_NAME: (context) => AccountPage(),
        EditProfilePage.ROUTE_NAME: (context) => const EditProfilePage(),
        ChangePasswordPage.ROUTE_NAME: (context) => ChangePasswordPage(),
        CheckInternetPage.ROUTE_NAME: (context) => const CheckInternetPage(),
        PetDescriptionPage.ROUTE_NAME: (context) => const PetDescriptionPage(),
        AdoptPage.ROUTE_NAME: (context) => const AdoptPage(),
                DetailPetrivia.ROUTE_NAME: (context) => DetailPetrivia(),
        ScheduleCalendarPage.ROUTE_NAME: (context) => ScheduleCalendarPage(),
        AddMedicalActivity.ROUTE_NAME: (context) => AddMedicalActivity(),
        AddNewTaskActivity.ROUTE_NAME: (context) => AddNewTaskActivity(),

      },
    );
  }
}
