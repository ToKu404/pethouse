import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? petId;
  final String? activity;
  final Timestamp? date;
  final Timestamp? startTime;
  final Timestamp? endTime;
  final String repeat;
  final String description;

  TaskEntity(
      { this.petId,
        required this.activity,
        required this.date,
        required this.startTime,
        required this.endTime,
        required this.repeat,
        required this.description});

  @override
  List<Object?> get props => [activity, date,repeat,description, startTime, endTime];
}
