import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/domain/entities/medical_entity.dart';

class MedicalModel extends MedicalEntity {
  final String? medical_id;
  final String? activity;
  final Timestamp? expired_date;
  final String location;
  final String description;
  final Timestamp time_publish;
  final String? pet_id;

  MedicalModel(
      { this.medical_id,
        this.pet_id,
      required this.activity,
      required this.expired_date,
      required this.location,
      required this.description,
      required this.time_publish})
      : super(
            time_publish: time_publish,
            pet_id: pet_id,
            activity: activity,
            expired_date: expired_date,
            location: location,
            description: description,
            medical_id: medical_id);

  Map<String, dynamic> toJson() {
    return {
      'pet_id':pet_id,
      'activity': activity,
      'expired_date': expired_date,
      'location': location,
      'description': description,
      'time_publish': time_publish
    };
  }
}
