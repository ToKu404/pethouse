import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pethouse/presentation/pages/pet/add_pet.dart';
import 'package:pethouse/presentation/pages/pet/pet_description_page.dart';
import 'package:schedule/activity/presentation/pages/activity/add_medical_activity.dart';
import 'package:schedule/activity/presentation/pages/activity/add_new_task.dart';
import 'package:pethouse/presentation/pages/adopt/adopt_page.dart';
import 'package:pethouse/presentation/pages/adopt/detail_adopt_page.dart';
import 'package:pethouse/presentation/pages/main_page.dart';
import 'package:pethouse/presentation/pages/other/check_internet_page.dart';
import 'package:user/user.dart';
import 'package:pethouse/presentation/pages/splash_page.dart';
import 'package:pethouse/presentation/pages/petrivia/detail_petrivia.dart';
import 'package:pethouse/presentation/pages/schedule/schedule_calendar_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:user/presentation/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:user/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'package:user/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => di.locator<SignInBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<SignUpBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<AuthCubit>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UserDbBloc>(),
          ),
          BlocProvider(
            create: (_) => di.locator<UserProfileBloc>(),
          ),
          BlocProvider(create: (_) => di.locator<ResetPasswordBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pethouse',
          theme: ThemeData(
            colorScheme: kColorScheme,
            timePickerTheme: kTimePickerTheme,
          ),
          home: const SplashScreen(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case SplashScreen.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const SplashScreen());
              case RegisterPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const RegisterPage());
              case LoginPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const LoginPage());
              case MainPage.ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (_) => MainPage(
                          userId: uid,
                        ));
              case ProfilePage.ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          userId: uid,
                        ));
              case EditProfilePage.ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                          uid: uid,
                        ));
              // case ChangePasswordPage.ROUTE_NAME:
              //   return MaterialPageRoute(
              //       builder: (context) => ChangePasswordPage());
              case CheckInternetPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const CheckInternetPage());
              case PetDescriptionPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const PetDescriptionPage());
              case AdoptPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AdoptPage());
              case DetailPetrivia.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const DetailPetrivia());
              case ScheduleCalendarPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => ScheduleCalendarPage());
              case AddMedicalActivity.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AddMedicalActivity());
              case AddNewTaskActivity.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AddNewTaskActivity());
              case DetailAdoptPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const DetailAdoptPage());
              case AddPet.ROUTE_NAME:
                return MaterialPageRoute(builder: (context) => AddPet());
            }
          },
        ));
  }
}
