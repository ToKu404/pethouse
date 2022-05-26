import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pethouse/presentation/pages/auth/login_page.dart';
import 'package:pethouse/utils/styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const ROUTE_NAME = "splashscreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 7), () {
      Navigator.pushReplacementNamed(context, LoginPage.ROUTE_NAME);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 195, 142),
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
            SizedBox(
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
            Padding(
              padding: const EdgeInsets.only(
                top: 75,
                right: 30,
                left: 30,
              ),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B2710)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("version 1.0",
                style: Theme.of(context).textTheme.overline,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
