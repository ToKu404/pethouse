import 'package:adopt/presentation/blocs/detail_adopt_bloc/detail_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/list_adopt_bloc/list_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/open_adopt_bloc/open_adopt_bloc.dart';
import 'package:adopt/presentation/pages/adopt_page.dart';
import 'package:adopt/presentation/pages/detail_adopt_page.dart';
import 'package:adopt/presentation/pages/open_adopt_page.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/no_internet_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:pet/presentation/bloc/get_medical/get_medical_bloc.dart';
import 'package:pet/presentation/pages/add_pet.dart';
import 'package:pet/presentation/pages/pet_description_page.dart';
import 'package:pethouse/presentation/pages/main_page.dart';
import 'package:pethouse/presentation/pages/petrivia/detail_petrivia.dart';
import 'package:pethouse/presentation/pages/schedule/schedule_calendar_page.dart';
import 'package:pethouse/presentation/pages/splash_page.dart';
import 'package:schedule/activity/presentation/blocs/addmedical_bloc/medical_bloc.dart';
import 'package:schedule/activity/presentation/blocs/addtask_bloc/task_bloc.dart';
import 'package:schedule/activity/presentation/pages/activity/add_medical_activity.dart';
import 'package:schedule/activity/presentation/pages/activity/add_new_task.dart';
import 'package:user/presentation/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:user/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'package:user/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:user/user.dart';

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
          BlocProvider(create: (_) => di.locator<SignInBloc>()),
          BlocProvider(create: (_) => di.locator<SignUpBloc>()),
          BlocProvider(create: (_) => di.locator<AuthCubit>()),
          BlocProvider(create: (_) => di.locator<UserDbBloc>()),
          BlocProvider(create: (_) => di.locator<UserProfileBloc>()),
          BlocProvider(create: (_) => di.locator<ResetPasswordBloc>()),
          BlocProvider(create: (_) => di.locator<MedicalBloc>()),
          BlocProvider(create: (_) => di.locator<TaskBloc>()),
          BlocProvider(create: (_) => di.locator<AddPetBloc>()),
          BlocProvider(create: (_) => di.locator<OpenAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<DetailAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<ListAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<GetMedicalBloc>())
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
              case SPLASH_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const SplashScreen());
              case REGISTER_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const RegisterPage());
              case LOGIN_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const LoginPage());
              case MainPage.ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (_) => MainPage(
                          userId: uid,
                        ));
              case PROFILE_ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          userId: uid,
                        ));
              case EDIT_PROFILE_ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                          uid: uid,
                        ));
              // case ChangePasswordPage.ROUTE_NAME:
              //   return MaterialPageRoute(
              //       builder: (context) => ChangePasswordPage());
              case OPEN_ADOPT_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const OpenAdoptPage());
              case ADOPT_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AdoptPage());
              case DETAIL_ADOPT_ROUTE_NAME:
                final petId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => DetailAdoptPage(
                    petAdoptId: petId,
                  ),
                );
              case NoInternetPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const NoInternetPage());
              case PetDescriptionPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const PetDescriptionPage());
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

              case AddPet.ROUTE_NAME:
                return MaterialPageRoute(builder: (context) => AddPet());
            }
          },
        ));
  }
}
