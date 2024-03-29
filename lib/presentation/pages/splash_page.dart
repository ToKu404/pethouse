import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user/presentation/blocs/auth_cubit/auth_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
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
            () => Navigator.pushReplacementNamed(context, MAIN_ROUTE_NAME,
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
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
         color: kPrimaryColor
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // logo here
                SvgPicture.asset(
                  'assets/icons/pethouse_icon.svg',
                  height: 200,
                ),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    Text(
                      kAppTitle,
                      style: kTextTheme.headline1
                          ?.copyWith(color: kWhite, height: 1),
                    ),
                    SizedBox(
                      width: 200,
                      child: Text(
                        kAppDesc,
                        textAlign: TextAlign.center,
                        style: kTextTheme.bodyText1
                            ?.copyWith(color: kWhite, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ],
            )),
            Container(
              height: 60,
              padding: const EdgeInsets.all(8.0),
              child: Text(
                kAppVersion,
                style: kTextTheme.overline?.copyWith(color: kWhite),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
