import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/account/change_password_page.dart';
import 'package:pethouse/presentation/pages/account/edit_profile_page.dart';
import 'package:pethouse/presentation/pages/account_page.dart';
import 'package:pethouse/presentation/pages/check_internet_page.dart';
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
        AccountPage.ROUTE_NAME: (context) => AccountPage(),
        EditProfilePage.ROUTE_NAME: (context) => EditProfilePage(),
        ChangePasswordPage.ROUTE_NAME: (context) => ChangePasswordPage(),
        CheckInternetPage.ROUTE_NAME: (context) => CheckInternetPage(),
      },
    );
  }
}
