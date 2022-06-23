import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    final String? id,
    final String? title,
    final String? activityType,
    final String? date,
    final String? petId,
    final String? habbitId,
    final bool? completeStatus,
    final Timestamp? time,
  }) : super(
            id: id,
            title: title,
            petId: petId,
            date: date,
            habbitId: habbitId,
            activityType: activityType,
            completeStatus: completeStatus,
            time: time);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'activity_type': activityType,
      'date': date,
      'habbit_id': habbitId,
      'pet_id':petId,
      'complete_status': completeStatus,
      'time': time
    };
  }

  factory TaskModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return TaskModel(
      id: documentSnapshot.get('id'),
      time: documentSnapshot.get('time'),
      date: documentSnapshot.get('date'),
      petId: documentSnapshot.get('pet_id'),
      habbitId: documentSnapshot.get('habbit_id'),
      completeStatus: documentSnapshot.get('complete_status'),
      activityType: documentSnapshot.get('activity_type'),
      title: documentSnapshot.get('title'),
    );
  }
  @override
  List<Object?> get props => [
       id,
       time,
       completeStatus,
       activityType,
       title,
       habbitId,
       petId,
       date,
      ];
}
