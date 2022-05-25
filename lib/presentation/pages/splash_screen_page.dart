import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pethouse/presentation/pages/login_page.dart';

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
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 195, 142),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                Text("PETHOUSE",
                  style: Theme.of(context).textTheme.headline1,
                    ),
                Text("Join and Discover The Best Habit Tracker for Your Pet",
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 75, right: 30, left: 30,),
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4B2710)),
              ),
            )
          ],
        ),
      ),
    );
  }
}