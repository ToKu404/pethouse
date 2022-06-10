import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schedule/domain/entities/medical_entity.dart';

class MedicalModel extends MedicalEntity {
  final String? medicalId;
  final String? activity;
  final Timestamp? expiredDate;
  final String location;
  final String description;
  final Timestamp timeNow;

  MedicalModel(
      { this.medicalId,
      required this.activity,
      required this.expiredDate,
      required this.location,
      required this.description,
      required this.timeNow})
      : super(
            timeNow: timeNow,
            activity: activity,
            expiredDate: expiredDate,
            location: location,
            description: description,
            medicalId: medicalId);

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'expiredDate': expiredDate,
      'location': location,
      'description': description,
      'timeNow': timeNow
    };
  }
}
