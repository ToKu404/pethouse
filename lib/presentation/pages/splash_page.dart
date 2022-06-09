import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user/presentation/blocs/auth_cubit/auth_cubit.dart';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).authenticationStarted();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Timer(
            const Duration(seconds: 7),
            () => Navigator.pushReplacementNamed(context, MainPage.ROUTE_NAME,
                arguments: state.uid),
          );
        } else {
          Timer(
            const Duration(seconds: 7),
            () => Navigator.pushReplacementNamed(context, LOGIN_ROUTE_NAME),
          );
        }
      },
      child: const _BuildSplashLayout(),
    );
  }
}

class _BuildSplashLayout extends StatelessWidget {
  const _BuildSplashLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 195, 142),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // logo here
            SvgPicture.asset(
              'assets/vectors/splash.svg',
              height: 240,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              children: [
                Text(
                  "PETHOUSE",
                  style: kTextTheme.headline1?.copyWith(color: kDarkBrown),
                ),
                Text(
                  "Join and Discover The Best Habit Tracker for Your Pet",
                  style: kTextTheme.bodyText2,
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(
                top: 75,
                right: 30,
                left: 30,
              ),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kDarkBrown),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "version 1.0",
                style: kTextTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
