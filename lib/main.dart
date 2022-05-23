import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/home.dart';
import 'package:pethouse/presentation/pages/registration_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: MyHomeApp.routeName ,
      routes: {
        MyHomeApp.routeName: (context) => MyHomeApp(),
        FormRegistration.routeName: (context) => FormRegistration(),
      },
    );
  }
}
