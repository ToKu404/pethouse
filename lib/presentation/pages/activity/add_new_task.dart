import 'package:flutter/material.dart';

class AddNewTaskActivity extends StatelessWidget {
  static const ROUTE_NAME = "add_newTask_activity";
  const AddNewTaskActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          child: Text('Add New Task'),
        ),
      ),
    );
  }
}
