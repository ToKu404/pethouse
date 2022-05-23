import 'package:flutter/material.dart';
import 'package:pethouse/presentation/pages/registration_page.dart';

class MyHomeApp extends StatelessWidget {
  static const routeName = '/home';
  const MyHomeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home App'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: (){},
                child: Text('Login'),
              ),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, FormRegistration.routeName);
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
