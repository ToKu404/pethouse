import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/activity/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final String? petId;
  final String? activity;
  final Timestamp? date;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String repeat;
  final String description;

  TaskModel(
      { this.petId,
        required this.activity,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.repeat,
        required this.description})
      : super(
      activity: activity,
      date: date,
      startTime: startTime,
      endTime: endTime,
      repeat: repeat,
      description: description,
      petId: petId);

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'Date': date,
      'Start Time': startTime,
      'End Time': endTime,
      'repeat': repeat,
      'description': description
    };
  }
}
