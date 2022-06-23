import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PlanEntity extends Equatable {
  final String? id;
  final String? petId;
  final String? activity;
  final String? activityTitle;
  final String? date;
  final int? notifId;
  final Timestamp? time;
  final bool? reminder;
  final String? location;
  final bool? completeStatus;
  final String? description;

  const PlanEntity(
      {this.petId,
      this.id,
      required this.date,
      required this.time,
      this.notifId,
      required this.activity,
      required this.activityTitle,
      required this.location,
      required this.description,
      required this.reminder,
      required this.completeStatus});

  @override
  List<Object?> get props => [
        activity,
        location,
        activityTitle,
        time,
        date,
        notifId,
        description,
        reminder,
        completeStatus
      ];
}
