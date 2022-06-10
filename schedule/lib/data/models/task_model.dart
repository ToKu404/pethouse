import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final String? petId;
  final String? activity;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String repeat;
  final String description;
  final String status;

  TaskModel({
    this.petId,
    required this.activity,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.description,
    required this.status,
  }) : super(
            activity: activity,
            startTime: startTime,
            endTime: endTime,
            repeat: repeat,
            description: description,
            petId: petId,
            status: status);

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'start_time': startTime,
      'end_time': endTime,
      'repeat': repeat,
      'description': description,
      'pet_id': petId,
      'status': status
    };
  }
}
