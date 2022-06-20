import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/domain/entities/plan_entity.dart';

class PlanModel extends PlanEntity {
  const PlanModel({
    final String? id,
    final String? petId,
    final String? activity,
    final String? activityTitle,
    final String? date,
    final Timestamp? time,
    final bool? reminder,
    final String? location,
    final String? description,
    final String? status,
  }) : super(
            id: id,
            petId: petId,
            activity: activity,
            activityTitle: activityTitle,
            date: date,
            time: time,
            reminder: reminder,
            location: location,
            status: status,
            description: description);

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "pet_id": petId,
      "activity": activity,
      "activity_title": activityTitle,
      "date": date,
      "time": time,
      "reminder": reminder,
      "status":status,
      "location": location,
      "description": description
    };
  }

  factory PlanModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return PlanModel(
        id: documentSnapshot.get('id'),
        petId: documentSnapshot.get('pet_id'),
        activity: documentSnapshot.get('activity'),
        activityTitle: documentSnapshot.get('activity_title'),
        date: documentSnapshot.get('date'),
        time: documentSnapshot.get('time'),
        status: documentSnapshot.get('status'),
        reminder: documentSnapshot.get('reminder'),
        location: documentSnapshot.get('location'),
        description: documentSnapshot.get('description'));
  }
  @override
  List<Object?> get props =>
      [activity, location, time, activityTitle, date, description, reminder, status];
}
