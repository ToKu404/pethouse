import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    final String? id,
    final String? petId,
    final String? activity,
    final String? activityTitle,
    final String? date,
    final Timestamp? time,
    final bool? reminder,
    final int? notifId,
    final String? location,
    final String? description,
    final bool? completeStatus,
  }) : super(
            id: id,
            petId: petId,
            activity: activity,
            activityTitle: activityTitle,
            date: date,
            time: time,
            notifId: notifId,
            reminder: reminder,
            location: location,
            completeStatus: completeStatus,
            description: description);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pet_id": petId,
      "notif_id": notifId,
      "activity": activity,
      "activity_title": activityTitle,
      "date": date,
      "time": time,
      "reminder": reminder,
      "complete_status":completeStatus,
      "location": location,
      "description": description
    };
  }

  factory PlanModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PlanModel(
        id: documentSnapshot.get('id'),
        petId: documentSnapshot.get('pet_id'),
        notifId: documentSnapshot.get('notif_id'),
        activity: documentSnapshot.get('activity'),
        activityTitle: documentSnapshot.get('activity_title'),
        date: documentSnapshot.get('date'),
        time: documentSnapshot.get('time'),
        completeStatus: documentSnapshot.get('complete_status'),
        reminder: documentSnapshot.get('reminder'),
        location: documentSnapshot.get('location'),
        description: documentSnapshot.get('description'));
  }
  @override
  List<Object?> get props =>
      [activity, location, time, activityTitle, date, notifId, description, reminder, completeStatus];
}
