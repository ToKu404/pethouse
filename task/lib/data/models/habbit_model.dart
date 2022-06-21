import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/data/models/task_model.dart';

import '../../domain/entities/habbit_entity.dart';

class HabbitModel extends HabbitEntity {
  const HabbitModel({
    final String? id,
    final String? petId,
    final String? activityType,
    final Timestamp? time,
    final String? repeat,
    final String? title,
    final List<String>? dayRepeat,
  }) : super(
            id: id,
            petId: petId,
            activityType: activityType,
            time: time,
            title: title,
            repeat: repeat,
            dayRepeat: dayRepeat);

  factory HabbitModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return HabbitModel(
        id: documentSnapshot.get('id'),
        petId: documentSnapshot.get('pet_id'),
        activityType: documentSnapshot.get('activity_type'),
        time: documentSnapshot.get('time'),
        title: documentSnapshot.get('title'),
        repeat: documentSnapshot.get('repeat'),
        dayRepeat:
            List<String>.from(documentSnapshot["day_repeat"].map((x) => x)));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'pet_id': petId,
        'activity_type': activityType,
        'time': time,
        'repeat': repeat,
        'title': title,
        'day_repeat': dayRepeat,
      };
  

  @override
  List<Object?> get props => [
        id,
        petId,
        activityType,
        time,
        title,
        repeat,
        dayRepeat,
      ];
}
