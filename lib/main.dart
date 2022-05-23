import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/login_page.dart';
import 'package:pethouse/presentation/pages/register_page.dart';
import 'package:pethouse/utils/styles.dart';

import 'presentation/pages/home_page.dart';

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
      initialRoute: LoginPage.ROUTE_NAME,
      routes: {
        RegisterPage.ROUTE_NAME: (context) => RegisterPage(),
        LoginPage.ROUTE_NAME: (context) => LoginPage(),
        HomePage.ROUTE_NAME: (context) => HomePage(),
      },
    );
  }
}
