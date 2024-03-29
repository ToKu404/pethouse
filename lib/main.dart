import 'package:core/core.dart';
import 'package:adopt/adopt.dart';
import 'package:pet_map/pet_map.dart';
import 'package:petrivia/petrivia.dart';
import 'package:store/store.dart';
import 'package:user/presentation/pages/auth_pages/reset_password_page.dart';
import 'package:user/user.dart';
import 'package:task/task.dart';
import 'package:pet/pet.dart';
import 'package:plan/plan.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrivia/presentation/pages/detail_petrivia_page.dart';
import 'package:notification/presentation/blocs/notification_bloc/notification_bloc.dart';
import 'package:notification/presentation/blocs/send_notif_bloc/send_notif_bloc.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/pages/main_page.dart';
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
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: kWhite, // navigation bar color
      statusBarColor: kPrimaryColor, // status bar color
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => di.locator<SignInBloc>()),
          BlocProvider(create: (_) => di.locator<SignUpBloc>()),
          BlocProvider(create: (_) => di.locator<AuthCubit>()),
          BlocProvider(create: (_) => di.locator<AddPlanCubit>()),
          BlocProvider(create: (_) => di.locator<EditPlanCubit>()),
          BlocProvider(create: (_) => di.locator<UserDbBloc>()),
          BlocProvider(create: (_) => di.locator<UserProfileBloc>()),
          BlocProvider(create: (_) => di.locator<ResetPasswordBloc>()),
          BlocProvider(create: (_) => di.locator<AddPetBloc>()),
          BlocProvider(create: (_) => di.locator<OpenAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<DetailAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<ListAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<EditAdoptBloc>()),
          BlocProvider(create: (_) => di.locator<NotificationBloc>()),
          BlocProvider(create: (_) => di.locator<OpenAdoptStatusBloc>()),
          BlocProvider(create: (_) => di.locator<RequestAdoptStatusBloc>()),
          BlocProvider(create: (_) => di.locator<SettingNotificationCubit>()),
          BlocProvider(create: (_) => di.locator<SendNotifBloc>()),
          BlocProvider(create: (_) => di.locator<GetPetBloc>()),
          BlocProvider(create: (_) => di.locator<GetSchedulePetBloc>()),
          BlocProvider(create: (_) => di.locator<HomePlanCalendarBloc>()),
          BlocProvider(create: (_) => di.locator<PlanCalendarBloc>()),
          BlocProvider(create: (_) => di.locator<GetPetDescBloc>()),
          BlocProvider(create: (_) => di.locator<GetMonthlyTaskBloc>()),
          BlocProvider(create: (_) => di.locator<GetPlanHistoryBloc>()),
          BlocProvider(create: (_) => di.locator<UpdatePetBloc>()),
          BlocProvider(create: (_) => di.locator<GetPetriviaBloc>()),
          BlocProvider(create: (_) => di.locator<PetmapCubit>()),
          BlocProvider(create: (_) => di.locator<StoreScrappingCubit>()),
          BlocProvider(create: (_) => di.locator<GetAllPetMapBloc>()),
          BlocProvider(create: (_) => di.locator<HabbitCubit>()),
          BlocProvider(create: (_) => di.locator<GetPetMapBloc>()),
          BlocProvider(create: (_) => di.locator<GetHabbitBloc>()),
          BlocProvider(create: (_) => di.locator<TaskBloc>()),
          BlocProvider(create: (_) => di.locator<OnetimeInternetCheckCubit>()),
          BlocProvider(create: (_) => di.locator<RealtimeInternetCheckCubit>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Pethouse',
          theme: ThemeData(
            colorScheme: kColorScheme,
            timePickerTheme: kTimePickerTheme,
          ),
          home: const SplashPage(),
          navigatorObservers: [routeObserver],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case SPLASH_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const SplashPage());
              case REGISTER_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const RegisterPage());
              case LOGIN_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const LoginPage());
              case MAIN_ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (_) => MainPage(
                          userId: uid,
                        ));
              case DETAIL_PETRIVIA_ROUTE_NAME:
                final petriviaEntity = settings.arguments as PetriviaEntity;
                return MaterialPageRoute(
                    builder: (context) => DetailPetriviaPage(
                          petriviaEntity: petriviaEntity,
                        ));
              case PROFILE_ROUTE_NAME:
                final userId = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => ProfilePage(
                          userId: userId,
                        ));
              case CHOICE_PET_MAP_ROUTE_NAME:
                final userId = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => ChoicePetPage(
                          userId: userId,
                        ));
              case EDIT_PROFILE_ROUTE_NAME:
                final uid = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                          uid: uid,
                        ));
              case OPEN_ADOPT_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const OpenAdoptPage());
              case ACTIVITY_STATUS_ROUT_NAME:
                return MaterialPageRoute(
                    builder: (context) => const ActivityStatusPage());
              case DETAIL_ADOPT_ROUTE_NAME:
                final adoptId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (context) => DetailAdoptPage(
                    adoptId: adoptId,
                  ),
                );
              case EDIT_ADOPT_ROUTE_NAME:
                final adopt = settings.arguments as AdoptEntity;
                return MaterialPageRoute(
                    builder: (context) => EditAdoptPage(adoptPet: adopt));
              case EDIT_PET_ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => EditPetPage(
                          pet: pet,
                        ));
              case EDIT_PLAN_ROUTE_NAME:
                final plan = settings.arguments as PlanEntity;
                return MaterialPageRoute(
                    builder: (context) => EditPlanPage(
                          plan: plan,
                        ));
              case PET_DESC_ROUTE_NAME:
                final petId = settings.arguments as String;
                return MaterialPageRoute(
                    builder: (context) => PetDescriptionPage(
                          petId: petId,
                        ));
              case SCHEDULE_CALENDAR_ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => CalendarPage(
                          petEntity: pet,
                        ));
              case ADD_PLAN_ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => AddPlanPage(petEntity: pet));
              case ALL_HABBIT_ROUTE_NAME:
                final pet = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => AllHabbitPage(petEntity: pet));
              case ADD_HABBIT_ROUTE_NAME:
                final petEntity = settings.arguments as PetEntity;
                return MaterialPageRoute(
                    builder: (context) => AddHabbitPage(
                          petEntity: petEntity,
                        ));
              case ADD_PET_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const AddPetPage());
              case ABOUT_ROUTE_NAME:
                return MaterialPageRoute(builder: (context) => AboutPage());
              case RESET_PASSWORD_ROUTE_NAME:
                return MaterialPageRoute(
                    builder: (context) => const ResetPasswordPage());
            }
          },
        ));
  }
}
