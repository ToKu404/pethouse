import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  final String? petId;
  final String? activity;
  final String? date;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String repeat;
  final String description;
  final String status;
  final String id;

  TaskModel({
    this.petId,
    required this.activity,
    required this.startTime,
    required this.endTime,
    required this.repeat,
    required this.date,
    required this.description,
    required this.status,
    required this.id,
  }) : super(
          activity: activity,
          startTime: startTime,
          endTime: endTime,
          repeat: repeat,
          date: date,
          description: description,
          petId: petId,
          status: status,
          id: id,
        );

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'start_time': startTime,
      'end_time': endTime,
      'repeat': repeat,
      'description': description,
      'pet_id': petId,
      'status': status,
      'date': date,
      'id': id,
    };
  }

  factory TaskModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TaskModel(
        activity: documentSnapshot.get('activity'),
        startTime: documentSnapshot.get('start_time'),
        endTime: documentSnapshot.get('end_time'),
        repeat: documentSnapshot.get('repeat'),
        description: documentSnapshot.get('description'),
        petId: documentSnapshot.get('pet_id'),
        status: documentSnapshot.get('status'),
        date: documentSnapshot.get('date'),
        id: documentSnapshot.get('id'));
  }
}
