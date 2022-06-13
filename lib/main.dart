import 'package:adopt/domain/entities/adopt_enitity.dart';
import 'package:adopt/presentation/blocs/open_adopt_status_bloc/open_adopt_status_bloc.dart';
import 'package:adopt/presentation/blocs/detail_adopt_bloc/detail_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/edit_adopt_bloc/edit_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/list_adopt_bloc/list_adopt_bloc.dart';
import 'package:adopt/presentation/blocs/open_adopt_bloc/open_adopt_bloc.dart';
import 'package:adopt/presentation/pages/adopt_page.dart';
import 'package:adopt/presentation/pages/detail_adopt_page.dart';
import 'package:adopt/presentation/pages/edit_adopt_page.dart';
import 'package:adopt/presentation/pages/open_adopt_page.dart';
import 'package:adopt/presentation/pages/activity_status_page.dart';

import 'package:core/core.dart';
import 'package:core/presentation/pages/no_internet_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification/presentation/blocs/send_notif_bloc/send_notif_bloc.dart';
import 'package:notification/presentation/pages/notification_page.dart';
import 'package:pet/domain/entities/pet_entity.dart';
import 'package:pet/presentation/bloc/add_pet/add_pet_bloc.dart';
import 'package:pet/presentation/bloc/get_pet/get_pet_bloc.dart';
import 'package:pet/presentation/bloc/get_schedule_pet/get_schedule_pet_bloc.dart';
import 'package:pet/presentation/pages/add_pet.dart';
import 'package:pet/presentation/pages/pet_description_page.dart';
import 'package:schedule/presentation/blocs/addmedical_bloc/medical_bloc.dart';
import 'package:schedule/presentation/blocs/addtask_bloc/task_bloc.dart';
import 'package:schedule/presentation/blocs/get_today_task_bloc/get_today_task_bloc.dart';
import 'package:schedule/presentation/pages/add_medical_activity.dart';
import 'package:schedule/presentation/pages/add_new_task.dart';
import 'package:user/domain/entities/user_entity.dart';
import 'package:user/presentation/blocs/reset_password_bloc/reset_password_bloc.dart';
import 'package:user/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:user/presentation/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:user/presentation/blocs/user_db_bloc/user_db_bloc.dart';
import 'package:user/presentation/blocs/user_profile_bloc/user_profile_bloc.dart';
import 'package:schedule/presentation/blocs/day_calendar_task_bloc/day_calendar_task_bloc.dart';

import 'package:user/user.dart';

import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/pages/main_page.dart';
import 'presentation/pages/petrivia/detail_petrivia.dart';
import 'presentation/pages/calendar_page.dart';
import 'presentation/pages/splash_page.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: kWhite, // navigation bar color
      statusBarColor: kMainOrangeColor, // status bar color
    ));
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
          BlocProvider(create: (_) => di.locator<EditAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<NotificationBloc>()),
          BlocProvider(create: (_) => di.locator<OpenAdoptStatusBloc>()),
          BlocProvider(create: (_) => di.locator<SendNotifBloc>()),
          BlocProvider(create: (_) => di.locator<GetPetBloc>()),
          BlocProvider(create: (_) => di.locator<GetSchedulePetBloc>()),
          BlocProvider(create: (_) => di.locator<GetTodayTaskBloc>()),
          BlocProvider(create: (_) => di.locator<DayCalendarTaskBloc>()),

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
                final userEntity = settings.arguments as UserEntity;
                return MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          userEntity: userEntity,
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
              case ACTIVITY_STATUS_ROUT_NAME:
                return MaterialPageRoute(
                    builder: (context) => const ActivityStatusPage());
              case DETAIL_ADOPT_ROUTE_NAME:
                final petId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => DetailAdoptPage(
                    petAdoptId: petId,
                  ),
                );
              case NOTIFICATION_ROUT_NAME:
                return MaterialPageRoute(
                    builder: (context) => const NotificationPage());
              case EDIT_ADOPT_ROUTE_NAME:
                final adopt = settings.arguments as AdoptEntity;
                return MaterialPageRoute(
                    builder: (context) => EditAdoptPage(adoptPet: adopt));
              case NoInternetPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const NoInternetPage());
              case PetDescriptionPage.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const PetDescriptionPage());
              case DetailPetrivia.ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const DetailPetrivia());
              case SCHEDULE_CALENDAR_ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => CalendarPage(
                          petEntity: pet,
                        ));
              case AddMedicalActivity.ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => AddMedicalActivity(petEntity: pet));
              case ADD_TASK_ROUTE_NAME:
                final petEntity = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => AddTaskPage(
                          petEntity: petEntity,
                        ));

              case ADD_PET_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AddPetPage());
            }
          },
        ));
  }
}
