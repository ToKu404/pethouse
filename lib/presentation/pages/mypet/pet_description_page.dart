import 'package:flutter/material.dart';

class PetDescriptionPage extends StatelessWidget {
  static const ROUTE_NAME = "pet_description";

  const PetDescriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Description'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text(
            'DESCRIPTION'
          ),
        ),
      ),
    );
  }
}
