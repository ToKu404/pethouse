import 'package:flutter/material.dart';
import 'package:plan/domain/entities/plan_entity.dart';

class EditPlanPage extends StatefulWidget {
  final PlanEntity plan;
  const EditPlanPage({Key? key, required this.plan}) : super(key: key);

  @override
  State<EditPlanPage> createState() => _EditPlanPageState();
}

class _EditPlanPageState extends State<EditPlanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
