import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String? id;
  final String? title;
  final String? petId;
  final String? habbitId;
  final String? activityType;
  final bool? completeStatus;
  final String? date;
  final Timestamp? time;

  TaskEntity(
      {this.id,
      required this.time,
      required this.title,
      required this.petId,
      required this.habbitId,
      required this.activityType,
      required this.date,
      required this.completeStatus});

  @override
  List<Object?> get props => [
        id,
        time,
        date,
        petId,
        habbitId,
        title,
        activityType,
        completeStatus,
      ];
}
