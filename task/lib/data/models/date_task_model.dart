import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/date_task_entity.dart';

class DateTaskModel extends DateTaskEntity {
  DateTaskModel({
    final String? id,
    final String? date,
    final String? petId,
    final List<String>? listTaskId,
  }) : super(id: id, date: date, petId: petId, listTaskId: listTaskId);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'pet_id': petId,
      'list_task_id': listTaskId,
    };
  }

  factory DateTaskModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return DateTaskModel(
      id: documentSnapshot.get('id'),
      date: documentSnapshot.get('date'),
      petId: documentSnapshot.get('pet_id'),
      listTaskId:
          List<String>.from(documentSnapshot["list_task_id"].map((x) => x)),
    );
  }
  @override
  List<Object?> get props => [
        id,
        date,
        petId,
        listTaskId,
      ];
}
